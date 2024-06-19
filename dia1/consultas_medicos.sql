use medicos;

-- ConSULTas
-- 1.Número de pacientes atendidos por cada médico
select m.Nombre as Medico,COUNT(p.ID_Paciente) as Numero_Pacientes
from Medicos m
left join Pacientes p on m.ID_Medico = p.ID_Medico
group by m.ID_Medico;

-- 2.Total de días de vacaciones planificadas y disfrutadas por cada empleado
select e.Nombre as Empleado,SUM(DATEDIFF(v.Fecha_Fin, v.Fecha_Inicio) + 1) as Dias_Vacaciones,v.Estado
from Empleados e
join Vacaciones v on e.ID_Empleado = v.ID_Empleado
group by e.ID_Empleado, v.Estado;

-- 3.Médicos con mayor cantidad de horas de consulta en la semana
select m.Nombre as Medico,SUM(timestampdiff(hour, h.Hora_Inicio, h.Hora_Fin)) as Horas_Consulta
from Medicos m
join Horario_Consultas h on m.ID_Medico = h.ID_Medico
group by m.ID_Medico order by Horas_Consulta desc;

-- 4.Número de sustituciones realizadas por cada médico sustituto
select m.Nombre as Medico,COUNT(s.ID_Sustitucion) as Numero_Sustituciones
from Medicos m
join Sustituciones s on m.ID_Medico = s.ID_Medico
where m.Tipo = 'sustituto'
group by m.ID_Medico;

-- 5.Número de médicos que están actualmente en sustitución
select COUNT(distinct s.ID_Medico) as Medicos_En_Sustitucion
from Sustituciones s
where CURDATE() between s.Fecha_Alta and s.Fecha_Baja;

-- 6.Horas totales de consulta por médico por día de la semana
select m.Nombre as Medico,h.Dia_Semana,SUM(timestampdiff(hour, h.Hora_Inicio, h.Hora_Fin)) as Horas_Consulta
from Medicos m
join Horario_Consultas h on m.ID_Medico = h.ID_Medico
group by m.ID_Medico, h.Dia_Semana;

-- 7. Médico con mayor cantidad de pacientes asignados
select m.Nombre as Medico,COUNT(p.ID_Paciente) as Numero_Pacientes
from Medicos m
left join Pacientes p on m.ID_Medico = p.ID_Medico
group by m.ID_Medico
order by Numero_Pacientes desc;

-- 8. Empleados con más de 10 días de vacaciones disfrutadas
select e.Nombre as Empleado,SUM(DATEDIFF(v.Fecha_Fin, v.Fecha_Inicio) + 1) as Dias_Disfrutados
from Empleados e
join Vacaciones v on e.ID_Empleado = v.ID_Empleado
where v.Estado = 'disfrutadas'
group by e.ID_Empleado
HAVING Dias_Disfrutados > 10;

-- 9.Médicos que actualmente están realizando una sustitución
select m.Nombre as Medico
from Medicos m
join Sustituciones s on m.ID_Medico = s.ID_Medico
where CURDATE() between s.Fecha_Alta and s.Fecha_Baja;

-- 10.Promedio de horas de consulta por médico por día de la semana
select h.Dia_Semana,AVG(timestampdiff(hour, h.Hora_Inicio, h.Hora_Fin)) as Promedio_Horas
from Horario_Consultas h
group by h.Dia_Semana;


