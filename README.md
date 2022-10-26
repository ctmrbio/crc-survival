# Tumor Microbiome in Survival

Analysis for Debelius et al, "The local tumor microbiome is associated with survival in late-stage colorectal cancer patients". *medrxiv*. (doi: [10.1101/2022.09.16.22279353](https://doi.org/10.1101/2022.09.16.22279353))

# Raw Data Avaliability

Raw sequence data and mdetata can be found on ENA under accession <Accession>. 

# Stata

The stata script is in the `stata` folder. The code should be runable on the `metadata_paired.tsv` files in the `ipynb/data/` folder.

# Jupyter notebooks

Microbiome data was prepared and processed through Jupyter notebooks.

## Installation

This code was initially run in a qiime2-2022.11 enviroment with plugins for [gemelli](https://library.qiime2.org/plugins/gemelli/28/), [DEICODE](), and [empress](). 

To replicate the qiime2 enviroment, install qiime2 2021.11 according to the [installation instructions](https://docs.qiime2.org/2021.11/install/) which are most appropriate for your enviroment. (Click through when it warns you there is a new version!)

Then, activate the enviroment and install the qiime2 plugings according to installation instructions:

```bash
pip install gemelli
pip install deicode
pip install git+https://github.com/biocore/empress
qiime dev refresh-cache
``` 

[Jupyter lab](https://jupyter.org/install) may be optionally installed to make Jupyter notebook handling functional, although it should not be required.

### PyStan

Differential ranking requires [pystan](https://pystan.readthedocs.io/en/latest/index.html); we used pystan 3.4. This is operation system dependent; our group was able to get pystan to work with Mac OS 15.2 but unable to coerce it on a linus system. (If you dont want to experiment with the pystan run, the files are included.)

```bash
pip install pystan=3.4
```

## Data Processing and analysis

### Preprocessing and processing

#### Feature Table Construction

The microbiome data was denoised using the standardized pipeline in CTMR bio Amplicon workflow](https://github.com/ctmrbio/Amplicon_workflows). The dada2 denoised text table was used; the original table can be found in the `ipynb/data/raw_data` directory.

#### Import into qiime2 (`01-Parse-dada2-Table.ipynb`)

The notebook parases the dada2 table for qiime2. It also filters the table to match the metadata and removes features with undefined depths.

#### Diversity Calculations (`02.02-Generate-Diversity.ipynb`)

The notebook performs fragment insertion into the [Silva 128 fragment insertion backbone](https://docs.qiime2.org/2022.8/data-resources/#sepp-reference-databases) and uses the phylogenetic tree to construct a feature table. 

The feature table is rarefied to 2500 sequences/sample. Alpha diveristy (observed features, shannon, and Simpson diversity) and beta diversity (Bray Curtis, jaccard, weighted UniFrac and unweighted UniFrac) were calcualted on the rarefied table. Beta diversity measured through Aitchison distance was calcualted using an unrarefied table with a pseudocount of 1.

We also generated the complex tensor factorization (CTF) via Gemelli and rPCA via DEICODE.

#### Stan Differential ranking (`03-Stan-Ranking.ipynb`)

Stan differential rankings are calculated using a linear mixed effects model. If you are unable to get stan to work on your system (or just don't like sleeping with your laptop overnight), output files are in the `data/differential_ranking` folder.

### Analysis

To standardize display, we defined a set of colors for taxa.

#### Figure S1: Taxonomic Barplot (`04-Taxonomic-barplot.ipynb`)

#### Figure S2: Within individual Boxplots (`05-Individual-Similarity-Boxplots.ipynb`)

#### Figure S3: Subject CTF PCA and Table S3 (`06-Pairedr-PCA-Subject-Specific.ipynb`)

#### Figure 1: Comparison of tumor and normal tissue (`07-Paired-rPCA-Tissue-Seperation.ipynb`)
Also generates Table S4 and supplemental file 

#### Table S5: Survival by difference in beta diversity metrics (`08-Beta-Survival.ipynb`)

#### Figure 2: Survival by Tissue type (`09-PairedrPCA-Tissue-Survival.ipynb`)
Also generates Table S6, S7, and supplemental file 2

#### Figure 3: Tumor rPCA (`10-TumorrPCA.ipynb`)



