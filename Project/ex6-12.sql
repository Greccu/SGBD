--  select * from classes_students;
--  select student_id, count(*) from classes_students group by student_id;

-- ex6.
-- Definiti un subprogram stocat care returneaza materiile 
-- pe care le are o facultate data ca parametru


/
create or replace type tclasses is table of VARCHAR2(70); -- VARCHAR2(70) - class_name
/
create or replace function ex6(ffaculty_id faculties.faculty_id%type)
return tclasses
is
    returntable tclasses := tclasses();
    
begin

    if ffaculty_id is null then
        return returntable;
    end if;
    
    select c.class_name
    bulk collect into returntable
    from classes c, professors p, faculties f
    where c.professor_id = p.professor_id
    and p.faculty_id = f.faculty_id
    and f.faculty_id = ffaculty_id;
    return returntable;
end;
/
-- test ex6.
declare
    printtable tclasses := tclasses();
    ffaculty_id number := 1;
begin
    printtable := ex6(ffaculty_id);
    for i in printtable.first .. printtable.last loop
        dbms_output.put_line(printtable(i));
    end loop;
end;
/

-- ex7.
-- Defini?i un subprogram stocat care s? returneze
-- cea mai populara facultate dintr-un oras dat ca parametru
/
create or replace function ex7(locat_name locations.city%type)
return varchar2
is
    maxx number := 0;
    retname faculties.faculty_name%type;
    currentnr number;
    f_id faculties.faculty_id%type;
    f_name faculties.faculty_name%type;
    exceptie1 exception;
    cursor c is
        select faculty_id, faculty_name
        from locations l, faculties f
        where l.location_id = f.faculty_id
        and l.city = locat_name;
begin
    open c;
    loop
        fetch c into f_id, f_name;
        exit when c%notfound;
        
        select count(student_id)
        into currentnr
        from students
        where faculty_id = f_id;
        
        if (currentnr > maxx) then
            maxx := currentnr;
            retname := f_name;
            --dbms_output.put_line(f_name);
        end if;
    end loop;
    if (maxx = 0) then
        raise exceptie1;
    else
        return retname;
    end if;
exception
    when exceptie1 then
        dbms_output.put_line('Orasul dat ca parametru nu exista in baza de date');
        return null;
    when no_data_found then 
        DBMS_OUTPUT.PUT_LINE (' no data found: ' ||SQLCODE || ' - ' || SQLERRM);
    when others then
        DBMS_OUTPUT.PUT_LINE ('alta eroare ' || SQLCODE || ' - ' || SQLERRM);
end;
/
declare
    text varchar2(60);
begin
    text := ex7('Bucuresti');
    dbms_output.put_line(text);
end;
/
-- ex8.
-- Definiti un subprogram stocat de tip functie care returneaza universitatea
-- cu cei mai multi studenti dintr-un oras dat ca parametru
-- locations, universities, faculties, students
/
create or replace function ex8(locat_name locations.city%type)
return varchar
IS
    type uids_type is table of universities.university_id%type;
    uids uids_type := uids_type();
    
    uname universities.university_name%type;
    checkk number;
    checkk2 number;
    maxx number := 0;
    nrc number;
    uid universities.university_id%type;
    exceptie1 exception;
    exceptie2 exception;
    exceptie3 exception;
BEGIN
    select count(*) into checkk
    from locations
    where city = locat_name;
    
    if checkk = 0 then 
        raise exceptie1;
    end if;
    
    select count(university_id)
    into checkk2
    from universities u, locations l
    where u.location_id = l.location_id
    and l.city = locat_name;

    if (checkk2 = 0) then 
        raise exceptie2;
    end if;
    
    select university_id
    bulk collect into uids
    from universities u, locations l
    where u.location_id = l.location_id
    and l.city = locat_name;
    
    for i in uids.first .. uids.last loop
        select count(student_id)
        into nrc
        from faculties f, students s
        where f.university_id = uids(i)
        and f.faculty_id = s.faculty_id;
        
        if (nrc > maxx) then
            maxx := nrc;
            uid := uids(i);
        end if;
    end loop;
    
    if maxx = 0 then 
        raise exceptie3;
    else
        select university_name
        into uname
        from universities
        where university_id = uid;
        
        return uname;
    end if;
    

