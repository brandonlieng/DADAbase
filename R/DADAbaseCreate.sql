CREATE DATABASE DADAbase;

USE DADAbase;

/*
archivedSeqs    holds an archive of sequence variants from previous data
incoming        holds the incoming data to be split and analyzed using DADAbase
newSeqs         holds sequence variants that do not show up in existingSeqs
oldSeqs      holds sequence variants that show up in existingSeqs
*/
CREATE TABLE archivedSeqs(
    sequence VARCHAR(400),
    accessionNum INT,
    taxonomy VARCHAR(400),
    taxoKeys VARCHAR(100),
    foundInRuns VARCHAR(50),
    PRIMARY KEY (sequence)
);

CREATE TABLE incoming(
    sequence VARCHAR(400),
    accessionNum INT,
    taxonomy VARCHAR(400),
    taxoKeys VARCHAR(100),
    foundInRuns VARCHAR(50),
    PRIMARY KEY (sequence)
);

CREATE TABLE newSeqs(
sequence VARCHAR(400),
accessionNum INT,
taxonomy VARCHAR(400),
taxoKeys VARCHAR(100),
foundInRuns VARCHAR(50),
PRIMARY KEY (sequence)
);

CREATE TABLE oldSeqs(
sequence VARCHAR(400),
accessionNum INT,
taxonomy VARCHAR(400),
taxoKeys VARCHAR(100),
foundInRuns VARCHAR(50),
PRIMARY KEY (sequence)
);
