-- LABORATORY WORK 4
-- BY Tymoveiev_Nikita

--при добавлении студента заселяет его в комнату --

create or replace TRIGGER SET_INTO_A_ROOM 
after INSERT ON STUDENT
FOR EACH ROW

declare 

r_n room.room_number%type;
d_n ROOM.DORM_NUMBER%type;
d_a ROOM.DORM_ADDRESS%type;

BEGIN

select dorm_number, dorm_address into d_n, d_a
FROM DORM
WHERE university = :new.university;

select room_number into r_n
from(
select room_number
from room
where dorm_number = d_n and dorm_address = d_a
order by dbms_random.value)
where rownum = 1;
insert into students_room (stud_card,room_number,dorm_number,dorm_address) values(:new.stud_card, r_n, d_n, d_a);
END;

--При измененнии имени и фамилии выселяют из комнаты--

create or replace TRIGGER delete_from_ROOM 
before update of stud_name, stud_surname ON STUDENT
FOR EACH ROW
declare 

BEGIN

delete from  students_room
where stud_card = :old.stud_card;
END;

--Курсор параметр университет. Выводит количество университетов и всю информацию о студенте--
set serveroutput ON
DECLARE
universitet  VARCHAR2(50);
counter number :=0;

    CURSOR univer_curs (
        univer_par VARCHAR2
    ) IS SELECT
        count_dorm,
        stud_card,
        stud_name,
        stud_surname,
        stud_email,
        stud_year_of_receipt
         FROM
        student,
        (
            SELECT
                COUNT(dorm_number) as count_dorm
            FROM
                dorm
            WHERE university = univer_par)WHERE
                university = univer_par;     
stud_info univer_curs%rowtype;

BEGIN
universitet := 'KPI';
OPEN univer_curs(universitet);

loop

fetch univer_curs into stud_info;

exit when univer_curs%NOTFOUND;
if counter = 0 then
dbms_output.put_line('University: ' || universitet);
dbms_output.put_line('Count of dorm '|| stud_info.count_dorm);
counter:=counter+1;
end if;

dbms_output.put_line('Info about student: ' ||'Stud card ' || stud_info.stud_card || ' '||
        'Stud name '|| stud_info.stud_name ||' '||
        'Stud surname ' || stud_info.stud_surname ||' '||
        'Stud email ' || stud_info.stud_email || ' '||
        'Stud year of receipt ' || stud_info.stud_year_of_receipt); 
end loop;
end;

 
