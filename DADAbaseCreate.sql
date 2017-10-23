/*CREATE DATABASE DADAbase;

USE DADAbase;
*/
CREATE TABLE sequence(
    accessNum INT NOT NULL AUTO_INCREMENT,
    sequence VARCHAR(400),
    taxonomy VARCHAR(400),
    taxoMethod VARCHAR(100),
    runNum INT,
    groupNum INT,
    PRIMARY KEY(accessNum)
);

CREATE TABLE runNum(
    runNum INT,
    groupNum INT
);

CREATE TABLE entry(
    runNum INT NOT NULL AUTO_INCREMENT,
    entryDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    platform varchar(100),
    operator varchar(100),
    PRIMARY KEY(runNum)
);
