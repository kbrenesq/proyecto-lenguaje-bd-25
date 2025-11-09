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


end fide_smartmotriz_pkg;
/

   SET SERVEROUTPUT ON;

begin
   fide_smartmotriz_pkg.estados_archivar_estado_sp(3);
end;
/