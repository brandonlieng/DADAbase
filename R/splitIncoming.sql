/*
Push new sequences in the incoming data to newSeqs
*/
INSERT INTO newSeqs SELECT
sequence, accessionNum, taxonomy, taxoKeys, foundInRuns
FROM incoming
WHERE sequence NOT IN (SELECT sequence FROM archivedSeqs);

/*
Opposite for old variants
*/
INSERT INTO oldSeqs SELECT
sequence, accessionNum, taxonomy, taxoKeys, foundInRuns
FROM incoming
WHERE sequence IN (SELECT sequence FROM archivedSeqs);
