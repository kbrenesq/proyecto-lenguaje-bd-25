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

create or replace package body fide_smartmotriz_pkg as

    ---------------------------------------------------------------------
   -- ESTADOS
   ---------------------------------------------------------------------
   procedure estados_insertar_estado_sp (
      p_estado in varchar2
   ) is
      v_estado_id fide_estados_tb.estado_id%type;
   begin
      select estados_seq.nextval
        into v_estado_id
        from dual;

      insert into fide_estados_tb (
         estado_id,
         estado
      ) values ( v_estado_id,
                 p_estado );

      commit;
      dbms_output.put_line('Estado insertado con ID: ' || v_estado_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un estado con este ID');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar un estado');
   end estados_insertar_estado_sp;

   procedure estados_actualizar_estado_sp (
      p_estado_id in number,
      p_estado    in varchar2
   ) is
   begin
      update fide_estados_tb
         set
         estado = p_estado
       where estado_id = p_estado_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningun estado con el id: ' || p_estado_id);
         raise_application_error(
            -20001,
            'no se encontró ningun estado con el id:  ' || p_estado_id
         );
      end if;
      commit;
      dbms_output.put_line('Estado '
                           || p_estado || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el estado: ' || sqlerrm);
   end estados_actualizar_estado_sp;

   procedure estados_archivar_estado_sp (
      p_estado_id in number
   ) is
   begin
      delete from fide_estados_tb
       where estado_id = p_estado_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Estado no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Estado con id '
                           || p_estado_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el estado: ' || sqlerrm);
   end estados_archivar_estado_sp;

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
   ) is
   begin
      insert into fide_usuarios_tb (
         cedula,
         primer_nombre,
         segundo_nombre,
         primer_apellido,
         segundo_apellido,
         fecha_nacimiento,
         estado_id
      ) values ( p_cedula,
                 p_primer_nombre,
                 p_segundo_nombre,
                 p_primer_apellido,
                 p_segundo_apellido,
                 p_fecha_nacimiento,
                 p_estado_id );

      commit;
      dbms_output.put_line('Usuario insertado con cédula: ' || p_cedula);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un usuario con la cédula: ' || p_cedula);
      when others then
         rollback;
         dbms_output.put_line('Error al insertar usuario: ' || sqlerrm);
   end usuarios_insertar_usuario_sp;

   procedure usuarios_actualizar_usuario_sp (
      p_cedula           in varchar2,
      p_primer_nombre    in varchar2,
      p_segundo_nombre   in varchar2,
      p_primer_apellido  in varchar2,
      p_segundo_apellido in varchar2,
      p_fecha_nacimiento in date,
      p_estado_id        in number
   ) is
   begin
      update fide_usuarios_tb
         set primer_nombre = p_primer_nombre,
             segundo_nombre = p_segundo_nombre,
             primer_apellido = p_primer_apellido,
             segundo_apellido = p_segundo_apellido,
             fecha_nacimiento = p_fecha_nacimiento,
             estado_id = p_estado_id
       where cedula = p_cedula;

      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró usuario con la cédula: ' || p_cedula
         );
      end if;

      commit;
      dbms_output.put_line('Usuario actualizado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al actualizar usuario: ' || sqlerrm);
   end usuarios_actualizar_usuario_sp;

   procedure usuarios_archivar_usuario_sp (
      p_cedula in varchar2
   ) is
   begin
      delete from fide_usuarios_tb
       where cedula = p_cedula;

      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'Usuario no encontrado para eliminación.'
         );
      end if;

      commit;
      dbms_output.put_line('Usuario con cédula '
                           || p_cedula || ' fue eliminado.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar usuario: ' || sqlerrm);
   end usuarios_archivar_usuario_sp;

   ---------------------------------------------------------------------
   -- TIPO USUARIOS
   ---------------------------------------------------------------------

   procedure tipo_usuarios_insertar_tipo_sp (
      p_tipo      in varchar2,
      p_estado_id in number
   ) is
      v_tipo_usuario_id fide_tipo_usuarios_tb.tipo_usuario_id%type;
   begin
      select tipos_usuarios_seq.nextval
        into v_tipo_usuario_id
        from dual;

      insert into fide_tipo_usuarios_tb (
         tipo_usuario_id,
         tipo,
         estado_id
      ) values ( v_tipo_usuario_id,
                 p_tipo,
                 p_estado_id );

      commit;
      dbms_output.put_line('Tipo de usuario insertado con ID: ' || v_tipo_usuario_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un tipo de usuario con este ID.');
      when others then
         rollback;
         dbms_output.put_line('Error al insertar tipo de usuario: ' || sqlerrm);
   end tipo_usuarios_insertar_tipo_sp;

   procedure tipo_usuarios_actualizar_tipo_sp (
      p_tipo_usuario_id in number,
      p_tipo            in varchar2,
      p_estado_id       in number
   ) is
   begin
      update fide_tipo_usuarios_tb
         set tipo = p_tipo,
             estado_id = p_estado_id
       where tipo_usuario_id = p_tipo_usuario_id;

      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el tipo de usuario con el ID: ' || p_tipo_usuario_id
         );
      end if;

      commit;
      dbms_output.put_line('Tipo de usuario actualizado.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al actualizar tipo de usuario: ' || sqlerrm);
   end tipo_usuarios_actualizar_tipo_sp;

   procedure tipo_usuarios_archivar_tipo_sp (
      p_tipo_usuario_id in number
   ) is
   begin
      delete from fide_tipo_usuarios_tb
       where tipo_usuario_id = p_tipo_usuario_id;

      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'Tipo de usuario no encontrado.'
         );
      end if;

      commit;
      dbms_output.put_line('Tipo de usuario eliminado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar tipo de usuario: ' || sqlerrm);
   end tipo_usuarios_archivar_tipo_sp;

   ---------------------------------------------------------------------
   -- USUARIOS POR TIPO USUARIO
   ---------------------------------------------------------------------

   procedure usuarios_tipos_insertar_relacion_sp (
      p_cedula          in varchar2,
      p_tipo_usuario_id in number,
      p_estado_id       in number
   ) is
   begin
      insert into fide_usuarios_por_tipo_usuario_tb (
         cedula,
         tipo_usuario_id,
         estado_id
      ) values ( p_cedula,
                 p_tipo_usuario_id,
                 p_estado_id );

      commit;
      dbms_output.put_line('Relación usuario-tipo creada correctamente.');
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('La relación ya existe para el usuario y tipo especificado.');
      when others then
         rollback;
         dbms_output.put_line('Error al insertar relación usuario-tipo: ' || sqlerrm);
   end usuarios_tipos_insertar_relacion_sp;

   procedure usuarios_tipos_actualizar_relacion_sp (
      p_cedula          in fide_usuarios_por_tipo_usuario_tb.cedula%type,
      p_tipo_usuario_id in fide_usuarios_por_tipo_usuario_tb.tipo_usuario_id%type
   ) is
   begin
      update fide_usuarios_por_tipo_usuario_tb
         set
         tipo_usuario_id = p_tipo_usuario_id
       where cedula = p_cedula;

      if sql%rowcount = 0 then
         raise_application_error(
            -20003,
            'No se encontró relación usuario - tipo usuario con la cédula especificada.'
         );
      end if;
      commit;
      dbms_output.put_line('Relación usuario - tipo usuario actualizada correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al actualizar la relación usuario - tipo usuario: ' || sqlerrm);
   end usuarios_tipos_actualizar_relacion_sp;


   procedure usuarios_tipos_archivar_relacion_sp (
      p_cedula          in varchar2,
      p_tipo_usuario_id in number
   ) is
   begin
      delete from fide_usuarios_por_tipo_usuario_tb
       where cedula = p_cedula
         and tipo_usuario_id = p_tipo_usuario_id;

      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'Relación no encontrada.'
         );
      end if;

      commit;
      dbms_output.put_line('Relación usuario-tipo eliminada correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar relación: ' || sqlerrm);
   end usuarios_tipos_archivar_relacion_sp;

   ---------------------------------------------------------------------
   -- TELÉFONOS
   ---------------------------------------------------------------------

   procedure telefonos_insertar_telefono_sp (
      p_cedula    in varchar2,
      p_telefono  in varchar2,
      p_estado_id in number
   ) is
   begin
      insert into fide_telefonos_tb (
         cedula,
         telefono,
         estado_id
      ) values ( p_cedula,
                 p_telefono,
                 p_estado_id );

      commit;
      dbms_output.put_line('Teléfono agregado al usuario ' || p_cedula);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('El teléfono ya existe para este usuario.');
      when others then
         rollback;
         dbms_output.put_line('Error al insertar teléfono: ' || sqlerrm);
   end telefonos_insertar_telefono_sp;

   procedure telefonos_actualizar_telefono_sp (
      p_cedula          in fide_telefonos_tb.cedula%type,
      p_telefono_actual in fide_telefonos_tb.telefono%type,
      p_telefono_nuevo  in fide_telefonos_tb.telefono%type
   ) is
   begin
      update fide_telefonos_tb
         set
         telefono = p_telefono_nuevo
       where cedula = p_cedula
         and telefono = p_telefono_actual;

      if sql%rowcount = 0 then
         raise_application_error(
            -20004,
            'No se encontró el teléfono especificado para el usuario.'
         );
      end if;
      commit;
      dbms_output.put_line('Teléfono actualizado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al actualizar el teléfono: ' || sqlerrm);
   end telefonos_actualizar_telefono_sp;


   procedure telefonos_archivar_telefono_sp (
      p_cedula   in varchar2,
      p_telefono in varchar2
   ) is
   begin
      delete from fide_telefonos_tb
       where cedula = p_cedula
         and telefono = p_telefono;

      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'Teléfono no encontrado para eliminar.'
         );
      end if;

      commit;
      dbms_output.put_line('Teléfono eliminado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar teléfono: ' || sqlerrm);
   end telefonos_archivar_telefono_sp;

   ---------------------------------------------------------------------
   -- CORREOS
   ---------------------------------------------------------------------

   procedure correos_insertar_correo_sp (
      p_cedula    in varchar2,
      p_correo    in varchar2,
      p_estado_id in number
   ) is
   begin
      insert into fide_correos_tb (
         cedula,
         correo,
         estado_id
      ) values ( p_cedula,
                 p_correo,
                 p_estado_id );

      commit;
      dbms_output.put_line('Correo agregado al usuario ' || p_cedula);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('El correo ya existe para este usuario.');
      when others then
         rollback;
         dbms_output.put_line('Error al insertar correo: ' || sqlerrm);
   end correos_insertar_correo_sp;

   procedure correos_actualizar_correo_sp (
      p_cedula        in fide_correos_tb.cedula%type,
      p_correo_actual in fide_correos_tb.correo%type,
      p_correo_nuevo  in fide_correos_tb.correo%type
   ) is
   begin
      update fide_correos_tb
         set
         correo = p_correo_nuevo
       where cedula = p_cedula
         and correo = p_correo_actual;

      if sql%rowcount = 0 then
         raise_application_error(
            -20005,
            'No se encontró el correo especificado para el usuario.'
         );
      end if;
      commit;
      dbms_output.put_line('Correo actualizado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al actualizar el correo: ' || sqlerrm);
   end correos_actualizar_correo_sp;


   procedure correos_archivar_correo_sp (
      p_cedula in varchar2,
      p_correo in varchar2
   ) is
   begin
      delete from fide_correos_tb
       where cedula = p_cedula
         and correo = p_correo;

      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'Correo no encontrado para eliminar.'
         );
      end if;

      commit;
      dbms_output.put_line('Correo eliminado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar correo: ' || sqlerrm);
   end correos_archivar_correo_sp;

   ---------------------------------------------------------------------
   -- PUESTOS
   ---------------------------------------------------------------------

   procedure puestos_insertar_puesto_sp (
      p_puesto      in varchar2,
      p_salario_min in number,
      p_salario_max in number,
      p_estado_id   in number
   ) is
      v_puesto_id fide_puestos_tb.puesto_id%type;
   begin
      select puestos_seq.nextval
        into v_puesto_id
        from dual;
      insert into fide_puestos_tb (
         puesto_id,
         puesto,
         salario_max,
         salario_min,
         estado_id
      ) values ( v_puesto_id,
                 p_puesto,
                 p_salario_max,
                 p_salario_min,
                 p_estado_id );
      commit;
      dbms_output.put_line('Puesto insertado con ID: ' || v_puesto_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un puesto con este nombre.');
      when others then
         rollback;
         dbms_output.put_line('Error al insertar puesto: ' || sqlerrm);
   end puestos_insertar_puesto_sp;

   procedure puestos_actualizar_puesto_sp (
      p_puesto_id   in number,
      p_puesto      in varchar2,
      p_salario_min in number,
      p_salario_max in number,
      p_estado_id   in number
   ) is
   begin
      update fide_puestos_tb
         set puesto = p_puesto,
             salario_max = p_salario_max,
             salario_min = p_salario_min,
             estado_id = p_estado_id
       where puesto_id = p_puesto_id;
      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el puesto con el ID: ' || p_puesto_id
         );
      end if;
      commit;
      dbms_output.put_line('Puesto actualizado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al actualizar puesto: ' || sqlerrm);
   end puestos_actualizar_puesto_sp;

   procedure puestos_archivar_puesto_sp (
      p_puesto_id in number
   ) is
   begin
      delete from fide_puestos_tb
       where puesto_id = p_puesto_id;
      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el puesto con el ID: ' || p_puesto_id
         );
      end if;
      commit;
      dbms_output.put_line('Puesto eliminado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar puesto: ' || sqlerrm);
   end puestos_archivar_puesto_sp;

   ---------------------------------------------------------------------
   -- MECÁNICOS
   ---------------------------------------------------------------------

   procedure mecanicos_insertar_mecanico_sp (
      p_cedula        in varchar2,
      p_puesto_id     in number,
      p_fecha_ingreso in date,
      p_fecha_fin     in date,
      p_estado_id     in number
   ) is
      v_mecanico_id fide_mecanicos_tb.mecanico_id%type;
   begin
      select mecanicos_seq.nextval
        into v_mecanico_id
        from dual;
      insert into fide_mecanicos_tb (
         mecanico_id,
         cedula,
         puesto_id,
         fecha_ingreso,
         fecha_fin,
         estado_id
      ) values ( v_mecanico_id,
                 p_cedula,
                 p_puesto_id,
                 p_fecha_ingreso,
                 p_fecha_fin,
                 p_estado_id );
      commit;
      dbms_output.put_line('Mecánico insertado con ID: ' || v_mecanico_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un mecánico con esta cédula.');
      when others then
         rollback;
         dbms_output.put_line('Error al insertar mecánico: ' || sqlerrm);
   end mecanicos_insertar_mecanico_sp;

   procedure mecanicos_actualizar_mecanico_sp (
      p_mecanico_id in number,
      p_puesto_id   in number,
      p_fecha_fin   in date,
      p_estado_id   in number
   ) is
   begin
      update fide_mecanicos_tb
         set puesto_id = p_puesto_id,
             fecha_fin = p_fecha_fin,
             estado_id = p_estado_id
       where mecanico_id = p_mecanico_id;
      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el mecánico con el ID: ' || p_mecanico_id
         );
      end if;
      commit;
      dbms_output.put_line('Mecánico actualizado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al actualizar mecánico: ' || sqlerrm);
   end mecanicos_actualizar_mecanico_sp;

   procedure mecanicos_archivar_mecanico_sp (
      p_mecanico_id in number
   ) is
   begin
      delete from fide_mecanicos_tb
       where mecanico_id = p_mecanico_id;
      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el mecánico con el ID: ' || p_mecanico_id
         );
      end if;
      commit;
      dbms_output.put_line('Mecánico eliminado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar mecánico: ' || sqlerrm);
   end mecanicos_archivar_mecanico_sp;

   ---------------------------------------------------------------------
   -- REGISTRO ASISTENCIA
   ---------------------------------------------------------------------

   procedure registro_asistencia_insertar_asistencia_sp (
      p_mecanico_id  in number,
      p_fecha        in date,
      p_hora_entrada in timestamp,
      p_hora_salida  in timestamp,
      p_estado_id    in number
   ) is
   begin
      insert into fide_registro_asistencia_tb (
         mecanico_id,
         fecha,
         hora_entrada,
         hora_salida,
         estado_id
      ) values ( p_mecanico_id,
                 p_fecha,
                 p_hora_entrada,
                 p_hora_salida,
                 p_estado_id );
      commit;
      dbms_output.put_line('Registro de asistencia insertado para el mecánico ID: ' || p_mecanico_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un registro de asistencia para este mecánico en la fecha especificada.');
      when others then
         rollback;
         dbms_output.put_line('Error al insertar registro de asistencia: ' || sqlerrm);
   end registro_asistencia_insertar_asistencia_sp;

   procedure registro_asistencia_actualizar_asistencia_sp (
      p_mecanico_id in number,
      p_fecha       in date,
      p_hora_salida in timestamp,
      p_estado_id   in number
   ) is
   begin
      update fide_registro_asistencia_tb
         set hora_salida = p_hora_salida,
             estado_id = p_estado_id
       where mecanico_id = p_mecanico_id
         and fecha = p_fecha;
      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el registro de asistencia para el mecánico ID: '
            || p_mecanico_id
            || ' en la fecha: '
            || p_fecha
         );
      end if;
      commit;
      dbms_output.put_line('Registro de asistencia actualizado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al actualizar registro de asistencia: ' || sqlerrm);
   end registro_asistencia_actualizar_asistencia_sp;

   procedure registro_asistencia_archivar_asistencia_sp (
      p_mecanico_id in number,
      p_fecha       in date
   ) is
   begin
      delete from fide_registro_asistencia_tb
       where mecanico_id = p_mecanico_id
         and fecha = p_fecha;
      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el registro de asistencia para eliminar.'
         );
      end if;
      commit;
      dbms_output.put_line('Registro de asistencia eliminado correctamente.');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar registro de asistencia: ' || sqlerrm);
   end registro_asistencia_archivar_asistencia_sp;

   ---------------------------------------------------------------------
   -- SALARIOS
   ---------------------------------------------------------------------

   procedure salarios_insertar_salario_sp (
      p_mecanico_id   in number,
      p_salario       in number,
      p_fecha_inicio  in date,
      p_fecha_fin     in date,
      p_motivo_cambio in varchar2,
      p_estado_id     in number
   ) is
      v_salario_id fide_salarios_tb.salario_id%type;
   begin
      select salarios_seq.nextval
        into v_salario_id
        from dual;
      insert into fide_salarios_tb (
         salario_id,
         mecanico_id,
         salario,
         fecha_inicio,
         fecha_fin,
         motivo_cambio,
         estado_id
      ) values ( v_salario_id,
                 p_mecanico_id,
                 p_salario,
                 p_fecha_inicio,
                 p_fecha_fin,
                 p_motivo_cambio,
                 p_estado_id );
      commit;
      dbms_output.put_line('Salario insertado con ID: ' || v_salario_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un salario con este ID.');
      when others then
         rollback;
         dbms_output.put_line('Error al insertar salario: ' || sqlerrm);
   end salarios_insertar_salario_sp;

   procedure salarios_actualizar_salario_sp (
      p_salario_id    in number,
      p_salario       in number,
      p_fecha_inicio  in date,
      p_fecha_fin     in date,
      p_motivo_cambio in varchar2,
      p_estado_id     in number
   ) is
   begin
      update fide_salarios_tb
         set salario = p_salario,
             fecha_inicio = p_fecha_inicio,
             fecha_fin = p_fecha_fin,
             motivo_cambio = p_motivo_cambio,
             estado_id = p_estado_id
       where salario_id = p_salario_id;
      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el salario con el ID: ' || p_salario_id
         );
      end if;
      commit;
   end salarios_actualizar_salario_sp;

   procedure salarios_archivar_salario_sp (
      p_salario_id in number
   ) is
   begin
      delete from fide_salarios_tb
       where salario_id = p_salario_id;
      if sql%rowcount = 0 then
         rollback;
         raise_application_error(
            -20001,
            'No se encontró el salario con el ID: ' || p_salario_id
         );
      end if;
      commit;
   end salarios_archivar_salario_sp;

   function total_mecanicos_activos_fn return number is
      v_total number;
   begin
      select count(*)
        into v_total
        from fide_mecanicos_tb
       where estado_id = 1;
      return v_total;
   exception
      when others then
         return 0;
   end total_mecanicos_activos_fn;

   ---------------------------------------------------------------------
    -- TIPO DIRECCIONES
    ---------------------------------------------------------------------

   procedure tipo_direcciones_insertar_tipo_sp (
      p_tipo      in varchar2,
      p_estado_id in number
   ) is
      v_tipo_direccion_id fide_tipo_direcciones_tb.tipo_direccion_id%type;
   begin
      select tipo_direcciones_seq.nextval
        into v_tipo_direccion_id
        from dual;

      insert into fide_tipo_direcciones_tb (
         tipo_direccion_id,
         tipo,
         estado_id
      ) values ( v_tipo_direccion_id,
                 p_tipo,
                 p_estado_id );

      commit;
      dbms_output.put_line('Tipo de dirección insertado con ID: ' || v_tipo_direccion_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un tipo de dirección con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el tipo de dirección');
   end tipo_direcciones_insertar_tipo_sp;

   procedure tipo_direcciones_actualizar_tipo_sp (
      p_tipo_direccion_id in number,
      p_tipo              in varchar2,
      p_estado_id         in number
   ) is
   begin
      update fide_tipo_direcciones_tb
         set tipo = p_tipo,
             estado_id = p_estado_id
       where tipo_direccion_id = p_tipo_direccion_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún tipo de dirección con el id: ' || p_tipo_direccion_id);
         raise_application_error(
            -20001,
            'No se encontró ningún tipo de dirección con el id: ' || p_tipo_direccion_id
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de dirección '
                           || p_tipo || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el tipo de dirección: ' || sqlerrm);
   end tipo_direcciones_actualizar_tipo_sp;

   procedure tipo_direcciones_archivar_tipo_sp (
      p_tipo_direccion_id in number
   ) is
   begin
      delete from fide_tipo_direcciones_tb
       where tipo_direccion_id = p_tipo_direccion_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Tipo de dirección no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de dirección con id '
                           || p_tipo_direccion_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el tipo de dirección: ' || sqlerrm);
   end tipo_direcciones_archivar_tipo_sp;

    ---------------------------------------------------------------------
    -- PROVINCIAS
    ---------------------------------------------------------------------

   procedure provincias_insertar_provincia_sp (
      p_provincia in varchar2,
      p_estado_id in number
   ) is
      v_provincia_id fide_provincias_tb.provincia_id%type;
   begin
      select provincias_seq.nextval
        into v_provincia_id
        from dual;

      insert into fide_provincias_tb (
         provincia_id,
         provincia,
         estado_id
      ) values ( v_provincia_id,
                 p_provincia,
                 p_estado_id );

      commit;
      dbms_output.put_line('Provincia insertada con ID: ' || v_provincia_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe una provincia con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar la provincia');
   end provincias_insertar_provincia_sp;

   procedure provincias_actualizar_provincia_sp (
      p_provincia_id in number,
      p_provincia    in varchar2,
      p_estado_id    in number
   ) is
   begin
      update fide_provincias_tb
         set provincia = p_provincia,
             estado_id = p_estado_id
       where provincia_id = p_provincia_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ninguna provincia con el id: ' || p_provincia_id);
         raise_application_error(
            -20001,
            'No se encontró ninguna provincia con el id: ' || p_provincia_id
         );
      end if;
      commit;
      dbms_output.put_line('Provincia '
                           || p_provincia || ' actualizada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar la provincia: ' || sqlerrm);
   end provincias_actualizar_provincia_sp;

   procedure provincias_archivar_provincia_sp (
      p_provincia_id in number
   ) is
   begin
      delete from fide_provincias_tb
       where provincia_id = p_provincia_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Provincia no encontrada.'
         );
      end if;
      commit;
      dbms_output.put_line('Provincia con id '
                           || p_provincia_id || ' fue eliminada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar la provincia: ' || sqlerrm);
   end provincias_archivar_provincia_sp;

    ---------------------------------------------------------------------
    -- CANTONES
    ---------------------------------------------------------------------

   procedure cantones_insertar_canton_sp (
      p_canton       in varchar2,
      p_provincia_id in number,
      p_estado_id    in number
   ) is
      v_canton_id fide_cantones_tb.canton_id%type;
   begin
      select cantones_seq.nextval
        into v_canton_id
        from dual;

      insert into fide_cantones_tb (
         canton_id,
         canton,
         provincia_id,
         estado_id
      ) values ( v_canton_id,
                 p_canton,
                 p_provincia_id,
                 p_estado_id );

      commit;
      dbms_output.put_line('Cantón insertado con ID: ' || v_canton_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un cantón con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el cantón');
   end cantones_insertar_canton_sp;

   procedure cantones_actualizar_canton_sp (
      p_canton_id    in number,
      p_canton       in varchar2,
      p_provincia_id in number,
      p_estado_id    in number
   ) is
   begin
      update fide_cantones_tb
         set canton = p_canton,
             provincia_id = p_provincia_id,
             estado_id = p_estado_id
       where canton_id = p_canton_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún cantón con el id: ' || p_canton_id);
         raise_application_error(
            -20001,
            'No se encontró ningún cantón con el id: ' || p_canton_id
         );
      end if;
      commit;
      dbms_output.put_line('Cantón '
                           || p_canton || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el cantón: ' || sqlerrm);
   end cantones_actualizar_canton_sp;

   procedure cantones_archivar_canton_sp (
      p_canton_id in number
   ) is
   begin
      delete from fide_cantones_tb
       where canton_id = p_canton_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Cantón no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Cantón con id '
                           || p_canton_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el cantón: ' || sqlerrm);
   end cantones_archivar_canton_sp;

    ---------------------------------------------------------------------
    -- DISTRITOS
    ---------------------------------------------------------------------

   procedure distritos_insertar_distrito_sp (
      p_distrito  in varchar2,
      p_canton_id in number,
      p_estado_id in number
   ) is
      v_distrito_id fide_distritos_tb.distrito_id%type;
   begin
      select distritos_seq.nextval
        into v_distrito_id
        from dual;

      insert into fide_distritos_tb (
         distrito_id,
         distrito,
         canton_id,
         estado_id
      ) values ( v_distrito_id,
                 p_distrito,
                 p_canton_id,
                 p_estado_id );

      commit;
      dbms_output.put_line('Distrito insertado con ID: ' || v_distrito_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un distrito con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el distrito');
   end distritos_insertar_distrito_sp;

   procedure distritos_actualizar_distrito_sp (
      p_distrito_id in number,
      p_distrito    in varchar2,
      p_canton_id   in number,
      p_estado_id   in number
   ) is
   begin
      update fide_distritos_tb
         set distrito = p_distrito,
             canton_id = p_canton_id,
             estado_id = p_estado_id
       where distrito_id = p_distrito_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún distrito con el id: ' || p_distrito_id);
         raise_application_error(
            -20001,
            'No se encontró ningún distrito con el id: ' || p_distrito_id
         );
      end if;
      commit;
      dbms_output.put_line('Distrito '
                           || p_distrito || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el distrito: ' || sqlerrm);
   end distritos_actualizar_distrito_sp;

   procedure distritos_archivar_distrito_sp (
      p_distrito_id in number
   ) is
   begin
      delete from fide_distritos_tb
       where distrito_id = p_distrito_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Distrito no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Distrito con id '
                           || p_distrito_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el distrito: ' || sqlerrm);
   end distritos_archivar_distrito_sp;

    ---------------------------------------------------------------------
    -- DIRECCIONES
    ---------------------------------------------------------------------

   procedure direcciones_insertar_direccion_sp (
      p_cedula            in varchar2,
      p_tipo_direccion_id in number,
      p_distrito_id       in number,
      p_otras_senas       in varchar2,
      p_estado_id         in number
   ) is
   begin
      insert into fide_direcciones_tb (
         cedula,
         tipo_direccion_id,
         distrito_id,
         otras_senas,
         estado_id
      ) values ( p_cedula,
                 p_tipo_direccion_id,
                 p_distrito_id,
                 p_otras_senas,
                 p_estado_id );

      commit;
      dbms_output.put_line('Dirección insertada para el usuario: ' || p_cedula);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe una dirección de este tipo para el usuario');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar la dirección');
   end direcciones_insertar_direccion_sp;

   procedure direcciones_actualizar_direccion_sp (
      p_cedula            in varchar2,
      p_tipo_direccion_id in number,
      p_distrito_id       in number,
      p_otras_senas       in varchar2,
      p_estado_id         in number
   ) is
   begin
      update fide_direcciones_tb
         set distrito_id = p_distrito_id,
             otras_senas = p_otras_senas,
             estado_id = p_estado_id
       where cedula = p_cedula
         and tipo_direccion_id = p_tipo_direccion_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ninguna dirección para el usuario: ' || p_cedula);
         raise_application_error(
            -20001,
            'No se encontró ninguna dirección para el usuario: ' || p_cedula
         );
      end if;
      commit;
      dbms_output.put_line('Dirección actualizada para el usuario: ' || p_cedula);
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar la dirección: ' || sqlerrm);
   end direcciones_actualizar_direccion_sp;

   procedure direcciones_archivar_direccion_sp (
      p_cedula            in varchar2,
      p_tipo_direccion_id in number
   ) is
   begin
      delete from fide_direcciones_tb
       where cedula = p_cedula
         and tipo_direccion_id = p_tipo_direccion_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Dirección no encontrada.'
         );
      end if;
      commit;
      dbms_output.put_line('Dirección eliminada para el usuario: ' || p_cedula);
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar la dirección: ' || sqlerrm);
   end direcciones_archivar_direccion_sp;

   ---------------------------------------------------------------------
    -- TIPO CARROCERIAS
    ---------------------------------------------------------------------

   procedure tipo_carrocerias_insertar_tipo_sp (
      p_nombre    in varchar2,
      p_estado_id in number
   ) is
      v_tipo_carroceria_id fide_tipo_carrocerias_tb.tipo_carroceria_id%type;
   begin
      select tipo_carrocerias_seq.nextval
        into v_tipo_carroceria_id
        from dual;

      insert into fide_tipo_carrocerias_tb (
         tipo_carroceria_id,
         nombre,
         estado_id
      ) values ( v_tipo_carroceria_id,
                 p_nombre,
                 p_estado_id );

      commit;
      dbms_output.put_line('Tipo de carrocería insertado con ID: ' || v_tipo_carroceria_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un tipo de carrocería con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el tipo de carrocería');
   end tipo_carrocerias_insertar_tipo_sp;

   procedure tipo_carrocerias_actualizar_tipo_sp (
      p_tipo_carroceria_id in number,
      p_nombre             in varchar2,
      p_estado_id          in number
   ) is
   begin
      update fide_tipo_carrocerias_tb
         set nombre = p_nombre,
             estado_id = p_estado_id
       where tipo_carroceria_id = p_tipo_carroceria_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún tipo de carrocería con el id: ' || p_tipo_carroceria_id);
         raise_application_error(
            -20001,
            'No se encontró ningún tipo de carrocería con el id: ' || p_tipo_carroceria_id
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de carrocería '
                           || p_nombre || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el tipo de carrocería: ' || sqlerrm);
   end tipo_carrocerias_actualizar_tipo_sp;

   procedure tipo_carrocerias_archivar_tipo_sp (
      p_tipo_carroceria_id in number
   ) is
   begin
      delete from fide_tipo_carrocerias_tb
       where tipo_carroceria_id = p_tipo_carroceria_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Tipo de carrocería no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de carrocería con id '
                           || p_tipo_carroceria_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el tipo de carrocería: ' || sqlerrm);
   end tipo_carrocerias_archivar_tipo_sp;

    ---------------------------------------------------------------------
    -- TIPO COMBUSTIONES
    ---------------------------------------------------------------------

   procedure tipo_combustiones_insertar_tipo_sp (
      p_nombre    in varchar2,
      p_estado_id in number
   ) is
      v_tipo_combustion_id fide_tipo_combustiones_tb.tipo_combustion_id%type;
   begin
      select tipo_combustiones_seq.nextval
        into v_tipo_combustion_id
        from dual;

      insert into fide_tipo_combustiones_tb (
         tipo_combustion_id,
         nombre,
         estado_id
      ) values ( v_tipo_combustion_id,
                 p_nombre,
                 p_estado_id );

      commit;
      dbms_output.put_line('Tipo de combustión insertado con ID: ' || v_tipo_combustion_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un tipo de combustión con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el tipo de combustión');
   end tipo_combustiones_insertar_tipo_sp;

   procedure tipo_combustiones_actualizar_tipo_sp (
      p_tipo_combustion_id in number,
      p_nombre             in varchar2,
      p_estado_id          in number
   ) is
   begin
      update fide_tipo_combustiones_tb
         set nombre = p_nombre,
             estado_id = p_estado_id
       where tipo_combustion_id = p_tipo_combustion_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún tipo de combustión con el id: ' || p_tipo_combustion_id);
         raise_application_error(
            -20001,
            'No se encontró ningún tipo de combustión con el id: ' || p_tipo_combustion_id
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de combustión '
                           || p_nombre || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el tipo de combustión: ' || sqlerrm);
   end tipo_combustiones_actualizar_tipo_sp;

   procedure tipo_combustiones_archivar_tipo_sp (
      p_tipo_combustion_id in number
   ) is
   begin
      delete from fide_tipo_combustiones_tb
       where tipo_combustion_id = p_tipo_combustion_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Tipo de combustión no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de combustión con id '
                           || p_tipo_combustion_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el tipo de combustión: ' || sqlerrm);
   end tipo_combustiones_archivar_tipo_sp;

    ---------------------------------------------------------------------
    -- TIPO TRANSMISIONES
    ---------------------------------------------------------------------

   procedure tipo_transmisiones_insertar_tipo_sp (
      p_nombre    in varchar2,
      p_estado_id in number
   ) is
      v_tipo_transmision_id fide_tipo_transmisiones_tb.tipo_transmision_id%type;
   begin
      select tipo_transmisiones_seq.nextval
        into v_tipo_transmision_id
        from dual;

      insert into fide_tipo_transmisiones_tb (
         tipo_transmision_id,
         nombre,
         estado_id
      ) values ( v_tipo_transmision_id,
                 p_nombre,
                 p_estado_id );

      commit;
      dbms_output.put_line('Tipo de transmisión insertado con ID: ' || v_tipo_transmision_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un tipo de transmisión con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el tipo de transmisión');
   end tipo_transmisiones_insertar_tipo_sp;

   procedure tipo_transmisiones_actualizar_tipo_sp (
      p_tipo_transmision_id in number,
      p_nombre              in varchar2,
      p_estado_id           in number
   ) is
   begin
      update fide_tipo_transmisiones_tb
         set nombre = p_nombre,
             estado_id = p_estado_id
       where tipo_transmision_id = p_tipo_transmision_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún tipo de transmisión con el id: ' || p_tipo_transmision_id);
         raise_application_error(
            -20001,
            'No se encontró ningún tipo de transmisión con el id: ' || p_tipo_transmision_id
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de transmisión '
                           || p_nombre || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el tipo de transmisión: ' || sqlerrm);
   end tipo_transmisiones_actualizar_tipo_sp;

   procedure tipo_transmisiones_archivar_tipo_sp (
      p_tipo_transmision_id in number
   ) is
   begin
      delete from fide_tipo_transmisiones_tb
       where tipo_transmision_id = p_tipo_transmision_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Tipo de transmisión no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de transmisión con id '
                           || p_tipo_transmision_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el tipo de transmisión: ' || sqlerrm);
   end tipo_transmisiones_archivar_tipo_sp;

    ---------------------------------------------------------------------
    -- TRACCIONES
    ---------------------------------------------------------------------

   procedure tracciones_insertar_traccion_sp (
      p_nombre    in varchar2,
      p_estado_id in number
   ) is
      v_traccion_id fide_tracciones_tb.traccion_id%type;
   begin
      select tracciones_seq.nextval
        into v_traccion_id
        from dual;

      insert into fide_tracciones_tb (
         traccion_id,
         nombre,
         estado_id
      ) values ( v_traccion_id,
                 p_nombre,
                 p_estado_id );

      commit;
      dbms_output.put_line('Tracción insertada con ID: ' || v_traccion_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe una tracción con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar la tracción');
   end tracciones_insertar_traccion_sp;

   procedure tracciones_actualizar_traccion_sp (
      p_traccion_id in number,
      p_nombre      in varchar2,
      p_estado_id   in number
   ) is
   begin
      update fide_tracciones_tb
         set nombre = p_nombre,
             estado_id = p_estado_id
       where traccion_id = p_traccion_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ninguna tracción con el id: ' || p_traccion_id);
         raise_application_error(
            -20001,
            'No se encontró ninguna tracción con el id: ' || p_traccion_id
         );
      end if;
      commit;
      dbms_output.put_line('Tracción '
                           || p_nombre || ' actualizada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar la tracción: ' || sqlerrm);
   end tracciones_actualizar_traccion_sp;

   procedure tracciones_archivar_traccion_sp (
      p_traccion_id in number
   ) is
   begin
      delete from fide_tracciones_tb
       where traccion_id = p_traccion_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Tracción no encontrada.'
         );
      end if;
      commit;
      dbms_output.put_line('Tracción con id '
                           || p_traccion_id || ' fue eliminada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar la tracción: ' || sqlerrm);
   end tracciones_archivar_traccion_sp;

    ---------------------------------------------------------------------
    -- MARCAS VEHICULOS
    ---------------------------------------------------------------------

   procedure marcas_vehiculos_insertar_marca_sp (
      p_marca     in varchar2,
      p_estado_id in number
   ) is
      v_marca_id fide_marcas_vehiculos_tb.marca_id%type;
   begin
      select marcas_vehiculos_seq.nextval
        into v_marca_id
        from dual;

      insert into fide_marcas_vehiculos_tb (
         marca_id,
         marca,
         estado_id
      ) values ( v_marca_id,
                 p_marca,
                 p_estado_id );

      commit;
      dbms_output.put_line('Marca de vehículo insertada con ID: ' || v_marca_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe una marca con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar la marca');
   end marcas_vehiculos_insertar_marca_sp;

   procedure marcas_vehiculos_actualizar_marca_sp (
      p_marca_id  in number,
      p_marca     in varchar2,
      p_estado_id in number
   ) is
   begin
      update fide_marcas_vehiculos_tb
         set marca = p_marca,
             estado_id = p_estado_id
       where marca_id = p_marca_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ninguna marca con el id: ' || p_marca_id);
         raise_application_error(
            -20001,
            'No se encontró ninguna marca con el id: ' || p_marca_id
         );
      end if;
      commit;
      dbms_output.put_line('Marca '
                           || p_marca || ' actualizada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar la marca: ' || sqlerrm);
   end marcas_vehiculos_actualizar_marca_sp;

   procedure marcas_vehiculos_archivar_marca_sp (
      p_marca_id in number
   ) is
   begin
      delete from fide_marcas_vehiculos_tb
       where marca_id = p_marca_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Marca no encontrada.'
         );
      end if;
      commit;
      dbms_output.put_line('Marca con id '
                           || p_marca_id || ' fue eliminada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar la marca: ' || sqlerrm);
   end marcas_vehiculos_archivar_marca_sp;

    ---------------------------------------------------------------------
    -- MODELOS VEHICULOS
    ---------------------------------------------------------------------

   procedure modelos_vehiculos_insertar_modelo_sp (
      p_marca_id           in number,
      p_tipo_carroceria_id in number,
      p_modelo             in varchar2,
      p_estado_id          in number
   ) is
      v_modelo_id fide_modelos_vehiculos_tb.modelo_id%type;
   begin
      select modelos_vehiculos_seq.nextval
        into v_modelo_id
        from dual;

      insert into fide_modelos_vehiculos_tb (
         modelo_id,
         marca_id,
         tipo_carroceria_id,
         modelo,
         estado_id
      ) values ( v_modelo_id,
                 p_marca_id,
                 p_tipo_carroceria_id,
                 p_modelo,
                 p_estado_id );

      commit;
      dbms_output.put_line('Modelo de vehículo insertado con ID: ' || v_modelo_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un modelo con este nombre');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el modelo');
   end modelos_vehiculos_insertar_modelo_sp;

   procedure modelos_vehiculos_actualizar_modelo_sp (
      p_modelo_id          in number,
      p_marca_id           in number,
      p_tipo_carroceria_id in number,
      p_modelo             in varchar2,
      p_estado_id          in number
   ) is
   begin
      update fide_modelos_vehiculos_tb
         set marca_id = p_marca_id,
             tipo_carroceria_id = p_tipo_carroceria_id,
             modelo = p_modelo,
             estado_id = p_estado_id
       where modelo_id = p_modelo_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún modelo con el id: ' || p_modelo_id);
         raise_application_error(
            -20001,
            'No se encontró ningún modelo con el id: ' || p_modelo_id
         );
      end if;
      commit;
      dbms_output.put_line('Modelo '
                           || p_modelo || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el modelo: ' || sqlerrm);
   end modelos_vehiculos_actualizar_modelo_sp;

   procedure modelos_vehiculos_archivar_modelo_sp (
      p_modelo_id in number
   ) is
   begin
      delete from fide_modelos_vehiculos_tb
       where modelo_id = p_modelo_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Modelo no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Modelo con id '
                           || p_modelo_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el modelo: ' || sqlerrm);
   end modelos_vehiculos_archivar_modelo_sp;

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
   ) is
      v_motor_id fide_motores_tb.motor_id%type;
   begin
      select motores_seq.nextval
        into v_motor_id
        from dual;

      insert into fide_motores_tb (
         motor_id,
         tipo_combustion_id,
         nombre,
         potencia_hp,
         torque_nm,
         cilindraje_cc,
         estado_id
      ) values ( v_motor_id,
                 p_tipo_combustion_id,
                 p_nombre,
                 p_potencia_hp,
                 p_torque_nm,
                 p_cilindraje_cc,
                 p_estado_id );

      commit;
      dbms_output.put_line('Motor insertado con ID: ' || v_motor_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un motor con este ID');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el motor');
   end motores_insertar_motor_sp;

   procedure motores_actualizar_motor_sp (
      p_motor_id           in number,
      p_tipo_combustion_id in number,
      p_nombre             in varchar2,
      p_potencia_hp        in number,
      p_torque_nm          in number,
      p_cilindraje_cc      in number,
      p_estado_id          in number
   ) is
   begin
      update fide_motores_tb
         set tipo_combustion_id = p_tipo_combustion_id,
             nombre = p_nombre,
             potencia_hp = p_potencia_hp,
             torque_nm = p_torque_nm,
             cilindraje_cc = p_cilindraje_cc,
             estado_id = p_estado_id
       where motor_id = p_motor_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún motor con el id: ' || p_motor_id);
         raise_application_error(
            -20001,
            'No se encontró ningún motor con el id: ' || p_motor_id
         );
      end if;
      commit;
      dbms_output.put_line('Motor '
                           || p_nombre || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el motor: ' || sqlerrm);
   end motores_actualizar_motor_sp;

   procedure motores_archivar_motor_sp (
      p_motor_id in number
   ) is
   begin
      delete from fide_motores_tb
       where motor_id = p_motor_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Motor no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Motor con id '
                           || p_motor_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el motor: ' || sqlerrm);
   end motores_archivar_motor_sp;

    ---------------------------------------------------------------------
    -- TRANSMISIONES
    ---------------------------------------------------------------------

   procedure transmisiones_insertar_transmision_sp (
      p_tipo_transmision_id in number,
      p_tipo_traccion_id    in number,
      p_nombre              in varchar2,
      p_velocidades         in number,
      p_estado_id           in number
   ) is
      v_transmision_id fide_transmisiones_tb.transmision_id%type;
   begin
      select transmisiones_seq.nextval
        into v_transmision_id
        from dual;

      insert into fide_transmisiones_tb (
         transmision_id,
         tipo_transmision_id,
         tipo_traccion_id,
         nombre,
         velocidades,
         estado_id
      ) values ( v_transmision_id,
                 p_tipo_transmision_id,
                 p_tipo_traccion_id,
                 p_nombre,
                 p_velocidades,
                 p_estado_id );

      commit;
      dbms_output.put_line('Transmisión insertada con ID: ' || v_transmision_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe una transmisión con este ID');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar la transmisión');
   end transmisiones_insertar_transmision_sp;

   procedure transmisiones_actualizar_transmision_sp (
      p_transmision_id      in number,
      p_tipo_transmision_id in number,
      p_tipo_traccion_id    in number,
      p_nombre              in varchar2,
      p_velocidades         in number,
      p_estado_id           in number
   ) is
   begin
      update fide_transmisiones_tb
         set tipo_transmision_id = p_tipo_transmision_id,
             tipo_traccion_id = p_tipo_traccion_id,
             nombre = p_nombre,
             velocidades = p_velocidades,
             estado_id = p_estado_id
       where transmision_id = p_transmision_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ninguna transmisión con el id: ' || p_transmision_id);
         raise_application_error(
            -20001,
            'No se encontró ninguna transmisión con el id: ' || p_transmision_id
         );
      end if;
      commit;
      dbms_output.put_line('Transmisión '
                           || p_nombre || ' actualizada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar la transmisión: ' || sqlerrm);
   end transmisiones_actualizar_transmision_sp;

   procedure transmisiones_archivar_transmision_sp (
      p_transmision_id in number
   ) is
   begin
      delete from fide_transmisiones_tb
       where transmision_id = p_transmision_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Transmisión no encontrada.'
         );
      end if;
      commit;
      dbms_output.put_line('Transmisión con id '
                           || p_transmision_id || ' fue eliminada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar la transmisión: ' || sqlerrm);
   end transmisiones_archivar_transmision_sp;

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
   ) is
      v_modelo_version_id fide_modelos_versiones_tb.modelo_version_id%type;
   begin
      select modelos_versiones_seq.nextval
        into v_modelo_version_id
        from dual;

      insert into fide_modelos_versiones_tb (
         modelo_version_id,
         modelo_id,
         motor_id,
         transmision_id,
         nombre,
         numero_puertas,
         estado_id
      ) values ( v_modelo_version_id,
                 p_modelo_id,
                 p_motor_id,
                 p_transmision_id,
                 p_nombre,
                 p_numero_puertas,
                 p_estado_id );

      commit;
      dbms_output.put_line('Versión de modelo insertada con ID: ' || v_modelo_version_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe una versión con este ID');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar la versión del modelo');
   end modelos_versiones_insertar_version_sp;

   procedure modelos_versiones_actualizar_version_sp (
      p_modelo_version_id in number,
      p_modelo_id         in number,
      p_motor_id          in number,
      p_transmision_id    in number,
      p_nombre            in varchar2,
      p_numero_puertas    in number,
      p_estado_id         in number
   ) is
   begin
      update fide_modelos_versiones_tb
         set modelo_id = p_modelo_id,
             motor_id = p_motor_id,
             transmision_id = p_transmision_id,
             nombre = p_nombre,
             numero_puertas = p_numero_puertas,
             estado_id = p_estado_id
       where modelo_version_id = p_modelo_version_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ninguna versión con el id: ' || p_modelo_version_id);
         raise_application_error(
            -20001,
            'No se encontró ninguna versión con el id: ' || p_modelo_version_id
         );
      end if;
      commit;
      dbms_output.put_line('Versión '
                           || p_nombre || ' actualizada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar la versión: ' || sqlerrm);
   end modelos_versiones_actualizar_version_sp;

   procedure modelos_versiones_archivar_version_sp (
      p_modelo_version_id in number
   ) is
   begin
      delete from fide_modelos_versiones_tb
       where modelo_version_id = p_modelo_version_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Versión no encontrada.'
         );
      end if;
      commit;
      dbms_output.put_line('Versión con id '
                           || p_modelo_version_id || ' fue eliminada');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar la versión: ' || sqlerrm);
   end modelos_versiones_archivar_version_sp;

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
   ) is
   begin
      insert into fide_vehiculos_tb (
         placa_id,
         cedula,
         modelo_version_id,
         anio_fabricacion,
         kilometraje,
         fecha_registro,
         estado_id
      ) values ( p_placa_id,
                 p_cedula,
                 p_modelo_version_id,
                 p_anio_fabricacion,
                 p_kilometraje,
                 p_fecha_registro,
                 p_estado_id );

      commit;
      dbms_output.put_line('Vehículo insertado con placa: ' || p_placa_id);
   exception
      when dup_val_on_index then
         rollback;
         dbms_output.put_line('Ya existe un vehículo con esta placa');
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al insertar el vehículo');
   end vehiculos_insertar_vehiculo_sp;

   procedure vehiculos_actualizar_vehiculo_sp (
      p_placa_id          in varchar2,
      p_cedula            in varchar2,
      p_modelo_version_id in number,
      p_anio_fabricacion  in number,
      p_kilometraje       in number,
      p_estado_id         in number
   ) is
   begin
      update fide_vehiculos_tb
         set cedula = p_cedula,
             modelo_version_id = p_modelo_version_id,
             anio_fabricacion = p_anio_fabricacion,
             kilometraje = p_kilometraje,
             estado_id = p_estado_id
       where placa_id = p_placa_id;

      if sql%rowcount = 0 then
         dbms_output.put_line('No se encontró ningún vehículo con la placa: ' || p_placa_id);
         raise_application_error(
            -20001,
            'No se encontró ningún vehículo con la placa: ' || p_placa_id
         );
      end if;
      commit;
      dbms_output.put_line('Vehículo con placa '
                           || p_placa_id || ' actualizado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Hubo un error al actualizar el vehículo: ' || sqlerrm);
   end vehiculos_actualizar_vehiculo_sp;

   procedure vehiculos_archivar_vehiculo_sp (
      p_placa_id in varchar2
   ) is
   begin
      delete from fide_vehiculos_tb
       where placa_id = p_placa_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Vehículo no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Vehículo con placa '
                           || p_placa_id || ' fue eliminado');
   exception
      when others then
         rollback;
         dbms_output.put_line('Error al eliminar el vehículo: ' || sqlerrm);
   end vehiculos_archivar_vehiculo_sp;


   function salario_promedio_general_fn return number is
      v_promedio number;
   begin
      select avg(salario)
        into v_promedio
        from fide_salarios_tb;
      return nvl(
         v_promedio,
         0
      );
   exception
      when others then
         return 0;
   end salario_promedio_general_fn;

   function asistencias_hoy_fn return number is
      v_total number;
   begin
      select count(*)
        into v_total
        from fide_registro_asistencia_tb
       where trunc(fecha) = trunc(sysdate);
      return v_total;
   exception
      when others then
         return 0;
   end asistencias_hoy_fn;
end fide_smartmotriz_pkg;