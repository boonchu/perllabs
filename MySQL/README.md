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
```
