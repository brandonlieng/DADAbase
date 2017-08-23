INSERT INTO archivedSeqs
SELECT sequence, accessionNum, taxonomy, taxoKeys, foundInRuns
FROM newSeqs;
