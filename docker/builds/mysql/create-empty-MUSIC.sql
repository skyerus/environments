CREATE MUSIC IF NOT EXISTS MUSIC DEFAULT CHARACTER SET utf8_bin;

GRANT ALL ON *.* TO 'music'@'%' IDENTIFIED BY 'music';

FLUSH PRIVILEGES;