# Learning OS — guía rápida

Esta versión es una web responsive pensada para PC + celular y con datos persistentes por cuenta.

## Incluye

- Login / registro con Supabase Auth.
- Dashboard.
- Biblioteca de cursos.
- Estados y prioridades.
- Progreso 0–100%.
- Plataforma, categoría, instructor, URL, duración y fechas.
- Registro de sesiones de estudio.
- Objetivos.
- Certificados.
- Subida de archivos de certificados a Supabase Storage.
- Calendario/listado de fechas objetivo.
- Estadísticas.
- XP y gamificación.
- Exportación de Cursos, Sesiones, Objetivos y Certificados a Excel.
- Diseño responsive para móvil y desktop.

## Configuración

### 1. Crear Supabase
Crea un proyecto en https://supabase.com/

### 2. Base de datos
Abre SQL Editor y ejecuta TODO el contenido de `schema.sql`.

### 3. Auth
En Authentication > Providers habilita Email.

Para simplificar la primera prueba puedes desactivar la confirmación de email en Authentication > Settings. Si la dejas activa, el usuario deberá confirmar su correo.

### 4. Storage
En Storage crea un bucket PRIVADO llamado `certificates`.

Las policies del bucket están al final de `schema.sql`.

### 5. Conectar la web
Abre `index.html` y busca:

const SUPABASE_URL = "YOUR_SUPABASE_URL";
const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";

Reemplázalos por:
- Project URL
- Publishable/anon key

Estos datos se encuentran en Supabase > Project Settings > API.

NO pongas nunca una `service_role` key en esta web.

### 6. Publicarla
Puedes subir `index.html` a Netlify, Vercel o GitHub Pages.

Al abrir la URL desde PC o celular, iniciarás sesión con la misma cuenta y verás tus datos.

## Excel

El botón “Excel ↓” genera un `.xlsx` con cuatro hojas:
- Cursos
- Sesiones
- Objetivos
- Certificados

## Nota sobre la V1

La arquitectura está preparada para crecer. Para una V2 recomendaría añadir:
- calendario mensual real;
- edición de sesiones;
- archivos/apuntes asociados a cada curso;
- módulos/lecciones dentro de cada curso;
- etiquetas;
- estadísticas por mes;
- rachas calculadas con precisión;
- importación desde Excel;
- drag & drop de cursos;
- PWA instalable como app;
- modo offline con sincronización;
- dashboard de horas por categoría/plataforma;
- backups automáticos.
