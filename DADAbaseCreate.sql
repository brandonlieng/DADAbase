/*CREATE DATABASE DADAbase;

USE DADAbase;
*/
CREATE TABLE Sequence(
    accessNum INTEGER PRIMARY KEY,
    sequence VARCHAR(400) UNIQUE,
    taxonomy VARCHAR(400),
    taxoMethod VARCHAR(100),
    primers VARCHAR(10),
    annealingTemp INTEGER,
    doi VARCHAR(30),
    groupNum INTEGER
);

CREATE TABLE Entry(
    runNum INTEGER PRIMARY KEY,
    entryDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    platform VARCHAR(100),
    operator VARCHAR(100)
);

CREATE TABLE SequenceInEntry(
    accessNum INTEGER,
    runNum INTEGER,
    groupNum INTEGER,
    CONSTRAINT accessNum
    FOREIGN KEY (accessNum) REFERENCES Sequence (accessNum)
    ON DELETE CASCADE,
    CONSTRAINT runNum
    FOREIGN KEY (runNum) REFERENCES Entry (runNum)
    ON DELETE CASCADE
);
