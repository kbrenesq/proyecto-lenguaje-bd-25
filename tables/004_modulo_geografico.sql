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
-- Modulo: Geofrafico
-- =====================================================================


-- ---------------------------------------------------------------------
-- TABLA: FIDE_TIPO_DIRECCIONES_TB
-- Descripción: Tabla para almacenar los tipos de direcciones
-- Uso: Permite gestionar los diferentes tipos de direcciones (casa, trabajo, etc)
-- ---------------------------------------------------------------------

create table fide_tipo_direcciones_tb (
   tipo_direccion_id number
      constraint tipo_direcciones_tipo_direccion_id_pk primary key,
   tipo              varchar2(50)
      constraint tipo_direcciones_tipo_nn not null
      constraint tipo_direcciones_tipo_uk unique,
   estado_id         number
      constraint tipo_direcciones_estado_fk
         references fide_estados_tb ( estado_id )
);


-- ---------------------------------------------------------------------
-- TABLA: FIDE_FIDE_PROVINCIAS_TB
-- Descripción: Tabla para almacenar las provincias
-- Uso: Permite gestionar las provincias del país
-- ---------------------------------------------------------------------

create table fide_provincias_tb (
   provincia_id number
      constraint provincias_provincia_id_pk primary key,
   provincia    varchar2(100)
      constraint provincias_provincia_nn not null
      constraint provincias_provincia_uk unique,
   estado_id    number
      constraint provincias_estado_fk
         references fide_estados_tb ( estado_id )
);



-- ---------------------------------------------------------------------
-- TABLA: FIDE_CANTONES_TB
-- Descripción: Tabla para almacenar los cantones
-- Uso: Permite gestionar los cantones asociados a las provincias
-- ---------------------------------------------------------------------

create table fide_cantones_tb (
   canton_id    number
      constraint cantones_canton_id_pk primary key,
   canton       varchar2(100)
      constraint cantones_canton_nn not null
      constraint cantones_canton_uk unique,
   provincia_id number
      constraint cantones_provincia_id_fk
         references fide_provincias_tb ( provincia_id ),
   estado_id    number
      constraint cantones_estado_fk
         references fide_estados_tb ( estado_id )
);



-- ---------------------------------------------------------------------
-- TABLA: FIDE_DISTRITOS_TB
-- Descripción: Tabla para almacenar los distritos
-- Uso: Permite gestionar los distritos asociados a los cantones
-- ---------------------------------------------------------------------

create table fide_distritos_tb (
   distrito_id number
      constraint distritos_distrito_id_pk primary key,
   distrito    varchar2(100)
      constraint distritos_distrito_nn not null,
   canton_id   number
      constraint distritos_canton_id_fk
         references fide_cantones_tb ( canton_id ),
   estado_id   number
      constraint distritos_estado_fk
         references fide_estados_tb ( estado_id )
);


-- ---------------------------------------------------------------------
-- TABLA: FIDE_DIRECCIONES_TB
-- Descripción: Tabla para almacenar direcciones específicas
-- Uso: Permite gestionar las direcciones detalladas de usuarios
-- ---------------------------------------------------------------------

create table fide_direcciones_tb (
   cedula            varchar2(12)
      constraint direcciones_cedula_fk
         references fide_usuarios_tb ( cedula ),
   tipo_direccion_id number
      constraint direcciones_tipo_direccion_id_fk
         references fide_tipo_direcciones_tb ( tipo_direccion_id ),
   distrito_id       number
      constraint direcciones_distrito_id_fk
         references fide_distritos_tb ( distrito_id ),
   otras_senas       varchar2(255),
   estado_id         number
      constraint direcciones_estado_fk
         references fide_estados_tb ( estado_id ),
   constraint direcciones_pk primary key ( cedula,
                                           tipo_direccion_id )
);