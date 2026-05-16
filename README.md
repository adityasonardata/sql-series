LEARN SQL — Zero to Advanced

A free, structured SQL course for beginners to advanced learners.

Built for students, aspiring data analysts, and developers who want to get job-ready with SQL.

📺 Watch the full series: 

https://youtube.com/playlist?list=PLDmT8j6JZFAPnQ6MWiekhcAEnS_yanxAq&si=Y-jv1Dkeeqi9mtwX

🗃️ Database Used
We use a single Online Store database across all 12 episodes.

3 tables — Customers, Products, Orders

store_db

├── customers   (100 rows)

├── products    (30 rows)

└── orders      (100 rows)

Download datasets → /datasets

⚠️ Always import CSV files in this order:

Customers → Products → Orders

(Orders has foreign keys referencing both other tables)

🚀 How to Get Started

Step 1 — Clone or download this repo

bashgit clone https://github.com/yourusername/sql-for-data-analysts.git

Step 2 — Open MySQL Workbench

Step 3 — Create the database
sqlCREATE DATABASE store_db;
USE store_db;

Step 4 — Run scripts to create the tables

Step 5 — Import CSV files from the /datasets folder

Step 6 — Follow along episode by episode

🛠️ Tools Required

Tool | MySQL8.0+mysql.com/downloads | MySQL Workbench8.0 + Included with MySQL installer

Both are free and available for Windows, Mac, and Linux.


💡 How to Use This Repo

1. Each episode has its own folder with .sql files
   
2. Files are numbered and named by topic — open them in order
   
3. Every file has detailed comments explaining what each query does
   
4. Follow along with the YouTube video for full explanation
   
5. Each folder has its own README with concepts, tables and quick reference


📋 SQL Commands Covered
DDL   →  CREATE, ALTER, DROP, TRUNCATE

DML   →  INSERT, UPDATE, DELETE

DQL   →  SELECT, WHERE, GROUP BY, ORDER BY, HAVING

JOINS →  INNER, LEFT, RIGHT, FULL OUTER, SELF, CROSS

SET   →  UNION, UNION ALL

ADV   →  Subqueries, Window Functions, CTEs, Recursive CTEs

🤝 Contributing

Found an error or typo in the SQL files?

Open an Issue describing the problem
Or submit a Pull Request with the fix

⭐ Support the Series

⭐ Star this repository

👍 Like the videos on YouTube

🔔 Subscribe to the channel for new episodes

💬 Share with someone who is learning SQL
