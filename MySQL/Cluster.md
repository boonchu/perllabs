###### MySQL cluster setup
* setup master 
  * edit /etc/my.cnf
```
[mysqld]
log-bin = mysql-bin
server-id = 1
```
  * add replicator account
```
MariaDB [(none)]> GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO replicator@'192.168.1.%' IDENTIFIED BY 'password';
```
  * dump files from master
```
mysqldump -u root -p password --all-databases --master-data=2 > /root/dbdump.db
```
* setup slave
  * edit /etc/my.cnf
```
[mysqld]

log-bin = mysql-bin
server-id = 2
relay-log = mysql-relay-bin
log-slave-updates = 1
read-only = 1
```
  * restore from dump file
```
$ mysql -u root -p password < /tmp/dbdump.db
```
