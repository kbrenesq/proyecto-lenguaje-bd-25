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
-- Modulo: Vistas SmartMotriz
-- =====================================================================

create or replace view fide_informacion_puestos_mecanicos_v as
   select m.mecanico_id,
          m.cedula,
          p.puesto,
          m.fecha_ingreso,
          m.estado_id
     from fide_mecanicos_tb m
     join fide_puestos_tb p
   on m.puesto_id = p.puesto_id;
/

create or replace view fide_informacion_salarios_mecanicos_v as
   select s.salario_id,
          m.cedula,
          s.salario,
          s.fecha_inicio,
          s.fecha_fin
     from fide_salarios_tb s
     join fide_mecanicos_tb m
   on s.mecanico_id = m.mecanico_id;
/