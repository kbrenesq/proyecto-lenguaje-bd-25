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
end fide_smartmotriz_pkg;
/