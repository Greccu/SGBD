create or replace package ex13 as 
	type tclasses is table of VARCHAR2(70);
	function ex6(ffaculty_id faculties.faculty_id%type)return tclasses;
	function ex7(locat_name locations.city%type)return varchar2;
	function ex8(locat_name locations.city%type)return varchar;
    procedure ex9 (locat_name locations.city%type);
	procedure remove_11(s_id students.student_id%type);
end ex13;
/
--------------------------------------------------------
/
create or replace package body ex13 as

    function ex6(ffaculty_id faculties.faculty_id%type)
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
    
    function ex7(locat_name locations.city%type)
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
       
        
    function ex8(locat_name locations.city%type)
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
    
    procedure ex9 (locat_name locations.city%type)
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
    
    procedure remove_11(s_id students.student_id%type)
    as
    begin
        delete 
        from classes_students
        where student_id = s_id;
    end; 

end ex13;

/
declare
    printtable ex13.tclasses := ex13.tclasses();
    ffaculty_id number := 1;
    text varchar2(60);
begin
    printtable := ex13.ex6(ffaculty_id);
    for i in printtable.first .. printtable.last loop
        dbms_output.put_line(printtable(i));
    end loop;
    text := ex13.ex7('Bucuresti');
    dbms_output.put_line(text);
    dbms_output.put_line(ex13.ex8('Bucuresti'));
    ex13.ex9('Bucuresti');
end;