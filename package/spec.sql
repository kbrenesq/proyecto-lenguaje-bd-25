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
-- Modulo: Specificación del paquete de SmartMotriz
-- =====================================================================


-- ---------------------------------------------------------------------
-- PAQUETE: FIDE_SMARTMOTRIZ_PKG
-- Descripción: Paquete que contiene procedimientos y funciones
--              comunes para la gestión del sistema SmartMotriz.
-- ---------------------------------------------------------------------

create or replace package fide_smartmotriz_pkg as

    -- -----------------------------------------------------------------
    -- Procedimiento: INSERTAR_ESTADO
    -- Descripción: Inserta un nuevo estado en la tabla fide_estados_tb.
    -- Parámetros:
    --   p_estado - Nombre del estado a insertar.
    -- Retorna: El ID del estado insertado.
    -- -----------------------------------------------------------------

   procedure estados_insertar_estado_sp (
      p_estado in varchar2
   );

   -- -----------------------------------------------------------------
    -- Procedimiento: ACTUALIZAR_ESTADO
    -- Descripción: Actualiza el nombre de un estado existente.
    -- Parámetros:
    --   p_estado_id - ID del estado a actualizar.
    --   p_estado    - Nuevo nombre del estado.
    -- -----------------------------------------------------------------

   procedure estados_actualizar_estado_sp (
      p_estado_id in number,
      p_estado    in varchar2
   );

    -- -----------------------------------------------------------------
     -- Procedimiento: ARCHIVAR_ESTADO
     -- Descripción: Marca un estado como archivado en la tabla fide_estados_tb.
     -- Parámetros:
     --   p_estado_id - ID del estado a eliminar.
     -- -----------------------------------------------------------------

   procedure estados_archivar_estado_sp (
      p_estado_id in number
   );


end fide_smartmotriz_pkg;