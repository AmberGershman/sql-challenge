-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(100)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emps" (
    "emp_no" int   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" VARCHAR(100)   NOT NULL,
    "last_name" VARCHAR(100)   NOT NULL,
    "sex" VARCHAR(2)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(100)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);


ALTER TABLE "dept_emps" ADD CONSTRAINT "fk_dept_emps_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emps" ADD CONSTRAINT "fk_dept_emps_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Question 1: Return all employees
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
left join salaries as s
on e.emp_no = s.emp_no;

--Question 2: Employee hires from 1986
SELECT first_name, last_name, hire_date
FROM employees 
WHERE hire_Date BETWEEN '1986-01-01' AND '1986-12-31';

--Question 3: Manager by Department
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
left join departments as d
on dm.dept_no = d.dept_no
left join employees as e
on e.emp_no = dm.emp_no;

--Question 4: Employees by Department
SELECT e.emp_no, e.last_name, e.first_name, dn.dept_name
FROM employees as e
left join dept_emps as de
on de.emp_no = e.emp_no
left join departments as dn
on de.dept_no = dn.dept_no;

--Question 5: Employees named "Hercules B.."
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

--Question 6: Employees by Department: Sales
SELECT e.emp_no, e.last_name, e.first_name, dn.dept_name
from employees as e 
left join dept_emps as de
on e.emp_no = de.emp_no
left join departments as dn 
on de.dept_no = dn.dept_no
where dn.dept_name = 'Sales';

--Question 7: Employees by Department: Sales and Development
SELECT e.first_name, e.last_name, dn.dept_name
from employees as e 
left join dept_emps as de
on e.emp_no = de.emp_no
left join departments as dn 
on de.dept_no = dn.dept_no
where dn.dept_name = 'Development' OR dn.dept_name = 'Sales';

--Question 8: Frequency of Last Names in Descending Order
SELECT last_name, count(last_name)
from employees 
group by last_name
order by count(last_name) desc;