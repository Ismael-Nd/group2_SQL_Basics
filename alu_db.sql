
-- THE ALU DATABASE — GROUP 2
-- Members: Ismael, Grace, Joy, Blair, Christa, Hassan, Rosanne

-- 1. DATABASE (Rosanne)
CREATE DATABASE group2_alu_db;
USE group2_alu_db;

-- 2. CREATE TABLES (in dependency order!)

-- STUDENTS TABLE (Ismael)
-- ===== STUDENTS TABLE (Ismael) =====
CREATE TABLE Students (
    student_id       INT PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(100),
    email            VARCHAR(100),
    classroom_id     INT,
    enrollment_date  DATE,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);;

-- CLASSROOM TABLE (Grace)
CREATE TABLE Classroom ( ... );

-- FACULTY TABLE (Joy) 
CREATE TABLE Faculty ( 
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(50)
);

-- COURSES TABLE (Blair)
CREATE TABLE Courses ( ... );

-- EXTRA_CURRICULAR_ACTIVITIES TABLE (Christa)
CREATE TABLE Extra_Curricular_Activities ( ... );

-- JUNCTION TABLES (Hassan)
CREATE TABLE Student_Courses ( ... );
CREATE TABLE Student_Activities ( ... );

-- 3. INSERT STATEMENTS

-- Ismael: insert into Students 
INSERT INTO Students (name, email, classroom_id, enrollment_date) VALUES
('Kayirnaga Uwase',  'uwase@gmail.com',      1, '2025-09-01'),
('Aline Mugisha',    'mugisha@gmail.com',    2, '2025-09-01'),
('Ismail Niyonzima', 'niyonzima@gmail.com',  1, '2026-01-15'),
('Hassan Karim',     'h.karim@gmail.com',    3, '2026-01-15'),
('Brian Habimana',   'habimana@gmail.com',   2, '2025-09-01'),
('Grace Ingabire',   'g.ingabire@gmail.com', 3, '2026-01-15');;

-- Grace: insert into Classroom
INSERT INTO Classroom ...;

-- Joy: insert into Faculty
INSERT INTO Faculty (name, email, department) VALUES  
('Dr. ALice Smith', 'alice.smith@alueducation.com', 'Computer Science'),
('John Allen', 'johnallen@alueducation.com', 'Software Engineering'),
('Simeon Karekezi', 'simeonkare@alueducation.com', 'Leadership Skills'),
('Belyse Keza', 'belysekez@alueducation.com', 'Communication'),
('Jane Mukamana', 'janemukamana@alueducation.com', 'Business');

-- (and so on for each member)



-- 4. INDIVIDUAL UPDATE / DELETE / SELECT (labeled by name)

-- Ismael: UPDATE — fix a student's email
UPDATE Students SET email = 'uwase@alu.com' WHERE student_id = 1;

-- Ismael: DELETE — remove one student
DELETE FROM Students WHERE student_id = 6;

-- Ismael: SELECT — students who enrolled in 2025
SELECT name, email FROM Students WHERE enrollment_date < '2026-01-01';
-- (each member adds theirs the same way)
-- Joy: UPDATE - Change Dr. Alice Smith's email
UPDATE Faculty
SET email = 'dr.alice.smith@alueducation.com'
WHERE name = 'Dr. Alice Smith';

-- Joy : DELETE - remove John Allen
DELETE FROM Faculty
WHERE name = 'John Allen';

--Joy : SELECT - Faculty in the Business department
SELECT name, email
FROM Faculty
WHERE department = 'Business';
-- 5. GROUP QUERIES

-- Join query 1 (Ismael + Blair): student → course → faculty → classroom

-->

-- Join query 2 (Grace + Joy): student → activity → faculty

-->

-- Join query 3 (Rosanne): our choice

-->

-- Aggregate query (Rosanne + Hassan): COUNT / GROUP BY

-->


-- 6. NORMALIZATION PARAGRAPH (Christa drafts, team reviews)


-- Our tables avoid duplication because... [short paragraph as a comment]

