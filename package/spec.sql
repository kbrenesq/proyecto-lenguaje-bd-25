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
      p_estado in fide_estados_tb.estado%type
   );


   procedure estados_actualizar_estado_sp (
      p_estado_id in fide_estados_tb.estado_id%type,
      p_estado    in fide_estados_tb.estado%type
   );

   procedure estados_archivar_estado_sp (
      p_estado_id in fide_estados_tb.estado_id%type
   );

    ---------------------------------------------------------------------
   -- USUARIOS
   ---------------------------------------------------------------------

   procedure usuarios_insertar_usuario_sp (
      p_cedula           in fide_usuarios_tb.cedula%type,
      p_primer_nombre    in fide_usuarios_tb.primer_nombre%type,
      p_segundo_nombre   in fide_usuarios_tb.segundo_nombre%type,
      p_primer_apellido  in fide_usuarios_tb.primer_apellido%type,
      p_segundo_apellido in fide_usuarios_tb.segundo_apellido%type,
      p_fecha_nacimiento in fide_usuarios_tb.fecha_nacimiento%type,
      p_estado_id        in fide_usuarios_tb.estado_id%type
   );

   procedure usuarios_actualizar_usuario_sp (
      p_cedula           in fide_usuarios_tb.cedula%type,
      p_primer_nombre    in fide_usuarios_tb.primer_nombre%type,
      p_segundo_nombre   in fide_usuarios_tb.segundo_nombre%type,
      p_primer_apellido  in fide_usuarios_tb.primer_apellido%type,
      p_segundo_apellido in fide_usuarios_tb.segundo_apellido%type,
      p_fecha_nacimiento in fide_usuarios_tb.fecha_nacimiento%type,
      p_estado_id        in fide_usuarios_tb.estado_id%type
   );

   procedure usuarios_archivar_usuario_sp (
      p_cedula in fide_usuarios_tb.cedula%type
   );

   ---------------------------------------------------------------------
   -- TIPO USUARIOS
   ---------------------------------------------------------------------

   procedure tipo_usuarios_insertar_tipo_sp (
      p_tipo      in fide_tipo_usuarios_tb.tipo%type,
      p_estado_id in fide_tipo_usuarios_tb.estado_id%type
   );

   procedure tipo_usuarios_actualizar_tipo_sp (
      p_tipo_usuario_id in fide_tipo_usuarios_tb.tipo_usuario_id%type,
      p_tipo            in fide_tipo_usuarios_tb.tipo%type,
      p_estado_id       in fide_tipo_usuarios_tb.estado_id%type
   );

   procedure tipo_usuarios_archivar_tipo_sp (
      p_tipo_usuario_id in fide_tipo_usuarios_tb.tipo_usuario_id%type
   );

   ---------------------------------------------------------------------
   -- USUARIOS POR TIPO USUARIO
   ---------------------------------------------------------------------

   procedure usuarios_tipos_insertar_relacion_sp (
      p_cedula          in fide_usuarios_por_tipo_usuario_tb.cedula%type,
      p_tipo_usuario_id in fide_usuarios_por_tipo_usuario_tb.tipo_usuario_id%type,
      p_estado_id       in fide_usuarios_por_tipo_usuario_tb.estado_id%type
   );

   procedure usuarios_tipos_actualizar_relacion_sp (
      p_cedula          in fide_usuarios_por_tipo_usuario_tb.cedula%type,
      p_tipo_usuario_id in fide_usuarios_por_tipo_usuario_tb.tipo_usuario_id%type
   );

   procedure usuarios_tipos_archivar_relacion_sp (
      p_cedula          in fide_usuarios_por_tipo_usuario_tb.cedula%type,
      p_tipo_usuario_id in fide_usuarios_por_tipo_usuario_tb.tipo_usuario_id%type
   );

   ---------------------------------------------------------------------
   -- TELÉFONOS
   ---------------------------------------------------------------------

   procedure telefonos_insertar_telefono_sp (
      p_cedula    in fide_telefonos_tb.cedula%type,
      p_telefono  in fide_telefonos_tb.telefono%type,
      p_estado_id in fide_telefonos_tb.estado_id%type
   );

   procedure telefonos_actualizar_telefono_sp (
      p_cedula          in fide_telefonos_tb.cedula%type,
      p_telefono_actual in fide_telefonos_tb.telefono%type,
      p_telefono_nuevo  in fide_telefonos_tb.telefono%type
   );

   procedure telefonos_archivar_telefono_sp (
      p_cedula   in fide_telefonos_tb.cedula%type,
      p_telefono in fide_telefonos_tb.telefono%type
   );

   ---------------------------------------------------------------------
   -- CORREOS
   ---------------------------------------------------------------------

   procedure correos_insertar_correo_sp (
      p_cedula    in fide_correos_tb.cedula%type,
      p_correo    in fide_correos_tb.correo%type,
      p_estado_id in fide_correos_tb.estado_id%type
   );

   procedure correos_actualizar_correo_sp (
      p_cedula        in fide_correos_tb.cedula%type,
      p_correo_actual in fide_correos_tb.correo%type,
      p_correo_nuevo  in fide_correos_tb.correo%type
   );
   procedure correos_archivar_correo_sp (
      p_cedula in fide_correos_tb.cedula%type,
      p_correo in fide_correos_tb.correo%type
   );

   ---------------------------------------------------------------------
   -- PUESTOS
   ---------------------------------------------------------------------
   procedure puestos_insertar_puesto_sp (
      p_puesto      in fide_puestos_tb.puesto%type,
      p_salario_min in fide_puestos_tb.salario_min%type,
      p_salario_max in fide_puestos_tb.salario_max%type,
      p_estado_id   in fide_puestos_tb.estado_id%type
   );

   procedure puestos_actualizar_puesto_sp (
      p_puesto_id   in fide_puestos_tb.puesto_id%type,
      p_puesto      in fide_puestos_tb.puesto%type,
      p_salario_min in fide_puestos_tb.salario_min%type,
      p_salario_max in fide_puestos_tb.salario_max%type,
      p_estado_id   in fide_puestos_tb.estado_id%type
   );

   procedure puestos_archivar_puesto_sp (
      p_puesto_id in fide_puestos_tb.puesto_id%type
   );
    
    
    
   ---------------------------------------------------------------------
   -- MECANICOS
   ---------------------------------------------------------------------
   procedure mecanicos_insertar_mecanico_sp (
      p_cedula        in fide_mecanicos_tb.cedula%type,
      p_puesto_id     in fide_mecanicos_tb.puesto_id%type,
      p_fecha_ingreso in fide_mecanicos_tb.fecha_ingreso%type,
      p_fecha_fin     in fide_mecanicos_tb.fecha_fin%type,
      p_estado_id     in fide_mecanicos_tb.estado_id%type
   );

   procedure mecanicos_actualizar_mecanico_sp (
      p_mecanico_id in fide_mecanicos_tb.mecanico_id%type,
      p_puesto_id   in fide_mecanicos_tb.puesto_id%type,
      p_fecha_fin   in fide_mecanicos_tb.fecha_fin%type,
      p_estado_id   in fide_mecanicos_tb.estado_id%type
   );

   procedure mecanicos_archivar_mecanico_sp (
      p_mecanico_id in fide_mecanicos_tb.mecanico_id%type
   );
    
   ---------------------------------------------------------------------
   -- REGISTRO_ASISTENCIA
   ---------------------------------------------------------------------
   procedure registro_asistencia_insertar_asistencia_sp (
      p_mecanico_id  in fide_registro_asistencia_tb.mecanico_id%type,
      p_fecha        in fide_registro_asistencia_tb.fecha%type,
      p_hora_entrada in fide_registro_asistencia_tb.hora_entrada%type,
      p_hora_salida  in fide_registro_asistencia_tb.hora_salida%type,
      p_estado_id    in fide_registro_asistencia_tb.estado_id%type
   );

   procedure registro_asistencia_actualizar_asistencia_sp (
      p_mecanico_id in fide_registro_asistencia_tb.mecanico_id%type,
      p_fecha       in fide_registro_asistencia_tb.fecha%type,
      p_hora_salida in fide_registro_asistencia_tb.hora_salida%type,
      p_estado_id   in fide_registro_asistencia_tb.estado_id%type
   );

   procedure registro_asistencia_archivar_asistencia_sp (
      p_mecanico_id in fide_registro_asistencia_tb.mecanico_id%type,
      p_fecha       in fide_registro_asistencia_tb.fecha%type
   );
    
   ---------------------------------------------------------------------
   -- SALARIO
   ---------------------------------------------------------------------
   procedure salarios_insertar_salario_sp (
      p_mecanico_id   in fide_salarios_tb.mecanico_id%type,
      p_salario       in fide_salarios_tb.salario%type,
      p_fecha_inicio  in fide_salarios_tb.fecha_inicio%type,
      p_fecha_fin     in fide_salarios_tb.fecha_fin%type,
      p_motivo_cambio in fide_salarios_tb.motivo_cambio%type,
      p_estado_id     in fide_salarios_tb.estado_id%type
   );

   procedure salarios_actualizar_salario_sp (
      p_salario_id    in fide_salarios_tb.salario_id%type,
      p_salario       in fide_salarios_tb.salario%type,
      p_fecha_inicio  in fide_salarios_tb.fecha_inicio%type,
      p_fecha_fin     in fide_salarios_tb.fecha_fin%type,
      p_motivo_cambio in fide_salarios_tb.motivo_cambio%type,
      p_estado_id     in fide_salarios_tb.estado_id%type
   );

   procedure salarios_archivar_salario_sp (
      p_salario_id in fide_salarios_tb.salario_id%type
   );

   ---------------------------------------------------------------------
    -- TIPO DIRECCIONES
    ---------------------------------------------------------------------

   procedure tipo_direcciones_insertar_tipo_sp (
      p_tipo      in fide_tipo_direcciones_tb.tipo%type,
      p_estado_id in fide_tipo_direcciones_tb.estado_id%type
   );

   procedure tipo_direcciones_actualizar_tipo_sp (
      p_tipo_direccion_id in fide_tipo_direcciones_tb.tipo_direccion_id%type,
      p_tipo              in fide_tipo_direcciones_tb.tipo%type,
      p_estado_id         in fide_tipo_direcciones_tb.estado_id%type
   );

   procedure tipo_direcciones_archivar_tipo_sp (
      p_tipo_direccion_id in fide_tipo_direcciones_tb.tipo_direccion_id%type
   );

    ---------------------------------------------------------------------
    -- PROVINCIAS
    ---------------------------------------------------------------------

   procedure provincias_insertar_provincia_sp (
      p_provincia in fide_provincias_tb.provincia%type,
      p_estado_id in fide_provincias_tb.estado_id%type
   );

   procedure provincias_actualizar_provincia_sp (
      p_provincia_id in fide_provincias_tb.provincia_id%type,
      p_provincia    in fide_provincias_tb.provincia%type,
      p_estado_id    in fide_provincias_tb.estado_id%type
   );

   procedure provincias_archivar_provincia_sp (
      p_provincia_id in fide_provincias_tb.provincia_id%type
   );

    ---------------------------------------------------------------------
    -- CANTONES
    ---------------------------------------------------------------------

   procedure cantones_insertar_canton_sp (
      p_canton       in fide_cantones_tb.canton%type,
      p_provincia_id in fide_cantones_tb.provincia_id%type,
      p_estado_id    in fide_cantones_tb.estado_id%type
   );

   procedure cantones_actualizar_canton_sp (
      p_canton_id    in fide_cantones_tb.canton_id%type,
      p_canton       in fide_cantones_tb.canton%type,
      p_provincia_id in fide_cantones_tb.provincia_id%type,
      p_estado_id    in fide_cantones_tb.estado_id%type
   );

   procedure cantones_archivar_canton_sp (
      p_canton_id in fide_cantones_tb.canton_id%type
   );

    ---------------------------------------------------------------------
    -- DISTRITOS
    ---------------------------------------------------------------------

   procedure distritos_insertar_distrito_sp (
      p_distrito  in fide_distritos_tb.distrito%type,
      p_canton_id in fide_distritos_tb.canton_id%type,
      p_estado_id in fide_distritos_tb.estado_id%type
   );

   procedure distritos_actualizar_distrito_sp (
      p_distrito_id in fide_distritos_tb.distrito_id%type,
      p_distrito    in fide_distritos_tb.distrito%type,
      p_canton_id   in fide_distritos_tb.canton_id%type,
      p_estado_id   in fide_distritos_tb.estado_id%type
   );

   procedure distritos_archivar_distrito_sp (
      p_distrito_id in fide_distritos_tb.distrito_id%type
   );

    ---------------------------------------------------------------------
    -- DIRECCIONES
    ---------------------------------------------------------------------

   procedure direcciones_insertar_direccion_sp (
      p_cedula            in fide_direcciones_tb.cedula%type,
      p_tipo_direccion_id in fide_direcciones_tb.tipo_direccion_id%type,
      p_distrito_id       in fide_direcciones_tb.distrito_id%type,
      p_otras_senas       in fide_direcciones_tb.otras_senas%type,
      p_estado_id         in fide_direcciones_tb.estado_id%type
   );

   procedure direcciones_actualizar_direccion_sp (
      p_cedula            in fide_direcciones_tb.cedula%type,
      p_tipo_direccion_id in fide_direcciones_tb.tipo_direccion_id%type,
      p_distrito_id       in fide_direcciones_tb.distrito_id%type,
      p_otras_senas       in fide_direcciones_tb.otras_senas%type,
      p_estado_id         in fide_direcciones_tb.estado_id%type
   );

   procedure direcciones_archivar_direccion_sp (
      p_cedula            in fide_direcciones_tb.cedula%type,
      p_tipo_direccion_id in fide_direcciones_tb.tipo_direccion_id%type
   );

    --------------------------------------------------------------------
    -- TIPO CARROCERIAS
    ---------------------------------------------------------------------

   procedure tipo_carrocerias_insertar_tipo_sp (
      p_nombre    in fide_tipo_carrocerias_tb.nombre%type,
      p_estado_id in fide_tipo_carrocerias_tb.estado_id%type
   );

   procedure tipo_carrocerias_actualizar_tipo_sp (
      p_tipo_carroceria_id in fide_tipo_carrocerias_tb.tipo_carroceria_id%type,
      p_nombre             in fide_tipo_carrocerias_tb.nombre%type,
      p_estado_id          in fide_tipo_carrocerias_tb.estado_id%type
   );

   procedure tipo_carrocerias_archivar_tipo_sp (
      p_tipo_carroceria_id in fide_tipo_carrocerias_tb.tipo_carroceria_id%type
   );

    ---------------------------------------------------------------------
    -- TIPO COMBUSTIONES
    ---------------------------------------------------------------------

   procedure tipo_combustiones_insertar_tipo_sp (
      p_nombre    in fide_tipo_combustiones_tb.nombre%type,
      p_estado_id in fide_tipo_combustiones_tb.estado_id%type
   );

   procedure tipo_combustiones_actualizar_tipo_sp (
      p_tipo_combustion_id in fide_tipo_combustiones_tb.tipo_combustion_id%type,
      p_nombre             in fide_tipo_combustiones_tb.nombre%type,
      p_estado_id          in fide_tipo_combustiones_tb.estado_id%type
   );

   procedure tipo_combustiones_archivar_tipo_sp (
      p_tipo_combustion_id in fide_tipo_combustiones_tb.tipo_combustion_id%type
   );

    ---------------------------------------------------------------------
    -- TIPO TRANSMISIONES
    ---------------------------------------------------------------------

   procedure tipo_transmisiones_insertar_tipo_sp (
      p_nombre    in fide_tipo_transmisiones_tb.nombre%type,
      p_estado_id in fide_tipo_transmisiones_tb.estado_id%type
   );

   procedure tipo_transmisiones_actualizar_tipo_sp (
      p_tipo_transmision_id in fide_tipo_transmisiones_tb.tipo_transmision_id%type,
      p_nombre              in fide_tipo_transmisiones_tb.nombre%type,
      p_estado_id           in fide_tipo_transmisiones_tb.estado_id%type
   );

   procedure tipo_transmisiones_archivar_tipo_sp (
      p_tipo_transmision_id in fide_tipo_transmisiones_tb.tipo_transmision_id%type
   );

    ---------------------------------------------------------------------
    -- TRACCIONES
    ---------------------------------------------------------------------

   procedure tracciones_insertar_traccion_sp (
      p_nombre    in fide_tracciones_tb.nombre%type,
      p_estado_id in fide_tracciones_tb.estado_id%type
   );

   procedure tracciones_actualizar_traccion_sp (
      p_traccion_id in fide_tracciones_tb.traccion_id%type,
      p_nombre      in fide_tracciones_tb.nombre%type,
      p_estado_id   in fide_tracciones_tb.estado_id%type
   );

   procedure tracciones_archivar_traccion_sp (
      p_traccion_id in fide_tracciones_tb.traccion_id%type
   );

    ---------------------------------------------------------------------
    -- MARCAS VEHICULOS
    ---------------------------------------------------------------------

   procedure marcas_vehiculos_insertar_marca_sp (
      p_marca     in fide_marcas_vehiculos_tb.marca%type,
      p_estado_id in fide_marcas_vehiculos_tb.estado_id%type
   );

   procedure marcas_vehiculos_actualizar_marca_sp (
      p_marca_id  in fide_marcas_vehiculos_tb.marca_id%type,
      p_marca     in fide_marcas_vehiculos_tb.marca%type,
      p_estado_id in fide_marcas_vehiculos_tb.estado_id%type
   );

   procedure marcas_vehiculos_archivar_marca_sp (
      p_marca_id in fide_marcas_vehiculos_tb.marca_id%type
   );

    ---------------------------------------------------------------------
    -- MODELOS VEHICULOS
    ---------------------------------------------------------------------

   procedure modelos_vehiculos_insertar_modelo_sp (
      p_marca_id           in fide_modelos_vehiculos_tb.marca_id%type,
      p_tipo_carroceria_id in fide_modelos_vehiculos_tb.tipo_carroceria_id%type,
      p_modelo             in fide_modelos_vehiculos_tb.modelo%type,
      p_estado_id          in fide_modelos_vehiculos_tb.estado_id%type
   );

   procedure modelos_vehiculos_actualizar_modelo_sp (
      p_modelo_id          in fide_modelos_vehiculos_tb.modelo_id%type,
      p_marca_id           in fide_modelos_vehiculos_tb.marca_id%type,
      p_tipo_carroceria_id in fide_modelos_vehiculos_tb.tipo_carroceria_id%type,
      p_modelo             in fide_modelos_vehiculos_tb.modelo%type,
      p_estado_id          in fide_modelos_vehiculos_tb.estado_id%type
   );

   procedure modelos_vehiculos_archivar_modelo_sp (
      p_modelo_id in fide_modelos_vehiculos_tb.modelo_id%type
   );

    ---------------------------------------------------------------------
    -- MOTORES
    ---------------------------------------------------------------------

   procedure motores_insertar_motor_sp (
      p_tipo_combustion_id in fide_motores_tb.tipo_combustion_id%type,
      p_nombre             in fide_motores_tb.nombre%type,
      p_potencia_hp        in fide_motores_tb.potencia_hp%type,
      p_torque_nm          in fide_motores_tb.torque_nm%type,
      p_cilindraje_cc      in fide_motores_tb.cilindraje_cc%type,
      p_estado_id          in fide_motores_tb.estado_id%type
   );

   procedure motores_actualizar_motor_sp (
      p_motor_id           in fide_motores_tb.motor_id%type,
      p_tipo_combustion_id in fide_motores_tb.tipo_combustion_id%type,
      p_nombre             in fide_motores_tb.nombre%type,
      p_potencia_hp        in fide_motores_tb.potencia_hp%type,
      p_torque_nm          in fide_motores_tb.torque_nm%type,
      p_cilindraje_cc      in fide_motores_tb.cilindraje_cc%type,
      p_estado_id          in fide_motores_tb.estado_id%type
   );

   procedure motores_archivar_motor_sp (
      p_motor_id in fide_motores_tb.motor_id%type
   );

    ---------------------------------------------------------------------
    -- TRANSMISIONES
    ---------------------------------------------------------------------

   procedure transmisiones_insertar_transmision_sp (
      p_tipo_transmision_id in fide_transmisiones_tb.tipo_transmision_id%type,
      p_tipo_traccion_id    in fide_transmisiones_tb.tipo_traccion_id%type,
      p_nombre              in fide_transmisiones_tb.nombre%type,
      p_velocidades         in fide_transmisiones_tb.velocidades%type,
      p_estado_id           in fide_transmisiones_tb.estado_id%type
   );

   procedure transmisiones_actualizar_transmision_sp (
      p_transmision_id      in fide_transmisiones_tb.transmision_id%type,
      p_tipo_transmision_id in fide_transmisiones_tb.tipo_transmision_id%type,
      p_tipo_traccion_id    in fide_transmisiones_tb.tipo_traccion_id%type,
      p_nombre              in fide_transmisiones_tb.nombre%type,
      p_velocidades         in fide_transmisiones_tb.velocidades%type,
      p_estado_id           in fide_transmisiones_tb.estado_id%type
   );

   procedure transmisiones_archivar_transmision_sp (
      p_transmision_id in fide_transmisiones_tb.transmision_id%type
   );

    ---------------------------------------------------------------------
    -- MODELOS VERSIONES
    ---------------------------------------------------------------------

   procedure modelos_versiones_insertar_version_sp (
      p_modelo_id      in fide_modelos_versiones_tb.modelo_id%type,
      p_motor_id       in fide_modelos_versiones_tb.motor_id%type,
      p_transmision_id in fide_modelos_versiones_tb.transmision_id%type,
      p_nombre         in fide_modelos_versiones_tb.nombre%type,
      p_numero_puertas in fide_modelos_versiones_tb.numero_puertas%type,
      p_estado_id      in fide_modelos_versiones_tb.estado_id%type
   );

   procedure modelos_versiones_actualizar_version_sp (
      p_modelo_version_id in fide_modelos_versiones_tb.modelo_version_id%type,
      p_modelo_id         in fide_modelos_versiones_tb.modelo_id%type,
      p_motor_id          in fide_modelos_versiones_tb.motor_id%type,
      p_transmision_id    in fide_modelos_versiones_tb.transmision_id%type,
      p_nombre            in fide_modelos_versiones_tb.nombre%type,
      p_numero_puertas    in fide_modelos_versiones_tb.numero_puertas%type,
      p_estado_id         in fide_modelos_versiones_tb.estado_id%type
   );

   procedure modelos_versiones_archivar_version_sp (
      p_modelo_version_id in fide_modelos_versiones_tb.modelo_version_id%type
   );

    ---------------------------------------------------------------------
    -- VEHICULOS
    ---------------------------------------------------------------------

   procedure vehiculos_insertar_vehiculo_sp (
      p_placa_id          in fide_vehiculos_tb.placa_id%type,
      p_cedula            in fide_vehiculos_tb.cedula%type,
      p_modelo_version_id in fide_vehiculos_tb.modelo_version_id%type,
      p_anio_fabricacion  in fide_vehiculos_tb.anio_fabricacion%type,
      p_kilometraje       in fide_vehiculos_tb.kilometraje%type,
      p_fecha_registro    in fide_vehiculos_tb.fecha_registro%type,
      p_estado_id         in fide_vehiculos_tb.estado_id%type
   );

   procedure vehiculos_actualizar_vehiculo_sp (
      p_placa_id          in fide_vehiculos_tb.placa_id%type,
      p_cedula            in fide_vehiculos_tb.cedula%type,
      p_modelo_version_id in fide_vehiculos_tb.modelo_version_id%type,
      p_anio_fabricacion  in fide_vehiculos_tb.anio_fabricacion%type,
      p_kilometraje       in fide_vehiculos_tb.kilometraje%type,
      p_estado_id         in fide_vehiculos_tb.estado_id%type
   );

   procedure vehiculos_archivar_vehiculo_sp (
      p_placa_id in fide_vehiculos_tb.placa_id%type
   );

   function total_mecanicos_activos_fn return number;
   function salario_promedio_general_fn return number;
   function asistencias_hoy_fn return number;
end fide_smartmotriz_pkg;