
CREATE TABLE "Department" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Employee" (
    "emp_no" VARCHAR(10)   NOT NULL,
    "title_id" VARCHAR(20)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(25)   NOT NULL,
    "sex" CHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employee" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salary" (
    "emp_no" VARCHAR(10)   NOT NULL,
    "salary" INTEGER   NOT NULL,
    CONSTRAINT "pk_Salary" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Title" (
    "title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Title" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "DepartmentEmployees" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_DepartmentEmployees" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "DepartmentManagers" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_DepartmentManagers" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

ALTER TABLE "Employee" ADD CONSTRAINT "fk_Employee_title_id" FOREIGN KEY("title_id")
REFERENCES "Title" ("title_id");

ALTER TABLE "Salary" ADD CONSTRAINT "fk_Salary_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employee" ("emp_no");

ALTER TABLE "DepartmentEmployees" ADD CONSTRAINT "fk_DepartmentEmployees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

ALTER TABLE "DepartmentEmployees" ADD CONSTRAINT "fk_DepartmentEmployees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employee" ("emp_no");

ALTER TABLE "DepartmentManagers" ADD CONSTRAINT "fk_DepartmentManagers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

ALTER TABLE "DepartmentManagers" ADD CONSTRAINT "fk_DepartmentManagers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employee" ("emp_no");


SELECT 
    E.emp_no, 
    E.last_name, 
    E.first_name, 
    E.sex, 
    S.salary
FROM 
    "Employee" E
JOIN 
    "Salary" S ON E.emp_no = S.emp_no;
	

SELECT 
	first_name, 
	last_name, 
	hire_date 
FROM "Employee" 
WHERE hire_date 
BETWEEN '1986-01-01' AND '1986-12-31';


SELECT 
	D.dept_no, 
	D.dept_name, 
	M.emp_no,
	E.last_name, 
	E.first_name 
FROM "Department" D 
JOIN "DepartmentManagers" M 
ON D.dept_no = M.dept_no 
JOIN "Employee" E 
ON M.emp_no = E.emp_no;


SELECT 
	DE.dept_no,
	DE.emp_no,
	E.last_name,
	E.first_name,
	D.dept_name
FROM "DepartmentEmployees" DE 
JOIN "Employee" E 
ON DE.emp_no = E.emp_no 
JOIN "Department" D 
ON DE.dept_no = D.dept_no;


SELECT 
	first_name,
	last_name,
	sex 
FROM "Employee" 
WHERE first_name = 'Hercules' 
AND last_name 
LIKE 'B%';


SELECT 
	E.emp_no,
	E.last_name,
	E.first_name
FROM "Employee" E 
JOIN "DepartmentEmployees" DE 
ON E.emp_no = DE.emp_no 
JOIN "Department" D 
ON DE.dept_no = D.dept_no 
WHERE D.dept_name = 'Sales';


SELECT 
	E.emp_no,
	E.last_name,
	E.first_name,
	D.dept_name 
FROM "Employee" E 
JOIN "DepartmentEmployees" DE 
ON E.emp_no = DE.emp_no 
JOIN "Department" D 
ON DE.dept_no = D.dept_no 
WHERE D.dept_name 
IN ('Sales', 'Development');


SELECT last_name,
COUNT(*) AS frequency 
FROM "Employee" 
GROUP BY last_name 
ORDER BY frequency DESC;