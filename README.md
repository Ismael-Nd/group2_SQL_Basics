# group2_SQL_Basics
MySQL relational database for a school system: Students, Classroom, Faculty, Courses, Extra_Curricular_Activities, plus two junction tables.

## Members & tables
| Members | Table                               |
|---------|-------------------------------------|
| Ismael  | Students (+ database setup)         |
| Grace   | Classroom                           |
| Joy     | Faculty                             |
| Blair   | Courses                             |
| Christa | Extra_Curricular_Activities         |
| Hassan  | Student_Courses, Student_Activities |
| Rosanne | Coordination, group queries         |

## How to run
Execute "alu_db.sql" top to bottom on a MySQL 8+ server: "mysql -h <host> -P <port> -u <user> -p --ssl-mode=REQUIRED < alu_db.sql"
