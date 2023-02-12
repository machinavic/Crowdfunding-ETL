-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/dlKkBe
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "campaign" (
    "cf_id" int   NOT NULL,
    "contact_id" int   NOT NULL,
    "company_name" varchar(100)   NOT NULL,
    "description" text   NOT NULL,
    "goal" numeric(10,2)   NOT NULL,
    "pledged" numeric(10,2)   NOT NULL,
    "outcome" varchar(50)   NOT NULL,
    "backers_count" int   NOT NULL,
    "country" varchar(10)   NOT NULL,
    "currency" varchar(10)   NOT NULL,
    "launch_date" date   NOT NULL,
    "end_date" date   NOT NULL,
    "category_id" varchar(10)   NOT NULL,
    "subcategory_id" varchar(10)   NOT NULL,
    CONSTRAINT "pk_campaign" PRIMARY KEY (
        "cf_id"
     )
);

CREATE TABLE "category" (
    "category_id" varchar(10)   NOT NULL,
    "category_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_category" PRIMARY KEY (
        "category_id"
     )
);

CREATE TABLE "subcategory" (
    "subcategory_id" varchar(10)   NOT NULL,
    "subcategory_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_subcategory" PRIMARY KEY (
        "subcategory_id"
     )
);

CREATE TABLE "contacts" (
    "contact_id" int   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "pk_contacts" PRIMARY KEY (
        "contact_id"
     )
);

CREATE TABLE "backers" (
    "backer_id" varchar(10)   NOT NULL,
    "cf_id" int   NOT NULL,
	"first_name" varchar(50) NOT NULL,
	"last_name" varchar(50) NOT NULL,
	"email" varchar(100) NOT NULL,
    CONSTRAINT "pk_backers" PRIMARY KEY (
        "backer_id"
		)
);


ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_contact_id" FOREIGN KEY("contact_id")
REFERENCES "contacts" ("contact_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_category_id" FOREIGN KEY("category_id")
REFERENCES "category" ("category_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_subcategory_id" FOREIGN KEY("subcategory_id")
REFERENCES "subcategory" ("subcategory_id");

ALTER TABLE "backers" ADD CONSTRAINT "fk_backers_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");


SELECT * FROM campaign;
SELECT * FROM category;
SELECT * FROM contacts;
SELECT * FROM subcategory;
SELECT * FROM backers;


-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT backers_count,
	outcome,
	cf_id
FROM campaign
WHERE outcome = 'live'
ORDER BY cf_id desc;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cam.backers_count,
	cam.outcome,
	cam.cf_id
FROM campaign AS cam;

SELECT bac.backer_id	
FROM backers AS bac;

SELECT cam.backers_count,
	cam.outcome,
	cam.cf_id,
	bac.backer_id
FROM campaign AS cam
RIGHT JOIN backers AS bac
ON cam.cf_id = bac.cf_id
WHERE cam.outcome = 'live'
ORDER BY cf_id DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

ALTER TABLE campaign
ADD "RGA" numeric;

UPDATE campaign
SET "RGA" = goal - pledged;

SELECT "RGA" FROM campaign;

SELECT con.first_name, con.last_name, con.email
FROM contacts as con;

SELECT cam."RGA", cam.outcome
FROM campaign as cam;

SELECT con.first_name,
	con.last_name,
	con.email,
	cam."RGA"
INTO email_contacts_goal_amount
FROM campaign as cam
right JOIN contacts as con
ON con.contact_id = cam.contact_id
WHERE outcome = 'live'
ORDER BY "RGA" DESC;

-- Check the table
SELECT * FROM email_contacts_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT bac.email, bac.first_name, bac.last_name,
	bac.cf_id
FROM backers as bac;

SELECT cam.company_name, cam.description, cam.end_date,
	cam."RGA"
FROM campaign as cam;

SELECT bac.email, bac.first_name, bac.last_name,
	bac.cf_id,cam.company_name, cam.description,
	cam.end_date,cam."RGA"
INTO email_backers_remaining_goal_amount
FROM campaign as cam
RIGHT JOIN backers as bac
ON cam.cf_id = bac.cf_id
ORDER BY bac.email DESC;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

