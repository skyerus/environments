USE mysql;

UPDATE user SET host='%' WHERE user='root' AND host='localhost';

SELECT host,user FROM user;

FLUSH PRIVILEGES;
