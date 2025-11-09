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
-- Modulo: Facturación
-- =====================================================================

-- ---------------------------------------------------------------------
-- TABLA: FIDE_METODOS_PAGO_TB
-- Descripción: Tabla para almacenar los métodos de pago disponibles
-- Uso: Permite gestionar los diferentes métodos de pago aceptados en el taller mecánico
-- ---------------------------------------------------------------------    

create table fide_metodos_pago_tb (
   metodo_pago_id number
      constraint metodos_pago_metodo_pago_id_pk primary key,
   nombre         varchar2(100)
      constraint metodos_pago_metodo_nn not null
      constraint metodos_pago_metodo_uk unique,
   estado_id      number
      constraint metodos_pago_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_PAGOS_TB
-- Descripción: Tabla para almacenar los pagos realizados por los clientes
-- Uso: Permite registrar y gestionar los pagos efectuados en el taller mecánico
-- ---------------------------------------------------------------------

create table fide_pagos_tb (
   pago_id        number
      constraint pagos_pago_id_pk primary key
      constraint pagos_factura_id_nn not null,
   metodo_pago_id number
      constraint pagos_metodo_pago_id_fk
         references fide_metodos_pago_tb ( metodo_pago_id )
      constraint pagos_metodo_pago_id_nn not null,
   monto          number(10,4)
      constraint pagos_monto_nn not null,
   fecha_pago     date
      constraint pagos_fecha_pago_nn not null,
   estado_id      number
      constraint pagos_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_FACTURAS_TB
-- Descripción: Tabla para almacenar las facturas emitidas a los clientes
-- Uso: Permite gestionar las facturas generadas por los servicios y productos vendidos
-- ---------------------------------------------------------------------
create table fide_facturas_tb (
   factura_id       number
      constraint facturas_factura_id_pk primary key,
   orden_trabajo_id number
      constraint facturas_orden_trabajo_id_fk
         references fide_ordenes_de_trabajo_tb ( orden_trabajo_id )
      constraint facturas_orden_trabajo_id_nn not null,
   cedula           varchar2(12)
      constraint facturas_cedula_fk
         references fide_usuarios_tb ( cedula )
      constraint facturas_cedula_nn not null,
   fecha_emision    date
      constraint facturas_fecha_emision_nn not null,
   subtotal         number(10,4)
      constraint facturas_subtotal_nn not null,
   impuesto         number(10,4)
      constraint facturas_impuesto_nn not null,
   total            number(10,4)
      constraint facturas_total_nn not null,
   estado_id        number
      constraint facturas_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_DETALLES_FACTURA_TB
-- Descripción: Tabla para almacenar los detalles de cada factura
-- Uso: Permite gestionar los productos y servicios incluidos en cada factura
-- ---------------------------------------------------------------------

create table fide_detalles_factura_tb (
   detalle_id      number
      constraint detalles_factura_detalle_id_pk primary key,
   factura_id      number
      constraint detalles_factura_factura_id_fk
         references fide_facturas_tb ( factura_id )
      constraint detalles_factura_factura_id_nn not null,
   descripcion     varchar2(255)
      constraint detalles_factura_descripcion_nn not null,
   cantidad        integer
      constraint detalles_factura_cantidad_nn not null,
   precio_unitario number(10,4)
      constraint detalles_factura_precio_unitario_nn not null,
   total           number(10,4)
      constraint detalles_factura_total_nn not null,
   estado_id       number
      constraint detalles_factura_estado_fk
         references fide_estados_tb ( estado_id )
);