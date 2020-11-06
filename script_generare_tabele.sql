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
  location_id NUMBER(10)    CONSTRAINT universtiy_location_fk REFERENCES locations(location_id)
);

CREATE TABLE faculties (
  faculty_id NUMBER(10)     CONSTRAINT faculty_pk PRIMARY KEY,
  university_id NUMBER(10)  CONSTRAINT faculty_university_fk REFERENCES universities(university_id),
  location_id NUMBER(10)    CONSTRAINT faculty_location_fk REFERENCES locations(location_id)
);

CREATE TABLE students (
  student_id NUMBER(10) constraint student_pk PRIMARY KEY,
  first_name VARCHAR2(25) CONSTRAINT student_first_name_nn NOT NULL,
  last_name VARCHAR2(25) CONSTRAINT student_last_name_nn NOT NULL,
  email VARCHAR2(25),
  phone_number NUMBER(15),
  faculty_id NUMBER(10) CONSTRAINT student_faculty_fk REFERENCES faculties(faculty_id)
);

CREATE TABLE professors (
  professor_id NUMBER(10)   CONSTRAINT professor_pk PRIMARY KEY,
  first_name VARCHAR2(25)   CONSTRAINT professor_first_name_nn NOT NULL,
  last_name VARCHAR2(25)    CONSTRAINT professor_last_name_nn NOT NULL,
  email VARCHAR2(25),
  phone_number NUMBER(15),
  faculty_id NUMBER(10)     CONSTRAINT professor_faculty_fk REFERENCES faculties(faculty_id)
);

CREATE TABLE classes (
  class_id NUMBER(10)       CONSTRAINT class_pk PRIMARY KEY,
  class_name VARCHAR2(32)   CONSTRAINT class_name_nn NOT NULL,
  professor_id NUMBER(10)   CONSTRAINT class_professor_fk REFERENCES professors(professor_id)
);

CREATE TABLE classes_students (
  student_id NUMBER(10) CONSTRAINT class_student_student_fk REFERENCES students(student_id),
  class_id NUMBER(10)   CONSTRAINT class_student_class_fk REFERENCES classes(class_id),
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