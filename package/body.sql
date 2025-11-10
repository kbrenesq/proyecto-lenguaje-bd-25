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

end fide_smartmotriz_pkg;
/