exception
    when exceptie1 then
        dbms_output.put_line('orasul dat ca parametru nu exista in baza de date');
        return null;
    when exceptie2 then
        dbms_output.put_line('nu exista nicio universitate in orasul dat ca parametru');
        return null;
    when exceptie3 then
        dbms_output.put_line('nicio universitate din orasul dat ca parametru nu are studenti');
        return null;
    when others then
        DBMS_OUTPUT.PUT_LINE ('alta eroare ' || SQLCODE || ' - ' || SQLERRM);
        return null; 
end ex8;
/


/
begin
    -- ruleaza
    dbms_output.put_line(ex8('Bucuresti'));
    -- exceptia1
    dbms_output.put_line(ex8('Braila'));
    -- exceptia2
    INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (16,'dummy','111111','Galati','Galati','Romania'); --16
    dbms_output.put_line(ex8('Galati'));
    -- excepia3
    INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (17,'dummy','111111','Craiova','Craiova','Romania'); --17
    INSERT INTO universities (university_id, university_name,location_id) VALUES (6,'Universitate text ex 8',17);
    INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (11,'Facultate test ex 8',6,17);
    dbms_output.put_line(ex8('Craiova'));
    ROLLBACK;
end;



/
select * from students;

select * from faculties;

select * from locations;

select * from universities;
/
delete from locations where location_id = 18;

/

--  ex9. 
--  Defini?i un subprogram stocat de tip procedur? care s? afiseze 
--  pe ecran profesorul cu cei mai multi studenti, care preda la o
--  facultate dintr-un oras dat ca parametru
--  locations, faculties, classes_students, classes, professors
/
create or replace procedure ex9 (locat_name locations.city%type)
is
    checkk number;
    checkk2 number;
    maxx number := 0;
    nrc number;
    pid professors.professor_id%type;
    type pidtab is table of professors.professor_id%type;
    ptab pidtab := pidtab();
    professor_name varchar(50);
    exceptie1 exception;
    exceptie2 exception;
    exceptie3 exception;
begin
    -- selectez profesorii care predau la o facultate din orasul dat ca parametru
    
    select count(*) into checkk
    from locations
    where city = locat_name;
    
    if checkk = 0 then 
        raise exceptie1;
    end if;
    
    select count(professor_id)
    into checkk2
    from professors p, faculties f, locations l 
    where p.faculty_id = f.faculty_id
    and f.location_id = l.location_id
    and l.city = locat_name;

    if (checkk2 = 0) then 
        raise exceptie2;
    end if;
    
    select professor_id 
    bulk collect into ptab
    from professors p, faculties f, locations l 
    where p.faculty_id = f.faculty_id
    and f.location_id = l.location_id
    and l.city = locat_name;
    
    if (ptab.last = 0) then 
        raise exceptie2;
    end if;
    
    for i in ptab.first .. ptab.last loop
        select count(cs.student_id)
        into nrc
        from  classes c, classes_students cs
        where c.professor_id = ptab(i)
        and c.class_id = cs.class_id;
        
        if (nrc > maxx) then
            maxx := nrc;
            pid := ptab(i);
        end if;
    end loop;
    
    if maxx = 0 then 
        raise exceptie3;
    else
        select first_name || ' ' || last_name
        into professor_name
        from professors
        where professor_id = pid;
        DBMS_OUTPUT.PUT_LINE ('Profesorul ' || professor_name || ' este profesorul cu cei mai multi elevi - ' || maxx);

    end if;
    
exception
    when exceptie1 then
        dbms_output.put_line('orasul dat ca parametru nu exista in baza de date');
    when exceptie2 then
        dbms_output.put_line('nu exista niciun profesor in orasul dat ca parametru');
    when exceptie3 then
        dbms_output.put_line('niciun profesor din orasul dat ca parametru nu are studenti');
    when others then
        DBMS_OUTPUT.PUT_LINE ('alta eroare ' || SQLCODE || ' - ' || SQLERRM);
end;
/

begin
    -- ruleaza
    ex9('Bucuresti');
    -- exceptia1
    ex9('Braila');
    -- exceptia2
    INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (16,'dummy','111111','Galati','Galati','Romania'); --16
    ex9('Galati');
    -- excepia3
    INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (17,'dummy','111111','Craiova','Craiova','Romania'); --17
    INSERT INTO universities (university_id, university_name,location_id) VALUES (6,'Universitate text ex 9',17);
    INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (11,'Facultate test ex 9',6,17);
    INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (61,'test','ex9','test@ex.9','0000000000',11);
    INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (62,'test2','ex9','test2@ex.9','0000000001',11);
    ex9('Craiova');
    ROLLBACK;
