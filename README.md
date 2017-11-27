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

Ensure you are in an active R session and call `library(DADAbase)` to load DADAbase.

<hr>

### I. Opening a connection to DADAbase
Use the `DADAbase.openConnection()` function to establish a link to cjelli's sqlite server and, more specifically, DADAbase.

A message will relay if you are successfully connected to DADAbase.

<hr>

### II. Retrieve known sequence variants
At this point in the DADA2 pipeline, you should have a sequence matrix. In the tutorial, the matrix is placed in the variable name `seqtab.nochim` and we will use this object name to reference the matrix. This table should contain sequence variants identified by DADA2 as column names. You can check this by calling `colnames(seqtab.nochim)[1]`. A sequence should print on the terminal.

To retrieve annotated sequence variants in DADAbase that appear in your sequence matrix, pass it into `DADAbase.getKnownSeqs()` as an argument and store the returned data frame into a separate variable. Example: `seqtab.known <- DADAbase.getKnownSeqs(seqtab.nochim)`. Sequence variants and annotations are now loaded into `seqtab.known`.

Note: If you don't store this in an extra table, the resulting data frame that prints can look a little messy!

<hr>

### III. Remove known sequence variants
After exploring `seqtab.known`, we can remove sequence variants which we already have data for so that we're left with sequence variants for downstream annotation.

Store the output data frame of `DADAbase.removeKnownSeqs(seqtab.nochim, seqtab.known)` into another variable such as `seqtab.novel`. This data frame holds only sequences that don't already exist in DADAbase.

<hr>

### IV. Import novel sequence variants
Now that we have our data frame of novel sequence variants, we can convert them into a matrix that will be standard for DADAbase to import. This matrix will come with columns for you to add annotation information. Load your novel data frame and known data frame into two import frames with `DADAbase.prepareSeqs(seqtab.removed, seqtab.known)` and store it into another variable. An example: `seqtab.import <- DADAbase.prepareNovelSeqs(seqtab.removed)`. seqtab.import holds a list containing two data frames.
<hr>

### V. Adding annotations, tool information, and grouping information
We now have two data frames with six columns.

#### a. Novel Sequence Preparation
The first column should already be populated with novel sequence variants. The remaining five columns are for matching taxonomy, taxonomic assignment tool information, primer and annealing temperature information, associated DOIs, and run/group number information.

How you fill this matrix is entirely up to you. Each sequence variant should have information across the columns. To enter information into a column, it's easiest to just insert the whole column as a vector in one shot. A requirement for this though, is that the order of the values in the vector you're inserting must match the order of the sequence variants present in the 'sequence' column.

If all the values are the same for annotation tools and primer/annealing temperature information, the insertion is rather easy.
```
# Used GreenGenes for example
seqtab.import$novelSeqs$taxoMethod <- c(rep("GreenGenes", dim(seqtab.import)[1]))

# Replace the "V4" with what describes the primers you used -- see https://github.com/ggloor/miseq_bin/blob/master/primer_sequences.txt
seqtab.import$novelSeqs$primers <- c(rep("V4", dim(seqtab.import)[1]))

# Example if the annealing temperature was 41 deg. Celsius
seqtab.import$novelSeqs$annealingTemp<- c(rep(41, dim(seqtab.import)[1]))
```

For other columns, where the information is rather variable, make a vector first and edit it. Then, insert that vector into the appropriate column in one go.

#### b. Known Sequence Preparation
For known sequences, we can update DADAbase to show that they were seen in this particular run as well. The knownSeqs data frame allows you to match up sequences with group numbers if your run consisted of multiple groups.


Once you have a properly filled out matrix, the novel variants are ready for insertion into DADAbase!
<hr>

### VI. Commit annotated sequence variants to DADAbase
Now that we have annotated our sequences and have entered our metadata, its time to commit them into DADAbase's archive. This step is easy, just enter: `DADAbase.commit()`. Enter metadata according to prompts. A message will notify you of how many sequences are committed successfully.

<hr>

### VII. Close the connection to DADAbase
Close the connection to DADAbase using `DADAbase.closeConnection()`.

<hr>

## Querying DADAbase to find metadata on variants
There are two ways one can go about this.

In the first method, we start with a table of variants from DADA2 and want to know more about ones we have information on. In this case, it is easiest to use `DADAbase.getKnownSeqs()` to retrieve a data frame of information.

In the second method, we are just searching the DADAbase archive using query terms. In this case, one would use `DADAbase.query()` to match terms. The `DADAbase.query()` function takes three parameters:
1. The term we would like to query for (e.g. "V4")
2. The attribute we would like to query on (e.g. "primers")
3. Whether or not we want exact string matches (by default is FALSE)

For example, if I wanted to get information for all sequences and information where the sequence was annotated to *Lactobacillus*, I would enter `DADAbase.query('Lactobacillus', 'taxonomy')`. Note that if I had put TRUE in as the third parameter, I would get no rows back. If I put TRUE in for exact matches only, I need to know the exact contents of the entire field I'm looking for.

## Querying DADAbase to find history on variants in previous runs
Using `DADAbase.knownSeqsSource`, we can query DADAbase's history to find where a particular sequence has been seen before.

If you know the accessNum (first column in the seqtab.known frame), you can query just with that single number like so: `DADAbase.knownSeqsSource(122)`. If you would like to query by sequence, you can do so with `DADAbase.knownSeqsSource("sequence", queryOnSeq=TRUE)` where `sequence` is your string.
