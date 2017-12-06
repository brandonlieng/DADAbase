CREATE TABLE Sequence(
    seqID INTEGER NOT NULL PRIMARY KEY,
    sequence VARCHAR(400) UNIQUE,
    primaryassign INTEGER,

    CONSTRAINT primaryassign
    FOREIGN KEY (primaryassign) REFERENCES Assignment (taxoID)
    ON DELETE CASCADE
);

CREATE TABLE Taxonomy(
    taxoID INTEGER NOT NULL PRIMARY KEY,
    RID INTEGER,
    sourcedatabase VARCHAR(50),
    kingdom VARCHAR(25),
    phylum VARCHAR(25),
    class VARCHAR(25),
    "order" VARCHAR(25),
    family VARCHAR(25),
    genus VARCHAR(25),
    species VARCHAR(25)
);

CREATE TABLE Assignment(
    seqID INTEGER,
    taxoID INTEGER,
    primers VARCHAR(10),
    doi VARCHAR(50),

    PRIMARY KEY (seqID, taxoID),

    CONSTRAINT seqID
    FOREIGN KEY (seqID) REFERENCES Sequence (seqID)
    ON DELETE CASCADE,

    CONSTRAINT runID
    FOREIGN KEY (taxoID) REFERENCES Taxonomy (taxoID)
    ON DELETE CASCADE
);

CREATE TABLE Run(
    runID INTEGER PRIMARY KEY,
    entrydate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    operator VARCHAR(100),
    platform VARCHAR(100)
);

CREATE TABLE Log(
    seqID INTEGER,
    runID INTEGER,
    groupID INTEGER,

    PRIMARY KEY (seqID, runID),

    CONSTRAINT seqID
    FOREIGN KEY (seqID) REFERENCES Sequence (seqID)
    ON DELETE CASCADE,

    CONSTRAINT runID
    FOREIGN KEY (runID) REFERENCES Run (runID)
    ON DELETE CASCADE
);
