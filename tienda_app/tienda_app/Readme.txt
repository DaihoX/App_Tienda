REPORTE DE PROYECTO: APP DE TIENDA (PARCIAL 1)
Facultad de Inteligencia Artificial e Ingenierías
Docente: Ricardo Andrés Bolaños
Estudiante: Jeison David Gomez Hernandez

1. OBJETIVO DEL PROYECTO

Desarrollar una aplicación móvil funcional en Flutter que consuma la "Fake Store API", 
implementando operaciones CRUD (Create, Read, Update, Delete), manejo de estados 
asíncronos y una interfaz de usuario moderna.

2. FUNCIONALIDADES

* Pantalla Principal: Listado de productos en un Grid de 3 columnas con 
  indicador de carga y manejo de errores de conexión.
* Pantalla de Detalle: Visualización de información completa (imagen, precio, 
  categoría, descripción y rating) al seleccionar un producto.
* Pantalla de Creación (POST): Formulario con validaciones para Título, Precio 
  y Descripción.
* BONIFICACIÓN (PUT/DELETE): Implementación de botones para actualizar datos 
  existentes y eliminar productos mediante peticiones simuladas a la API.

3. TECNOLOGÍAS UTILIZADAS

* Lenguaje: Dart.
* Framework: Flutter (Material 3).
* API Externa: Fake Store API (https://fakestoreapi.com).
* Paquetes: http (para consumo de servicios REST).

4. INSTRUCCIONES DE EJECUCIÓN

1. Asegurarse de tener Flutter SDK instalado.
2. Ejecutar 'flutter pub get' para instalar las dependencias.
3. Iniciar la aplicación en un emulador o dispositivo físico mediante 'flutter run'.