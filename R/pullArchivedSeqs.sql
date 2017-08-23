SELECT
sequence, accessionNum, taxonomy, taxoKeys, foundInRuns
FROM archivedSeqs
WHERE sequence IN (SELECT sequence FROM oldSeqs);
