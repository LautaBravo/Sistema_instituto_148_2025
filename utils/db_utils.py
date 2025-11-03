import os
import mysql.connector
from mysql.connector import Error
from contextlib import contextmanager


def ejecutar_sql(sentencia_sql, params=None):
    """
    Ejecuta una sentencia SQL simple.
    - Para SELECT devuelve la lista de tuplas (resultado).
    - Para INSERT/UPDATE/DELETE devuelve None.

    Importante: en caso de error la excepción se vuelve a lanzar para que
    el llamador pueda manejarla (antes la función la silenció y devolvía None).
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
        # Mostrar el error y volver a lanzarlo para que el llamador lo capture
        print("Error al conectar a MySQL:", e)
        raise
    finally:
        # Cerrar cursor/connection si fueron creados
        if cursor:
            try:
                cursor.close()
            except Exception:
                pass
        if connection and connection.is_connected():
            try:
                connection.close()
            except Exception:
                pass

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
