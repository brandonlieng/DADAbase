/*CREATE DATABASE DADAbase;

USE DADAbase;


archivedSeqs    holds an archive of sequence variants from previous data
incoming        holds the incoming data to be split and analyzed using DADAbase
newSeqs         holds sequence variants that do not show up in existingSeqs
oldSeqs      holds sequence variants that show up in existingSeqs
*/
CREATE TABLE archivedSeqs(
    accessionNum INT NOT NULL AUTO_INCREMENT,
    sequence VARCHAR(400),
    taxonomy VARCHAR(400),
    taxoKeys VARCHAR(100),
    entryNum INT,
    PRIMARY KEY(accessionNum)
);

CREATE TABLE knownSeqs(
    sequence VARCHAR(400)
);

CREATE TABLE incoming(
    sequence VARCHAR(400),
    taxonomy VARCHAR(400),
    taxoKeys VARCHAR(100),
    entryNum INT
);

CREATE TABLE newSeqs(
sequence VARCHAR(400),
taxonomy VARCHAR(400),
taxoKeys VARCHAR(100),
entryNum INT
);
