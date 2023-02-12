# Crowdfunding-ETL
##Overview
This assignment's approach is to combine all the acquired knowledge from SQL and ETL to be applied to a real case. For this reason, the hipothetic company named "Independent Funding" loves what me and Britta (hipothetic character) have done with both the crowdfunding ETL project and the SQL data analysis, but a more in depth study has to be done applying all the ETL techniques learnt in class, so after clean the data, some queries will be done using PostgreSQL.

This assignment is compound by these 4 deliverables:

*Deliverable 1: Extract Data
--All the alphanumeric strings where extracted.
--The numeric "cf_id" string identification number is extracted without extra characters.
--The "name" string value is extracted without extra characters.
--The "email" string value is extracted without extra characters.
--A DataFrame is created with the following columns: "backer_id", "cf_id", "name", and "email".
--Each column in the DataFrame contains the appropriate data.

*Deliverable 2: Transform and Clean Data
--The "cf_id" column is converted to int64. 
--The "name" column is split into "first_name" and "last_name" columns that are added to the DataFrame. 
--The "name" column is dropped from the DataFrame.
--The columns are reordered and then the DataFrame is exported as backers.csv.

*Deliverable 3: Create an ERD and Table Schema, and Load Data
--The crowdfunding_db relationship diagram has five tables, and the diagram is saved as crowdfunding_db_relationships.png.
--The crowdfunding_db_schema.sql file contains the table schema and the ALTER TABLE statement for each of the five tables; and the backers.csv file is imported into the backers table without any errors.

*Deliverable 4: SQL Analysis
--A SQL query is written and successfully executed that retrieves the number of backer_counts in descending order for each cf_id and for all the live campaigns. (2.5 pt)
--A SQL query is written and successfully executed that retrieves the number of backers in descending order for each cf_id from the backers table. (2.5 pt)
--A SQL query is written and successfully executed to create the email_contacts_remaining_goal_amount table, and the table is exported as email_contacts_remaining_goal_amount.csv.
--A SQL query is written and successfully executed to create the email_backers_remaining_goal_amount table, and the table is exported as email_contacts_remaining_goal_amount.csv.

--*All these files and analysis can be found in the repo*--
