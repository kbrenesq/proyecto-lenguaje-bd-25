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
-- Modulo: Vehículo
-- =====================================================================


-- ---------------------------------------------------------------------
-- TABLA: FIDE_TIPO_CARROCERIAS_TB
-- Descripción: Tabla para almacenar los tipos de carrocerías de vehículos
-- Uso: Permite gestionar los diferentes tipos de carrocerías (sedán, SUV, etc)
-- ---------------------------------------------------------------------
create table fide_tipo_carrocerias_tb (
   tipo_carroceria_id number
      constraint tipo_carrocerias_tipo_carroceria_id_pk primary key,
   nombre             varchar2(50)
      constraint tipo_carrocerias_tipo_nn not null
      constraint tipo_carrocerias_tipo_uk unique,
   estado_id          number
      constraint tipo_carrocerias_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_TIPO_COMBUSTIONES_TB
-- Descripción: Tabla para almacenar los tipos de combustibles de vehículos
-- Uso: Permite gestionar los diferentes tipos de combustibles (gasolina, diésel, eléctrico, etc)
-- ---------------------------------------------------------------------

create table fide_tipo_combustiones_tb (
   tipo_combustion_id number
      constraint tipo_combustibles_tipo_combustion_id_pk primary key,
   nombre             varchar2(50)
      constraint tipo_combustibles_tipo_nn not null
      constraint tipo_combustibles_tipo_uk unique,
   estado_id          number
      constraint tipo_combustibles_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_TIPO_TRANSMISIONES_TB
-- Descripción: Tabla para almacenar los tipos de transmisiones de vehículos
-- Uso: Permite gestionar los diferentes tipos de transmisiones (manual, automática, etc)
-- ---------------------------------------------------------------------

create table fide_tipo_transmisiones_tb (
   tipo_transmision_id number
      constraint tipo_transmisiones_tipo_transmision_id_pk primary key,
   nombre              varchar2(50)
      constraint tipo_transmisiones_tipo_nn not null
      constraint tipo_transmisiones_tipo_uk unique,
   estado_id           number
      constraint tipo_transmisiones_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_TRACCIONES_TB
-- Descripción: Tabla para almacenar los tipos de tracciones de vehículos
-- Uso: Permite gestionar los diferentes tipos de tracciones (4x2, 4x4, etc)
-- ---------------------------------------------------------------------    

create table fide_tracciones_tb (
   traccion_id number
      constraint tracciones_traccion_id_pk primary key,
   nombre      varchar2(50)
      constraint tracciones_nombre_nn not null
      constraint tracciones_nombre_uk unique,
   estado_id   number
      constraint tracciones_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_MARCAS_VEHICULOS_TB
-- Descripción: Tabla para almacenar las marcas de vehículos
-- Uso: Permite gestionar las diferentes marcas de vehículos (Toyota, Ford, etc)
-- ---------------------------------------------------------------------

create table fide_marcas_vehiculos_tb (
   marca_id  number
      constraint marcas_vehiculos_marca_id_pk primary key,
   marca     varchar2(100)
      constraint marcas_vehiculos_marca_nn not null
      constraint marcas_vehiculos_marca_uk unique,
   estado_id number
      constraint marcas_vehiculos_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_MODELOS_VEHICULOS_TB
-- Descripción: Tabla para almacenar los modelos de vehículos
-- Uso: Permite gestionar los diferentes modelos de vehículos asociados a las marcas
-- ---------------------------------------------------------------------

create table fide_modelos_vehiculos_tb (
   modelo_id          number
      constraint modelos_vehiculos_modelo_id_pk primary key,
   marca_id           number
      constraint modelos_vehiculos_marca_id_fk
         references fide_marcas_vehiculos_tb ( marca_id )
      constraint modelos_vehiculos_marca_id_nn not null,
   tipo_carroceria_id number
      constraint modelos_vehiculos_tipo_carroceria_id_fk
         references fide_tipo_carrocerias_tb ( tipo_carroceria_id )
      constraint modelos_vehiculos_tipo_carroceria_id_nn not null,
   modelo             varchar2(100)
      constraint modelos_vehiculos_modelo_nn not null,
   estado_id          number
      constraint modelos_vehiculos_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_MOTORES_TB
-- Descripción: Tabla para almacenar los tipos de motores de vehículos
-- Uso: Permite gestionar los diferentes tipos de motores (V6, V8, eléctrico
-- ---------------------------------------------------------------------

create table fide_motores_tb (
   motor_id           number
      constraint motores_motor_id_pk primary key,
   tipo_combustion_id number
      constraint motores_tipo_combustion_id_fk
         references fide_tipo_combustiones_tb ( tipo_combustion_id )
      constraint motores_tipo_combustion_id_nn not null,
   nombre             varchar2(100)
      constraint motores_nombre_nn not null,
   potencia_hp        number(10,2),
   torque_nm          number(10,2),
   cilindraje_cc      number(10,2),
   estado_id          number
      constraint motores_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_TRANSMISIONES_TB
-- Descripción: Tabla para almacenar las transmisiones de vehículos
-- Uso: Permite gestionar las diferentes transmisiones disponibles en vehículos
-- ---------------------------------------------------------------------

create table fide_transmisiones_tb (
   transmision_id      number
      constraint transmisiones_transmision_id_pk primary key,
   tipo_transmision_id number
      constraint transmisiones_tipo_transmision_id_fk
         references fide_tipo_transmisiones_tb ( tipo_transmision_id )
      constraint transmisiones_tipo_transmision_id_nn not null,
   tipo_traccion_id    number
      constraint transmisiones_tipo_traccion_id_fk
         references fide_tracciones_tb ( traccion_id )
      constraint transmisiones_tipo_traccion_id_nn not null,
   nombre              varchar2(100),
   velocidades         number,
   estado_id           number
      constraint transmisiones_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_MODELOS_VERSIONES_TB
-- Descripción: Tabla para almacenar las versiones específicas de los modelos de vehículos
-- Uso: Permite gestionar las diferentes versiones de un mismo modelo de vehículo
-- ---------------------------------------------------------------------

create table fide_modelos_versiones_tb (
   modelo_version_id number
      constraint modelos_versiones_modelo_version_id_pk primary key,
   modelo_id         number
      constraint modelos_versiones_modelo_id_fk
         references fide_modelos_vehiculos_tb ( modelo_id )
      constraint modelos_versiones_modelo_id_nn not null,
   motor_id          number
      constraint modelos_versiones_motor_id_fk
         references fide_motores_tb ( motor_id )
      constraint modelos_versiones_motor_id_nn not null,
   transmision_id    number
      constraint modelos_versiones_transmision_id_fk
         references fide_transmisiones_tb ( transmision_id )
      constraint modelos_versiones_transmision_id_nn not null,
   nombre            varchar2(100)
      constraint modelos_versiones_nombre_nn not null,
   numero_puertas    number
      constraint modelos_versiones_numero_puertas_nn not null,
   estado_id         number
      constraint modelos_versiones_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_VEHICULOS_TB
-- Descripción: Tabla para almacenar los vehículos registrados en el sistema
-- Uso: Permite gestionar la información de los vehículos atendidos en el taller
-- ---------------------------------------------------------------------

create table fide_vehiculos_tb (
   placa_id          varchar2(6)
      constraint vehiculos_placa_id_pk primary key,
   cedula            varchar2(12)
      constraint vehiculos_cedula_fk
         references fide_usuarios_tb ( cedula )
      constraint vehiculos_cedula_nn not null,
   modelo_version_id number
      constraint vehiculos_modelo_version_id_fk
         references fide_modelos_versiones_tb ( modelo_version_id )
      constraint vehiculos_modelo_version_id_nn not null,
   anio_fabricacion  number,
   kilometraje       number(10,2),
   fecha_registro    date
      constraint vehiculos_fecha_registro_nn not null,
   estado_id         number
      constraint vehiculos_estado_fk
         references fide_estados_tb ( estado_id )
);