-- auto increment - https://www.w3schools.com/sql/sql_autoincrement.asp
-- delete content from tables
DELETE FROM classes;
DELETE FROM classes_students;
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
-- VALUES
-- locations
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
INSERT INTO locations (location_id) VALUES (seq_location.nextval);
-- view values
select * from locations;

commit;