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
-- SECUENCIA: FIDE_ESTADOS_SEQ
-- Descripción: Secuencia para generar IDs únicos para la tabla fide_estados_tb
-- ---------------------------------------------------------------------
create sequence estados_seq start with 1 increment by 1 nocache nocycle;


-- --------------------------------------------------------------
-- SECUENCIA: TIPOS_USUARIOS_SEQ
-- Uso: Generar IDs para la tabla FIDE_TIPO_USUARIOS_TB
-- --------------------------------------------------------------
create sequence tipos_usuarios_seq start with 1 increment by 1 nocache nocycle;