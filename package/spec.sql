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

   ---------------------------------------------------------------------
    -- TIPO DIRECCIONES
    ---------------------------------------------------------------------

   procedure tipo_direcciones_insertar_tipo_sp (
      p_tipo      in varchar2,
      p_estado_id in number
   );

   procedure tipo_direcciones_actualizar_tipo_sp (
      p_tipo_direccion_id in number,
      p_tipo              in varchar2,
      p_estado_id         in number
   );

   procedure tipo_direcciones_archivar_tipo_sp (
      p_tipo_direccion_id in number
   );

    ---------------------------------------------------------------------
    -- PROVINCIAS
    ---------------------------------------------------------------------

   procedure provincias_insertar_provincia_sp (
      p_provincia in varchar2,
      p_estado_id in number
   );

   procedure provincias_actualizar_provincia_sp (
      p_provincia_id in number,
      p_provincia    in varchar2,
      p_estado_id    in number
   );

   procedure provincias_archivar_provincia_sp (
      p_provincia_id in number
   );

    ---------------------------------------------------------------------
    -- CANTONES
    ---------------------------------------------------------------------

   procedure cantones_insertar_canton_sp (
      p_canton       in varchar2,
      p_provincia_id in number,
      p_estado_id    in number
   );

   procedure cantones_actualizar_canton_sp (
      p_canton_id    in number,
      p_canton       in varchar2,
      p_provincia_id in number,
      p_estado_id    in number
   );

   procedure cantones_archivar_canton_sp (
      p_canton_id in number
   );

    ---------------------------------------------------------------------
    -- DISTRITOS
    ---------------------------------------------------------------------

   procedure distritos_insertar_distrito_sp (
      p_distrito  in varchar2,
      p_canton_id in number,
      p_estado_id in number
   );

   procedure distritos_actualizar_distrito_sp (
      p_distrito_id in number,
      p_distrito    in varchar2,
      p_canton_id   in number,
      p_estado_id   in number
   );

   procedure distritos_archivar_distrito_sp (
      p_distrito_id in number
   );

    ---------------------------------------------------------------------
    -- DIRECCIONES
    ---------------------------------------------------------------------

   procedure direcciones_insertar_direccion_sp (
      p_cedula            in varchar2,
      p_tipo_direccion_id in number,
      p_distrito_id       in number,
      p_otras_senas       in varchar2,
      p_estado_id         in number
   );

   procedure direcciones_actualizar_direccion_sp (
      p_cedula            in varchar2,
      p_tipo_direccion_id in number,
      p_distrito_id       in number,
      p_otras_senas       in varchar2,
      p_estado_id         in number
   );

   procedure direcciones_archivar_direccion_sp (
      p_cedula            in varchar2,
      p_tipo_direccion_id in number
   );

    ---------------------------------------------------------------------
    -- TIPO CARROCERIAS
    ---------------------------------------------------------------------

   procedure tipo_carrocerias_insertar_tipo_sp (
      p_nombre    in varchar2,
      p_estado_id in number
   );

   procedure tipo_carrocerias_actualizar_tipo_sp (
      p_tipo_carroceria_id in number,
      p_nombre             in varchar2,
      p_estado_id          in number
   );

   procedure tipo_carrocerias_archivar_tipo_sp (
      p_tipo_carroceria_id in number
   );

    ---------------------------------------------------------------------
    -- TIPO COMBUSTIONES
    ---------------------------------------------------------------------

   procedure tipo_combustiones_insertar_tipo_sp (
      p_nombre    in varchar2,
      p_estado_id in number
   );

   procedure tipo_combustiones_actualizar_tipo_sp (
      p_tipo_combustion_id in number,
      p_nombre             in varchar2,
      p_estado_id          in number
   );

   procedure tipo_combustiones_archivar_tipo_sp (
      p_tipo_combustion_id in number
   );

    ---------------------------------------------------------------------
    -- TIPO TRANSMISIONES
    ---------------------------------------------------------------------

   procedure tipo_transmisiones_insertar_tipo_sp (
      p_nombre    in varchar2,
      p_estado_id in number
   );

   procedure tipo_transmisiones_actualizar_tipo_sp (
      p_tipo_transmision_id in number,
      p_nombre              in varchar2,
      p_estado_id           in number
   );

   procedure tipo_transmisiones_archivar_tipo_sp (
      p_tipo_transmision_id in number
   );

    ---------------------------------------------------------------------
    -- TRACCIONES
    ---------------------------------------------------------------------

   procedure tracciones_insertar_traccion_sp (
      p_nombre    in varchar2,
      p_estado_id in number
   );

   procedure tracciones_actualizar_traccion_sp (
      p_traccion_id in number,
      p_nombre      in varchar2,
      p_estado_id   in number
   );

   procedure tracciones_archivar_traccion_sp (
      p_traccion_id in number
   );

    ---------------------------------------------------------------------
    -- MARCAS VEHICULOS
    ---------------------------------------------------------------------

   procedure marcas_vehiculos_insertar_marca_sp (
      p_marca     in varchar2,
      p_estado_id in number
   );

   procedure marcas_vehiculos_actualizar_marca_sp (
      p_marca_id  in number,
      p_marca     in varchar2,
      p_estado_id in number
   );

   procedure marcas_vehiculos_archivar_marca_sp (
      p_marca_id in number
   );

    ---------------------------------------------------------------------
    -- MODELOS VEHICULOS
    ---------------------------------------------------------------------

   procedure modelos_vehiculos_insertar_modelo_sp (
      p_marca_id           in number,
      p_tipo_carroceria_id in number,
      p_modelo             in varchar2,
      p_estado_id          in number
   );

   procedure modelos_vehiculos_actualizar_modelo_sp (
      p_modelo_id          in number,
      p_marca_id           in number,
      p_tipo_carroceria_id in number,
      p_modelo             in varchar2,
      p_estado_id          in number
   );

   procedure modelos_vehiculos_archivar_modelo_sp (
      p_modelo_id in number
   );

    ---------------------------------------------------------------------
    -- MOTORES
    ---------------------------------------------------------------------

   procedure motores_insertar_motor_sp (
      p_tipo_combustion_id in number,
      p_nombre             in varchar2,
      p_potencia_hp        in number,
      p_torque_nm          in number,
      p_cilindraje_cc      in number,
      p_estado_id          in number
   );

   procedure motores_actualizar_motor_sp (
      p_motor_id           in number,
      p_tipo_combustion_id in number,
      p_nombre             in varchar2,
      p_potencia_hp        in number,
      p_torque_nm          in number,
      p_cilindraje_cc      in number,
      p_estado_id          in number
   );

   procedure motores_archivar_motor_sp (
      p_motor_id in number
   );

    ---------------------------------------------------------------------
    -- TRANSMISIONES
    ---------------------------------------------------------------------

   procedure transmisiones_insertar_transmision_sp (
      p_tipo_transmision_id in number,
      p_tipo_traccion_id    in number,
      p_nombre              in varchar2,
      p_velocidades         in number,
      p_estado_id           in number
   );

   procedure transmisiones_actualizar_transmision_sp (
      p_transmision_id      in number,
      p_tipo_transmision_id in number,
      p_tipo_traccion_id    in number,
      p_nombre              in varchar2,
      p_velocidades         in number,
      p_estado_id           in number
   );

   procedure transmisiones_archivar_transmision_sp (
      p_transmision_id in number
   );

    ---------------------------------------------------------------------
    -- MODELOS VERSIONES
    ---------------------------------------------------------------------

   procedure modelos_versiones_insertar_version_sp (
      p_modelo_id      in number,
      p_motor_id       in number,
      p_transmision_id in number,
      p_nombre         in varchar2,
      p_numero_puertas in number,
      p_estado_id      in number
   );

   procedure modelos_versiones_actualizar_version_sp (
      p_modelo_version_id in number,
      p_modelo_id         in number,
      p_motor_id          in number,
      p_transmision_id    in number,
      p_nombre            in varchar2,
      p_numero_puertas    in number,
      p_estado_id         in number
   );

   procedure modelos_versiones_archivar_version_sp (
      p_modelo_version_id in number
   );

    ---------------------------------------------------------------------
    -- VEHICULOS
    ---------------------------------------------------------------------

   procedure vehiculos_insertar_vehiculo_sp (
      p_placa_id          in varchar2,
      p_cedula            in varchar2,
      p_modelo_version_id in number,
      p_anio_fabricacion  in number,
      p_kilometraje       in number,
      p_fecha_registro    in date,
      p_estado_id         in number
   );

   procedure vehiculos_actualizar_vehiculo_sp (
      p_placa_id          in varchar2,
      p_cedula            in varchar2,
      p_modelo_version_id in number,
      p_anio_fabricacion  in number,
      p_kilometraje       in number,
      p_estado_id         in number
   );

   procedure vehiculos_archivar_vehiculo_sp (
      p_placa_id in varchar2
   );

   function total_mecanicos_activos_fn return number;
   function salario_promedio_general_fn return number;
   function asistencias_hoy_fn return number;
end fide_smartmotriz_pkg;