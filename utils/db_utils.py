import os
import mysql.connector
from mysql.connector import Error
from contextlib import contextmanager

def ejecutar_sql(sentencia_sql, params=None):
    try:
        connection = mysql.connector.connect(
            host=os.getenv('DB_HOST'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASS'),
            database=os.getenv('DB_DATABASE')
        )
        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute(sentencia_sql, params)
            if sentencia_sql.strip().lower().startswith("select"):
                resultado = cursor.fetchall()
                return resultado
            else:
                connection.commit()
                return None
    except Error as e:
        print("Error al conectar a MySQL:", e)
        return None
    finally:
        # Verificar si 'connection' fue inicializada y está conectada antes de cerrarla
        if connection and connection.is_connected():
            cursor.close()
            connection.close()

@contextmanager
def transactional():
    """
    Context manager para transacciones manuales.
    Devuelve (connection, cursor) para operaciones que necesitan lastrowid
    o múltiples queries en una transacción.
    
    Ejemplo de uso:
        with transactional() as (conn, cursor):
            cursor.execute("INSERT INTO tabla (...) VALUES (...)", (params,))
            new_id = cursor.lastrowid
            cursor.execute("UPDATE otra_tabla SET ... WHERE id = %s", (new_id,))
    """
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(
            host=os.getenv('DB_HOST'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASS'),
            database=os.getenv('DB_DATABASE')
        )
        cursor = connection.cursor()
        yield (connection, cursor)
        connection.commit()
    except Error as e:
        if connection:
            connection.rollback()
        print("Error en transacción:", e)
        raise
    finally:
        if cursor:
            cursor.close()
        if connection and connection.is_connected():
            connection.close()
