drop table students cascade constraints;
drop table professors cascade constraints;
drop table universities cascade constraints;
drop table faculties cascade constraints;
drop table locations cascade constraints;
drop table classes cascade constraints;
drop table classes_students cascade constraints;

SELECT 
SYS_CONTEXT('USERENV','NLS_TERRITORY') nls_territory,
SYS_CONTEXT('USERENV','NLS_DATE_FORMAT') nls_date_format,
SYS_CONTEXT('USERENV','NLS_DATE_LANGUAGE') nls_date_language,
SYS_CONTEXT('USERENV','NLS_SORT') nls_sort, 
SYS_CONTEXT('USERENV','LANGUAGE') language
FROM DUAL;

select sysdate from dual;

alter session set NLS_LANGUAGE='AMERICAN';
alter session set NLS_TERRITORY='AMERICA';
alter session set NLS_DATE_LANGUAGE='AMERICAN';

PROMPT Please wait while tables are created.

CREATE TABLE locations (
  location_id NUMBER(10) CONSTRAINT location_pk PRIMARY KEY,
  street_adress varchar2(128),
  postal_code varchar2(20),
  city varchar2(60),
  state_region varchar2(60),
  country varchar2(60)
);

CREATE TABLE universities (
  university_id NUMBER(10)  CONSTRAINT university_pk PRIMARY KEY,
  university_name VARCHAR2(60) CONSTRAINT university_name_nn NOT NULL,
  location_id NUMBER(10)    CONSTRAINT universtiy_location_fk REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE faculties (
  faculty_id NUMBER(10)     CONSTRAINT faculty_pk PRIMARY KEY,
  faculty_name VARCHAR2(60) CONSTRAINT faculty_name_nn NOT NULL,
  university_id NUMBER(10)  CONSTRAINT faculty_university_fk REFERENCES universities(university_id) ON DELETE CASCADE,
  location_id NUMBER(10)    CONSTRAINT faculty_location_fk REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE students (
  student_id NUMBER(10) constraint student_pk PRIMARY KEY,
  first_name VARCHAR2(25) CONSTRAINT student_first_name_nn NOT NULL,
  last_name VARCHAR2(25) CONSTRAINT student_last_name_nn NOT NULL,
  email VARCHAR2(40),
  phone_number VARCHAR(15),
  faculty_id NUMBER(10) CONSTRAINT student_faculty_fk REFERENCES faculties(faculty_id) ON DELETE CASCADE
);

CREATE TABLE professors (
  professor_id NUMBER(10)   CONSTRAINT professor_pk PRIMARY KEY,
  first_name VARCHAR2(25)   CONSTRAINT professor_first_name_nn NOT NULL,
  last_name VARCHAR2(25)    CONSTRAINT professor_last_name_nn NOT NULL,
  email VARCHAR2(60),
  phone_number VARCHAR2(15),
  faculty_id NUMBER(10)     CONSTRAINT professor_faculty_fk REFERENCES faculties(faculty_id) ON DELETE CASCADE
);

CREATE TABLE classes (
  class_id NUMBER(10)       CONSTRAINT class_pk PRIMARY KEY,
  class_name VARCHAR2(70)   CONSTRAINT class_name_nn NOT NULL,
  professor_id NUMBER(10)   CONSTRAINT class_professor_fk REFERENCES professors(professor_id) ON DELETE CASCADE
);

CREATE TABLE classes_students (
  student_id NUMBER(10) CONSTRAINT class_student_student_fk REFERENCES students(student_id) ON DELETE CASCADE,
  class_id NUMBER(10)   CONSTRAINT class_student_class_fk REFERENCES classes(class_id) ON DELETE CASCADE,
  CONSTRAINT class_student_pk PRIMARY KEY(class_id, student_id)
);


PROMPT TABLES CREATED.

describe classes;
PROMPT
describe locations;
PROMPT
describe faculties;
PROMPT
describe locations;
PROMPT
describe professors;
PROMPT
describe students;
PROMPT
describe universities;


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

-- auto increment - https://www.w3schools.com/sql/sql_autoincrement.asp
-- delete content from tables
DELETE FROM classes_students;
DELETE FROM classes;
DELETE FROM faculties;
DELETE FROM locations;
DELETE FROM professors;
DELETE FROM students;
DELETE FROM universities;
-- drop sequences
DROP SEQUENCE seq_class;
DROP SEQUENCE seq_faculty;
DROP SEQUENCE seq_location;
DROP SEQUENCE seq_professor;
DROP SEQUENCE seq_student;
DROP SEQUENCE seq_university;
-- create sequences
CREATE SEQUENCE seq_class MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_faculty MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_location MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_professor MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_student MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
CREATE SEQUENCE seq_university MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10;
-- describe tables
describe locations;
describe universities;
describe faculties;
describe students;
describe professors;
describe classes;
describe classes_students;
-- inserts
/
--locations
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Strada Mihail Kogalniceanu 1','400084','Cluj-Napoca','Cluj','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Bulevardul Carol 11','700506','Iasi','Iasi','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Splaiul Independentei 313','060042','Bucuresti','Bucuresti','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Bulevardul M. Kogalniceanu 36-46','050107','Bucuresti','Bucuresti','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Piata Romana 6, Sector 1','010374','Bucuresti','Bucuresti','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Str. Teodor Mihali, Nr. 58-60','400591','Cluj-Napoca','Cluj','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Str. Mihail KogÄƒlniceanu, nr. 1','400084','Cluj-Napoca','Cluj','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Str. Toma Cozma, Nr. 3','700554','Iasi','Iasi','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'B-dul Carol I, Nr. 11','700506','Iasi','Iasi','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Strada Gheorghe Polizu, nr 1-7, Corp F','011061','Bucuresti','Bucuresti','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Splaiul Independentei, nr. 313','060042','Bucuresti','Bucuresti','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Str. Academiei nr.14','010014','Bucuresti','Bucuresti','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Bd. Mihail KogÄƒlniceanu nr. 36-46','050107','Bucuresti','Bucuresti','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Str. Caderera Bastiliei nr. 2-10','010374','Bucuresti','Bucuresti','Romania');
INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'Bd. Dacia nr. 41','010404','Bucuresti','Bucuresti','Romania');
--universities
INSERT INTO universities (university_id, university_name,location_id) VALUES (seq_university.nextval,'Universitatea Babes-Bolyai',1);
INSERT INTO universities (university_id, university_name,location_id) VALUES (seq_university.nextval,'Universitatea Alexandru Ioan Cuza din Iasi',2);
INSERT INTO universities (university_id, university_name,location_id) VALUES (seq_university.nextval,'Universitatea Politehnica din Bucuresti',3);
INSERT INTO universities (university_id, university_name,location_id) VALUES (seq_university.nextval,'Universitatea din Bucuresti',4);
INSERT INTO universities (university_id, university_name,location_id) VALUES (seq_university.nextval,'Academia de Studii Economice din Bucuresti',5);
--faculties
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Stiinte Economice si Gestiunea Afacerilor',1,6);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Matematica si Informatica',1,7);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Psihologie si stiinte ale Educatiei',2,8);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Litere',2,9);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Inginerie Medicala',3,10);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Automatica si Calculatoare',3,11);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Matematica si Informatica',4,12);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Drept',4,13);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Contabilitate si Informatica de Gestiune',5,13);
INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'Facultatea de Marketing',5,14);
--students
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Costi','Comeaga','costi.comeaga@s.lit.uaic.ro','0719211398',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Denis','Dita','denis.dita@s.econ.ubb.ro','0710268296',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'George','Tudor','george.tudor@s.mk.ase.ro','0717787847',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Horasiu','Goga','horasiu.goga@s.acs.upb.ro','0716488499',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Danus','Gabor','danus.gabor@s.lit.uaic.ro','0713517407',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Adrian','Olinescu','adrian.olinescu@s.psih.uaic.ro','0714833670',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cristian','Kazaku','cristian.kazaku@s.lit.uaic.ro','0717759703',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'George','Petrescu','george.petrescu@s.econ.ubb.ro','0711158596',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Felix','Romanescu','felix.romanescu@s.fim.upb.ro','0713564223',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Florentin','Stancu','florentin.stancu@s.psih.uaic.ro','0711500541',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sonia','Rudeanu','sonia.rudeanu@s.acs.upb.ro','0714335112',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Codruta','Marcovici','codruta.marcovici@s.fim.upb.ro','0711691911',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Adrianna','Boroi','adrianna.boroi@s.mk.ase.ro','0710343566',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Eliza','Rotaru','eliza.rotaru@s.lit.uaic.ro','0710299114',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Margareta','Zamfir','margareta.zamfir@s.psih.uaic.ro','0716013956',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Aurelia','Cojoc','aurelia.cojoc@s.acs.upb.ro','0714585971',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marta','Filipescu','marta.filipescu@s.lit.uaic.ro','0716692745',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Adela','Ciora','adela.ciora@s.acs.upb.ro','0714131849',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mara','Raducioiu','mara.raducioiu@s.drept.unibuc.ro','0713601608',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Michaela','Artenie','michaela.artenie@s.acs.upb.ro','0712976788',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Manuel','Vasilescu','manuel.vasilescu@s.fim.upb.ro','0715286394',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Simu','Costache','simu.costache@s.drept.unibuc.ro','0719189255',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dragos','Vulpes','dragos.vulpes@s.acs.upb.ro','0718474537',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Flaviu','Lupescu','flaviu.lupescu@s.cig.ase.ro','0718340414',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Gheorghe','Groza','gheorghe.groza@s.mk.ase.ro','0712528781',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Codrin','Filipescu','codrin.filipescu@s.fim.upb.ro','0712173416',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ferka','Dalca','ferka.dalca@s.acs.upb.ro','0711115731',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Carol','Paler','carol.paler@s.drept.unibuc.ro','0716057633',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Florentin','Ojacarcu','florentin.ojacarcu@s.econ.ubb.ro','0719178637',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iulian','Theodorescu','iulian.theodorescu@s.fim.upb.ro','0719252311',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Denisa','Cosovei','denisa.cosovei@s.psih.uaic.ro','0710303106',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Anca','Arcos','anca.arcos@s.acs.upb.ro','0716254501',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Adela','Nemes','adela.nemes@s.fim.upb.ro','0710015058',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Rodika','Corbeanu','rodika.corbeanu@s.drept.unibuc.ro','0712683469',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Constansa','Blaga','constansa.blaga@s.psih.uaic.ro','0712226502',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ilena','Grigorescu','ilena.grigorescu@s.econ.ubb.ro','0719384737',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mihaela','Rosetti','mihaela.rosetti@s.econ.ubb.ro','0715548191',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Irina','Negoitescu','irina.negoitescu@s.fmi.unibuc.ro','0718228494',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Codruta','Donceanu','codruta.donceanu@s.cig.ase.ro','0718773146',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Yessenia','Voicu','yessenia.voicu@s.fmi.ubb.ro','0710751043',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mazonn','Ardelean','mazonn.ardelean@s.psih.uaic.ro','0717392397',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Teo','Kazaku','teo.kazaku@s.mk.ase.ro','0714396639',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Petru','Nita','petru.nita@s.acs.upb.ro','0717869757',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dracul','Troester','dracul.troester@s.fim.upb.ro','0719906008',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ciodaru','Mihaili','ciodaru.mihaili@s.fmi.ubb.ro','0716565275',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marius','Costiniu','marius.costiniu@s.cig.ase.ro','0712632419',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marius','Minea','marius.minea@s.cig.ase.ro','0714154680',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Glad','Apostu','glad.apostu@s.psih.uaic.ro','0712588308',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Anton','Dumitru','anton.dumitru@s.fim.upb.ro','0717978252',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Rasvan','Moscovici','rasvan.moscovici@s.fmi.ubb.ro','0719693579',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Stefania','Mihai','stefania.mihai@s.drept.unibuc.ro','0711483674',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Carmen','Luca','carmen.luca@s.mk.ase.ro','0719548793',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Izabela','Tatarescu','izabela.tatarescu@s.econ.ubb.ro','0710809250',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Teofila','Tilea','teofila.tilea@s.lit.uaic.ro','0714244385',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ana-maria','Tavitian','ana-maria.tavitian@s.econ.ubb.ro','0716659808',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Alexandreina','Iacobescu','alexandreina.iacobescu@s.drept.unibuc.ro','0714128801',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ilinca','Lupul','ilinca.lupul@s.mk.ase.ro','0712649946',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Florenta','Boroi','florenta.boroi@s.lit.uaic.ro','0717631135',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iuliana','Raducanu','iuliana.raducanu@s.acs.upb.ro','0712467976',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ilinca','Dragan','ilinca.dragan@s.fim.upb.ro','0714667498',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Paul','Costache','paul.costache@s.psih.uaic.ro','0718748920',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ciodaru','Checiches','ciodaru.checiches@s.lit.uaic.ro','0719885127',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marius','Gilca','marius.gilca@s.econ.ubb.ro','0717067887',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Claudiu','Enescu','claudiu.enescu@s.psih.uaic.ro','0713530108',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mihai','Bogoescu','mihai.bogoescu@s.acs.upb.ro','0712664904',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Boian','Lascar','boian.lascar@s.fmi.unibuc.ro','0711042203',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Arsenie','Apostol','arsenie.apostol@s.mk.ase.ro','0719365187',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cristofor','Muresanu','cristofor.muresanu@s.econ.ubb.ro','0711100768',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Costel','Mandruleanu','costel.mandruleanu@s.psih.uaic.ro','0712429886',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Filip','Cristescu','filip.cristescu@s.lit.uaic.ro','0712971141',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Alina','Popescu','alina.popescu@s.fmi.unibuc.ro','0716920722',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Uta','Ciora','uta.ciora@s.fmi.ubb.ro','0716819562',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Virginia','Alexandrescu','virginia.alexandrescu@s.econ.ubb.ro','0714273722',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Constansa','Marandici','constansa.marandici@s.psih.uaic.ro','0712420337',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Magdalena','Musat','magdalena.musat@s.acs.upb.ro','0711247659',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Catina','Manole','catina.manole@s.psih.uaic.ro','0712319924',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Luiza','Giurgiu','luiza.giurgiu@s.mk.ase.ro','0714275247',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Craita','Ionescu','craita.ionescu@s.acs.upb.ro','0719577514',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Zina','PoÃ©naru','zina.poã©naru@s.fim.upb.ro','0719703496',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Alexandreina','Cosovei','alexandreina.cosovei@s.fmi.ubb.ro','0715799189',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Boian','Pirvu','boian.pirvu@s.acs.upb.ro','0712674687',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dracul','Ojacarcu','dracul.ojacarcu@s.mk.ase.ro','0711811241',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Calin','Ojacarcu','calin.ojacarcu@s.fmi.unibuc.ro','0718783893',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dionisie','Vladimiri','dionisie.vladimiri@s.mk.ase.ro','0713791714',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ciprian','Pop','ciprian.pop@s.psih.uaic.ro','0718579156',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iorghu','Munteanu','iorghu.munteanu@s.drept.unibuc.ro','0713181965',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cristofor','Oprea','cristofor.oprea@s.fmi.unibuc.ro','0715244810',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Theodor','Ghezzo','theodor.ghezzo@s.fmi.ubb.ro','0717630145',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marius','Macek','marius.macek@s.cig.ase.ro','0712593546',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Stan','Barnutiu','stan.barnutiu@s.psih.uaic.ro','0712169904',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Regina','Pacuraru','regina.pacuraru@s.mk.ase.ro','0717060720',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sandra','Gilca','sandra.gilca@s.fmi.ubb.ro','0713962083',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ilinca','Ceausescu','ilinca.ceausescu@s.psih.uaic.ro','0711877327',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Miruna','PoÃ©naru','miruna.poã©naru@s.lit.uaic.ro','0710095017',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Melita','Ciumak','melita.ciumak@s.fim.upb.ro','0712034133',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marinela','Ilica','marinela.ilica@s.acs.upb.ro','0716236613',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Rodika','Goian','rodika.goian@s.drept.unibuc.ro','0716682272',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Daniela','Leonte','daniela.leonte@s.acs.upb.ro','0719081342',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Diona','Troester','diona.troester@s.mk.ase.ro','0711372409',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Codruta','PÃ®rvulescu','codruta.pã®rvulescu@s.econ.ubb.ro','0716852050',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Nicolas','Chitu','nicolas.chitu@s.acs.upb.ro','0711142665',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sergiu','Raceanu','sergiu.raceanu@s.psih.uaic.ro','0718609908',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Valeriu','Skutnik','valeriu.skutnik@s.fmi.unibuc.ro','0715543922',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Simu','Donceanu','simu.donceanu@s.fmi.ubb.ro','0712253999',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iulio','Mechitbayeva','iulio.mechitbayeva@s.lit.uaic.ro','0710794979',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Glad','Constantin','glad.constantin@s.fim.upb.ro','0715806448',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iosif','Dobre','iosif.dobre@s.fmi.ubb.ro','0710928488',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sebastian','Stefan','sebastian.stefan@s.drept.unibuc.ro','0713425054',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Niculaie','Breban','niculaie.breban@s.psih.uaic.ro','0718868933',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Simion','Marinescu','simion.marinescu@s.fim.upb.ro','0716247216',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mihaela','Popescu','mihaela.popescu@s.econ.ubb.ro','0711679838',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Florenta','Kazaku','florenta.kazaku@s.fmi.unibuc.ro','0717692589',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Petronela','Andreescu','petronela.andreescu@s.psih.uaic.ro','0716206849',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Madalina','Dimir','madalina.dimir@s.lit.uaic.ro','0710953543',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iolanda','Moculescu','iolanda.moculescu@s.mk.ase.ro','0716512159',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Eugenia','Osmochescu','eugenia.osmochescu@s.lit.uaic.ro','0713808551',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Lucia','Alexandrescu','lucia.alexandrescu@s.fim.upb.ro','0718121031',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mariana','Vladimirescu','mariana.vladimirescu@s.acs.upb.ro','0714346585',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Lizuca','Barnutiu','lizuca.barnutiu@s.psih.uaic.ro','0713587086',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sorinna','Milosovici','sorinna.milosovici@s.econ.ubb.ro','0713159368',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Jean','Filotti','jean.filotti@s.psih.uaic.ro','0714672526',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Alin','Baicu','alin.baicu@s.acs.upb.ro','0712161808',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Codrin','Ionita','codrin.ionita@s.drept.unibuc.ro','0710440611',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Costica','Barbulescu','costica.barbulescu@s.lit.uaic.ro','0716029181',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Eduard','Pekurar','eduard.pekurar@s.drept.unibuc.ro','0711927786',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Rica','Olinescu','rica.olinescu@s.fim.upb.ro','0716603342',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Flavius','Gabor','flavius.gabor@s.fmi.ubb.ro','0711203138',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Costica','Ciumak','costica.ciumak@s.drept.unibuc.ro','0713873246',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Simu','Apostu','simu.apostu@s.psih.uaic.ro','0718603611',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dumitru','Tudor','dumitru.tudor@s.psih.uaic.ro','0710477487',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Amalia','Bumbescu','amalia.bumbescu@s.lit.uaic.ro','0711091000',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Vanda','Luca','vanda.luca@s.lit.uaic.ro','0716658283',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ruxandra','Gilca','ruxandra.gilca@s.fmi.unibuc.ro','0715536999',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Anemona','Cornea','anemona.cornea@s.fmi.unibuc.ro','0710639697',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Narcisa','Puiu','narcisa.puiu@s.cig.ase.ro','0715743927',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Elena','Stefanescu','elena.stefanescu@s.lit.uaic.ro','0713304972',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Catalina','Nica','catalina.nica@s.lit.uaic.ro','0710858723',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ilinca','Iordache','ilinca.iordache@s.cig.ase.ro','0717298130',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ileana','Anghelescu','ileana.anghelescu@s.fmi.ubb.ro','0710683745',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Lavinia','Mondragon','lavinia.mondragon@s.fim.upb.ro','0713181613',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Nandru','Ragar','nandru.ragar@s.drept.unibuc.ro','0718755556',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Petru','Stirbei','petru.stirbei@s.mk.ase.ro','0713047939',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Artur','Miklos','artur.miklos@s.psih.uaic.ro','0717996989',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Virgil','Cosma','virgil.cosma@s.fmi.ubb.ro','0717719670',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Grigore','Rosetti','grigore.rosetti@s.lit.uaic.ro','0715699237',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marku','Pop','marku.pop@s.fmi.ubb.ro','0713941978',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Vasile','Belododia','vasile.belododia@s.econ.ubb.ro','0715124436',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Virgil','Rotaru','virgil.rotaru@s.psih.uaic.ro','0718564808',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Vasilescu','Macedonski','vasilescu.macedonski@s.fmi.ubb.ro','0710470811',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Petar','Antonescu','petar.antonescu@s.lit.uaic.ro','0710952309',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ana-maria','Amanar','ana-maria.amanar@s.econ.ubb.ro','0716604590',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Rozalia','Stanescu','rozalia.stanescu@s.acs.upb.ro','0715676036',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mirela','Fidatov','mirela.fidatov@s.fim.upb.ro','0710891881',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dorota','Hutopila','dorota.hutopila@s.econ.ubb.ro','0713873452',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Tatiana','Hasdeu','tatiana.hasdeu@s.cig.ase.ro','0718584925',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Aurora','Enache','aurora.enache@s.fim.upb.ro','0719159067',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Isabella','Ripnu','isabella.ripnu@s.cig.ase.ro','0712103815',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Viorica','Adamache','viorica.adamache@s.econ.ubb.ro','0716769882',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Voctorita','Blerinca','voctorita.blerinca@s.mk.ase.ro','0719746887',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Vanda','Cojocar','vanda.cojocar@s.acs.upb.ro','0712904060',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dinu','Stoica','dinu.stoica@s.fmi.unibuc.ro','0710003393',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ion','Tugurlan','ion.tugurlan@s.acs.upb.ro','0715978439',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Simon','Serbanescu','simon.serbanescu@s.psih.uaic.ro','0716611709',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Danut','Nicu','danut.nicu@s.econ.ubb.ro','0714537418',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Adrian','Nicolescu','adrian.nicolescu@s.fmi.unibuc.ro','0718630697',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Aurel','Yonescu','aurel.yonescu@s.econ.ubb.ro','0716549186',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Lucian','Lixandroiu','lucian.lixandroiu@s.acs.upb.ro','0718370501',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Horasiu','Mihalache','horasiu.mihalache@s.fmi.ubb.ro','0710555891',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Augustin','Marin','augustin.marin@s.fmi.unibuc.ro','0710568511',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Raul','Nemes','raul.nemes@s.fim.upb.ro','0716111831',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Floarea','Argetoianu','floarea.argetoianu@s.lit.uaic.ro','0719936551',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Erika','Piturca','erika.piturca@s.econ.ubb.ro','0714305781',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Aurica','Gaina','aurica.gaina@s.lit.uaic.ro','0713795942',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Angelica','Ganea','angelica.ganea@s.econ.ubb.ro','0710460033',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Lina','Alecsandri','lina.alecsandri@s.lit.uaic.ro','0719195286',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ecaterina','Selymes','ecaterina.selymes@s.acs.upb.ro','0713393284',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Tabitha','Dita','tabitha.dita@s.cig.ase.ro','0719857123',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Costela','Petri','costela.petri@s.lit.uaic.ro','0713280182',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Luminita','Banciu','luminita.banciu@s.econ.ubb.ro','0711400151',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Crina','Ghezzo','crina.ghezzo@s.fim.upb.ro','0719454426',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Costache','Izbasa','costache.izbasa@s.econ.ubb.ro','0714818663',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mihai','Stinga','mihai.stinga@s.fmi.ubb.ro','0717912858',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Geza','Diaconu','geza.diaconu@s.drept.unibuc.ro','0716991380',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Varujan','Otvos','varujan.otvos@s.lit.uaic.ro','0710507729',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Antonio','Olinescu','antonio.olinescu@s.drept.unibuc.ro','0719532626',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dorin','Stanasila','dorin.stanasila@s.acs.upb.ro','0713768074',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Toma','Tilea','toma.tilea@s.econ.ubb.ro','0715041488',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Anton','Lupei','anton.lupei@s.psih.uaic.ro','0711738274',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cornel','Butacu','cornel.butacu@s.fmi.unibuc.ro','0711080727',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Adi','Butacu','adi.butacu@s.mk.ase.ro','0716145222',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Lenuta','Cosmescu','lenuta.cosmescu@s.psih.uaic.ro','0719057529',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Rozalia','VÃ£duva','rozalia.vã£duva@s.cig.ase.ro','0716018676',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Valeria','Vladimiri','valeria.vladimiri@s.fmi.unibuc.ro','0710300043',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Doina','Otvos','doina.otvos@s.fmi.unibuc.ro','0716242498',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Relia','Iordache','relia.iordache@s.lit.uaic.ro','0719627786',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cristina','Albu','cristina.albu@s.psih.uaic.ro','0715953067',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Constanta','Blaga','constanta.blaga@s.fmi.unibuc.ro','0718512307',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Codruta','Vulpes','codruta.vulpes@s.lit.uaic.ro','0715810797',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Virginia','Covaci','virginia.covaci@s.fim.upb.ro','0718171966',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Daciana','Ionita','daciana.ionita@s.drept.unibuc.ro','0710758409',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ionache','Barnutiu','ionache.barnutiu@s.psih.uaic.ro','0711750238',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'George','Lupescu','george.lupescu@s.fmi.unibuc.ro','0718296367',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sergiu','Bus','sergiu.bus@s.mk.ase.ro','0718903842',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Costin','Kazaku','costin.kazaku@s.mk.ase.ro','0712407131',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dragoslav','Torje','dragoslav.torje@s.psih.uaic.ro','0711076417',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dracul','Manea','dracul.manea@s.fim.upb.ro','0714600319',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ionache','Mihalache','ionache.mihalache@s.mk.ase.ro','0711558839',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iulien','Mondragon','iulien.mondragon@s.fmi.ubb.ro','0714187157',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Pereteanu','Kogalniceaunu','pereteanu.kogalniceaunu@s.fmi.unibuc.ro','0716616631',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Doru','Cernea','doru.cernea@s.mk.ase.ro','0711657214',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Monique','Silivasi','monique.silivasi@s.fmi.ubb.ro','0712999751',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marina','Vladimirescu','marina.vladimirescu@s.drept.unibuc.ro','0714888544',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Carla','Ojacarcu','carla.ojacarcu@s.mk.ase.ro','0711322886',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Alexandra','Ene','alexandra.ene@s.acs.upb.ro','0716469761',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Rodica','Moculescu','rodica.moculescu@s.econ.ubb.ro','0719710467',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iona','Kogalniceanu','iona.kogalniceanu@s.drept.unibuc.ro','0712169600',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ileana','Goian','ileana.goian@s.psih.uaic.ro','0719465288',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Olivia','Pescariu','olivia.pescariu@s.lit.uaic.ro','0713529146',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Corina','Popa','corina.popa@s.mk.ase.ro','0715458358',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Viorica','Saftoiu','viorica.saftoiu@s.fmi.unibuc.ro','0718318737',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dragoslav','Nistor','dragoslav.nistor@s.fmi.unibuc.ro','0716129810',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Catarino','Cosma','catarino.cosma@s.drept.unibuc.ro','0710656903',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Adam','VÃ¢ntu','adam.vã¢ntu@s.mk.ase.ro','0717445245',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Eftemie','Alexandrescu','eftemie.alexandrescu@s.lit.uaic.ro','0716050051',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Alin','Ojacarcu','alin.ojacarcu@s.lit.uaic.ro','0713496883',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cristinel','Georgescu','cristinel.georgescu@s.fmi.unibuc.ro','0711670493',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Raul','Arcos','raul.arcos@s.econ.ubb.ro','0716306452',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Felix','Cojocar','felix.cojocar@s.acs.upb.ro','0714389431',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dragomir','Maniu','dragomir.maniu@s.fim.upb.ro','0712524132',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marcel','Dinu','marcel.dinu@s.fmi.unibuc.ro','0716650298',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Delia','Rebreanu','delia.rebreanu@s.econ.ubb.ro','0710097443',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Codruta','Simeonescu','codruta.simeonescu@s.drept.unibuc.ro','0713086976',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mirela','Bucur','mirela.bucur@s.fmi.ubb.ro','0717629576',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Luminita','Mihai','luminita.mihai@s.fmi.unibuc.ro','0716418385',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Daria','Stirbei','daria.stirbei@s.acs.upb.ro','0715371964',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Bogdana','Cardei','bogdana.cardei@s.drept.unibuc.ro','0719364039',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Atanasia','Mihalache','atanasia.mihalache@s.mk.ase.ro','0714179142',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Eveline','Nica','eveline.nica@s.fmi.ubb.ro','0712750549',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Estera','Giurgiu','estera.giurgiu@s.acs.upb.ro','0710759196',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Flori','Blerinca','flori.blerinca@s.cig.ase.ro','0711112255',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ciodaru','Filipescu','ciodaru.filipescu@s.mk.ase.ro','0716289992',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Emanuel','Moldovan','emanuel.moldovan@s.acs.upb.ro','0715159728',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Stelian','Costin','stelian.costin@s.drept.unibuc.ro','0714408554',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Teodor','Tugurlan','teodor.tugurlan@s.lit.uaic.ro','0712416041',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Nicusor','Bengescu','nicusor.bengescu@s.fmi.unibuc.ro','0711862663',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Alexandru','Pescariu','alexandru.pescariu@s.lit.uaic.ro','0715175722',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sorin','Prunea','sorin.prunea@s.drept.unibuc.ro','0712574024',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sorin','Milcu','sorin.milcu@s.fim.upb.ro','0713236070',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Sergiu','Enache','sergiu.enache@s.cig.ase.ro','0718483248',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cristinel','Diaconu','cristinel.diaconu@s.psih.uaic.ro','0716718214',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Lizuca','Kazaku','lizuca.kazaku@s.econ.ubb.ro','0715417962',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Claudia','Checiches','claudia.checiches@s.fmi.ubb.ro','0718810233',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Tara','Roman','tara.roman@s.mk.ase.ro','0711971003',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Teodora','Milosovici','teodora.milosovici@s.lit.uaic.ro','0714425352',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Jeni','Morosanu','jeni.morosanu@s.mk.ase.ro','0714585905',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cecilia','Iordanescu','cecilia.iordanescu@s.acs.upb.ro','0711674200',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Yessenia','Rusu','yessenia.rusu@s.psih.uaic.ro','0710894838',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Tereza','Zamfir','tereza.zamfir@s.lit.uaic.ro','0713207933',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Luminita','Draghici','luminita.draghici@s.lit.uaic.ro','0719723565',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Elena','Sala','elena.sala@s.lit.uaic.ro','0715410820',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Tiberiu','Banica','tiberiu.banica@s.econ.ubb.ro','0718054385',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Cristinel','Constantinescu','cristinel.constantinescu@s.fmi.ubb.ro','0717070035',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Razvan','Cozma','razvan.cozma@s.econ.ubb.ro','0718305137',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Serghei','Silivasi','serghei.silivasi@s.psih.uaic.ro','0719260291',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Carol','Petri','carol.petri@s.drept.unibuc.ro','0712882079',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Beniamin','Lupu','beniamin.lupu@s.acs.upb.ro','0718242448',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dorin','PÃ¢rvulescu','dorin.pã¢rvulescu@s.fmi.unibuc.ro','0716823326',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Mihaita','Moisuc','mihaita.moisuc@s.lit.uaic.ro','0712032711',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dan','Artenie','dan.artenie@s.drept.unibuc.ro','0710712913',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Shaithis','Lazarescu','shaithis.lazarescu@s.econ.ubb.ro','0717200827',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dominique','Popescu','dominique.popescu@s.econ.ubb.ro','0717284501',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Draguta','Istrati','draguta.istrati@s.cig.ase.ro','0714382385',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Gheorghita','Teodorescu','gheorghita.teodorescu@s.acs.upb.ro','0714026240',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Melania','Morosanu','melania.morosanu@s.lit.uaic.ro','0714143628',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Lavinia','Ene','lavinia.ene@s.cig.ase.ro','0717368574',9);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Elena','Vianu','elena.vianu@s.acs.upb.ro','0718363638',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Jenica','Cristescu','jenica.cristescu@s.fmi.ubb.ro','0715277726',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Kathryn','Puiu','kathryn.puiu@s.econ.ubb.ro','0717223348',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Monica','Presecan','monica.presecan@s.mk.ase.ro','0719475518',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Beatrix','Silivasi','beatrix.silivasi@s.fmi.ubb.ro','0719625997',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Alexandru','Hasdeu','alexandru.hasdeu@s.acs.upb.ro','0714713733',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Teodor','Hagi','teodor.hagi@s.mk.ase.ro','0711863114',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Jan','VÃ£duva','jan.vã£duva@s.fmi.ubb.ro','0712831464',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ciodaru','Groza','ciodaru.groza@s.drept.unibuc.ro','0714629306',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Vlad','Catargiu','vlad.catargiu@s.fmi.ubb.ro','0718381360',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Nicu','Toma','nicu.toma@s.econ.ubb.ro','0713884221',1);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Marius','Sala','marius.sala@s.psih.uaic.ro','0714988441',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Beryx','Bus','beryx.bus@s.fim.upb.ro','0718318026',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Emil','Butacu','emil.butacu@s.fim.upb.ro','0712465063',5);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Adrian','Toma','adrian.toma@s.psih.uaic.ro','0710955958',3);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Catina','Vasile','catina.vasile@s.fmi.ubb.ro','0713157824',2);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Dana','Pangratiu','dana.pangratiu@s.drept.unibuc.ro','0719751995',8);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Virginia','Filotti','virginia.filotti@s.fmi.unibuc.ro','0711932696',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Anamaria','Pop','anamaria.pop@s.fmi.unibuc.ro','0718846844',7);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Ioanela','Sandulescu','ioanela.sandulescu@s.acs.upb.ro','0716925524',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Voileta','Teodorescu','voileta.teodorescu@s.mk.ase.ro','0717138847',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Virginia','Morariu','virginia.morariu@s.acs.upb.ro','0712496213',6);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Flavia','Mihalache','flavia.mihalache@s.mk.ase.ro','0712563816',10);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Emilia','Preda','emilia.preda@s.lit.uaic.ro','0719923159',4);
INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'Iulia','Pogonat','iulia.pogonat@s.drept.unibuc.ro','0715030383',8);
--professors
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Denis','Tugurlan','denis.tugurlan@p.econ.ubb.ro','0714797634',1);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Dragoslav','Poenaru','dragoslav.poenaru@p.econ.ubb.ro','0710370449',1);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Iuliu','Macedonski','iuliu.macedonski@p.econ.ubb.ro','0714898147',1);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Anton','Cojocar','anton.cojocar@p.econ.ubb.ro','0712793202',1);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Costel','Voinea','costel.voinea@p.econ.ubb.ro','0713459996',1);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Stelian','Istrati','stelian.istrati@p.econ.ubb.ro','0715083120',1);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Filip','Grul','filip.grul@p.fmi.ubb.ro','0713320046',2);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Dragos','Nemes','dragos.nemes@p.fmi.ubb.ro','0716451737',2);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Emanuel','Moldovanu','emanuel.moldovanu@p.fmi.ubb.ro','0711353899',2);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Jean','Constantinescu','jean.constantinescu@p.fmi.ubb.ro','0716572298',2);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Eveline','Cristea','eveline.cristea@p.fmi.ubb.ro','0714065699',2);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Vasilica','Enache','vasilica.enache@p.fmi.ubb.ro','0711779597',2);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Zana','Marinescu','zana.marinescu@p.psih.uaic.ro','0714666086',3);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Roxana','Ghita','roxana.ghita@p.psih.uaic.ro','0719184761',3);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Paula','Banciu','paula.banciu@p.psih.uaic.ro','0719302297',3);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Antanasia','Cretu','antanasia.cretu@p.psih.uaic.ro','0712169590',3);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Sorinna','Sollomovici','sorinna.sollomovici@p.psih.uaic.ro','0712142130',3);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Magdalena','Leonte','magdalena.leonte@p.psih.uaic.ro','0711577686',3);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Izabela','Mocanu','izabela.mocanu@p.lit.uaic.ro','0718443347',4);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Crina','Negutesco','crina.negutesco@p.lit.uaic.ro','0713424516',4);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Marcel','Pogonat','marcel.pogonat@p.lit.uaic.ro','0718621761',4);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Niculaie','Parasca','niculaie.parasca@p.lit.uaic.ro','0715308756',4);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Dominik','Baboescu','dominik.baboescu@p.lit.uaic.ro','0713390039',4);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Dominik','Eliade','dominik.eliade@p.lit.uaic.ro','0717864110',4);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Stan','Diaconu','stan.diaconu@p.fim.upb.ro','0718367017',5);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Teodor','Cosovei','teodor.cosovei@p.fim.upb.ro','0716094293',5);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Horea','Tarus','horea.tarus@p.fim.upb.ro','0715954418',5);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Arsenie','Diaconu','arsenie.diaconu@p.fim.upb.ro','0717399577',5);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Aurel','Cernat','aurel.cernat@p.fim.upb.ro','0710052722',5);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Petar','Cretu','petar.cretu@p.fim.upb.ro','0715122136',5);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Cristina','Mironescu','cristina.mironescu@p.acs.upb.ro','0715585904',6);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Eugenia','Muresan','eugenia.muresan@p.acs.upb.ro','0717145193',6);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Stefana','Eliade','stefana.eliade@p.acs.upb.ro','0712259848',6);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Adelina','Stolojan','adelina.stolojan@p.acs.upb.ro','0718791546',6);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Silvia','Goldis','silvia.goldis@p.acs.upb.ro','0716000393',6);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Daniela','Suciu','daniela.suciu@p.acs.upb.ro','0714948699',6);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Anca','Olaru','anca.olaru@p.fmi.unibuc.ro','0712634464',7);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Ana-maria','Ilie','ana-maria.ilie@p.fmi.unibuc.ro','0719798180',7);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Ana','Vasiliu','ana.vasiliu@p.fmi.unibuc.ro','0717367734',7);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Isabela','Pop','isabela.pop@p.fmi.unibuc.ro','0711038361',7);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Adrian','Tatarescu','adrian.tatarescu@p.fmi.unibuc.ro','0714403026',7);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Vasile','Serbanescu','vasile.serbanescu@p.fmi.unibuc.ro','0715251628',7);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Matei','Sala','matei.sala@p.drept.unibuc.ro','0718617221',8);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Dominik','Costache','dominik.costache@p.drept.unibuc.ro','0713920879',8);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Ivan','Rosetti','ivan.rosetti@p.drept.unibuc.ro','0719216525',8);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Serafim','Moculescu','serafim.moculescu@p.drept.unibuc.ro','0716986693',8);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Ionut','Gherea','ionut.gherea@p.drept.unibuc.ro','0711470121',8);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Timotei','Lupu','timotei.lupu@p.drept.unibuc.ro','0719318032',8);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Mihail','Alecsandri','mihail.alecsandri@p.cig.ase.ro','0711964656',9);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Nic','Bengescu','nic.bengescu@p.cig.ase.ro','0710231754',9);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Camelia','Nistor','camelia.nistor@p.cig.ase.ro','0718037348',9);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Mihaela','Puscas','mihaela.puscas@p.cig.ase.ro','0714099341',9);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Margareta','Gilca','margareta.gilca@p.cig.ase.ro','0712973355',9);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Juana','Simeonescu','juana.simeonescu@p.cig.ase.ro','0715491485',9);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Carmen','Constantinescu','carmen.constantinescu@p.mk.ase.ro','0712291342',10);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Lia','Nicolescu','lia.nicolescu@p.mk.ase.ro','0710577858',10);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Denisa','Tanase','denisa.tanase@p.mk.ase.ro','0714150043',10);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Adriana','Oprea','adriana.oprea@p.mk.ase.ro','0712195095',10);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Miruna','Dragomir','miruna.dragomir@p.mk.ase.ro','0716207409',10);
INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'Mihaela','Catargiu','mihaela.catargiu@p.mk.ase.ro','0717608618',10);
--classes
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Contabilitate bancara',1);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Contabilitate financiara',2);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Marketing',3);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Gestiunea financiara a firmei',4);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Gestiune bancara',5);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Buget si trezorerie publica',6);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Structuri de date',7);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Dezvoltarea aplicatiilor Web',8);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Retele de calculatoare',9);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Sisteme distribuite si securitate',10);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Grafica si vizualizare',11);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Dezvoltarea aplicatiilor mobile',12);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Psihologia educatiei',13);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Fundamentele psihologiei',14);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Psihologie sociala',15);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Tehnici de munca intelectuala',16);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Etica academica',17);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Statistica aplicata in psihologie',18);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Gestionarea informaÈ›iei Ã®n societatea contemporanÄƒ',19);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Modele de comunicare si relatii publice',20);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Etnologie',21);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Literatura universala',22);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Comunicare si relatii publice',23);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Cultura si politica in context international',24);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Biologie Celulara si Moleculara',25);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Nanobiomateriale',26);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Fiziologie',27);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Inginerie Medicala',28);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Electronica Analogica si Digitala in Biomedicina',29);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Analiza Probelor Biologice',30);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Proiectare logica',31);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Elemente de electronica analogica',32);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Proiectarea algoritmilor',33);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Protocoale de comunicatii',34);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Tehnici de optimizare',35);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Arhitectura calculatoarelor',36);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Inteligenta artificiala',37);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Fundamentele limbajelor de programare',38);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Metode de dezvoltare software',39);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Inginerie software',40);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Programare orientata pe obiecte',41);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Baze de date',42);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Drept civil',43);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Drept constitutional',44);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Filosofie',45);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Metodologie juridica',46);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Drept penal',47);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Criminologie',48);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Dreptul afacerilor',49);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Macroeconomie',50);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Econometrie',51);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Gestiune financiara',52);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Control de gestiune',53);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Analiza economico-financiara',54);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Macroeconomie',55);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Mediul de afaceri european',56);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Etica Ã®n afaceri',57);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Business to business marketing',58);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Cybermarketing',59);
INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'Tehnici de vanzare',60);
--classes_students
INSERT INTO classes_students (student_id,class_id) VALUES (1,22);
INSERT INTO classes_students (student_id,class_id) VALUES (1,23);
INSERT INTO classes_students (student_id,class_id) VALUES (1,21);
INSERT INTO classes_students (student_id,class_id) VALUES (2,2);
INSERT INTO classes_students (student_id,class_id) VALUES (2,4);
INSERT INTO classes_students (student_id,class_id) VALUES (2,1);
INSERT INTO classes_students (student_id,class_id) VALUES (3,59);
INSERT INTO classes_students (student_id,class_id) VALUES (3,58);
INSERT INTO classes_students (student_id,class_id) VALUES (3,56);
INSERT INTO classes_students (student_id,class_id) VALUES (4,34);
INSERT INTO classes_students (student_id,class_id) VALUES (4,32);
INSERT INTO classes_students (student_id,class_id) VALUES (4,33);
INSERT INTO classes_students (student_id,class_id) VALUES (5,19);
INSERT INTO classes_students (student_id,class_id) VALUES (5,21);
INSERT INTO classes_students (student_id,class_id) VALUES (5,22);
INSERT INTO classes_students (student_id,class_id) VALUES (6,14);
INSERT INTO classes_students (student_id,class_id) VALUES (6,16);
INSERT INTO classes_students (student_id,class_id) VALUES (6,17);
INSERT INTO classes_students (student_id,class_id) VALUES (7,21);
INSERT INTO classes_students (student_id,class_id) VALUES (7,19);
INSERT INTO classes_students (student_id,class_id) VALUES (7,20);
INSERT INTO classes_students (student_id,class_id) VALUES (8,4);
INSERT INTO classes_students (student_id,class_id) VALUES (8,5);
INSERT INTO classes_students (student_id,class_id) VALUES (8,3);
INSERT INTO classes_students (student_id,class_id) VALUES (9,28);
INSERT INTO classes_students (student_id,class_id) VALUES (9,29);
INSERT INTO classes_students (student_id,class_id) VALUES (9,26);
INSERT INTO classes_students (student_id,class_id) VALUES (10,13);
INSERT INTO classes_students (student_id,class_id) VALUES (10,17);
INSERT INTO classes_students (student_id,class_id) VALUES (10,16);
INSERT INTO classes_students (student_id,class_id) VALUES (11,33);
INSERT INTO classes_students (student_id,class_id) VALUES (11,31);
INSERT INTO classes_students (student_id,class_id) VALUES (11,34);
INSERT INTO classes_students (student_id,class_id) VALUES (12,29);
INSERT INTO classes_students (student_id,class_id) VALUES (12,26);
INSERT INTO classes_students (student_id,class_id) VALUES (12,25);
INSERT INTO classes_students (student_id,class_id) VALUES (13,55);
INSERT INTO classes_students (student_id,class_id) VALUES (13,58);
INSERT INTO classes_students (student_id,class_id) VALUES (13,56);
INSERT INTO classes_students (student_id,class_id) VALUES (14,21);
INSERT INTO classes_students (student_id,class_id) VALUES (14,19);
INSERT INTO classes_students (student_id,class_id) VALUES (14,23);
INSERT INTO classes_students (student_id,class_id) VALUES (15,13);
INSERT INTO classes_students (student_id,class_id) VALUES (15,17);
INSERT INTO classes_students (student_id,class_id) VALUES (15,14);
INSERT INTO classes_students (student_id,class_id) VALUES (16,34);
INSERT INTO classes_students (student_id,class_id) VALUES (16,33);
INSERT INTO classes_students (student_id,class_id) VALUES (16,32);
INSERT INTO classes_students (student_id,class_id) VALUES (17,22);
INSERT INTO classes_students (student_id,class_id) VALUES (17,19);
INSERT INTO classes_students (student_id,class_id) VALUES (17,23);
INSERT INTO classes_students (student_id,class_id) VALUES (18,34);
INSERT INTO classes_students (student_id,class_id) VALUES (18,35);
INSERT INTO classes_students (student_id,class_id) VALUES (18,32);
INSERT INTO classes_students (student_id,class_id) VALUES (19,47);
INSERT INTO classes_students (student_id,class_id) VALUES (19,44);
INSERT INTO classes_students (student_id,class_id) VALUES (19,43);
INSERT INTO classes_students (student_id,class_id) VALUES (20,35);
INSERT INTO classes_students (student_id,class_id) VALUES (20,32);
INSERT INTO classes_students (student_id,class_id) VALUES (20,31);
INSERT INTO classes_students (student_id,class_id) VALUES (21,26);
INSERT INTO classes_students (student_id,class_id) VALUES (21,27);
INSERT INTO classes_students (student_id,class_id) VALUES (21,25);
INSERT INTO classes_students (student_id,class_id) VALUES (22,45);
INSERT INTO classes_students (student_id,class_id) VALUES (22,44);
INSERT INTO classes_students (student_id,class_id) VALUES (22,43);
INSERT INTO classes_students (student_id,class_id) VALUES (23,32);
INSERT INTO classes_students (student_id,class_id) VALUES (23,34);
INSERT INTO classes_students (student_id,class_id) VALUES (23,35);
INSERT INTO classes_students (student_id,class_id) VALUES (24,49);
INSERT INTO classes_students (student_id,class_id) VALUES (24,52);
INSERT INTO classes_students (student_id,class_id) VALUES (24,51);
INSERT INTO classes_students (student_id,class_id) VALUES (25,56);
INSERT INTO classes_students (student_id,class_id) VALUES (25,58);
INSERT INTO classes_students (student_id,class_id) VALUES (25,59);
INSERT INTO classes_students (student_id,class_id) VALUES (26,29);
INSERT INTO classes_students (student_id,class_id) VALUES (26,26);
INSERT INTO classes_students (student_id,class_id) VALUES (26,28);
INSERT INTO classes_students (student_id,class_id) VALUES (27,33);
INSERT INTO classes_students (student_id,class_id) VALUES (27,34);
INSERT INTO classes_students (student_id,class_id) VALUES (27,31);
INSERT INTO classes_students (student_id,class_id) VALUES (28,45);
INSERT INTO classes_students (student_id,class_id) VALUES (28,46);
INSERT INTO classes_students (student_id,class_id) VALUES (28,44);
INSERT INTO classes_students (student_id,class_id) VALUES (29,3);
INSERT INTO classes_students (student_id,class_id) VALUES (29,1);
INSERT INTO classes_students (student_id,class_id) VALUES (29,5);
INSERT INTO classes_students (student_id,class_id) VALUES (30,28);
INSERT INTO classes_students (student_id,class_id) VALUES (30,25);
INSERT INTO classes_students (student_id,class_id) VALUES (30,26);
INSERT INTO classes_students (student_id,class_id) VALUES (31,14);
INSERT INTO classes_students (student_id,class_id) VALUES (31,16);
INSERT INTO classes_students (student_id,class_id) VALUES (31,17);
INSERT INTO classes_students (student_id,class_id) VALUES (32,31);
INSERT INTO classes_students (student_id,class_id) VALUES (32,33);
INSERT INTO classes_students (student_id,class_id) VALUES (32,32);
INSERT INTO classes_students (student_id,class_id) VALUES (33,27);
INSERT INTO classes_students (student_id,class_id) VALUES (33,29);
INSERT INTO classes_students (student_id,class_id) VALUES (33,25);
INSERT INTO classes_students (student_id,class_id) VALUES (34,45);
INSERT INTO classes_students (student_id,class_id) VALUES (34,47);
INSERT INTO classes_students (student_id,class_id) VALUES (34,46);
INSERT INTO classes_students (student_id,class_id) VALUES (35,13);
INSERT INTO classes_students (student_id,class_id) VALUES (35,17);
INSERT INTO classes_students (student_id,class_id) VALUES (35,14);
INSERT INTO classes_students (student_id,class_id) VALUES (36,4);
INSERT INTO classes_students (student_id,class_id) VALUES (36,2);
INSERT INTO classes_students (student_id,class_id) VALUES (36,1);
INSERT INTO classes_students (student_id,class_id) VALUES (37,4);
INSERT INTO classes_students (student_id,class_id) VALUES (37,2);
INSERT INTO classes_students (student_id,class_id) VALUES (37,3);
INSERT INTO classes_students (student_id,class_id) VALUES (38,39);
INSERT INTO classes_students (student_id,class_id) VALUES (38,40);
INSERT INTO classes_students (student_id,class_id) VALUES (38,41);
INSERT INTO classes_students (student_id,class_id) VALUES (39,49);
INSERT INTO classes_students (student_id,class_id) VALUES (39,51);
INSERT INTO classes_students (student_id,class_id) VALUES (39,50);
INSERT INTO classes_students (student_id,class_id) VALUES (40,11);
INSERT INTO classes_students (student_id,class_id) VALUES (40,7);
INSERT INTO classes_students (student_id,class_id) VALUES (40,9);
INSERT INTO classes_students (student_id,class_id) VALUES (41,16);
INSERT INTO classes_students (student_id,class_id) VALUES (41,14);
INSERT INTO classes_students (student_id,class_id) VALUES (41,15);
INSERT INTO classes_students (student_id,class_id) VALUES (42,58);
INSERT INTO classes_students (student_id,class_id) VALUES (42,59);
INSERT INTO classes_students (student_id,class_id) VALUES (42,56);
INSERT INTO classes_students (student_id,class_id) VALUES (43,32);
INSERT INTO classes_students (student_id,class_id) VALUES (43,31);
INSERT INTO classes_students (student_id,class_id) VALUES (43,33);
INSERT INTO classes_students (student_id,class_id) VALUES (44,29);
INSERT INTO classes_students (student_id,class_id) VALUES (44,28);
INSERT INTO classes_students (student_id,class_id) VALUES (44,27);
INSERT INTO classes_students (student_id,class_id) VALUES (45,8);
INSERT INTO classes_students (student_id,class_id) VALUES (45,9);
INSERT INTO classes_students (student_id,class_id) VALUES (45,7);
INSERT INTO classes_students (student_id,class_id) VALUES (46,51);
INSERT INTO classes_students (student_id,class_id) VALUES (46,49);
INSERT INTO classes_students (student_id,class_id) VALUES (46,53);
INSERT INTO classes_students (student_id,class_id) VALUES (47,53);
INSERT INTO classes_students (student_id,class_id) VALUES (47,50);
INSERT INTO classes_students (student_id,class_id) VALUES (47,49);
INSERT INTO classes_students (student_id,class_id) VALUES (48,14);
INSERT INTO classes_students (student_id,class_id) VALUES (48,16);
INSERT INTO classes_students (student_id,class_id) VALUES (48,13);
INSERT INTO classes_students (student_id,class_id) VALUES (49,27);
INSERT INTO classes_students (student_id,class_id) VALUES (49,25);
INSERT INTO classes_students (student_id,class_id) VALUES (49,26);
INSERT INTO classes_students (student_id,class_id) VALUES (50,11);
INSERT INTO classes_students (student_id,class_id) VALUES (50,7);
INSERT INTO classes_students (student_id,class_id) VALUES (50,10);
INSERT INTO classes_students (student_id,class_id) VALUES (51,45);
INSERT INTO classes_students (student_id,class_id) VALUES (51,44);
INSERT INTO classes_students (student_id,class_id) VALUES (51,43);
INSERT INTO classes_students (student_id,class_id) VALUES (52,59);
INSERT INTO classes_students (student_id,class_id) VALUES (52,56);
INSERT INTO classes_students (student_id,class_id) VALUES (52,57);
INSERT INTO classes_students (student_id,class_id) VALUES (53,2);
INSERT INTO classes_students (student_id,class_id) VALUES (53,4);
INSERT INTO classes_students (student_id,class_id) VALUES (53,5);
INSERT INTO classes_students (student_id,class_id) VALUES (54,22);
INSERT INTO classes_students (student_id,class_id) VALUES (54,19);
INSERT INTO classes_students (student_id,class_id) VALUES (54,20);
INSERT INTO classes_students (student_id,class_id) VALUES (55,3);
INSERT INTO classes_students (student_id,class_id) VALUES (55,4);
INSERT INTO classes_students (student_id,class_id) VALUES (55,1);
INSERT INTO classes_students (student_id,class_id) VALUES (56,44);
INSERT INTO classes_students (student_id,class_id) VALUES (56,45);
INSERT INTO classes_students (student_id,class_id) VALUES (56,47);
INSERT INTO classes_students (student_id,class_id) VALUES (57,59);
INSERT INTO classes_students (student_id,class_id) VALUES (57,55);
INSERT INTO classes_students (student_id,class_id) VALUES (57,56);
INSERT INTO classes_students (student_id,class_id) VALUES (58,21);
INSERT INTO classes_students (student_id,class_id) VALUES (58,19);
INSERT INTO classes_students (student_id,class_id) VALUES (58,20);
INSERT INTO classes_students (student_id,class_id) VALUES (59,34);
INSERT INTO classes_students (student_id,class_id) VALUES (59,33);
INSERT INTO classes_students (student_id,class_id) VALUES (59,31);
INSERT INTO classes_students (student_id,class_id) VALUES (60,28);
INSERT INTO classes_students (student_id,class_id) VALUES (60,26);
INSERT INTO classes_students (student_id,class_id) VALUES (60,27);
INSERT INTO classes_students (student_id,class_id) VALUES (61,13);
INSERT INTO classes_students (student_id,class_id) VALUES (61,15);
INSERT INTO classes_students (student_id,class_id) VALUES (61,16);
INSERT INTO classes_students (student_id,class_id) VALUES (62,19);
INSERT INTO classes_students (student_id,class_id) VALUES (62,23);
INSERT INTO classes_students (student_id,class_id) VALUES (62,21);
INSERT INTO classes_students (student_id,class_id) VALUES (63,4);
INSERT INTO classes_students (student_id,class_id) VALUES (63,2);
INSERT INTO classes_students (student_id,class_id) VALUES (63,3);
INSERT INTO classes_students (student_id,class_id) VALUES (64,15);
INSERT INTO classes_students (student_id,class_id) VALUES (64,16);
INSERT INTO classes_students (student_id,class_id) VALUES (64,13);
INSERT INTO classes_students (student_id,class_id) VALUES (65,35);
INSERT INTO classes_students (student_id,class_id) VALUES (65,34);
INSERT INTO classes_students (student_id,class_id) VALUES (65,32);
INSERT INTO classes_students (student_id,class_id) VALUES (66,41);
INSERT INTO classes_students (student_id,class_id) VALUES (66,40);
INSERT INTO classes_students (student_id,class_id) VALUES (66,38);
INSERT INTO classes_students (student_id,class_id) VALUES (67,58);
INSERT INTO classes_students (student_id,class_id) VALUES (67,59);
INSERT INTO classes_students (student_id,class_id) VALUES (67,55);
INSERT INTO classes_students (student_id,class_id) VALUES (68,5);
INSERT INTO classes_students (student_id,class_id) VALUES (68,2);
INSERT INTO classes_students (student_id,class_id) VALUES (68,1);
INSERT INTO classes_students (student_id,class_id) VALUES (69,13);
INSERT INTO classes_students (student_id,class_id) VALUES (69,16);
INSERT INTO classes_students (student_id,class_id) VALUES (69,14);
INSERT INTO classes_students (student_id,class_id) VALUES (70,20);
INSERT INTO classes_students (student_id,class_id) VALUES (70,23);
INSERT INTO classes_students (student_id,class_id) VALUES (70,21);
INSERT INTO classes_students (student_id,class_id) VALUES (71,41);
INSERT INTO classes_students (student_id,class_id) VALUES (71,37);
INSERT INTO classes_students (student_id,class_id) VALUES (71,40);
INSERT INTO classes_students (student_id,class_id) VALUES (72,11);
INSERT INTO classes_students (student_id,class_id) VALUES (72,9);
INSERT INTO classes_students (student_id,class_id) VALUES (72,7);
INSERT INTO classes_students (student_id,class_id) VALUES (73,2);
INSERT INTO classes_students (student_id,class_id) VALUES (73,3);
INSERT INTO classes_students (student_id,class_id) VALUES (73,4);
INSERT INTO classes_students (student_id,class_id) VALUES (74,16);
INSERT INTO classes_students (student_id,class_id) VALUES (74,13);
INSERT INTO classes_students (student_id,class_id) VALUES (74,14);
INSERT INTO classes_students (student_id,class_id) VALUES (75,33);
INSERT INTO classes_students (student_id,class_id) VALUES (75,31);
INSERT INTO classes_students (student_id,class_id) VALUES (75,35);
INSERT INTO classes_students (student_id,class_id) VALUES (76,17);
INSERT INTO classes_students (student_id,class_id) VALUES (76,14);
INSERT INTO classes_students (student_id,class_id) VALUES (76,13);
INSERT INTO classes_students (student_id,class_id) VALUES (77,57);
INSERT INTO classes_students (student_id,class_id) VALUES (77,56);
INSERT INTO classes_students (student_id,class_id) VALUES (77,59);
INSERT INTO classes_students (student_id,class_id) VALUES (78,31);
INSERT INTO classes_students (student_id,class_id) VALUES (78,35);
INSERT INTO classes_students (student_id,class_id) VALUES (78,34);
INSERT INTO classes_students (student_id,class_id) VALUES (79,29);
INSERT INTO classes_students (student_id,class_id) VALUES (79,26);
INSERT INTO classes_students (student_id,class_id) VALUES (79,27);
INSERT INTO classes_students (student_id,class_id) VALUES (80,10);
INSERT INTO classes_students (student_id,class_id) VALUES (80,7);
INSERT INTO classes_students (student_id,class_id) VALUES (80,9);
INSERT INTO classes_students (student_id,class_id) VALUES (81,35);
INSERT INTO classes_students (student_id,class_id) VALUES (81,33);
INSERT INTO classes_students (student_id,class_id) VALUES (81,31);
INSERT INTO classes_students (student_id,class_id) VALUES (82,57);
INSERT INTO classes_students (student_id,class_id) VALUES (82,58);
INSERT INTO classes_students (student_id,class_id) VALUES (82,55);
INSERT INTO classes_students (student_id,class_id) VALUES (83,37);
INSERT INTO classes_students (student_id,class_id) VALUES (83,40);
INSERT INTO classes_students (student_id,class_id) VALUES (83,39);
INSERT INTO classes_students (student_id,class_id) VALUES (84,55);
INSERT INTO classes_students (student_id,class_id) VALUES (84,56);
INSERT INTO classes_students (student_id,class_id) VALUES (84,57);
INSERT INTO classes_students (student_id,class_id) VALUES (85,16);
INSERT INTO classes_students (student_id,class_id) VALUES (85,14);
INSERT INTO classes_students (student_id,class_id) VALUES (85,13);
INSERT INTO classes_students (student_id,class_id) VALUES (86,47);
INSERT INTO classes_students (student_id,class_id) VALUES (86,43);
INSERT INTO classes_students (student_id,class_id) VALUES (86,45);
INSERT INTO classes_students (student_id,class_id) VALUES (87,41);
INSERT INTO classes_students (student_id,class_id) VALUES (87,40);
INSERT INTO classes_students (student_id,class_id) VALUES (87,37);
INSERT INTO classes_students (student_id,class_id) VALUES (88,8);
INSERT INTO classes_students (student_id,class_id) VALUES (88,10);
INSERT INTO classes_students (student_id,class_id) VALUES (88,9);
INSERT INTO classes_students (student_id,class_id) VALUES (89,51);
INSERT INTO classes_students (student_id,class_id) VALUES (89,53);
INSERT INTO classes_students (student_id,class_id) VALUES (89,52);
INSERT INTO classes_students (student_id,class_id) VALUES (90,16);
INSERT INTO classes_students (student_id,class_id) VALUES (90,14);
INSERT INTO classes_students (student_id,class_id) VALUES (90,15);
INSERT INTO classes_students (student_id,class_id) VALUES (91,57);
INSERT INTO classes_students (student_id,class_id) VALUES (91,59);
INSERT INTO classes_students (student_id,class_id) VALUES (91,55);
INSERT INTO classes_students (student_id,class_id) VALUES (92,7);
INSERT INTO classes_students (student_id,class_id) VALUES (92,9);
INSERT INTO classes_students (student_id,class_id) VALUES (92,10);
INSERT INTO classes_students (student_id,class_id) VALUES (93,17);
INSERT INTO classes_students (student_id,class_id) VALUES (93,15);
INSERT INTO classes_students (student_id,class_id) VALUES (93,13);
INSERT INTO classes_students (student_id,class_id) VALUES (94,23);
INSERT INTO classes_students (student_id,class_id) VALUES (94,22);
INSERT INTO classes_students (student_id,class_id) VALUES (94,20);
INSERT INTO classes_students (student_id,class_id) VALUES (95,26);
INSERT INTO classes_students (student_id,class_id) VALUES (95,28);
INSERT INTO classes_students (student_id,class_id) VALUES (95,29);
INSERT INTO classes_students (student_id,class_id) VALUES (96,31);
INSERT INTO classes_students (student_id,class_id) VALUES (96,35);
INSERT INTO classes_students (student_id,class_id) VALUES (96,34);
INSERT INTO classes_students (student_id,class_id) VALUES (97,43);
INSERT INTO classes_students (student_id,class_id) VALUES (97,46);
INSERT INTO classes_students (student_id,class_id) VALUES (97,47);
INSERT INTO classes_students (student_id,class_id) VALUES (98,33);
INSERT INTO classes_students (student_id,class_id) VALUES (98,31);
INSERT INTO classes_students (student_id,class_id) VALUES (98,32);
INSERT INTO classes_students (student_id,class_id) VALUES (99,55);
INSERT INTO classes_students (student_id,class_id) VALUES (99,56);
INSERT INTO classes_students (student_id,class_id) VALUES (99,58);
INSERT INTO classes_students (student_id,class_id) VALUES (100,4);
INSERT INTO classes_students (student_id,class_id) VALUES (100,1);
INSERT INTO classes_students (student_id,class_id) VALUES (100,3);
INSERT INTO classes_students (student_id,class_id) VALUES (101,31);
INSERT INTO classes_students (student_id,class_id) VALUES (101,35);
INSERT INTO classes_students (student_id,class_id) VALUES (101,33);
INSERT INTO classes_students (student_id,class_id) VALUES (102,17);
INSERT INTO classes_students (student_id,class_id) VALUES (102,16);
INSERT INTO classes_students (student_id,class_id) VALUES (102,13);
INSERT INTO classes_students (student_id,class_id) VALUES (103,37);
INSERT INTO classes_students (student_id,class_id) VALUES (103,41);
INSERT INTO classes_students (student_id,class_id) VALUES (103,38);
INSERT INTO classes_students (student_id,class_id) VALUES (104,7);
INSERT INTO classes_students (student_id,class_id) VALUES (104,10);
INSERT INTO classes_students (student_id,class_id) VALUES (104,11);
INSERT INTO classes_students (student_id,class_id) VALUES (105,23);
INSERT INTO classes_students (student_id,class_id) VALUES (105,20);
INSERT INTO classes_students (student_id,class_id) VALUES (105,19);
INSERT INTO classes_students (student_id,class_id) VALUES (106,25);
INSERT INTO classes_students (student_id,class_id) VALUES (106,26);
INSERT INTO classes_students (student_id,class_id) VALUES (106,29);
INSERT INTO classes_students (student_id,class_id) VALUES (107,8);
INSERT INTO classes_students (student_id,class_id) VALUES (107,10);
INSERT INTO classes_students (student_id,class_id) VALUES (107,11);
INSERT INTO classes_students (student_id,class_id) VALUES (108,43);
INSERT INTO classes_students (student_id,class_id) VALUES (108,46);
INSERT INTO classes_students (student_id,class_id) VALUES (108,45);
INSERT INTO classes_students (student_id,class_id) VALUES (109,17);
INSERT INTO classes_students (student_id,class_id) VALUES (109,13);
INSERT INTO classes_students (student_id,class_id) VALUES (109,15);
INSERT INTO classes_students (student_id,class_id) VALUES (110,29);
INSERT INTO classes_students (student_id,class_id) VALUES (110,27);
INSERT INTO classes_students (student_id,class_id) VALUES (110,25);
INSERT INTO classes_students (student_id,class_id) VALUES (111,5);
INSERT INTO classes_students (student_id,class_id) VALUES (111,3);
INSERT INTO classes_students (student_id,class_id) VALUES (111,4);
INSERT INTO classes_students (student_id,class_id) VALUES (112,41);
INSERT INTO classes_students (student_id,class_id) VALUES (112,38);
INSERT INTO classes_students (student_id,class_id) VALUES (112,40);
INSERT INTO classes_students (student_id,class_id) VALUES (113,13);
INSERT INTO classes_students (student_id,class_id) VALUES (113,15);
INSERT INTO classes_students (student_id,class_id) VALUES (113,14);
INSERT INTO classes_students (student_id,class_id) VALUES (114,23);
INSERT INTO classes_students (student_id,class_id) VALUES (114,19);
INSERT INTO classes_students (student_id,class_id) VALUES (114,20);
INSERT INTO classes_students (student_id,class_id) VALUES (115,55);
INSERT INTO classes_students (student_id,class_id) VALUES (115,59);
INSERT INTO classes_students (student_id,class_id) VALUES (115,58);
INSERT INTO classes_students (student_id,class_id) VALUES (116,22);
INSERT INTO classes_students (student_id,class_id) VALUES (116,23);
INSERT INTO classes_students (student_id,class_id) VALUES (116,21);
INSERT INTO classes_students (student_id,class_id) VALUES (117,26);
INSERT INTO classes_students (student_id,class_id) VALUES (117,29);
INSERT INTO classes_students (student_id,class_id) VALUES (117,25);
INSERT INTO classes_students (student_id,class_id) VALUES (118,34);
INSERT INTO classes_students (student_id,class_id) VALUES (118,31);
INSERT INTO classes_students (student_id,class_id) VALUES (118,32);
INSERT INTO classes_students (student_id,class_id) VALUES (119,17);
INSERT INTO classes_students (student_id,class_id) VALUES (119,16);
INSERT INTO classes_students (student_id,class_id) VALUES (119,14);
INSERT INTO classes_students (student_id,class_id) VALUES (120,4);
INSERT INTO classes_students (student_id,class_id) VALUES (120,3);
INSERT INTO classes_students (student_id,class_id) VALUES (120,1);
INSERT INTO classes_students (student_id,class_id) VALUES (121,14);
INSERT INTO classes_students (student_id,class_id) VALUES (121,17);
INSERT INTO classes_students (student_id,class_id) VALUES (121,13);
INSERT INTO classes_students (student_id,class_id) VALUES (122,34);
INSERT INTO classes_students (student_id,class_id) VALUES (122,35);
INSERT INTO classes_students (student_id,class_id) VALUES (122,31);
INSERT INTO classes_students (student_id,class_id) VALUES (123,43);
INSERT INTO classes_students (student_id,class_id) VALUES (123,46);
INSERT INTO classes_students (student_id,class_id) VALUES (123,45);
INSERT INTO classes_students (student_id,class_id) VALUES (124,23);
INSERT INTO classes_students (student_id,class_id) VALUES (124,21);
INSERT INTO classes_students (student_id,class_id) VALUES (124,22);
INSERT INTO classes_students (student_id,class_id) VALUES (125,45);
INSERT INTO classes_students (student_id,class_id) VALUES (125,43);
INSERT INTO classes_students (student_id,class_id) VALUES (125,46);
INSERT INTO classes_students (student_id,class_id) VALUES (126,26);
INSERT INTO classes_students (student_id,class_id) VALUES (126,27);
INSERT INTO classes_students (student_id,class_id) VALUES (126,28);
INSERT INTO classes_students (student_id,class_id) VALUES (127,10);
INSERT INTO classes_students (student_id,class_id) VALUES (127,9);
INSERT INTO classes_students (student_id,class_id) VALUES (127,8);
INSERT INTO classes_students (student_id,class_id) VALUES (128,47);
INSERT INTO classes_students (student_id,class_id) VALUES (128,44);
INSERT INTO classes_students (student_id,class_id) VALUES (128,46);
INSERT INTO classes_students (student_id,class_id) VALUES (129,17);
INSERT INTO classes_students (student_id,class_id) VALUES (129,15);
INSERT INTO classes_students (student_id,class_id) VALUES (129,13);
INSERT INTO classes_students (student_id,class_id) VALUES (130,13);
INSERT INTO classes_students (student_id,class_id) VALUES (130,17);
INSERT INTO classes_students (student_id,class_id) VALUES (130,15);
INSERT INTO classes_students (student_id,class_id) VALUES (131,22);
INSERT INTO classes_students (student_id,class_id) VALUES (131,19);
INSERT INTO classes_students (student_id,class_id) VALUES (131,23);
INSERT INTO classes_students (student_id,class_id) VALUES (132,20);
INSERT INTO classes_students (student_id,class_id) VALUES (132,21);
INSERT INTO classes_students (student_id,class_id) VALUES (132,23);
INSERT INTO classes_students (student_id,class_id) VALUES (133,37);
INSERT INTO classes_students (student_id,class_id) VALUES (133,40);
INSERT INTO classes_students (student_id,class_id) VALUES (133,41);
INSERT INTO classes_students (student_id,class_id) VALUES (134,39);
INSERT INTO classes_students (student_id,class_id) VALUES (134,41);
INSERT INTO classes_students (student_id,class_id) VALUES (134,40);
INSERT INTO classes_students (student_id,class_id) VALUES (135,53);
INSERT INTO classes_students (student_id,class_id) VALUES (135,49);
INSERT INTO classes_students (student_id,class_id) VALUES (135,51);
INSERT INTO classes_students (student_id,class_id) VALUES (136,21);
INSERT INTO classes_students (student_id,class_id) VALUES (136,20);
INSERT INTO classes_students (student_id,class_id) VALUES (136,23);
INSERT INTO classes_students (student_id,class_id) VALUES (137,23);
INSERT INTO classes_students (student_id,class_id) VALUES (137,20);
INSERT INTO classes_students (student_id,class_id) VALUES (137,22);
INSERT INTO classes_students (student_id,class_id) VALUES (138,53);
INSERT INTO classes_students (student_id,class_id) VALUES (138,52);
INSERT INTO classes_students (student_id,class_id) VALUES (138,50);
INSERT INTO classes_students (student_id,class_id) VALUES (139,10);
INSERT INTO classes_students (student_id,class_id) VALUES (139,7);
INSERT INTO classes_students (student_id,class_id) VALUES (139,9);
INSERT INTO classes_students (student_id,class_id) VALUES (140,28);
INSERT INTO classes_students (student_id,class_id) VALUES (140,27);
INSERT INTO classes_students (student_id,class_id) VALUES (140,25);
INSERT INTO classes_students (student_id,class_id) VALUES (141,46);
INSERT INTO classes_students (student_id,class_id) VALUES (141,44);
INSERT INTO classes_students (student_id,class_id) VALUES (141,43);
INSERT INTO classes_students (student_id,class_id) VALUES (142,59);
INSERT INTO classes_students (student_id,class_id) VALUES (142,55);
INSERT INTO classes_students (student_id,class_id) VALUES (142,58);
INSERT INTO classes_students (student_id,class_id) VALUES (143,17);
INSERT INTO classes_students (student_id,class_id) VALUES (143,16);
INSERT INTO classes_students (student_id,class_id) VALUES (143,14);
INSERT INTO classes_students (student_id,class_id) VALUES (144,8);
INSERT INTO classes_students (student_id,class_id) VALUES (144,9);
INSERT INTO classes_students (student_id,class_id) VALUES (144,11);
INSERT INTO classes_students (student_id,class_id) VALUES (145,21);
INSERT INTO classes_students (student_id,class_id) VALUES (145,20);
INSERT INTO classes_students (student_id,class_id) VALUES (145,22);
INSERT INTO classes_students (student_id,class_id) VALUES (146,11);
INSERT INTO classes_students (student_id,class_id) VALUES (146,8);
INSERT INTO classes_students (student_id,class_id) VALUES (146,7);
INSERT INTO classes_students (student_id,class_id) VALUES (147,3);
INSERT INTO classes_students (student_id,class_id) VALUES (147,5);
INSERT INTO classes_students (student_id,class_id) VALUES (147,1);
INSERT INTO classes_students (student_id,class_id) VALUES (148,13);
INSERT INTO classes_students (student_id,class_id) VALUES (148,17);
INSERT INTO classes_students (student_id,class_id) VALUES (148,16);
INSERT INTO classes_students (student_id,class_id) VALUES (149,10);
INSERT INTO classes_students (student_id,class_id) VALUES (149,9);
INSERT INTO classes_students (student_id,class_id) VALUES (149,7);
INSERT INTO classes_students (student_id,class_id) VALUES (150,22);
INSERT INTO classes_students (student_id,class_id) VALUES (150,23);
INSERT INTO classes_students (student_id,class_id) VALUES (150,20);
INSERT INTO classes_students (student_id,class_id) VALUES (151,4);
INSERT INTO classes_students (student_id,class_id) VALUES (151,2);
INSERT INTO classes_students (student_id,class_id) VALUES (151,3);
INSERT INTO classes_students (student_id,class_id) VALUES (152,31);
INSERT INTO classes_students (student_id,class_id) VALUES (152,34);
INSERT INTO classes_students (student_id,class_id) VALUES (152,35);
INSERT INTO classes_students (student_id,class_id) VALUES (153,28);
INSERT INTO classes_students (student_id,class_id) VALUES (153,29);
INSERT INTO classes_students (student_id,class_id) VALUES (153,26);
INSERT INTO classes_students (student_id,class_id) VALUES (154,5);
INSERT INTO classes_students (student_id,class_id) VALUES (154,3);
INSERT INTO classes_students (student_id,class_id) VALUES (154,4);
INSERT INTO classes_students (student_id,class_id) VALUES (155,50);
INSERT INTO classes_students (student_id,class_id) VALUES (155,49);
INSERT INTO classes_students (student_id,class_id) VALUES (155,52);
INSERT INTO classes_students (student_id,class_id) VALUES (156,28);
INSERT INTO classes_students (student_id,class_id) VALUES (156,26);
INSERT INTO classes_students (student_id,class_id) VALUES (156,25);
INSERT INTO classes_students (student_id,class_id) VALUES (157,51);
INSERT INTO classes_students (student_id,class_id) VALUES (157,52);
INSERT INTO classes_students (student_id,class_id) VALUES (157,50);
INSERT INTO classes_students (student_id,class_id) VALUES (158,1);
INSERT INTO classes_students (student_id,class_id) VALUES (158,4);
INSERT INTO classes_students (student_id,class_id) VALUES (158,3);
INSERT INTO classes_students (student_id,class_id) VALUES (159,57);
INSERT INTO classes_students (student_id,class_id) VALUES (159,56);
INSERT INTO classes_students (student_id,class_id) VALUES (159,58);
INSERT INTO classes_students (student_id,class_id) VALUES (160,31);
INSERT INTO classes_students (student_id,class_id) VALUES (160,32);
INSERT INTO classes_students (student_id,class_id) VALUES (160,34);
INSERT INTO classes_students (student_id,class_id) VALUES (161,39);
INSERT INTO classes_students (student_id,class_id) VALUES (161,40);
INSERT INTO classes_students (student_id,class_id) VALUES (161,37);
INSERT INTO classes_students (student_id,class_id) VALUES (162,35);
INSERT INTO classes_students (student_id,class_id) VALUES (162,33);
INSERT INTO classes_students (student_id,class_id) VALUES (162,31);
INSERT INTO classes_students (student_id,class_id) VALUES (163,16);
INSERT INTO classes_students (student_id,class_id) VALUES (163,14);
INSERT INTO classes_students (student_id,class_id) VALUES (163,15);
INSERT INTO classes_students (student_id,class_id) VALUES (164,1);
INSERT INTO classes_students (student_id,class_id) VALUES (164,4);
INSERT INTO classes_students (student_id,class_id) VALUES (164,2);
INSERT INTO classes_students (student_id,class_id) VALUES (165,37);
INSERT INTO classes_students (student_id,class_id) VALUES (165,39);
INSERT INTO classes_students (student_id,class_id) VALUES (165,38);
INSERT INTO classes_students (student_id,class_id) VALUES (166,2);
INSERT INTO classes_students (student_id,class_id) VALUES (166,4);
INSERT INTO classes_students (student_id,class_id) VALUES (166,5);
INSERT INTO classes_students (student_id,class_id) VALUES (167,35);
INSERT INTO classes_students (student_id,class_id) VALUES (167,31);
INSERT INTO classes_students (student_id,class_id) VALUES (167,34);
INSERT INTO classes_students (student_id,class_id) VALUES (168,7);
INSERT INTO classes_students (student_id,class_id) VALUES (168,10);
INSERT INTO classes_students (student_id,class_id) VALUES (168,11);
INSERT INTO classes_students (student_id,class_id) VALUES (169,37);
INSERT INTO classes_students (student_id,class_id) VALUES (169,41);
INSERT INTO classes_students (student_id,class_id) VALUES (169,38);
INSERT INTO classes_students (student_id,class_id) VALUES (170,28);
INSERT INTO classes_students (student_id,class_id) VALUES (170,25);
INSERT INTO classes_students (student_id,class_id) VALUES (170,29);
INSERT INTO classes_students (student_id,class_id) VALUES (171,20);
INSERT INTO classes_students (student_id,class_id) VALUES (171,21);
INSERT INTO classes_students (student_id,class_id) VALUES (171,19);
INSERT INTO classes_students (student_id,class_id) VALUES (172,3);
INSERT INTO classes_students (student_id,class_id) VALUES (172,2);
INSERT INTO classes_students (student_id,class_id) VALUES (172,1);
INSERT INTO classes_students (student_id,class_id) VALUES (173,21);
INSERT INTO classes_students (student_id,class_id) VALUES (173,22);
INSERT INTO classes_students (student_id,class_id) VALUES (173,23);
INSERT INTO classes_students (student_id,class_id) VALUES (174,3);
INSERT INTO classes_students (student_id,class_id) VALUES (174,5);
INSERT INTO classes_students (student_id,class_id) VALUES (174,4);
INSERT INTO classes_students (student_id,class_id) VALUES (175,23);
INSERT INTO classes_students (student_id,class_id) VALUES (175,20);
INSERT INTO classes_students (student_id,class_id) VALUES (175,22);
INSERT INTO classes_students (student_id,class_id) VALUES (176,35);
INSERT INTO classes_students (student_id,class_id) VALUES (176,32);
INSERT INTO classes_students (student_id,class_id) VALUES (176,33);
INSERT INTO classes_students (student_id,class_id) VALUES (177,53);
INSERT INTO classes_students (student_id,class_id) VALUES (177,49);
INSERT INTO classes_students (student_id,class_id) VALUES (177,50);
INSERT INTO classes_students (student_id,class_id) VALUES (178,19);
INSERT INTO classes_students (student_id,class_id) VALUES (178,20);
INSERT INTO classes_students (student_id,class_id) VALUES (178,21);
INSERT INTO classes_students (student_id,class_id) VALUES (179,1);
INSERT INTO classes_students (student_id,class_id) VALUES (179,2);
INSERT INTO classes_students (student_id,class_id) VALUES (179,4);
INSERT INTO classes_students (student_id,class_id) VALUES (180,27);
INSERT INTO classes_students (student_id,class_id) VALUES (180,26);
INSERT INTO classes_students (student_id,class_id) VALUES (180,29);
INSERT INTO classes_students (student_id,class_id) VALUES (181,4);
INSERT INTO classes_students (student_id,class_id) VALUES (181,2);
INSERT INTO classes_students (student_id,class_id) VALUES (181,5);
INSERT INTO classes_students (student_id,class_id) VALUES (182,8);
INSERT INTO classes_students (student_id,class_id) VALUES (182,11);
INSERT INTO classes_students (student_id,class_id) VALUES (182,10);
INSERT INTO classes_students (student_id,class_id) VALUES (183,44);
INSERT INTO classes_students (student_id,class_id) VALUES (183,45);
INSERT INTO classes_students (student_id,class_id) VALUES (183,47);
INSERT INTO classes_students (student_id,class_id) VALUES (184,20);
INSERT INTO classes_students (student_id,class_id) VALUES (184,22);
INSERT INTO classes_students (student_id,class_id) VALUES (184,23);
INSERT INTO classes_students (student_id,class_id) VALUES (185,44);
INSERT INTO classes_students (student_id,class_id) VALUES (185,47);
INSERT INTO classes_students (student_id,class_id) VALUES (185,46);
INSERT INTO classes_students (student_id,class_id) VALUES (186,32);
INSERT INTO classes_students (student_id,class_id) VALUES (186,33);
INSERT INTO classes_students (student_id,class_id) VALUES (186,31);
INSERT INTO classes_students (student_id,class_id) VALUES (187,5);
INSERT INTO classes_students (student_id,class_id) VALUES (187,1);
INSERT INTO classes_students (student_id,class_id) VALUES (187,3);
INSERT INTO classes_students (student_id,class_id) VALUES (188,17);
INSERT INTO classes_students (student_id,class_id) VALUES (188,14);
INSERT INTO classes_students (student_id,class_id) VALUES (188,15);
INSERT INTO classes_students (student_id,class_id) VALUES (189,38);
INSERT INTO classes_students (student_id,class_id) VALUES (189,39);
INSERT INTO classes_students (student_id,class_id) VALUES (189,41);
INSERT INTO classes_students (student_id,class_id) VALUES (190,58);
INSERT INTO classes_students (student_id,class_id) VALUES (190,59);
INSERT INTO classes_students (student_id,class_id) VALUES (190,56);
INSERT INTO classes_students (student_id,class_id) VALUES (191,13);
INSERT INTO classes_students (student_id,class_id) VALUES (191,17);
INSERT INTO classes_students (student_id,class_id) VALUES (191,15);
INSERT INTO classes_students (student_id,class_id) VALUES (192,50);
INSERT INTO classes_students (student_id,class_id) VALUES (192,51);
INSERT INTO classes_students (student_id,class_id) VALUES (192,49);
INSERT INTO classes_students (student_id,class_id) VALUES (193,41);
INSERT INTO classes_students (student_id,class_id) VALUES (193,37);
INSERT INTO classes_students (student_id,class_id) VALUES (193,40);
INSERT INTO classes_students (student_id,class_id) VALUES (194,40);
INSERT INTO classes_students (student_id,class_id) VALUES (194,38);
INSERT INTO classes_students (student_id,class_id) VALUES (194,41);
INSERT INTO classes_students (student_id,class_id) VALUES (195,20);
INSERT INTO classes_students (student_id,class_id) VALUES (195,21);
INSERT INTO classes_students (student_id,class_id) VALUES (195,22);
INSERT INTO classes_students (student_id,class_id) VALUES (196,16);
INSERT INTO classes_students (student_id,class_id) VALUES (196,17);
INSERT INTO classes_students (student_id,class_id) VALUES (196,13);
INSERT INTO classes_students (student_id,class_id) VALUES (197,40);
INSERT INTO classes_students (student_id,class_id) VALUES (197,41);
INSERT INTO classes_students (student_id,class_id) VALUES (197,37);
INSERT INTO classes_students (student_id,class_id) VALUES (198,23);
INSERT INTO classes_students (student_id,class_id) VALUES (198,19);
INSERT INTO classes_students (student_id,class_id) VALUES (198,22);
INSERT INTO classes_students (student_id,class_id) VALUES (199,27);
INSERT INTO classes_students (student_id,class_id) VALUES (199,26);
INSERT INTO classes_students (student_id,class_id) VALUES (199,29);
INSERT INTO classes_students (student_id,class_id) VALUES (200,45);
INSERT INTO classes_students (student_id,class_id) VALUES (200,47);
INSERT INTO classes_students (student_id,class_id) VALUES (200,44);
INSERT INTO classes_students (student_id,class_id) VALUES (201,14);
INSERT INTO classes_students (student_id,class_id) VALUES (201,13);
INSERT INTO classes_students (student_id,class_id) VALUES (201,17);
INSERT INTO classes_students (student_id,class_id) VALUES (202,37);
INSERT INTO classes_students (student_id,class_id) VALUES (202,40);
INSERT INTO classes_students (student_id,class_id) VALUES (202,39);
INSERT INTO classes_students (student_id,class_id) VALUES (203,58);
INSERT INTO classes_students (student_id,class_id) VALUES (203,57);
INSERT INTO classes_students (student_id,class_id) VALUES (203,59);
INSERT INTO classes_students (student_id,class_id) VALUES (204,55);
INSERT INTO classes_students (student_id,class_id) VALUES (204,56);
INSERT INTO classes_students (student_id,class_id) VALUES (204,59);
INSERT INTO classes_students (student_id,class_id) VALUES (205,16);
INSERT INTO classes_students (student_id,class_id) VALUES (205,13);
INSERT INTO classes_students (student_id,class_id) VALUES (205,17);
INSERT INTO classes_students (student_id,class_id) VALUES (206,29);
INSERT INTO classes_students (student_id,class_id) VALUES (206,27);
INSERT INTO classes_students (student_id,class_id) VALUES (206,25);
INSERT INTO classes_students (student_id,class_id) VALUES (207,57);
INSERT INTO classes_students (student_id,class_id) VALUES (207,58);
INSERT INTO classes_students (student_id,class_id) VALUES (207,59);
INSERT INTO classes_students (student_id,class_id) VALUES (208,8);
INSERT INTO classes_students (student_id,class_id) VALUES (208,10);
INSERT INTO classes_students (student_id,class_id) VALUES (208,7);
INSERT INTO classes_students (student_id,class_id) VALUES (209,41);
INSERT INTO classes_students (student_id,class_id) VALUES (209,40);
INSERT INTO classes_students (student_id,class_id) VALUES (209,39);
INSERT INTO classes_students (student_id,class_id) VALUES (210,56);
INSERT INTO classes_students (student_id,class_id) VALUES (210,55);
INSERT INTO classes_students (student_id,class_id) VALUES (210,57);
INSERT INTO classes_students (student_id,class_id) VALUES (211,11);
INSERT INTO classes_students (student_id,class_id) VALUES (211,9);
INSERT INTO classes_students (student_id,class_id) VALUES (211,7);
INSERT INTO classes_students (student_id,class_id) VALUES (212,43);
INSERT INTO classes_students (student_id,class_id) VALUES (212,47);
INSERT INTO classes_students (student_id,class_id) VALUES (212,44);
INSERT INTO classes_students (student_id,class_id) VALUES (213,55);
INSERT INTO classes_students (student_id,class_id) VALUES (213,56);
INSERT INTO classes_students (student_id,class_id) VALUES (213,58);
INSERT INTO classes_students (student_id,class_id) VALUES (214,33);
INSERT INTO classes_students (student_id,class_id) VALUES (214,31);
INSERT INTO classes_students (student_id,class_id) VALUES (214,32);
INSERT INTO classes_students (student_id,class_id) VALUES (215,4);
INSERT INTO classes_students (student_id,class_id) VALUES (215,2);
INSERT INTO classes_students (student_id,class_id) VALUES (215,3);
INSERT INTO classes_students (student_id,class_id) VALUES (216,47);
INSERT INTO classes_students (student_id,class_id) VALUES (216,45);
INSERT INTO classes_students (student_id,class_id) VALUES (216,44);
INSERT INTO classes_students (student_id,class_id) VALUES (217,16);
INSERT INTO classes_students (student_id,class_id) VALUES (217,13);
INSERT INTO classes_students (student_id,class_id) VALUES (217,15);
INSERT INTO classes_students (student_id,class_id) VALUES (218,22);
INSERT INTO classes_students (student_id,class_id) VALUES (218,19);
INSERT INTO classes_students (student_id,class_id) VALUES (218,21);
INSERT INTO classes_students (student_id,class_id) VALUES (219,55);
INSERT INTO classes_students (student_id,class_id) VALUES (219,58);
INSERT INTO classes_students (student_id,class_id) VALUES (219,56);
INSERT INTO classes_students (student_id,class_id) VALUES (220,37);
INSERT INTO classes_students (student_id,class_id) VALUES (220,39);
INSERT INTO classes_students (student_id,class_id) VALUES (220,41);
INSERT INTO classes_students (student_id,class_id) VALUES (221,37);
INSERT INTO classes_students (student_id,class_id) VALUES (221,41);
INSERT INTO classes_students (student_id,class_id) VALUES (221,38);
INSERT INTO classes_students (student_id,class_id) VALUES (222,44);
INSERT INTO classes_students (student_id,class_id) VALUES (222,47);
INSERT INTO classes_students (student_id,class_id) VALUES (222,46);
INSERT INTO classes_students (student_id,class_id) VALUES (223,56);
INSERT INTO classes_students (student_id,class_id) VALUES (223,58);
INSERT INTO classes_students (student_id,class_id) VALUES (223,57);
INSERT INTO classes_students (student_id,class_id) VALUES (224,22);
INSERT INTO classes_students (student_id,class_id) VALUES (224,21);
INSERT INTO classes_students (student_id,class_id) VALUES (224,20);
INSERT INTO classes_students (student_id,class_id) VALUES (225,21);
INSERT INTO classes_students (student_id,class_id) VALUES (225,23);
INSERT INTO classes_students (student_id,class_id) VALUES (225,22);
INSERT INTO classes_students (student_id,class_id) VALUES (226,37);
INSERT INTO classes_students (student_id,class_id) VALUES (226,40);
INSERT INTO classes_students (student_id,class_id) VALUES (226,39);
INSERT INTO classes_students (student_id,class_id) VALUES (227,3);
INSERT INTO classes_students (student_id,class_id) VALUES (227,2);
INSERT INTO classes_students (student_id,class_id) VALUES (227,4);
INSERT INTO classes_students (student_id,class_id) VALUES (228,34);
INSERT INTO classes_students (student_id,class_id) VALUES (228,31);
INSERT INTO classes_students (student_id,class_id) VALUES (228,33);
INSERT INTO classes_students (student_id,class_id) VALUES (229,27);
INSERT INTO classes_students (student_id,class_id) VALUES (229,26);
INSERT INTO classes_students (student_id,class_id) VALUES (229,29);
INSERT INTO classes_students (student_id,class_id) VALUES (230,37);
INSERT INTO classes_students (student_id,class_id) VALUES (230,40);
INSERT INTO classes_students (student_id,class_id) VALUES (230,41);
INSERT INTO classes_students (student_id,class_id) VALUES (231,5);
INSERT INTO classes_students (student_id,class_id) VALUES (231,3);
INSERT INTO classes_students (student_id,class_id) VALUES (231,1);
INSERT INTO classes_students (student_id,class_id) VALUES (232,46);
INSERT INTO classes_students (student_id,class_id) VALUES (232,45);
INSERT INTO classes_students (student_id,class_id) VALUES (232,44);
INSERT INTO classes_students (student_id,class_id) VALUES (233,10);
INSERT INTO classes_students (student_id,class_id) VALUES (233,11);
INSERT INTO classes_students (student_id,class_id) VALUES (233,8);
INSERT INTO classes_students (student_id,class_id) VALUES (234,38);
INSERT INTO classes_students (student_id,class_id) VALUES (234,41);
INSERT INTO classes_students (student_id,class_id) VALUES (234,40);
INSERT INTO classes_students (student_id,class_id) VALUES (235,32);
INSERT INTO classes_students (student_id,class_id) VALUES (235,31);
INSERT INTO classes_students (student_id,class_id) VALUES (235,34);
INSERT INTO classes_students (student_id,class_id) VALUES (236,45);
INSERT INTO classes_students (student_id,class_id) VALUES (236,46);
INSERT INTO classes_students (student_id,class_id) VALUES (236,44);
INSERT INTO classes_students (student_id,class_id) VALUES (237,59);
INSERT INTO classes_students (student_id,class_id) VALUES (237,56);
INSERT INTO classes_students (student_id,class_id) VALUES (237,58);
INSERT INTO classes_students (student_id,class_id) VALUES (238,11);
INSERT INTO classes_students (student_id,class_id) VALUES (238,8);
INSERT INTO classes_students (student_id,class_id) VALUES (238,7);
INSERT INTO classes_students (student_id,class_id) VALUES (239,33);
INSERT INTO classes_students (student_id,class_id) VALUES (239,34);
INSERT INTO classes_students (student_id,class_id) VALUES (239,31);
INSERT INTO classes_students (student_id,class_id) VALUES (240,50);
INSERT INTO classes_students (student_id,class_id) VALUES (240,51);
INSERT INTO classes_students (student_id,class_id) VALUES (240,52);
INSERT INTO classes_students (student_id,class_id) VALUES (241,57);
INSERT INTO classes_students (student_id,class_id) VALUES (241,59);
INSERT INTO classes_students (student_id,class_id) VALUES (241,56);
INSERT INTO classes_students (student_id,class_id) VALUES (242,34);
INSERT INTO classes_students (student_id,class_id) VALUES (242,32);
INSERT INTO classes_students (student_id,class_id) VALUES (242,35);
INSERT INTO classes_students (student_id,class_id) VALUES (243,45);
INSERT INTO classes_students (student_id,class_id) VALUES (243,43);
INSERT INTO classes_students (student_id,class_id) VALUES (243,47);
INSERT INTO classes_students (student_id,class_id) VALUES (244,20);
INSERT INTO classes_students (student_id,class_id) VALUES (244,23);
INSERT INTO classes_students (student_id,class_id) VALUES (244,22);
INSERT INTO classes_students (student_id,class_id) VALUES (245,39);
INSERT INTO classes_students (student_id,class_id) VALUES (245,40);
INSERT INTO classes_students (student_id,class_id) VALUES (245,37);
INSERT INTO classes_students (student_id,class_id) VALUES (246,23);
INSERT INTO classes_students (student_id,class_id) VALUES (246,21);
INSERT INTO classes_students (student_id,class_id) VALUES (246,22);
INSERT INTO classes_students (student_id,class_id) VALUES (247,43);
INSERT INTO classes_students (student_id,class_id) VALUES (247,44);
INSERT INTO classes_students (student_id,class_id) VALUES (247,45);
INSERT INTO classes_students (student_id,class_id) VALUES (248,29);
INSERT INTO classes_students (student_id,class_id) VALUES (248,27);
INSERT INTO classes_students (student_id,class_id) VALUES (248,26);
INSERT INTO classes_students (student_id,class_id) VALUES (249,49);
INSERT INTO classes_students (student_id,class_id) VALUES (249,50);
INSERT INTO classes_students (student_id,class_id) VALUES (249,52);
INSERT INTO classes_students (student_id,class_id) VALUES (250,16);
INSERT INTO classes_students (student_id,class_id) VALUES (250,17);
INSERT INTO classes_students (student_id,class_id) VALUES (250,13);
INSERT INTO classes_students (student_id,class_id) VALUES (251,5);
INSERT INTO classes_students (student_id,class_id) VALUES (251,2);
INSERT INTO classes_students (student_id,class_id) VALUES (251,1);
INSERT INTO classes_students (student_id,class_id) VALUES (252,9);
INSERT INTO classes_students (student_id,class_id) VALUES (252,8);
INSERT INTO classes_students (student_id,class_id) VALUES (252,11);
INSERT INTO classes_students (student_id,class_id) VALUES (253,56);
INSERT INTO classes_students (student_id,class_id) VALUES (253,59);
INSERT INTO classes_students (student_id,class_id) VALUES (253,57);
INSERT INTO classes_students (student_id,class_id) VALUES (254,21);
INSERT INTO classes_students (student_id,class_id) VALUES (254,19);
INSERT INTO classes_students (student_id,class_id) VALUES (254,20);
INSERT INTO classes_students (student_id,class_id) VALUES (255,58);
INSERT INTO classes_students (student_id,class_id) VALUES (255,59);
INSERT INTO classes_students (student_id,class_id) VALUES (255,57);
INSERT INTO classes_students (student_id,class_id) VALUES (256,33);
INSERT INTO classes_students (student_id,class_id) VALUES (256,34);
INSERT INTO classes_students (student_id,class_id) VALUES (256,31);
INSERT INTO classes_students (student_id,class_id) VALUES (257,15);
INSERT INTO classes_students (student_id,class_id) VALUES (257,16);
INSERT INTO classes_students (student_id,class_id) VALUES (257,17);
INSERT INTO classes_students (student_id,class_id) VALUES (258,23);
INSERT INTO classes_students (student_id,class_id) VALUES (258,22);
INSERT INTO classes_students (student_id,class_id) VALUES (258,20);
INSERT INTO classes_students (student_id,class_id) VALUES (259,20);
INSERT INTO classes_students (student_id,class_id) VALUES (259,22);
INSERT INTO classes_students (student_id,class_id) VALUES (259,23);
INSERT INTO classes_students (student_id,class_id) VALUES (260,20);
INSERT INTO classes_students (student_id,class_id) VALUES (260,19);
INSERT INTO classes_students (student_id,class_id) VALUES (260,22);
INSERT INTO classes_students (student_id,class_id) VALUES (261,2);
INSERT INTO classes_students (student_id,class_id) VALUES (261,5);
INSERT INTO classes_students (student_id,class_id) VALUES (261,3);
INSERT INTO classes_students (student_id,class_id) VALUES (262,9);
INSERT INTO classes_students (student_id,class_id) VALUES (262,10);
INSERT INTO classes_students (student_id,class_id) VALUES (262,8);
INSERT INTO classes_students (student_id,class_id) VALUES (263,2);
INSERT INTO classes_students (student_id,class_id) VALUES (263,3);
INSERT INTO classes_students (student_id,class_id) VALUES (263,5);
INSERT INTO classes_students (student_id,class_id) VALUES (264,14);
INSERT INTO classes_students (student_id,class_id) VALUES (264,13);
INSERT INTO classes_students (student_id,class_id) VALUES (264,16);
INSERT INTO classes_students (student_id,class_id) VALUES (265,46);
INSERT INTO classes_students (student_id,class_id) VALUES (265,47);
INSERT INTO classes_students (student_id,class_id) VALUES (265,45);
INSERT INTO classes_students (student_id,class_id) VALUES (266,33);
INSERT INTO classes_students (student_id,class_id) VALUES (266,32);
INSERT INTO classes_students (student_id,class_id) VALUES (266,35);
INSERT INTO classes_students (student_id,class_id) VALUES (267,41);
INSERT INTO classes_students (student_id,class_id) VALUES (267,40);
INSERT INTO classes_students (student_id,class_id) VALUES (267,38);
INSERT INTO classes_students (student_id,class_id) VALUES (268,22);
INSERT INTO classes_students (student_id,class_id) VALUES (268,19);
INSERT INTO classes_students (student_id,class_id) VALUES (268,20);
INSERT INTO classes_students (student_id,class_id) VALUES (269,47);
INSERT INTO classes_students (student_id,class_id) VALUES (269,44);
INSERT INTO classes_students (student_id,class_id) VALUES (269,46);
INSERT INTO classes_students (student_id,class_id) VALUES (270,1);
INSERT INTO classes_students (student_id,class_id) VALUES (270,3);
INSERT INTO classes_students (student_id,class_id) VALUES (270,4);
INSERT INTO classes_students (student_id,class_id) VALUES (271,3);
INSERT INTO classes_students (student_id,class_id) VALUES (271,4);
INSERT INTO classes_students (student_id,class_id) VALUES (271,2);
INSERT INTO classes_students (student_id,class_id) VALUES (272,49);
INSERT INTO classes_students (student_id,class_id) VALUES (272,53);
INSERT INTO classes_students (student_id,class_id) VALUES (272,51);
INSERT INTO classes_students (student_id,class_id) VALUES (273,33);
INSERT INTO classes_students (student_id,class_id) VALUES (273,34);
INSERT INTO classes_students (student_id,class_id) VALUES (273,31);
INSERT INTO classes_students (student_id,class_id) VALUES (274,20);
INSERT INTO classes_students (student_id,class_id) VALUES (274,22);
INSERT INTO classes_students (student_id,class_id) VALUES (274,19);
INSERT INTO classes_students (student_id,class_id) VALUES (275,49);
INSERT INTO classes_students (student_id,class_id) VALUES (275,50);
INSERT INTO classes_students (student_id,class_id) VALUES (275,53);
INSERT INTO classes_students (student_id,class_id) VALUES (276,34);
INSERT INTO classes_students (student_id,class_id) VALUES (276,35);
INSERT INTO classes_students (student_id,class_id) VALUES (276,33);
INSERT INTO classes_students (student_id,class_id) VALUES (277,9);
INSERT INTO classes_students (student_id,class_id) VALUES (277,10);
INSERT INTO classes_students (student_id,class_id) VALUES (277,11);
INSERT INTO classes_students (student_id,class_id) VALUES (278,1);
INSERT INTO classes_students (student_id,class_id) VALUES (278,4);
INSERT INTO classes_students (student_id,class_id) VALUES (278,2);
INSERT INTO classes_students (student_id,class_id) VALUES (279,59);
INSERT INTO classes_students (student_id,class_id) VALUES (279,56);
INSERT INTO classes_students (student_id,class_id) VALUES (279,55);
INSERT INTO classes_students (student_id,class_id) VALUES (280,11);
INSERT INTO classes_students (student_id,class_id) VALUES (280,10);
INSERT INTO classes_students (student_id,class_id) VALUES (280,8);
INSERT INTO classes_students (student_id,class_id) VALUES (281,33);
INSERT INTO classes_students (student_id,class_id) VALUES (281,34);
INSERT INTO classes_students (student_id,class_id) VALUES (281,35);
INSERT INTO classes_students (student_id,class_id) VALUES (282,58);
INSERT INTO classes_students (student_id,class_id) VALUES (282,59);
INSERT INTO classes_students (student_id,class_id) VALUES (282,55);
INSERT INTO classes_students (student_id,class_id) VALUES (283,11);
INSERT INTO classes_students (student_id,class_id) VALUES (283,10);
INSERT INTO classes_students (student_id,class_id) VALUES (283,7);
INSERT INTO classes_students (student_id,class_id) VALUES (284,46);
INSERT INTO classes_students (student_id,class_id) VALUES (284,43);
INSERT INTO classes_students (student_id,class_id) VALUES (284,45);
INSERT INTO classes_students (student_id,class_id) VALUES (285,10);
INSERT INTO classes_students (student_id,class_id) VALUES (285,8);
INSERT INTO classes_students (student_id,class_id) VALUES (285,11);
INSERT INTO classes_students (student_id,class_id) VALUES (286,5);
INSERT INTO classes_students (student_id,class_id) VALUES (286,1);
INSERT INTO classes_students (student_id,class_id) VALUES (286,4);
INSERT INTO classes_students (student_id,class_id) VALUES (287,13);
INSERT INTO classes_students (student_id,class_id) VALUES (287,14);
INSERT INTO classes_students (student_id,class_id) VALUES (287,15);
INSERT INTO classes_students (student_id,class_id) VALUES (288,29);
INSERT INTO classes_students (student_id,class_id) VALUES (288,27);
INSERT INTO classes_students (student_id,class_id) VALUES (288,28);
INSERT INTO classes_students (student_id,class_id) VALUES (289,26);
INSERT INTO classes_students (student_id,class_id) VALUES (289,25);
INSERT INTO classes_students (student_id,class_id) VALUES (289,27);
INSERT INTO classes_students (student_id,class_id) VALUES (290,17);
INSERT INTO classes_students (student_id,class_id) VALUES (290,15);
INSERT INTO classes_students (student_id,class_id) VALUES (290,13);
INSERT INTO classes_students (student_id,class_id) VALUES (291,7);
INSERT INTO classes_students (student_id,class_id) VALUES (291,11);
INSERT INTO classes_students (student_id,class_id) VALUES (291,8);
INSERT INTO classes_students (student_id,class_id) VALUES (292,44);
INSERT INTO classes_students (student_id,class_id) VALUES (292,47);
INSERT INTO classes_students (student_id,class_id) VALUES (292,43);
INSERT INTO classes_students (student_id,class_id) VALUES (293,40);
INSERT INTO classes_students (student_id,class_id) VALUES (293,38);
INSERT INTO classes_students (student_id,class_id) VALUES (293,39);
INSERT INTO classes_students (student_id,class_id) VALUES (294,37);
INSERT INTO classes_students (student_id,class_id) VALUES (294,39);
INSERT INTO classes_students (student_id,class_id) VALUES (294,38);
INSERT INTO classes_students (student_id,class_id) VALUES (295,35);
INSERT INTO classes_students (student_id,class_id) VALUES (295,33);
INSERT INTO classes_students (student_id,class_id) VALUES (295,31);
INSERT INTO classes_students (student_id,class_id) VALUES (296,55);
INSERT INTO classes_students (student_id,class_id) VALUES (296,59);
INSERT INTO classes_students (student_id,class_id) VALUES (296,58);
INSERT INTO classes_students (student_id,class_id) VALUES (297,31);
INSERT INTO classes_students (student_id,class_id) VALUES (297,34);
INSERT INTO classes_students (student_id,class_id) VALUES (297,32);
INSERT INTO classes_students (student_id,class_id) VALUES (298,55);
INSERT INTO classes_students (student_id,class_id) VALUES (298,58);
INSERT INTO classes_students (student_id,class_id) VALUES (298,59);
INSERT INTO classes_students (student_id,class_id) VALUES (299,21);
INSERT INTO classes_students (student_id,class_id) VALUES (299,20);
INSERT INTO classes_students (student_id,class_id) VALUES (299,19);
INSERT INTO classes_students (student_id,class_id) VALUES (300,46);
INSERT INTO classes_students (student_id,class_id) VALUES (300,43);
INSERT INTO classes_students (student_id,class_id) VALUES (300,44);

/
commit;

-- selects
select * from locations order by 1;
select * from universities order by 1;
select * from faculties order by 1;
select * from students order by 1;
select * from professors order by 1;
select * from classes order by 1;
select * from classes_students order by 1;


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

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
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------


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

    



