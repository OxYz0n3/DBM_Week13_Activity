CREATE TABLE "Departements"(
"DepartementID" INTEGER NOT NULL, "DepartementName" TEXT NOT NULL,
  PRIMARY KEY("DepartementID")
);

CREATE TABLE "Projects"(
  "ProjectID" INTEGER NOT NULL,
  "ProjectName" TEXT NOT NULL,
  "DepartementID" INTEGER NOT NULL,
  PRIMARY KEY("ProjectID"),
  CONSTRAINT "Departements_Projects"
    FOREIGN KEY ("DepartementID") REFERENCES "Departements" ("DepartementID")
);

CREATE TABLE "Employees"(
  "EmployeeID" INTEGER NOT NULL,
  "Name" TEXT NOT NULL,
  "Position" TEXT NOT NULL,
  "DepartementID" INTEGER NOT NULL,
  "Salary" INTEGER NOT NULL,
  PRIMARY KEY("EmployeeID"),
  CONSTRAINT "Departements_Employees"
    FOREIGN KEY ("DepartementID") REFERENCES "Departements" ("DepartementID")
);

CREATE TABLE "Assigments"(
  "EmployeeID" INTEGER NOT NULL,
  "ProjectID" INTEGER NOT NULL,
  "HoursWorked" INTEGER,
  CONSTRAINT "Employees_Assigments"
    FOREIGN KEY ("EmployeeID") REFERENCES "Employees" ("EmployeeID"),
  CONSTRAINT "Projects_Assigments"
    FOREIGN KEY ("ProjectID") REFERENCES "Projects" ("ProjectID")
);

CREATE TRIGGER IF NOT EXISTS HoursWorkedTrigger
  AFTER INSERT ON Assignments
  BEGIN
    UPDATE Projects
    SET HoursWorked = (
        SELECT COALESCE(SUM(Assignments.HoursWorked), 0)
        FROM Assignments
        WHERE Assignments.ProjectID = NEW.ProjectID
    )
    WHERE ProjectID = NEW.ProjectID;
  END;

INSERT INTO "Departments" ("DepartmentID", "DepartmentName") VALUES
  (1, 'HR'),
  (2, 'Engineering'),
  (3, 'Marketing');

INSERT INTO "Projects" ("ProjectID", "ProjectName", "DepartmentID") VALUES
    (101, 'ProjectA', 2),
    (102, 'ProjectB', 2),
    (103, 'ProjectC', 3);

INSERT INTO "Employees" ("EmployeeID", "Name", "Position", "DepartmentID", "Salary") VALUES
    (1001, 'John Doe', 'Software Engineer', 2, 300),
    (1002, 'Jane Smith', 'HR Manager', 2, 400),
    (1003, 'Bob Johnson', 'Marketing Specialist', 3, 500),
    (1004, 'Alice Brown', 'HR Coordinator', 1, 350),
    (1005, 'Charlie Wilson', 'Software Developer', 2, 320),
    (1006, 'David Lee', 'Marketing Coordinator', 3, 450),
    (1007, 'Emma Davis', 'Recruitment Specialist', 1, 380),
    (1008, 'Frank White', 'System Architect', 2, 420),
    (1009, 'Grace Miller', 'Marketing Manager', 3, 550),
    (1010, 'Henry Johnson', 'Software Tester', 2, 340);

INSERT INTO "Assignments" ("EmployeeID", "ProjectID", "HoursWorked") VALUES
    (1001, 101, 20),
    (1002, 103, 15),
    (1003, 102, 25),
    (1004, 101, 10),
    (1005, 102, 18),
    (1006, 103, 22),
    (1007, 101, 12),
    (1008, 102, 16),
    (1009, 103, 30),
    (1010, 101, 14);

SELECT Name, ProjectName FROM Employees
   INNER JOIN
   Departments
   ON Employees.DepartmentID = Departments.DepartmentID
   INNER JOIN
   Projects
   ON Projects.DepartmentID = Departments.DepartmentID;

WITH total AS (
  SELECT
    AVG(Salary) AS AverSalary,
    DepartmentID
  FROM Employees
  GROUP BY DepartmentID
  )
  SELECT DepartmentName, AverSalary FROM total
  INNER JOIN Departments ON Departments.DepartmentID=total.DepartmentID
  ORDER BY AverSalary DESC LIMIT 1;

SELECT
  Name,
  Salary,
  Departments.DepartmentName,
  RANK() OVER (PARTITION BY Departments.DepartmentName ORDER BY Salary DESC) AS RankEmployeesSalary
  FROM
    Employees
  JOIN
    Departments on Employees.DepartmentID = Departments.DepartmentID;

SELECT ProjectName, HoursWorked FROM Projects ORDER BY HoursWorked DESC;