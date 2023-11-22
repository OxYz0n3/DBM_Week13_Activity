# Company Database Management

## Overview

This Python script demonstrates the creation and management of a company database using SQLite. The database includes tables for departments, projects, employees, and assignments. The script also incorporates SQL queries to retrieve relevant information from the database.

## Prerequisites

- Python 3
- SQLite3

## Relationships

![alt text](https://github.com/OxYz0n3/DBM_Week13_Activity/main/screen.png?raw=true)

## Instructions

1. **Database Setup**: The script begins by creating a SQLite database named "company.db" if it does not already exist.

2. **Table Creation**: The script defines four tables - "Departments," "Projects," "Employees," and "Assignments" - along with necessary foreign key constraints.

3. **Trigger Creation**: A trigger named "HoursWorkedTrigger" is implemented to update the "HoursWorked" column in the "Projects" table whenever new assignments are inserted.

4. **Data Insertion**: Sample data is inserted into the "Departments," "Projects," "Employees," and "Assignments" tables to demonstrate the functionality.

5. **Query Examples**: The script includes various SQL queries to extract specific information from the database, such as:
   - List of employees and their assigned projects.
   - Average salary by department, ordered by the highest average salary.
   - Ranking of employees within each department based on salary.

2. Review the output to observe the results of the executed SQL queries.

## Dependencies

- SQLite3: The script utilizes SQLite as a lightweight relational database management system.

- Pandas: Used for handling and displaying query results in tabular format.

## Contributors

- [Cyprien SINGEZ]
- [Antoine VAN GORP]
- [Clément Monteiro]
- [Mahé Faure]
