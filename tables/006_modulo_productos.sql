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
-- Modulo: Prodcutos
-- =====================================================================

-- ---------------------------------------------------------------------
-- TABLA: FIDE_CATEGORIAS_PRODUCTOS_TB
-- Descripción: Tabla para almacenar las categorías de los productos
-- Uso: Permite clasificar los productos en diferentes categorías
-- ---------------------------------------------------------------------    

create table fide_categorias_productos_tb (
   categoria_id number
      constraint categorias_productos_categoria_id_pk primary key,
   categoria    varchar2(100)
      constraint categorias_productos_categoria_nn not null
      constraint categorias_productos_categoria_uk unique,
   descripcion  varchar2(255),
   estado_id    number
      constraint categorias_productos_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_PRODUCTOS_TB
-- Descripción: Tabla para almacenar los productos del inventario
-- Uso: Permite gestionar los productos disponibles en el taller mecánico
-- ---------------------------------------------------------------------

create table fide_productos_tb (
   producto_id     number
      constraint productos_producto_id_pk primary key,
   categoria_id    number
      constraint productos_categoria_id_fk
         references fide_categorias_productos_tb ( categoria_id )
      constraint productos_categoria_id_nn not null,
   nombre          varchar2(100)
      constraint productos_nombre_nn not null,
   descripcion     varchar2(255),
   precio_unitario number(10,4)
      constraint productos_precio_unit_nn not null,
   cantidad_stock  integer
      constraint productos_cantidad_stock_nn not null,
   estado_id       number
      constraint productos_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_PROVEEDORES_TB
-- Descripción: Tabla para almacenar los proveedores de productos
-- Uso: Permite gestionar la información de los proveedores del taller mecánico
-- ---------------------------------------------------------------------

create table fide_proveedores_tb (
   proveedor_id number
      constraint proveedores_proveedor_id_pk primary key,
   nombre       varchar2(100)
      constraint proveedores_nombre_nn not null,
   descripcion  varchar2(255),
   estado_id    number
      constraint proveedores_estado_fk
         references fide_estados_tb ( estado_id )
);

-- ---------------------------------------------------------------------
-- TABLA: FIDE_PRODUCTOS_POR_PROVEEDORES_TB
-- Descripción: Tabla para almacenar la relación entre productos y proveedores
-- Uso: Permite gestionar qué proveedores suministran qué productos
-- ---------------------------------------------------------------------

create table fide_productos_por_proveedores_tb (
   producto_id  number
      constraint productos_por_proveedores_producto_id_fk
         references fide_productos_tb ( producto_id )
      constraint productos_por_proveedores_producto_id_nn not null,
   proveedor_id number
      constraint productos_por_proveedores_proveedor_id_fk
         references fide_proveedores_tb ( proveedor_id )
      constraint productos_por_proveedores_proveedor_id_nn not null,
   estado_id    number
      constraint productos_por_proveedores_estado_fk
         references fide_estados_tb ( estado_id ),
   constraint productos_por_proveedores_pk primary key ( producto_id,
                                                         proveedor_id )
);