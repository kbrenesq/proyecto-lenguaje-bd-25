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
-- Modulo: Sequencias de las tablas de SmartMotriz
-- =====================================================================

-- ---------------------------------------------------------------------
-- SECUENCIA: ESTADOS_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_estados_tb
-- ---------------------------------------------------------------------
create sequence estados_seq start with 1 increment by 1 nocache nocycle;

-- ---------------------------------------------------------------------
-- SECUENCIA: TIPOS_USUARIOS_SEQ
-- Uso: Generar IDs para la tabla FIDE_TIPO_USUARIOS_TB
-- ---------------------------------------------------------------------
create sequence tipos_usuarios_seq start with 1 increment by 1 nocache nocycle;

-- ---------------------------------------------------------------------
-- SECUENCIA: PUESTOS_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_puestos_tb
-- ---------------------------------------------------------------------
create sequence puestos_seq start with 1 increment by 1 nocache nocycle;

-- ---------------------------------------------------------------------
-- SECUENCIA: MECANICOS_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_mecanicos_tb
-- ---------------------------------------------------------------------
create sequence mecanicos_seq start with 1 increment by 1 nocache nocycle;

-- ---------------------------------------------------------------------
-- SECUENCIA: SALARIOS_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_salarios_tb
-- ---------------------------------------------------------------------
create sequence salarios_seq start with 1 increment by 1 nocache nocycle;

-- ---------------------------------------------------------------------
-- SECUENCIA: TIPO_DIRECCIONES_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_tipo_direcciones_tb
-- ---------------------------------------------------------------------
create sequence tipo_direcciones_seq start with 1 increment by 1 nocache nocycle;

-- ---------------------------------------------------------------------
-- SECUENCIA: PROVINCIAS_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_provincias_tb
-- ---------------------------------------------------------------------
create sequence provincias_seq start with 1 increment by 1 nocache nocycle;

-- ---------------------------------------------------------------------
-- SECUENCIA: CANTONES_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_cantones_tb
-- ---------------------------------------------------------------------
create sequence cantones_seq start with 1 increment by 1 nocache nocycle;

-- ---------------------------------------------------------------------
-- SECUENCIA: DISTRITOS_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_distritos_tb
-- ---------------------------------------------------------------------
create sequence distritos_seq start with 1 increment by 1 nocache nocycle;