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


-- ---------------------------------------------------------------------
-- VISTA: FIDE_INFORMACION_PUESTOS_MECANICOS_ACTIVOS_V 
-- Descripción: Vista que muestra la información de los mecánicos activos junto con sus puestos 
-- ---------------------------------------------------------------------

create or replace view fide_informacion_puestos_mecanicos_activos_v as
   select m.mecanico_id,
          m.cedula,
          p.puesto,
          m.fecha_ingreso,
          m.estado_id
     from fide_mecanicos_tb m
     join fide_usuarios_tb u
   on m.cedula = u.cedula
     join fide_puestos_tb p
   on m.puesto_id = p.puesto_id
    where u.estado_id = 1;  -- Solo mecánicos activos
/

-- ---------------------------------------------------------------------
-- VISTA: FIDE_INFORMACION_SALARIOS_MECANICOS_ACTIVOS_V
-- Descripción: Vista que muestra la información de los salarios de los mecánicos activos
-- ---------------------------------------------------------------------

create or replace view fide_informacion_salarios_mecanicos_activos_v as
   select s.salario_id,
          m.cedula,
          u.primer_nombre
          || ' '
          || u.primer_apellido as nombre_mecanico,
          s.salario,
          s.fecha_inicio,
          s.fecha_fin
     from fide_salarios_tb s
     join fide_mecanicos_tb m
   on s.mecanico_id = m.mecanico_id
     join fide_usuarios_tb u
   on m.cedula = u.cedula
    where u.estado_id = 1;  -- Solo mecánicos activos
/

-- ---------------------------------------------------------------------
-- VISTA: FIDE_USUARIOS_POR_CANTIDAD_DE_VEHICULOS_V
-- Descripción: Vista que muestra los usuarios ordenados por la cantidad de vehículos registrados
-- ---------------------------------------------------------------------

create or replace view fide_usuarios_por_cantidad_de_vehiculos_v as
   select u.cedula,
          u.primer_nombre
          || ' '
          || u.segundo_nombre
          || ' '
          || u.primer_apellido
          || ' '
          || u.segundo_apellido as nombre_usuario,
          count(v.placa_id) as total_vehiculos
     from fide_usuarios_tb u
     join fide_vehiculos_tb v
   on u.cedula = v.cedula
    group by u.cedula,
             u.primer_nombre,
             u.segundo_nombre,
             u.primer_apellido,
             u.segundo_apellido
    order by count(v.placa_id) desc;

-- ---------------------------------------------------------------------
-- VISTA: FIDE_MECANICOS_POR_MAS_HORAS_TRABAJADAS_V
-- Descripción: Vista que muestra los mecánicos ordenados por las horas trabajadas
-- ---------------------------------------------------------------------

create or replace view fide_mecanicos_por_mas_horas_trabajadas_v as
   select m.mecanico_id,
          m.cedula,
          sum(t.horas_trabajadas) as total_horas
     from fide_mecanicos_tb m
     join fide_trabajos_realizados_por_mecanico_tb t
   on m.mecanico_id = t.mecanico_id
    group by m.mecanico_id,
             m.cedula;
/



-- ---------------------------------------------------------------------
-- VISTA: FIDE_CLIENTES_CON_MAS_VISITAS_V
-- Descripción: Vista que muestra los clientes con más visitas al taller
-- ---------------------------------------------------------------------

create or replace view fide_clientes_con_mas_visitas_v as
   select c.cedula,
          c.primer_nombre
          || ' '
          || c.segundo_nombre
          || ' '
          || c.primer_apellido
          || ' '
          || c.segundo_apellido as nombre_cliente,
          count(o.orden_trabajo_id) as total_visitas
     from fide_usuarios_tb c
     join fide_vehiculos_tb v
   on c.cedula = v.cedula
     join fide_ordenes_de_trabajo_tb o
   on v.placa_id = o.placa_id
    group by c.cedula,
             c.primer_nombre,
             c.segundo_nombre,
             c.primer_apellido,
             c.segundo_apellido
    order by count(o.orden_trabajo_id) desc;
/

-- ---------------------------------------------------------------------
-- VISTA: FIDE_TIPOS_USUARIO_POR_USUARIO_V
-- Descripción: Vista que muestra los tipos de usuario junto con la cantidad de usuarios por tipo
-- ---------------------------------------------------------------------

create or replace view fide_tipos_usuario_por_usuario_v as
   select u.cedula,
          u.primer_nombre,
          u.segundo_nombre,
          u.primer_apellido,
          u.segundo_apellido,
          u.fecha_nacimiento,
          u.estado_id,
          listagg(tu.tipo,
                  ', ') within group(
           order by tu.tipo) as tipo_usuario,
          listagg(c.correo,
                  ', ') within group(
           order by c.correo) as correos,
          listagg(t.telefono,
                  ', ') within group(
           order by t.telefono) as telefonos
     from fide_usuarios_tb u
     left join fide_usuarios_por_tipo_usuario_tb ut
   on u.cedula = ut.cedula
     left join fide_tipo_usuarios_tb tu
   on tu.tipo_usuario_id = ut.tipo_usuario_id
     left join fide_correos_tb c
   on c.cedula = u.cedula
     left join fide_telefonos_tb t
   on t.cedula = u.cedula
    group by u.cedula,
             u.primer_nombre,
             u.segundo_nombre,
             u.primer_apellido,
             u.segundo_apellido,
             u.fecha_nacimiento,
             u.estado_id;