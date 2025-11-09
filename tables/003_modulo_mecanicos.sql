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
-- Modulo: Mecanicos
-- =====================================================================


-- ---------------------------------------------------------------------
-- TABLA: FIDE_PUESTOS_TB
-- Descripción: Tabla para almacenar los puestos de los mecánicos
-- Uso: Permite gestionar los diferentes puestos dentro del taller mecánico
-- ---------------------------------------------------------------------

create table fide_puestos_tb (
   puesto_id   number
      constraint puestos_puesto_id_pk primary key,
   puesto      varchar2(100)
      constraint puestos_puesto_nn not null
      constraint puestos_puesto_uk unique,
   salario_max number(10,4)
      constraint puestos_salario_max_nn not null,
   salario_min number(10,4)
      constraint puestos_salario_min_nn not null,
   estado_id   number
      constraint puestos_estado_fk
         references fide_estados_tb ( estado_id )
)

-- ---------------------------------------------------------------------
-- TABLA: FIDE_MECANICOS_TB
-- Descripción: Tabla para almacenar información específica de mecánicos
-- Uso: Permite gestionar la información de los mecánicos en el sistema
-- ---------------------------------------------------------------------

create table fide_mecanicos_tb (
   mecanico_id   number
      constraint mecanicos_mecanico_id_pk primary key,
   cedula        varchar2(12)
      constraint mecanicos_cedula_fk
         references fide_usuarios_tb ( cedula )
      constraint mecanicos_cedula_uk unique
      constraint mecanicos_cedula_nn not null,
   puesto_id     number
      constraint mecanicos_puesto_id_fk
         references fide_puestos_tb ( puesto_id )
      constraint mecanicos_puesto_id_nn not null,
   fecha_ingreso date
      constraint mecanicos_fecha_ingreso_nn not null,
   fecha_fin     date,
   estado_id     number
      constraint mecanicos_estado_fk
         references fide_estados_tb ( estado_id )
)

-- ---------------------------------------------------------------------
-- TABLA: FIDE_REGISTRO_ASISTENCIA_TB
-- Descripción: Tabla para registrar la asistencia de los mecánicos
-- Uso: Permite llevar un control de la asistencia diaria de los mecánicos
-- ---------------------------------------------------------------------

create table fide_registro_asistencia_tb (
   mecanico_id  number
      constraint registro_asistencia_mecanico_id_fk
         references fide_mecanicos_tb ( mecanico_id )
      constraint registro_asistencia_mecanico_id_nn not null,
   fecha        date
      constraint registro_asistencia_fecha_nn not null,
   hora_entrada timestamp,
   hora_salida  timestamp,
   estado_id    number
      constraint registro_asistencia_estado_fk
         references fide_estados_tb ( estado_id ),
   constraint registro_asistencia_pk primary key ( mecanico_id,
                                                   fecha )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_SALARIOS_TB
-- Descripción: Tabla para almacenar los salarios de los mecánicos
-- Uso: Permite gestionar la información salarial de los mecánicos en el sistema
-- ---------------------------------------------------------------------

create table fide_salarios_tb (
   salario_id    number
      constraint salarios_salario_id_pk primary key,
   mecanico_id   number
      constraint salarios_mecanico_id_fk
         references fide_mecanicos_tb ( mecanico_id ),
   salario       number(10,4)
      constraint salarios_salario_nn not null,
   fecha_inicio  date
      constraint salarios_fecha_inicio_nn not null,
   fecha_fin     date,
   motivo_cambio varchar2(255),
   estado_id     number
      constraint salarios_estado_fk
         references fide_estados_tb ( estado_id )
)