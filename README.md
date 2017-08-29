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

Ensure you are in an active R session and call `library(DADAbase)` to load in DADAbase.

<hr>

### I. Opening a connection to DADAbase
Use the `DADAbase.openConnection()` function to establish a link to cjelli's MySQL server and, more specifically, DADAbase. Enter your credentials as such: `DADAbase.openConnection('username', 'password')`.

A message will relay if you are successfully connected to DADAbase.

<hr>

### II. Retrieve known sequence variants
At this point in the DADA2 pipeline, you should have a sequence matrix. In the tutorial, the matrix is placed in the variable name `seqtab.nochim` and we will use this object name to reference the matrix. This table should contain sequence variants identified by DADA2 as column names. You can check this by calling `colnames(seqtab.nochim)[1]`. A sequence should print on the terminal.

To retrieve annotated sequence variants in DADAbase that appear in your sequence matrix, pass it into `DADAbase.getKnownSeqs()` as an argument and store the returned data frame into a separate variable. Example: `seqtab.known <- DADAbase.getKnownSeqs(seqtab.nochim)`. Sequence variants and annotations are now loaded into `seqtab.known`.

<hr>

### III. Remove known sequence variants
After exploring `seqtab.known`, we can remove sequence variants which we already have data for so that we're left with sequence variants for downstream annotation.

Store the output data frame of `DADAbase.removeKnownSeqs(seqtab.nochim, seqtab.known)` into another variable such as `seqtab.removed`. This data frame holds only sequences that don't already exist in DADAbase.

<hr>

### IV. Import novel sequence variants
Now that we have our data frame of novel sequence variants, we can import them into DADAbase for annotation and committing. Load your novel data frame with `DADAbase.importSeqs(seqtab.removed)`.

<hr>

### V. Adding annotations, tool information, grouping information, and entry metadata
How you do this step is entirely up to you, so long as you end up with two data frames with the specific formatting required for DADAbase commits.

* A data frame of two columns titled EXACTLY "Sequences" and "Group" (we will call it `groupings`)
This data frame should pair each sequence variant from `seqtab.removed` with a group number from the run.

* A data frame of two columns titled EXACTLY "Sequences" and "Taxonomy" (we will call it `annoInfo`)
This data frame should pair each sequence variant from `seqtab.removed` with its taxonomic information. Preferably, the information should exist in the following format: "Kingdom; Phylum; Class; Order; Family; Genus; Species".

To associate the sequence variants loaded in DADAbase with their grouping and annotations, call the following two functions on the above data frames.

```
DADAbase.specifyGroupNums(groupings)
DADAbase.specifyTaxonomy(annoInfo)
```

To associate annotation tools and keywords to all sequence variants imported, call `DADAbase.specifyTaxoKeys(keys)`, where `keys` is a string specifying the tools used to annotate the sequences. For example, `keys` might be `"GreenGenes; Silva"`.

Entry metadata is recorded through `DADAbase.specifyMetadata()`. Call this function and follow the prompts to enter metadata.

<hr>

### VI. Commit annotated sequence variants to DADAbase
Now that we have annotated our sequences and have entered our metadata, its time to commit them into DADAbase's archive. This step is easy, just enter: `DADAbase.commitNewSeqs()`. A message will notify you of how many sequences are committed.

<hr>

### VII. Close the connection to DADAbase
Close the connection to MySQL and purge the incoming data using `DADAbase.closeConnection()`.
