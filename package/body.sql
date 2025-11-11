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
-- Modulo: Body del paquete de SmartMotriz
-- =====================================================================

create or replace package body fide_smartmotriz_pkg as

   ---------------------------------------------------------------------
   -- ESTADOS
   ---------------------------------------------------------------------
   procedure estados_insertar_estado_sp (
      p_estado in fide_estados_tb.estado%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en ESTADOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en ESTADOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar ESTADO: ' || sqlerrm);
   end estados_insertar_estado_sp;

   procedure estados_actualizar_estado_sp (
      p_estado_id in fide_estados_tb.estado_id%type,
      p_estado    in fide_estados_tb.estado%type
   ) is
   begin
      update fide_estados_tb
         set
         estado = p_estado
       where estado_id = p_estado_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ningún estado con el ID: ' || p_estado_id
         );
      end if;

      commit;
      dbms_output.put_line('Estado '
                           || p_estado || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en ESTADOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en ESTADOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar ESTADO: ' || sqlerrm);
   end estados_actualizar_estado_sp;

   procedure estados_archivar_estado_sp (
      p_estado_id in fide_estados_tb.estado_id%type
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
      dbms_output.put_line('Estado con ID '
                           || p_estado_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en ESTADOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en ESTADOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar ESTADO: ' || sqlerrm);
   end estados_archivar_estado_sp;

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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en USUARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en USUARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar USUARIO: ' || sqlerrm);
   end usuarios_insertar_usuario_sp;

   procedure usuarios_actualizar_usuario_sp (
      p_cedula           in fide_usuarios_tb.cedula%type,
      p_primer_nombre    in fide_usuarios_tb.primer_nombre%type,
      p_segundo_nombre   in fide_usuarios_tb.segundo_nombre%type,
      p_primer_apellido  in fide_usuarios_tb.primer_apellido%type,
      p_segundo_apellido in fide_usuarios_tb.segundo_apellido%type,
      p_fecha_nacimiento in fide_usuarios_tb.fecha_nacimiento%type,
      p_estado_id        in fide_usuarios_tb.estado_id%type
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
         raise_application_error(
            -20001,
            'No se encontró usuario con la cédula: ' || p_cedula
         );
      end if;

      commit;
      dbms_output.put_line('Usuario actualizado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en USUARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en USUARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar USUARIO: ' || sqlerrm);
   end usuarios_actualizar_usuario_sp;

   procedure usuarios_archivar_usuario_sp (
      p_cedula in fide_usuarios_tb.cedula%type
   ) is
   begin
      delete from fide_usuarios_tb
       where cedula = p_cedula;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Usuario no encontrado para eliminación.'
         );
      end if;
      commit;
      dbms_output.put_line('Usuario con cédula '
                           || p_cedula || ' fue eliminado.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en USUARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en USUARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar USUARIO: ' || sqlerrm);
   end usuarios_archivar_usuario_sp;

   ---------------------------------------------------------------------
   -- TIPO USUARIOS
   ---------------------------------------------------------------------
   procedure tipo_usuarios_insertar_tipo_sp (
      p_tipo      in fide_tipo_usuarios_tb.tipo%type,
      p_estado_id in fide_tipo_usuarios_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_USUARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_USUARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar TIPO_USUARIO: ' || sqlerrm);
   end tipo_usuarios_insertar_tipo_sp;

   procedure tipo_usuarios_actualizar_tipo_sp (
      p_tipo_usuario_id in fide_tipo_usuarios_tb.tipo_usuario_id%type,
      p_tipo            in fide_tipo_usuarios_tb.tipo%type,
      p_estado_id       in fide_tipo_usuarios_tb.estado_id%type
   ) is
   begin
      update fide_tipo_usuarios_tb
         set tipo = p_tipo,
             estado_id = p_estado_id
       where tipo_usuario_id = p_tipo_usuario_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró el tipo de usuario con el ID: ' || p_tipo_usuario_id
         );
      end if;

      commit;
      dbms_output.put_line('Tipo de usuario actualizado.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_USUARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_USUARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar TIPO_USUARIO: ' || sqlerrm);
   end tipo_usuarios_actualizar_tipo_sp;

   procedure tipo_usuarios_archivar_tipo_sp (
      p_tipo_usuario_id in fide_tipo_usuarios_tb.tipo_usuario_id%type
   ) is
   begin
      delete from fide_tipo_usuarios_tb
       where tipo_usuario_id = p_tipo_usuario_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Tipo de usuario no encontrado.'
         );
      end if;
      commit;
      dbms_output.put_line('Tipo de usuario eliminado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_USUARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_USUARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar TIPO_USUARIO: ' || sqlerrm);
   end tipo_usuarios_archivar_tipo_sp;

   ---------------------------------------------------------------------
   -- USUARIOS POR TIPO USUARIO
   ---------------------------------------------------------------------
   procedure usuarios_tipos_insertar_relacion_sp (
      p_cedula          in fide_usuarios_por_tipo_usuario_tb.cedula%type,
      p_tipo_usuario_id in fide_usuarios_por_tipo_usuario_tb.tipo_usuario_id%type,
      p_estado_id       in fide_usuarios_por_tipo_usuario_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en USUARIOS_POR_TIPO_USUARIO');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en USUARIOS_POR_TIPO_USUARIO');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar relación USUARIO-TIPO: ' || sqlerrm);
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
            'No se encontró relación usuario-tipo usuario con la cédula especificada.'
         );
      end if;
      commit;
      dbms_output.put_line('Relación usuario-tipo usuario actualizada correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en USUARIOS_POR_TIPO_USUARIO');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en USUARIOS_POR_TIPO_USUARIO');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar relación USUARIO-TIPO: ' || sqlerrm);
   end usuarios_tipos_actualizar_relacion_sp;

   procedure usuarios_tipos_archivar_relacion_sp (
      p_cedula          in fide_usuarios_por_tipo_usuario_tb.cedula%type,
      p_tipo_usuario_id in fide_usuarios_por_tipo_usuario_tb.tipo_usuario_id%type
   ) is
   begin
      delete from fide_usuarios_por_tipo_usuario_tb
       where cedula = p_cedula
         and tipo_usuario_id = p_tipo_usuario_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Relación no encontrada.'
         );
      end if;
      commit;
      dbms_output.put_line('Relación usuario-tipo eliminada correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en USUARIOS_POR_TIPO_USUARIO');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en USUARIOS_POR_TIPO_USUARIO');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar relación USUARIO-TIPO: ' || sqlerrm);
   end usuarios_tipos_archivar_relacion_sp;

   ---------------------------------------------------------------------
   -- TELÉFONOS
   ---------------------------------------------------------------------
   procedure telefonos_insertar_telefono_sp (
      p_cedula    in fide_telefonos_tb.cedula%type,
      p_telefono  in fide_telefonos_tb.telefono%type,
      p_estado_id in fide_telefonos_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TELÉFONOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TELÉFONOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar TELÉFONO: ' || sqlerrm);
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TELÉFONOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TELÉFONOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar TELÉFONO: ' || sqlerrm);
   end telefonos_actualizar_telefono_sp;

   procedure telefonos_archivar_telefono_sp (
      p_cedula   in fide_telefonos_tb.cedula%type,
      p_telefono in fide_telefonos_tb.telefono%type
   ) is
   begin
      delete from fide_telefonos_tb
       where cedula = p_cedula
         and telefono = p_telefono;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Teléfono no encontrado para eliminar.'
         );
      end if;
      commit;
      dbms_output.put_line('Teléfono eliminado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TELÉFONOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TELÉFONOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar TELÉFONO: ' || sqlerrm);
   end telefonos_archivar_telefono_sp;

   ---------------------------------------------------------------------
   -- CORREOS
   ---------------------------------------------------------------------
   procedure correos_insertar_correo_sp (
      p_cedula    in fide_correos_tb.cedula%type,
      p_correo    in fide_correos_tb.correo%type,
      p_estado_id in fide_correos_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en CORREOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en CORREOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar CORREO: ' || sqlerrm);
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en CORREOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en CORREOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar CORREO: ' || sqlerrm);
   end correos_actualizar_correo_sp;

   procedure correos_archivar_correo_sp (
      p_cedula in fide_correos_tb.cedula%type,
      p_correo in fide_correos_tb.correo%type
   ) is
   begin
      delete from fide_correos_tb
       where cedula = p_cedula
         and correo = p_correo;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'Correo no encontrado para eliminar.'
         );
      end if;
      commit;
      dbms_output.put_line('Correo eliminado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en CORREOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en CORREOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar CORREO: ' || sqlerrm);
   end correos_archivar_correo_sp;

   ---------------------------------------------------------------------
   -- PUESTOS
   ---------------------------------------------------------------------
   procedure puestos_insertar_puesto_sp (
      p_puesto      in fide_puestos_tb.puesto%type,
      p_salario_min in fide_puestos_tb.salario_min%type,
      p_salario_max in fide_puestos_tb.salario_max%type,
      p_estado_id   in fide_puestos_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en PUESTOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en PUESTOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar PUESTO: ' || sqlerrm);
   end puestos_insertar_puesto_sp;

   procedure puestos_actualizar_puesto_sp (
      p_puesto_id   in fide_puestos_tb.puesto_id%type,
      p_puesto      in fide_puestos_tb.puesto%type,
      p_salario_min in fide_puestos_tb.salario_min%type,
      p_salario_max in fide_puestos_tb.salario_max%type,
      p_estado_id   in fide_puestos_tb.estado_id%type
   ) is
   begin
      update fide_puestos_tb
         set puesto = p_puesto,
             salario_max = p_salario_max,
             salario_min = p_salario_min,
             estado_id = p_estado_id
       where puesto_id = p_puesto_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró el puesto con el ID: ' || p_puesto_id
         );
      end if;

      commit;
      dbms_output.put_line('Puesto actualizado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en PUESTOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en PUESTOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar PUESTO: ' || sqlerrm);
   end puestos_actualizar_puesto_sp;

   procedure puestos_archivar_puesto_sp (
      p_puesto_id in fide_puestos_tb.puesto_id%type
   ) is
   begin
      delete from fide_puestos_tb
       where puesto_id = p_puesto_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró el puesto con el ID: ' || p_puesto_id
         );
      end if;

      commit;
      dbms_output.put_line('Puesto eliminado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en PUESTOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en PUESTOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar PUESTO: ' || sqlerrm);
   end puestos_archivar_puesto_sp;

   ---------------------------------------------------------------------
   -- MECÁNICOS
   ---------------------------------------------------------------------
   procedure mecanicos_insertar_mecanico_sp (
      p_cedula        in fide_mecanicos_tb.cedula%type,
      p_puesto_id     in fide_mecanicos_tb.puesto_id%type,
      p_fecha_ingreso in fide_mecanicos_tb.fecha_ingreso%type,
      p_fecha_fin     in fide_mecanicos_tb.fecha_fin%type,
      p_estado_id     in fide_mecanicos_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MECÁNICOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MECÁNICOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar MECÁNICO: ' || sqlerrm);
   end mecanicos_insertar_mecanico_sp;

   procedure mecanicos_actualizar_mecanico_sp (
      p_mecanico_id in fide_mecanicos_tb.mecanico_id%type,
      p_puesto_id   in fide_mecanicos_tb.puesto_id%type,
      p_fecha_fin   in fide_mecanicos_tb.fecha_fin%type,
      p_estado_id   in fide_mecanicos_tb.estado_id%type
   ) is
   begin
      update fide_mecanicos_tb
         set puesto_id = p_puesto_id,
             fecha_fin = p_fecha_fin,
             estado_id = p_estado_id
       where mecanico_id = p_mecanico_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró el mecánico con el ID: ' || p_mecanico_id
         );
      end if;

      commit;
      dbms_output.put_line('Mecánico actualizado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MECÁNICOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MECÁNICOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar MECÁNICO: ' || sqlerrm);
   end mecanicos_actualizar_mecanico_sp;

   procedure mecanicos_archivar_mecanico_sp (
      p_mecanico_id in fide_mecanicos_tb.mecanico_id%type
   ) is
   begin
      delete from fide_mecanicos_tb
       where mecanico_id = p_mecanico_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró el mecánico con el ID: ' || p_mecanico_id
         );
      end if;

      commit;
      dbms_output.put_line('Mecánico eliminado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MECÁNICOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MECÁNICOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar MECÁNICO: ' || sqlerrm);
   end mecanicos_archivar_mecanico_sp;

   ---------------------------------------------------------------------
   -- REGISTRO ASISTENCIA
   ---------------------------------------------------------------------
   procedure registro_asistencia_insertar_asistencia_sp (
      p_mecanico_id  in fide_registro_asistencia_tb.mecanico_id%type,
      p_fecha        in fide_registro_asistencia_tb.fecha%type,
      p_hora_entrada in fide_registro_asistencia_tb.hora_entrada%type,
      p_hora_salida  in fide_registro_asistencia_tb.hora_salida%type,
      p_estado_id    in fide_registro_asistencia_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en REGISTRO_ASISTENCIA');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en REGISTRO_ASISTENCIA');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar REGISTRO_ASISTENCIA: ' || sqlerrm);
   end registro_asistencia_insertar_asistencia_sp;

   procedure registro_asistencia_actualizar_asistencia_sp (
      p_mecanico_id in fide_registro_asistencia_tb.mecanico_id%type,
      p_fecha       in fide_registro_asistencia_tb.fecha%type,
      p_hora_salida in fide_registro_asistencia_tb.hora_salida%type,
      p_estado_id   in fide_registro_asistencia_tb.estado_id%type
   ) is
   begin
      update fide_registro_asistencia_tb
         set hora_salida = p_hora_salida,
             estado_id = p_estado_id
       where mecanico_id = p_mecanico_id
         and fecha = p_fecha;

      if sql%rowcount = 0 then
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en REGISTRO_ASISTENCIA');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en REGISTRO_ASISTENCIA');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar REGISTRO_ASISTENCIA: ' || sqlerrm);
   end registro_asistencia_actualizar_asistencia_sp;

   procedure registro_asistencia_archivar_asistencia_sp (
      p_mecanico_id in fide_registro_asistencia_tb.mecanico_id%type,
      p_fecha       in fide_registro_asistencia_tb.fecha%type
   ) is
   begin
      delete from fide_registro_asistencia_tb
       where mecanico_id = p_mecanico_id
         and fecha = p_fecha;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró el registro de asistencia para eliminar.'
         );
      end if;
      commit;
      dbms_output.put_line('Registro de asistencia eliminado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en REGISTRO_ASISTENCIA');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en REGISTRO_ASISTENCIA');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar REGISTRO_ASISTENCIA: ' || sqlerrm);
   end registro_asistencia_archivar_asistencia_sp;

   ---------------------------------------------------------------------
   -- SALARIOS
   ---------------------------------------------------------------------
   procedure salarios_insertar_salario_sp (
      p_mecanico_id   in fide_salarios_tb.mecanico_id%type,
      p_salario       in fide_salarios_tb.salario%type,
      p_fecha_inicio  in fide_salarios_tb.fecha_inicio%type,
      p_fecha_fin     in fide_salarios_tb.fecha_fin%type,
      p_motivo_cambio in fide_salarios_tb.motivo_cambio%type,
      p_estado_id     in fide_salarios_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en SALARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en SALARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar SALARIO: ' || sqlerrm);
   end salarios_insertar_salario_sp;

   procedure salarios_actualizar_salario_sp (
      p_salario_id    in fide_salarios_tb.salario_id%type,
      p_salario       in fide_salarios_tb.salario%type,
      p_fecha_inicio  in fide_salarios_tb.fecha_inicio%type,
      p_fecha_fin     in fide_salarios_tb.fecha_fin%type,
      p_motivo_cambio in fide_salarios_tb.motivo_cambio%type,
      p_estado_id     in fide_salarios_tb.estado_id%type
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
         raise_application_error(
            -20001,
            'No se encontró el salario con el ID: ' || p_salario_id
         );
      end if;

      commit;
      dbms_output.put_line('Salario actualizado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en SALARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en SALARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar SALARIO: ' || sqlerrm);
   end salarios_actualizar_salario_sp;

   procedure salarios_archivar_salario_sp (
      p_salario_id in fide_salarios_tb.salario_id%type
   ) is
   begin
      delete from fide_salarios_tb
       where salario_id = p_salario_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró el salario con el ID: ' || p_salario_id
         );
      end if;

      commit;
      dbms_output.put_line('Salario eliminado correctamente.');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en SALARIOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en SALARIOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar SALARIO: ' || sqlerrm);
   end salarios_archivar_salario_sp;

   ---------------------------------------------------------------------
   -- TIPO DIRECCIONES
   ---------------------------------------------------------------------
   procedure tipo_direcciones_insertar_tipo_sp (
      p_tipo      in fide_tipo_direcciones_tb.tipo%type,
      p_estado_id in fide_tipo_direcciones_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_DIRECCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_DIRECCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar TIPO_DIRECCIÓN: ' || sqlerrm);
   end tipo_direcciones_insertar_tipo_sp;

   procedure tipo_direcciones_actualizar_tipo_sp (
      p_tipo_direccion_id in fide_tipo_direcciones_tb.tipo_direccion_id%type,
      p_tipo              in fide_tipo_direcciones_tb.tipo%type,
      p_estado_id         in fide_tipo_direcciones_tb.estado_id%type
   ) is
   begin
      update fide_tipo_direcciones_tb
         set tipo = p_tipo,
             estado_id = p_estado_id
       where tipo_direccion_id = p_tipo_direccion_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ningún tipo de dirección con el ID: ' || p_tipo_direccion_id
         );
      end if;

      commit;
      dbms_output.put_line('Tipo de dirección '
                           || p_tipo || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_DIRECCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_DIRECCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar TIPO_DIRECCIÓN: ' || sqlerrm);
   end tipo_direcciones_actualizar_tipo_sp;

   procedure tipo_direcciones_archivar_tipo_sp (
      p_tipo_direccion_id in fide_tipo_direcciones_tb.tipo_direccion_id%type
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
      dbms_output.put_line('Tipo de dirección con ID '
                           || p_tipo_direccion_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_DIRECCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_DIRECCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar TIPO_DIRECCIÓN: ' || sqlerrm);
   end tipo_direcciones_archivar_tipo_sp;

   ---------------------------------------------------------------------
   -- PROVINCIAS
   ---------------------------------------------------------------------
   procedure provincias_insertar_provincia_sp (
      p_provincia in fide_provincias_tb.provincia%type,
      p_estado_id in fide_provincias_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en PROVINCIAS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en PROVINCIAS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar PROVINCIA: ' || sqlerrm);
   end provincias_insertar_provincia_sp;

   procedure provincias_actualizar_provincia_sp (
      p_provincia_id in fide_provincias_tb.provincia_id%type,
      p_provincia    in fide_provincias_tb.provincia%type,
      p_estado_id    in fide_provincias_tb.estado_id%type
   ) is
   begin
      update fide_provincias_tb
         set provincia = p_provincia,
             estado_id = p_estado_id
       where provincia_id = p_provincia_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ninguna provincia con el ID: ' || p_provincia_id
         );
      end if;

      commit;
      dbms_output.put_line('Provincia '
                           || p_provincia || ' actualizada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en PROVINCIAS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en PROVINCIAS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar PROVINCIA: ' || sqlerrm);
   end provincias_actualizar_provincia_sp;

   procedure provincias_archivar_provincia_sp (
      p_provincia_id in fide_provincias_tb.provincia_id%type
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
      dbms_output.put_line('Provincia con ID '
                           || p_provincia_id || ' fue eliminada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en PROVINCIAS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en PROVINCIAS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar PROVINCIA: ' || sqlerrm);
   end provincias_archivar_provincia_sp;

   ---------------------------------------------------------------------
   -- CANTONES
   ---------------------------------------------------------------------
   procedure cantones_insertar_canton_sp (
      p_canton       in fide_cantones_tb.canton%type,
      p_provincia_id in fide_cantones_tb.provincia_id%type,
      p_estado_id    in fide_cantones_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en CANTONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en CANTONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar CANTÓN: ' || sqlerrm);
   end cantones_insertar_canton_sp;

   procedure cantones_actualizar_canton_sp (
      p_canton_id    in fide_cantones_tb.canton_id%type,
      p_canton       in fide_cantones_tb.canton%type,
      p_provincia_id in fide_cantones_tb.provincia_id%type,
      p_estado_id    in fide_cantones_tb.estado_id%type
   ) is
   begin
      update fide_cantones_tb
         set canton = p_canton,
             provincia_id = p_provincia_id,
             estado_id = p_estado_id
       where canton_id = p_canton_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ningún cantón con el ID: ' || p_canton_id
         );
      end if;

      commit;
      dbms_output.put_line('Cantón '
                           || p_canton || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en CANTONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en CANTONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar CANTÓN: ' || sqlerrm);
   end cantones_actualizar_canton_sp;

   procedure cantones_archivar_canton_sp (
      p_canton_id in fide_cantones_tb.canton_id%type
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
      dbms_output.put_line('Cantón con ID '
                           || p_canton_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en CANTONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en CANTONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar CANTÓN: ' || sqlerrm);
   end cantones_archivar_canton_sp;

   ---------------------------------------------------------------------
   -- DISTRITOS
   ---------------------------------------------------------------------
   procedure distritos_insertar_distrito_sp (
      p_distrito  in fide_distritos_tb.distrito%type,
      p_canton_id in fide_distritos_tb.canton_id%type,
      p_estado_id in fide_distritos_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en DISTRITOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en DISTRITOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar DISTRITO: ' || sqlerrm);
   end distritos_insertar_distrito_sp;

   procedure distritos_actualizar_distrito_sp (
      p_distrito_id in fide_distritos_tb.distrito_id%type,
      p_distrito    in fide_distritos_tb.distrito%type,
      p_canton_id   in fide_distritos_tb.canton_id%type,
      p_estado_id   in fide_distritos_tb.estado_id%type
   ) is
   begin
      update fide_distritos_tb
         set distrito = p_distrito,
             canton_id = p_canton_id,
             estado_id = p_estado_id
       where distrito_id = p_distrito_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ningún distrito con el ID: ' || p_distrito_id
         );
      end if;

      commit;
      dbms_output.put_line('Distrito '
                           || p_distrito || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en DISTRITOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en DISTRITOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar DISTRITO: ' || sqlerrm);
   end distritos_actualizar_distrito_sp;

   procedure distritos_archivar_distrito_sp (
      p_distrito_id in fide_distritos_tb.distrito_id%type
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
      dbms_output.put_line('Distrito con ID '
                           || p_distrito_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en DISTRITOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en DISTRITOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar DISTRITO: ' || sqlerrm);
   end distritos_archivar_distrito_sp;

   ---------------------------------------------------------------------
   -- DIRECCIONES
   ---------------------------------------------------------------------
   procedure direcciones_insertar_direccion_sp (
      p_cedula            in fide_direcciones_tb.cedula%type,
      p_tipo_direccion_id in fide_direcciones_tb.tipo_direccion_id%type,
      p_distrito_id       in fide_direcciones_tb.distrito_id%type,
      p_otras_senas       in fide_direcciones_tb.otras_senas%type,
      p_estado_id         in fide_direcciones_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en DIRECCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en DIRECCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar DIRECCIÓN: ' || sqlerrm);
   end direcciones_insertar_direccion_sp;

   procedure direcciones_actualizar_direccion_sp (
      p_cedula            in fide_direcciones_tb.cedula%type,
      p_tipo_direccion_id in fide_direcciones_tb.tipo_direccion_id%type,
      p_distrito_id       in fide_direcciones_tb.distrito_id%type,
      p_otras_senas       in fide_direcciones_tb.otras_senas%type,
      p_estado_id         in fide_direcciones_tb.estado_id%type
   ) is
   begin
      update fide_direcciones_tb
         set distrito_id = p_distrito_id,
             otras_senas = p_otras_senas,
             estado_id = p_estado_id
       where cedula = p_cedula
         and tipo_direccion_id = p_tipo_direccion_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ninguna dirección para el usuario: ' || p_cedula
         );
      end if;

      commit;
      dbms_output.put_line('Dirección actualizada para el usuario: ' || p_cedula);
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en DIRECCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en DIRECCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar DIRECCIÓN: ' || sqlerrm);
   end direcciones_actualizar_direccion_sp;

   procedure direcciones_archivar_direccion_sp (
      p_cedula            in fide_direcciones_tb.cedula%type,
      p_tipo_direccion_id in fide_direcciones_tb.tipo_direccion_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en DIRECCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en DIRECCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar DIRECCIÓN: ' || sqlerrm);
   end direcciones_archivar_direccion_sp;

   ---------------------------------------------------------------------
   -- TIPO CARROCERIAS
   ---------------------------------------------------------------------
   procedure tipo_carrocerias_insertar_tipo_sp (
      p_nombre    in fide_tipo_carrocerias_tb.nombre%type,
      p_estado_id in fide_tipo_carrocerias_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_CARROCERIAS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_CARROCERIAS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar TIPO_CARROCERÍA: ' || sqlerrm);
   end tipo_carrocerias_insertar_tipo_sp;

   procedure tipo_carrocerias_actualizar_tipo_sp (
      p_tipo_carroceria_id in fide_tipo_carrocerias_tb.tipo_carroceria_id%type,
      p_nombre             in fide_tipo_carrocerias_tb.nombre%type,
      p_estado_id          in fide_tipo_carrocerias_tb.estado_id%type
   ) is
   begin
      update fide_tipo_carrocerias_tb
         set nombre = p_nombre,
             estado_id = p_estado_id
       where tipo_carroceria_id = p_tipo_carroceria_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ningún tipo de carrocería con el ID: ' || p_tipo_carroceria_id
         );
      end if;

      commit;
      dbms_output.put_line('Tipo de carrocería '
                           || p_nombre || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_CARROCERIAS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_CARROCERIAS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar TIPO_CARROCERÍA: ' || sqlerrm);
   end tipo_carrocerias_actualizar_tipo_sp;

   procedure tipo_carrocerias_archivar_tipo_sp (
      p_tipo_carroceria_id in fide_tipo_carrocerias_tb.tipo_carroceria_id%type
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
      dbms_output.put_line('Tipo de carrocería con ID '
                           || p_tipo_carroceria_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_CARROCERIAS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_CARROCERIAS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar TIPO_CARROCERÍA: ' || sqlerrm);
   end tipo_carrocerias_archivar_tipo_sp;

   ---------------------------------------------------------------------
   -- TIPO COMBUSTIONES
   ---------------------------------------------------------------------
   procedure tipo_combustiones_insertar_tipo_sp (
      p_nombre    in fide_tipo_combustiones_tb.nombre%type,
      p_estado_id in fide_tipo_combustiones_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_COMBUSTIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_COMBUSTIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar TIPO_COMBUSTIÓN: ' || sqlerrm);
   end tipo_combustiones_insertar_tipo_sp;

   procedure tipo_combustiones_actualizar_tipo_sp (
      p_tipo_combustion_id in fide_tipo_combustiones_tb.tipo_combustion_id%type,
      p_nombre             in fide_tipo_combustiones_tb.nombre%type,
      p_estado_id          in fide_tipo_combustiones_tb.estado_id%type
   ) is
   begin
      update fide_tipo_combustiones_tb
         set nombre = p_nombre,
             estado_id = p_estado_id
       where tipo_combustion_id = p_tipo_combustion_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ningún tipo de combustión con el ID: ' || p_tipo_combustion_id
         );
      end if;

      commit;
      dbms_output.put_line('Tipo de combustión '
                           || p_nombre || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_COMBUSTIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_COMBUSTIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar TIPO_COMBUSTIÓN: ' || sqlerrm);
   end tipo_combustiones_actualizar_tipo_sp;

   procedure tipo_combustiones_archivar_tipo_sp (
      p_tipo_combustion_id in fide_tipo_combustiones_tb.tipo_combustion_id%type
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
      dbms_output.put_line('Tipo de combustión con ID '
                           || p_tipo_combustion_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_COMBUSTIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_COMBUSTIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar TIPO_COMBUSTIÓN: ' || sqlerrm);
   end tipo_combustiones_archivar_tipo_sp;

   ---------------------------------------------------------------------
   -- TIPO TRANSMISIONES
   ---------------------------------------------------------------------
   procedure tipo_transmisiones_insertar_tipo_sp (
      p_nombre    in fide_tipo_transmisiones_tb.nombre%type,
      p_estado_id in fide_tipo_transmisiones_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_TRANSMISIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_TRANSMISIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar TIPO_TRANSMISIÓN: ' || sqlerrm);
   end tipo_transmisiones_insertar_tipo_sp;

   procedure tipo_transmisiones_actualizar_tipo_sp (
      p_tipo_transmision_id in fide_tipo_transmisiones_tb.tipo_transmision_id%type,
      p_nombre              in fide_tipo_transmisiones_tb.nombre%type,
      p_estado_id           in fide_tipo_transmisiones_tb.estado_id%type
   ) is
   begin
      update fide_tipo_transmisiones_tb
         set nombre = p_nombre,
             estado_id = p_estado_id
       where tipo_transmision_id = p_tipo_transmision_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ningún tipo de transmisión con el ID: ' || p_tipo_transmision_id
         );
      end if;

      commit;
      dbms_output.put_line('Tipo de transmisión '
                           || p_nombre || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_TRANSMISIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_TRANSMISIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar TIPO_TRANSMISIÓN: ' || sqlerrm);
   end tipo_transmisiones_actualizar_tipo_sp;

   procedure tipo_transmisiones_archivar_tipo_sp (
      p_tipo_transmision_id in fide_tipo_transmisiones_tb.tipo_transmision_id%type
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
      dbms_output.put_line('Tipo de transmisión con ID '
                           || p_tipo_transmision_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TIPO_TRANSMISIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TIPO_TRANSMISIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar TIPO_TRANSMISIÓN: ' || sqlerrm);
   end tipo_transmisiones_archivar_tipo_sp;

   ---------------------------------------------------------------------
   -- TRACCIONES
   ---------------------------------------------------------------------
   procedure tracciones_insertar_traccion_sp (
      p_nombre    in fide_tracciones_tb.nombre%type,
      p_estado_id in fide_tracciones_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TRACCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TRACCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar TRACCIÓN: ' || sqlerrm);
   end tracciones_insertar_traccion_sp;

   procedure tracciones_actualizar_traccion_sp (
      p_traccion_id in fide_tracciones_tb.traccion_id%type,
      p_nombre      in fide_tracciones_tb.nombre%type,
      p_estado_id   in fide_tracciones_tb.estado_id%type
   ) is
   begin
      update fide_tracciones_tb
         set nombre = p_nombre,
             estado_id = p_estado_id
       where traccion_id = p_traccion_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ninguna tracción con el ID: ' || p_traccion_id
         );
      end if;

      commit;
      dbms_output.put_line('Tracción '
                           || p_nombre || ' actualizada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TRACCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TRACCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar TRACCIÓN: ' || sqlerrm);
   end tracciones_actualizar_traccion_sp;

   procedure tracciones_archivar_traccion_sp (
      p_traccion_id in fide_tracciones_tb.traccion_id%type
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
      dbms_output.put_line('Tracción con ID '
                           || p_traccion_id || ' fue eliminada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TRACCIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TRACCIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar TRACCIÓN: ' || sqlerrm);
   end tracciones_archivar_traccion_sp;

   ---------------------------------------------------------------------
   -- MARCAS VEHICULOS
   ---------------------------------------------------------------------
   procedure marcas_vehiculos_insertar_marca_sp (
      p_marca     in fide_marcas_vehiculos_tb.marca%type,
      p_estado_id in fide_marcas_vehiculos_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MARCAS_VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MARCAS_VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar MARCA_VEHÍCULO: ' || sqlerrm);
   end marcas_vehiculos_insertar_marca_sp;

   procedure marcas_vehiculos_actualizar_marca_sp (
      p_marca_id  in fide_marcas_vehiculos_tb.marca_id%type,
      p_marca     in fide_marcas_vehiculos_tb.marca%type,
      p_estado_id in fide_marcas_vehiculos_tb.estado_id%type
   ) is
   begin
      update fide_marcas_vehiculos_tb
         set marca = p_marca,
             estado_id = p_estado_id
       where marca_id = p_marca_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ninguna marca con el ID: ' || p_marca_id
         );
      end if;

      commit;
      dbms_output.put_line('Marca '
                           || p_marca || ' actualizada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MARCAS_VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MARCAS_VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar MARCA_VEHÍCULO: ' || sqlerrm);
   end marcas_vehiculos_actualizar_marca_sp;

   procedure marcas_vehiculos_archivar_marca_sp (
      p_marca_id in fide_marcas_vehiculos_tb.marca_id%type
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
      dbms_output.put_line('Marca con ID '
                           || p_marca_id || ' fue eliminada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MARCAS_VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MARCAS_VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar MARCA_VEHÍCULO: ' || sqlerrm);
   end marcas_vehiculos_archivar_marca_sp;

   ---------------------------------------------------------------------
   -- MODELOS VEHICULOS
   ---------------------------------------------------------------------
   procedure modelos_vehiculos_insertar_modelo_sp (
      p_marca_id           in fide_modelos_vehiculos_tb.marca_id%type,
      p_tipo_carroceria_id in fide_modelos_vehiculos_tb.tipo_carroceria_id%type,
      p_modelo             in fide_modelos_vehiculos_tb.modelo%type,
      p_estado_id          in fide_modelos_vehiculos_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MODELOS_VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MODELOS_VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar MODELO_VEHÍCULO: ' || sqlerrm);
   end modelos_vehiculos_insertar_modelo_sp;

   procedure modelos_vehiculos_actualizar_modelo_sp (
      p_modelo_id          in fide_modelos_vehiculos_tb.modelo_id%type,
      p_marca_id           in fide_modelos_vehiculos_tb.marca_id%type,
      p_tipo_carroceria_id in fide_modelos_vehiculos_tb.tipo_carroceria_id%type,
      p_modelo             in fide_modelos_vehiculos_tb.modelo%type,
      p_estado_id          in fide_modelos_vehiculos_tb.estado_id%type
   ) is
   begin
      update fide_modelos_vehiculos_tb
         set marca_id = p_marca_id,
             tipo_carroceria_id = p_tipo_carroceria_id,
             modelo = p_modelo,
             estado_id = p_estado_id
       where modelo_id = p_modelo_id;

      if sql%rowcount = 0 then
         raise_application_error(
            -20001,
            'No se encontró ningún modelo con el ID: ' || p_modelo_id
         );
      end if;

      commit;
      dbms_output.put_line('Modelo '
                           || p_modelo || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MODELOS_VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MODELOS_VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar MODELO_VEHÍCULO: ' || sqlerrm);
   end modelos_vehiculos_actualizar_modelo_sp;

   procedure modelos_vehiculos_archivar_modelo_sp (
      p_modelo_id in fide_modelos_vehiculos_tb.modelo_id%type
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
      dbms_output.put_line('Modelo con ID '
                           || p_modelo_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MODELOS_VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MODELOS_VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar MODELO_VEHÍCULO: ' || sqlerrm);
   end modelos_vehiculos_archivar_modelo_sp;

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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MOTORES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MOTORES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar MOTOR: ' || sqlerrm);
   end motores_insertar_motor_sp;

   procedure motores_actualizar_motor_sp (
      p_motor_id           in fide_motores_tb.motor_id%type,
      p_tipo_combustion_id in fide_motores_tb.tipo_combustion_id%type,
      p_nombre             in fide_motores_tb.nombre%type,
      p_potencia_hp        in fide_motores_tb.potencia_hp%type,
      p_torque_nm          in fide_motores_tb.torque_nm%type,
      p_cilindraje_cc      in fide_motores_tb.cilindraje_cc%type,
      p_estado_id          in fide_motores_tb.estado_id%type
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
         raise_application_error(
            -20001,
            'No se encontró ningún motor con el ID: ' || p_motor_id
         );
      end if;

      commit;
      dbms_output.put_line('Motor '
                           || p_nombre || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MOTORES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MOTORES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar MOTOR: ' || sqlerrm);
   end motores_actualizar_motor_sp;

   procedure motores_archivar_motor_sp (
      p_motor_id in fide_motores_tb.motor_id%type
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
      dbms_output.put_line('Motor con ID '
                           || p_motor_id || ' fue eliminado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MOTORES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MOTORES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar MOTOR: ' || sqlerrm);
   end motores_archivar_motor_sp;

   ---------------------------------------------------------------------
   -- TRANSMISIONES
   ---------------------------------------------------------------------
   procedure transmisiones_insertar_transmision_sp (
      p_tipo_transmision_id in fide_transmisiones_tb.tipo_transmision_id%type,
      p_tipo_traccion_id    in fide_transmisiones_tb.tipo_traccion_id%type,
      p_nombre              in fide_transmisiones_tb.nombre%type,
      p_velocidades         in fide_transmisiones_tb.velocidades%type,
      p_estado_id           in fide_transmisiones_tb.estado_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TRANSMISIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TRANSMISIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar TRANSMISIÓN: ' || sqlerrm);
   end transmisiones_insertar_transmision_sp;

   procedure transmisiones_actualizar_transmision_sp (
      p_transmision_id      in fide_transmisiones_tb.transmision_id%type,
      p_tipo_transmision_id in fide_transmisiones_tb.tipo_transmision_id%type,
      p_tipo_traccion_id    in fide_transmisiones_tb.tipo_traccion_id%type,
      p_nombre              in fide_transmisiones_tb.nombre%type,
      p_velocidades         in fide_transmisiones_tb.velocidades%type,
      p_estado_id           in fide_transmisiones_tb.estado_id%type
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
         raise_application_error(
            -20001,
            'No se encontró ninguna transmisión con el ID: ' || p_transmision_id
         );
      end if;

      commit;
      dbms_output.put_line('Transmisión '
                           || p_nombre || ' actualizada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TRANSMISIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TRANSMISIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar TRANSMISIÓN: ' || sqlerrm);
   end transmisiones_actualizar_transmision_sp;

   procedure transmisiones_archivar_transmision_sp (
      p_transmision_id in fide_transmisiones_tb.transmision_id%type
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
      dbms_output.put_line('Transmisión con ID '
                           || p_transmision_id || ' fue eliminada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en TRANSMISIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en TRANSMISIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar TRANSMISIÓN: ' || sqlerrm);
   end transmisiones_archivar_transmision_sp;

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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MODELOS_VERSIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MODELOS_VERSIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar VERSIÓN_MODELO: ' || sqlerrm);
   end modelos_versiones_insertar_version_sp;

   procedure modelos_versiones_actualizar_version_sp (
      p_modelo_version_id in fide_modelos_versiones_tb.modelo_version_id%type,
      p_modelo_id         in fide_modelos_versiones_tb.modelo_id%type,
      p_motor_id          in fide_modelos_versiones_tb.motor_id%type,
      p_transmision_id    in fide_modelos_versiones_tb.transmision_id%type,
      p_nombre            in fide_modelos_versiones_tb.nombre%type,
      p_numero_puertas    in fide_modelos_versiones_tb.numero_puertas%type,
      p_estado_id         in fide_modelos_versiones_tb.estado_id%type
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
         raise_application_error(
            -20001,
            'No se encontró ninguna versión con el ID: ' || p_modelo_version_id
         );
      end if;

      commit;
      dbms_output.put_line('Versión '
                           || p_nombre || ' actualizada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MODELOS_VERSIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MODELOS_VERSIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar VERSIÓN_MODELO: ' || sqlerrm);
   end modelos_versiones_actualizar_version_sp;

   procedure modelos_versiones_archivar_version_sp (
      p_modelo_version_id in fide_modelos_versiones_tb.modelo_version_id%type
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
      dbms_output.put_line('Versión con ID '
                           || p_modelo_version_id || ' fue eliminada');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en MODELOS_VERSIONES');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en MODELOS_VERSIONES');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar VERSIÓN_MODELO: ' || sqlerrm);
   end modelos_versiones_archivar_version_sp;

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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al insertar VEHÍCULO: ' || sqlerrm);
   end vehiculos_insertar_vehiculo_sp;

   procedure vehiculos_actualizar_vehiculo_sp (
      p_placa_id          in fide_vehiculos_tb.placa_id%type,
      p_cedula            in fide_vehiculos_tb.cedula%type,
      p_modelo_version_id in fide_vehiculos_tb.modelo_version_id%type,
      p_anio_fabricacion  in fide_vehiculos_tb.anio_fabricacion%type,
      p_kilometraje       in fide_vehiculos_tb.kilometraje%type,
      p_estado_id         in fide_vehiculos_tb.estado_id%type
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
         raise_application_error(
            -20001,
            'No se encontró ningún vehículo con la placa: ' || p_placa_id
         );
      end if;

      commit;
      dbms_output.put_line('Vehículo con placa '
                           || p_placa_id || ' actualizado');
   exception
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al actualizar VEHÍCULO: ' || sqlerrm);
   end vehiculos_actualizar_vehiculo_sp;

   procedure vehiculos_archivar_vehiculo_sp (
      p_placa_id in fide_vehiculos_tb.placa_id%type
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
      when no_data_found then
         rollback;
         dbms_output.put_line('DATOS NO ENCONTRADOS en VEHICULOS');
      when too_many_rows then
         rollback;
         dbms_output.put_line('DATOS DUPLICADOS en VEHICULOS');
      when others then
         rollback;
         dbms_output.put_line('ERROR al eliminar VEHÍCULO: ' || sqlerrm);
   end vehiculos_archivar_vehiculo_sp;

end fide_smartmotriz_pkg;
/