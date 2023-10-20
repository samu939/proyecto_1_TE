**README.md**

# Base de datos de PostgreSQL

Este repositorio contiene una base de datos de PostgreSQL.

## Requisitos

- Docker Desktop

## Instalación

1. Instalar Docker Desktop.
2. Abrir Docker Desktop y ejecutarlo.

## Ejecución

1. Clonar el repositorio:

```
git clone https://github.com/Holeekey/proyecto_1_TE
```

2. Acceder al directorio del repositorio:

```
cd base-de-datos-de-postgres
```

3. Ejecutar el comando `db` en el archivo `package.json`:

```
npm run db
```

4. Ejecutar el comando `seed` en el archivo `package.json`:

```
npm run seed
```

## Prueba

Una vez que la base de datos esté creada y poblada, puedes probarla conectando a ella con una herramienta GUI como pgAdmin.

## Licencia

Este proyecto está licenciado bajo la licencia MIT.

## Contacto

Si tienes alguna pregunta o problema, no dudes en contactarme.

**Pasos detallados**

1. **Instalar Docker Desktop**

Sigue las instrucciones de instalación de Docker Desktop para tu sistema operativo.

2. **Abrir Docker Desktop y ejecutarlo**

Una vez que Docker Desktop esté instalado, ábrelo y ejecutalo.

3. **Clonar el repositorio**

Abre una terminal y ejecuta el siguiente comando para clonar el repositorio:

```
git clone https://github.com/Holeekey/proyecto_1_TE
```

4. **Acceder al directorio del repositorio**

Una vez que el repositorio haya sido clonado, accede al directorio del repositorio:

```
cd base-de-datos-de-postgres
```

5. **Ejecutar el comando `db`**

El comando `db` en el archivo `package.json` creará la base de datos y la poblará con datos ficticios. Para ejecutar el comando, abre una terminal en el directorio del repositorio y ejecuta el siguiente comando:

```
npm run db
```

6. **Ejecutar el comando `seed`**

El comando `seed` en el archivo `package.json` agregará datos ficticios adicionales a la base de datos. Para ejecutar el comando, abre una terminal en el directorio del repositorio y ejecuta el siguiente comando:

```
npm run seed
```

7. **Probar la base de datos**

Una vez que la base de datos esté creada y poblada, puedes probarla conectando a ella con una herramienta GUI como pgAdmin.

Para conectarte a la base de datos con pgAdmin, sigue estos pasos:

1. Abre pgAdmin.
2. En el árbol de la izquierda, haz clic en el botón **New Server**.
3. En la ventana **Create Server**, ingresa la siguiente información:
   - **Name:** El nombre que quieras darle al servidor.
   - **Host:** `localhost`.
   - **Port:** `5432`.
   - **Username:** `postgres`.
   - **Password:** La contraseña que creaste para el usuario `postgres`.
4. Haz clic en el botón **Save**.

Una vez que el servidor haya sido creado, haz clic en él para expandirlo. Luego, haz clic en el botón **Connect** para conectarte a la base de datos.

Una vez que estés conectado a la base de datos, puedes explorar sus tablas y datos.
