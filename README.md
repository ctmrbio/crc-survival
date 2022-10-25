# Tumor Microbiome in Survival

Analysis for Debelius et al, "The local tumor microbiome is associated with survival in late-stage colorectal cancer patients". *medrxiv*. (doi: [10.1101/2022.09.16.22279353](https://doi.org/10.1101/2022.09.16.22279353))

# Raw Data Avaliability

Raw sequence data and mdetata can be found on ENA under accession <Accession>. 

# Sample Processing

The data for this project was processed through 2 platforms. The patient characterstics (table 1 and table s1) were generated through Stata. Microbiome data was analyzed using qiime2 within a conda enviroment.

## Stata

The stata script is in the `stata` folder. The code should be runable on the `metadata_paired.tsv` files in the `ipynb/data/` folder.

## Jupyter notebooks

Microbiome data was prepared and processed through Jupyter notebooks.

### Installation

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

#### PyStan

Differential ranking requires [pystan](https://pystan.readthedocs.io/en/latest/index.html); we used pystan 3.4. This is operation system dependent; our group was able to get pystan to work with Mac OS 15.2 but unable to coerce it on a linus system. (If you dont want to experiment with the pystan run, the files are included.)

```bash
pip install pystan=3.4
```

### Data Processing and analysis

#### Preprocessing

##### Feature Table Construction

The microbiome data was denoised using the standardized pipeline in CTMR bio Amplicon workflow](https://github.com/ctmrbio/Amplicon_workflows). The dada2 denoised text table was used; the original table can be found in the `ipynb/data/raw_data` directory.

##### Import into qiime2 (`01-Parse-dada2-Table.ipynb`)

The notebook parases the dada2 table for qiime2. It also filters the table to match the metadata and removes features with undefined depths.

##### Diversity Calculations (`02.`


