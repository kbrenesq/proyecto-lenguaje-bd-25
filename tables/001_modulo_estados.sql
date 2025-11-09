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
-- Modulo: Tabla de Estados
-- =====================================================================


-- ---------------------------------------------------------------------
-- TABLA: FIDE_ESTADOS_TB
-- Descripción: Tabla catálogo para estados de todas las entidades
-- Uso: Permite soft deletes y control de estados en todo el sistema
-- ---------------------------------------------------------------------

create table fide_estados_tb (
   estado_id number
      constraint estados_estado_id_pk primary key,
   estado    varchar2(50)
      constraint estados_estado_nn not null
)