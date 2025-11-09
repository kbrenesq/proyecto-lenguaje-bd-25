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
-- Modulo: Trabajos
-- =====================================================================

-- ---------------------------------------------------------------------
-- TABLA: FIDE_ORDENES_DE_TRABAJO_TB
-- Descripción: Tabla para almacenar las órdenes de trabajo realizadas
-- Uso: Permite gestionar las órdenes de trabajo asignadas a los vehículos
-- ---------------------------------------------------------------------

create table fide_ordenes_de_trabajo_tb (
   orden_trabajo_id number
      constraint ordenes_trabajo_orden_trabajo_id_pk primary key,
   placa_id         varchar2(6)
      constraint ordenes_trabajo_placa_id_fk
         references fide_vehiculos_tb ( placa_id )
      constraint ordenes_trabajo_placa_id_nn not null,
   fecha_inicio     date
      constraint ordenes_trabajo_fecha_inicio_nn not null,
   fecha_fin        date,
   descripcion      varchar2(500)
      constraint ordenes_trabajo_descripcion_nn not null,
   estado_id        number
      constraint ordenes_trabajo_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_TIPOS_DE_TRABAJO_TB
-- Descripción: Tabla para almacenar los tipos de trabajo que se pueden realizar
-- Uso: Permite gestionar los diferentes tipos de trabajos en el taller
-- ---------------------------------------------------------------------

create table fide_tipos_de_trabajo_tb (
   tipo_trabajo_id number
      constraint tipos_de_trabajo_tipo_trabajo_id_pk primary key,
   tipo_trabajo    varchar2(100)
      constraint tipos_de_trabajo_tipo_trabajo_nn not null
      constraint tipos_de_trabajo_tipo_trabajo_uk unique,
   descripcion     varchar2(500),
   precio          number(10,4)
      constraint tipos_de_trabajo_precio_nn not null,
   estado_id       number
      constraint tipos_de_trabajo_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_TRABAJOS_REALIZADOS_TB
-- Descripción: Tabla para almacenar los trabajos realizados en cada orden de trabajo
-- Uso: Permite gestionar los trabajos específicos realizados en cada orden de trabajo
-- ---------------------------------------------------------------------    

create table fide_trabajos_realizados_tb (
   trabajo_realizado_id number
      constraint trabajos_realizados_trabajo_realizado_id_pk primary key,
   orden_trabajo_id     number
      constraint trabajos_realizados_orden_trabajo_id_fk
         references fide_ordenes_de_trabajo_tb ( orden_trabajo_id )
      constraint trabajos_realizados_orden_trabajo_id_nn not null,
   tipo_trabajo_id      number
      constraint trabajos_realizados_tipo_trabajo_id_fk
         references fide_tipos_de_trabajo_tb ( tipo_trabajo_id )
      constraint trabajos_realizados_tipo_trabajo_id_nn not null,
   fecha                date
      constraint trabajos_realizados_fecha_nn not null,
   estado_id            number
      constraint trabajos_realizados_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_TRABAJOS_REALIZADOS_POR_MECANICO_TB
-- Descripción: Tabla intermedia para relacionar trabajos realizados con mecánicos
-- Uso: Permite asignar múltiples mecánicos a un mismo trabajo realizado
-- ---------------------------------------------------------------------

create table fide_trabajos_realizados_por_mecanico_tb (
   trabajo_realizado_id number
      constraint trabajos_realizados_por_mecanico_trabajo_realizado_id_fk
         references fide_trabajos_realizados_tb ( trabajo_realizado_id )
      constraint trabajos_realizados_por_mecanico_trabajo_realizado_id_nn not null,
   mecanico_id          number
      constraint trabajos_realizados_por_mecanico_mecanico_id_fk
         references fide_mecanicos_tb ( mecanico_id )
      constraint trabajos_realizados_por_mecanico_mecanico_id_nn not null,
   notas                varchar2(500),
   horas_trabajadas     number(5,2)
      constraint trabajos_realizados_por_mecanico_horas_trabajadas_nn not null,
   estado_id            number
      constraint trabajos_realizados_por_mecanico_estado_fk
         references fide_estados_tb ( estado_id ),
   constraint trabajos_realizados_por_mecanico_pk primary key ( trabajo_realizado_id,
                                                                mecanico_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_PRODUCTOS_USADOS_POR_TRABAJO_TB
-- Descripción: Tabla intermedia para relacionar productos usados en trabajos realizados
-- Uso: Permite gestionar los productos utilizados en cada trabajo realizado
-- ---------------------------------------------------------------------

create table fide_productos_usados_por_trabajo_tb (
   trabajo_realizado_id number
      constraint productos_usados_por_trabajo_trabajo_realizado_id_fk
         references fide_trabajos_realizados_tb ( trabajo_realizado_id )
      constraint productos_usados_por_trabajo_trabajo_realizado_id_nn not null,
   producto_id          number
      constraint productos_usados_por_trabajo_producto_id_fk
         references fide_productos_tb ( producto_id )
      constraint productos_usados_por_trabajo_producto_id_nn not null,
   cantidad             integer
      constraint productos_usados_por_trabajo_cantidad_nn not null,
   estado_id            number
      constraint productos_usados_por_trabajo_estado_fk
         references fide_estados_tb ( estado_id ),
   constraint productos_usados_por_trabajo_pk primary key ( trabajo_realizado_id,
                                                            producto_id )
);