end;
/
select * from professors;
/
--  ex10. Defini?i un trigger de tip LMD la nivel de comand? care sa nu permita 
--  de noi studenti decat pe perioada verii. Daca se pot efectua comenzi afiseaza
--  mesaje diferite pentru inserare, actualizare, stergere
/
create or replace trigger trig10
    before insert or update or delete on students
begin
    IF INSERTING THEN
        if (TO_CHAR(SYSDATE, 'MM' ) < '06' or TO_CHAR(SYSDATE, 'MM' ) >  '08') THEN
            raise_application_error(-20002,'Nu se pot insera copii in afara perioadei de vara!');
        else
            DBMS_OUTPUT.PUT_LINE('Inserting students...');
        end if;
    END IF;
    IF UPDATING THEN 
        DBMS_OUTPUT.PUT_LINE('Updating student`s information...');
    END IF;
    IF DELETING THEN
      DBMS_OUTPUT.PUT_LINE('Deleting students...');
    END IF;
end;
/
INSERT INTO students 
    (student_id,first_name,last_name,email,phone_number,faculty_id) 
    VALUES (seq_student.nextval,'Florin','Parizer',
    'florin.parizer@s.lit.uaic.ro',0711337516,4);
/
update students
set last_name = 'Ionita'
where student_id = 1;
/
rollback;
/
select * from students order by 1;

--  ex11.
--  Defini?i un trigger de tip LMD la nivel de comanda care sa nu permita
--  atasarea unui student la un curs daca studentul si profesorul care 
--  preda cursul nu fac parte din aceeasi facultate
/
create or replace trigger trig11
    before insert or update on classes_students
    for each row
declare
    student_faculty_id students.faculty_id%type;
    professor_faculty_id professors.faculty_id%type;
begin
    select s.faculty_id
    into student_faculty_id
    from students s
    where s.student_id = :new.student_id;
    
    select p.faculty_id 
    into professor_faculty_id
    from professors p, classes c
    where c.professor_id = p.professor_id
    and :new.class_id = c.class_id;
    
    if (student_faculty_id != professor_faculty_id) then
        RAISE_APPLICATION_ERROR(-20001, 'Profesorul cursului si studentul nu fac parte din aceeasi facultate');
    end if;
end;
    /
    drop trigger trig11;/
    /
    select * from students order by 1;
    select * from classes_students where student_id = 1;
    
    update classes_students
    set class_id = 1
    where student_id = 1 and class_id = 21;
    
    select c.class_id, p.faculty_id from professors p, classes c where c.professor_id = p.professor_id and class_id = 19;
    select c.class_id, p.faculty_id from professors p, classes c where c.professor_id = p.professor_id and faculty_id = 6;
    rollback;
--  rezerva ex11.
--  Defini?i un trigger de tip LMD la nivel de linie care elimina studentul  
--  de la curusri atunci cand isi schimba facultatea

/
create or replace procedure remove_11(s_id students.student_id%type)
as
begin
    delete 
    from classes_students
    where student_id = s_id;
end; 
/
create or replace trigger trig11v2
    after UPDATE of faculty_id on students
    for each row
begin
    remove_11(:old.student_id);    
end;

/


update students
set faculty_id = 6
where student_id = 1;
/

select * from classes_students order by 1;
/

rollback;

/


-- Defini?i un trigger de tip LDD. ex12 
/
CREATE TABLE audit12
 (utilizator VARCHAR2(30),
 nume_bd VARCHAR2(50),
 eveniment VARCHAR2(20),
 nume_obiect VARCHAR2(30),
 data DATE);
 /
CREATE OR REPLACE TRIGGER trig12
 AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
 INSERT INTO audit12
 VALUES (SYS.LOGIN_USER, SYS.DATABASE_NAME, SYS.SYSEVENT,
 SYS.DICTIONARY_OBJ_NAME, SYSDATE);
END;
/
CREATE INDEX ind12 ON students(first_name);
DROP INDEX ind12;
SELECT * FROM audit12;
DROP TRIGGER trig12;
/



-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

    


