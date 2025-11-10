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

    ---------------------------------------------------------------------
   -- ESTADOS
   ---------------------------------------------------------------------

   procedure estados_insertar_estado_sp (
      p_estado in varchar2
   );


   procedure estados_actualizar_estado_sp (
      p_estado_id in number,
      p_estado    in varchar2
   );

   procedure estados_archivar_estado_sp (
      p_estado_id in number
   );

    ---------------------------------------------------------------------
   -- USUARIOS
   ---------------------------------------------------------------------

   procedure usuarios_insertar_usuario_sp (
      p_cedula           in varchar2,
      p_primer_nombre    in varchar2,
      p_segundo_nombre   in varchar2,
      p_primer_apellido  in varchar2,
      p_segundo_apellido in varchar2,
      p_fecha_nacimiento in date,
      p_estado_id        in number
   );

   procedure usuarios_actualizar_usuario_sp (
      p_cedula           in varchar2,
      p_primer_nombre    in varchar2,
      p_segundo_nombre   in varchar2,
      p_primer_apellido  in varchar2,
      p_segundo_apellido in varchar2,
      p_fecha_nacimiento in date,
      p_estado_id        in number
   );

   procedure usuarios_archivar_usuario_sp (
      p_cedula in varchar2
   );

   ---------------------------------------------------------------------
   -- TIPO USUARIOS
   ---------------------------------------------------------------------

   procedure tipo_usuarios_insertar_tipo_sp (
      p_tipo      in varchar2,
      p_estado_id in number
   );

   procedure tipo_usuarios_actualizar_tipo_sp (
      p_tipo_usuario_id in number,
      p_tipo            in varchar2,
      p_estado_id       in number
   );

   procedure tipo_usuarios_archivar_tipo_sp (
      p_tipo_usuario_id in number
   );

   ---------------------------------------------------------------------
   -- USUARIOS POR TIPO USUARIO
   ---------------------------------------------------------------------

   procedure usuarios_tipos_insertar_relacion_sp (
      p_cedula          in varchar2,
      p_tipo_usuario_id in number,
      p_estado_id       in number
   );

   procedure usuarios_tipos_actualizar_relacion_sp (
      p_cedula          in fide_usuarios_por_tipo_usuario_tb.cedula%type,
      p_tipo_usuario_id in fide_usuarios_por_tipo_usuario_tb.tipo_usuario_id%type
   );

   procedure usuarios_tipos_archivar_relacion_sp (
      p_cedula          in varchar2,
      p_tipo_usuario_id in number
   );

   ---------------------------------------------------------------------
   -- TELÉFONOS
   ---------------------------------------------------------------------

   procedure telefonos_insertar_telefono_sp (
      p_cedula    in varchar2,
      p_telefono  in varchar2,
      p_estado_id in number
   );

   procedure telefonos_actualizar_telefono_sp (
      p_cedula          in fide_telefonos_tb.cedula%type,
      p_telefono_actual in fide_telefonos_tb.telefono%type,
      p_telefono_nuevo  in fide_telefonos_tb.telefono%type
   );

   procedure telefonos_archivar_telefono_sp (
      p_cedula   in varchar2,
      p_telefono in varchar2
   );

   ---------------------------------------------------------------------
   -- CORREOS
   ---------------------------------------------------------------------

   procedure correos_insertar_correo_sp (
      p_cedula    in varchar2,
      p_correo    in varchar2,
      p_estado_id in number
   );

   procedure correos_actualizar_correo_sp (
      p_cedula        in fide_correos_tb.cedula%type,
      p_correo_actual in fide_correos_tb.correo%type,
      p_correo_nuevo  in fide_correos_tb.correo%type
   );
   procedure correos_archivar_correo_sp (
      p_cedula in varchar2,
      p_correo in varchar2
   );

   ---------------------------------------------------------------------
   -- PUESTOS
   ---------------------------------------------------------------------
   procedure puestos_insertar_puesto_sp (
      p_puesto      in varchar2,
      p_salario_min in number,
      p_salario_max in number,
      p_estado_id   in number
   );

   procedure puestos_actualizar_puesto_sp (
      p_puesto_id   in number,
      p_puesto      in varchar2,
      p_salario_min in number,
      p_salario_max in number,
      p_estado_id   in number
   );

   procedure puestos_archivar_puesto_sp (
      p_puesto_id in number
   );
    
    
    
   ---------------------------------------------------------------------
   -- MECANICOS
   ---------------------------------------------------------------------
   procedure mecanicos_insertar_mecanico_sp (
      p_cedula        in varchar2,
      p_puesto_id     in number,
      p_fecha_ingreso in date,
      p_fecha_fin     in date,
      p_estado_id     in number
   );

   procedure mecanicos_actualizar_mecanico_sp (
      p_mecanico_id in number,
      p_puesto_id   in number,
      p_fecha_fin   in date,
      p_estado_id   in number
   );

   procedure mecanicos_archivar_mecanico_sp (
      p_mecanico_id in number
   );
    
   ---------------------------------------------------------------------
   -- REGISTRO_ASISTENCIA
   ---------------------------------------------------------------------
   procedure registro_asistencia_insertar_asistencia_sp (
      p_mecanico_id  in number,
      p_fecha        in date,
      p_hora_entrada in timestamp,
      p_hora_salida  in timestamp,
      p_estado_id    in number
   );

   procedure registro_asistencia_actualizar_asistencia_sp (
      p_mecanico_id in number,
      p_fecha       in date,
      p_hora_salida in timestamp,
      p_estado_id   in number
   );

   procedure registro_asistencia_archivar_asistencia_sp (
      p_mecanico_id in number,
      p_fecha       in date
   );
    
   ---------------------------------------------------------------------
   -- SALARIO
   ---------------------------------------------------------------------
   procedure salarios_insertar_salario_sp (
      p_mecanico_id   in number,
      p_salario       in number,
      p_fecha_inicio  in date,
      p_fecha_fin     in date,
      p_motivo_cambio in varchar2,
      p_estado_id     in number
   );

   procedure salarios_actualizar_salario_sp (
      p_salario_id    in number,
      p_salario       in number,
      p_fecha_inicio  in date,
      p_fecha_fin     in date,
      p_motivo_cambio in varchar2,
      p_estado_id     in number
   );

   procedure salarios_archivar_salario_sp (
      p_salario_id in number
   );
end fide_smartmotriz_pkg;