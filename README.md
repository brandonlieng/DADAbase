# DADAbase is...
A simple SQL database set up for the archiving of sequence variants identified through the DADA2 pipeline. Sequences are stored with annotation information and keywords specifying tools used in annotation. Functions written in R can query the SQL database to extract information from the archive and commit new sequences to archive.

Install the package using:

```
install.packages('devtools')
devtools::github_install('brandonlieng/DADAbase/DADAbase')
```


## Using DADAbase
After going through the majority of the DADA2 pipeline as outlined in the tutorial [here](http://benjjneb.github.io/dada2/tutorial.html), the user should come to the point where they have a sequence matrix consisting of samples on rows and sequence variants on columns. The purpose of DADAbase is to identify sequence variants that already have been seen before and are archived in DADAbase so that the user does not need to annotate them again. 

DADAbase will:
* Parse the variants in the sequence matrix, column by column
* Identify sequences already known of and return associated taxonomic information
* Partition out sequence variants from the matrix that are novel (to DADAbase, at least) for downstream taxonomy assignment
* Allow for the user to commit new annotated sequences to DADAbase
