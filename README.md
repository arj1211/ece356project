# ece356project
- when running on marmoset server, change data source path to `'/var/lib/mysql-files/21-Network-Traffic/Dataset-Unicauca-Version2-87Atts.csv'` in *populateDB.sql*
- when running locally, enable `SET GLOBAL local_infile=1;` in *populateDB.sql*
- run *clientapp.py* with python 3.9
- *clientapp.py* relies on `mysql.connector` python library
- change `hosturl` in *clientapp.py* to `marmoset04.shoshin.uwaterloo.ca` if running on marmoset
- when running locally, run `create database internet_traffic` before creating/populating tables

- note: edit configuration in *populateDB.sql* before running
```
    # change to marmoset04.shoshin.uwaterloo.ca if running on marmoset
    hosturl_ = 'localhost'
    # change to correct username
    user_="root"
    # change to correct password
    password_="Password123!"
    # change to db356_<userid> if running on marmoset
    database_="internet_traffic"
```