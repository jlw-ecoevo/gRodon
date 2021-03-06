% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict_growth.R
\name{predictGrowth}
\alias{predictGrowth}
\title{Predict Growth Rate}
\usage{
predictGrowth(
  genes,
  highly_expressed,
  mode = "full",
  temperature = "none",
  training_set = "vs",
  depth_of_coverage = NULL,
  fragments = FALSE
)
}
\arguments{
\item{genes}{DNAStringSet object holding all nucleotide sequences from a
genome. See Biostrings package.}

\item{highly_expressed}{Logical vector describing the set of highly expressed
genes. Must be of same length as \code{genes}.}

\item{mode}{Whether to run prediction in full, partial, or metagenome mode
(by default gRodon applies the full model)}

\item{temperature}{Optimal growth temperature. By default this is set as
"none" and we do not guarantee good results for non-mesophilic organisms since
few were used to fit the model.}

\item{training_set}{Whether to use models trained on the original Vieira-Silva et al.
doubling time dataset or doubling times drawn from the Madin et al. database.}

\item{depth_of_coverage}{When using metagenome mode, provide a vector containing
the coverage of your ORFs to improve your estimate}

\item{fragments}{If using gene fragments predicted from reads, will use a
more permissive length filter (120bp as opposed to 240bp)}
}
\value{
gRodon returns a list with the following elements:
\describe{
\item{CUBHE}{Median codon usage bias of the highly expressed genes (MILC)
calculated using the genome-wide codon usage as the expected bias}
\item{ConsistencyHE}{Mean codon usage bias of the highly expressed genes
(MILC) calculated using the codon usage of highly expressed genes as the
expected bias}
\item{CPB}{Genome-wide codon pair bias (Coleman et al. 2008)}
\item{FilteredSequences}{Number of gene sequences filtered out during
calulation (due to length and/or presence of ambiguous bases)}
\item{d}{Predicted doubling time in hours}
\item{LowerCI}{Lower CI of \code{d} (2.5\%)}
\item{UpperCI}{Upper CI of \code{d} (97.5\%)}
}
}
\description{
This function predicts the growth rate of a prokaryotic organism based on
genomic codon usage patterns (Weissman et. al. TBD).
}
\examples{
# Load in example genome (Streptococcus pyogenes M1, downloaded from RefSeq)
# included with gRodon
path_to_genome <- system.file('extdata',
  'GCF_000349925.2_ASM34992v2_cds_from_genomic.fna.gz',
  package = 'gRodon')
genes <- readDNAStringSet(path_to_genome)

# Search pre-existing annotations for ribosomal proteins, which we
# will use as our set of highly expressed genes
highly_expressed <- grepl("ribosomal protein",names(genes),ignore.case = T)

# Run the gRodon growth prediction pipeline
predictGrowth(genes, highly_expressed)

# Run gRodon with temperature option (not needed for mesophiles, gRodon not
# validated on extremophiles, use with care)
predictGrowth(genes, highly_expressed, temperature = 37)

}
