-- =====================================================================
-- SCRIPT DDL - BASE DE DATOS SMARTMOTRIZ
-- =====================================================================
-- Sistema de Gestión para Taller Mecánico
-- Universidad Fidelitas - Ingeniería en Sistemas de Computación
-- Lenguaje de Base de Datos - III Cuatrimestre 2025
-- 
-- Integrantes:
--   - Keylor Santiago Brenes Quiros
--   - Luis Eduardo Rodríguez Calvo
--   - Gabriel Brilla López
--
-- Profesor: Jerson Enrique Morales Méndez
-- Modulo: Usuarios
-- =====================================================================


-- ---------------------------------------------------------------------
-- TABLA: FIDE_USUARIOS_TB
-- Descripción: Tabla comun para usuarios del sistema con informacion básica
-- Uso: Permite gestionar la informacion basica de los tipos de usuarios del sistema
-- ---------------------------------------------------------------------

create table fide_usuarios_tb (
   cedula           varchar2(12)
      constraint usuarios_cedula_pk primary key,
   primer_nombre    varchar2(50)
      constraint usuarios_primer_nombre_nn not null,
   segundo_nombre   varchar2(50)
      constraint usuarios_segundo_nombre_nn not null,
   primer_apellido  varchar2(50)
      constraint usuarios_primer_apellido_nn not null,
   segundo_apellido varchar2(50)
      constraint usuarios_segundo_apellido_nn not null,
   fecha_nacimiento date,
   estado_id        number
      constraint usuarios_estado_fk
         references fide_estados_tb ( estado_id )
)


-- ---------------------------------------------------------------------
-- TABLA: FIDE_TIPO_USUARIOS_TB
-- Descripción: Tabla comun para tipos de usuarios
-- Uso: Permite gestionar los diferentes tipos de usuarios del sistema
-- ---------------------------------------------------------------------

create table fide_tipo_usuarios_tb (
   tipo_usuario_id number
      constraint tipo_usuarios_tipo_usuario_id_pk primary key,
   tipo            varchar2(50)
      constraint tipo_usuarios_tipo_usuario_nn not null,
   estado_id       number
      constraint tipo_usuarios_estado_fk
         references fide_estados_tb ( estado_id )
)

-- ---------------------------------------------------------------------
-- TABLA: FIDE_USUARIOS_POR_TIPO_USUARIO_TB
-- Descripción: Tabla intermedia para relacionar usuarios con tipos de usuarios
-- Uso: Permite asignar múltiples tipos de usuarios a un mismo usuario
-- ---------------------------------------------------------------------

create table fide_usuarios_por_tipo_usuario_tb (
   cedula          varchar2(12)
      constraint usuarios_por_tipo_usuario_cedula_fk
         references fide_usuarios_tb ( cedula ),
   tipo_usuario_id number
      constraint usuarios_por_tipo_usuario_tipo_usuario_id_fk
         references fide_tipo_usuarios_tb ( tipo_usuario_id ),
   estado_id       number
      constraint usuarios_por_tipo_usuario_estado_fk
         references fide_estados_tb ( estado_id ),
   constraint usuarios_por_tipo_usuario_pk primary key ( cedula,
                                                         tipo_usuario_id )
)

-- ---------------------------------------------------------------------
-- TABLA: FIDE_TELEFONOS_TB
-- Descripción: Tabla para teléfonos asociados a usuarios
-- Uso: Permite almacenar múltiples números de teléfono por usuario
-- ---------------------------------------------------------------------

create table fide_telefonos_tb (
   cedula    varchar(12)
      constraint telefonos_cedula_fk
         references fide_usuarios_tb ( cedula ),
   telefono  varchar2(8)
      constraint telefonos_telefono_nn not null,
   estado_id number
      constraint telefonos_estado_fk
         references fide_estados_tb ( estado_id ),
   constraint telefonos_pk primary key ( cedula,
                                         telefono )
)

-- ---------------------------------------------------------------------
-- TABLA: FIDE_CORREOS_TB
-- Descripción: Tabla para correos electrónicos asociados a usuarios
-- Uso: Permite almacenar múltiples correos electrónicos por usuario
-- ---------------------------------------------------------------------

create table fide_correos_tb (
   cedula    varchar(12)
      constraint correos_cedula_fk
         references fide_usuarios_tb ( cedula ),
   correo    varchar2(100)
      constraint correos_correo_nn not null,
   estado_id number
      constraint correos_estado_fk
         references fide_estados_tb ( estado_id ),
   constraint correos_pk primary key ( cedula,
                                       correo )
)