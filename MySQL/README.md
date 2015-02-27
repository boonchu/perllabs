###### MariaDB database server
* install mariadb 
```
$ sudo yum groupinstall mariadb mariadb-client
$ sudo systemctl enable mariadb
$ sudo systemctl start mariadb
```
* turn off firewalld and disable selinux 
* setup mariadb to disallow root access, no anonymous, etc.
```
$ sudo mysql_secure_installation
```
* client in database server still can access with root user.
```
$ mysql -u root -h localhost -predhat
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 13
Server version: 5.5.41-MariaDB MariaDB Server

Copyright (c) 2000, 2014, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]>
```
* how-to: [create database](https://mariadb.com/kb/en/mariadb/create-database/)
```
MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS webdb;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| webdb              |
+--------------------+
4 rows in set (0.00 sec)
```
* how-to: [database user access](https://mariadb.com/kb/en/mariadb/create-user/)
  - ideally, application users request for CRUD (CREATE, READ, UPDATE, DELETE) access.
```
MariaDB [(none)]> GRANT INSERT,SELECT,UPDATE,DELETE ON webdb.* TO 'webuser'@'192.168.1.%' IDENTIFIED BY 'app123';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> SELECT User, Host FROM mysql.user WHERE Host <> 'localhost';
+---------+-------------+
| User    | Host        |
+---------+-------------+
| root    | 127.0.0.1   |
| webuser | 192.168.1.% |
| root    | ::1         |
+---------+-------------+
3 rows in set (0.00 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;

it works from client.
bigchoo@vmk1 1003 $ mysql -u webuser -h192.168.1.101 -papp123
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 17
Server version: 5.5.41-MariaDB MariaDB Server

Copyright (c) 2000, 2014, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]>
```
* how-to: [create schema tables by workbench](http://dev.mysql.com/doc/workbench/en/wb-installing-mac.html)
  - grant admin user access for workbench to access
```
MariaDB [(none)]> GRANT ALL ON webdb.* TO 'webadmin'@'192.168.1.151' IDENTIFIED BY 'admin123';
Query OK, 0 rows affected (0.00 sec)
```

  - add new connection from workbench app
![Connection](https://github.com/boonchu/perllabs/blob/master/MySQL/Connection.png)
![Workbench_front](https://github.com/boonchu/perllabs/blob/master/MySQL/Workbench_front.png)
  - [Model new data](http://dev.mysql.com/doc/workbench/en/wb-getting-started-tutorial-creating-a-model.html)
  - This is simple ER tool ever! Once I have done the ER diagram, I pushed it to live Database that I prepared.
![ER](https://github.com/boonchu/perllabs/blob/master/MySQL/ER.png)
```
MariaDB [(none)]> use webdb;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MariaDB [webdb]> select * from links;
+---------+------------------------------------+----------------------+--------+
| link_id | title                              | url                  | target |
+---------+------------------------------------+----------------------+--------+
|       0 | Comprehensive Perl Archive Network | http://www.cpan.org/ | _blank |
+---------+------------------------------------+----------------------+--------+
1 row in set (0.00 sec)

MariaDB [webdb]> select * from tags;
+--------+------+
| tag_id | tag  |
+--------+------+
|      0 | Perl |
+--------+------+
1 row in set (0.00 sec)

MariaDB [webdb]> select * from link_tags;
+---------+--------+
| link_id | tag_id |
+---------+--------+
|       0 |      0 |
+---------+--------+
1 row in set (0.00 sec)
```
* what if I run again? when it commits, it falls back.
```
bigchoo@vmk1 1063 $ ./db.pl
Perl MySQL Transaction Demo
DBD::mysql::st execute failed: Duplicate entry '0' for key 'PRIMARY' at ./db.pl line 26.
Error inserting the link and tag: DBD::mysql::st execute failed: Duplicate entry '0' for key 'PRIMARY' at ./db.pl line 26.
```
