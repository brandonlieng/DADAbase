# DADAbase is...
A simple SQL database set up for the archiving of sequence variants identified through the DADA2 pipeline. Sequences are stored with annotation information and keywords specifying tools used in annotation. Functions written in R can query the SQL database to extract information from the archive and commit new sequences to archive.

Install the package using:

```
install.packages('devtools')
devtools::github_install('brandonlieng/DADAbase/DADAbase')
```

See the Wiki section for a run-through of how to interact with DADAbase.
