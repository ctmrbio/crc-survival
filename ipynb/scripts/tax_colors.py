import pandas as pd
import numpy as np

remappings = {
    'f__Enterococcaceae': 'c__Bacilli', 
    'f__Streptococcaceae': 'c__Bacilli', 
    'f__Staphylococcaceae': 'c__Bacilli', 
    'f__Lactobacillaceae': 'c__Bacilli', 
    'f__Carnobacteriaceae': 'c__Bacilli', 
    'f__Bacillaceae': 'c__Bacilli', 
    'f__Leuconostocaceae': 'c__Bacilli', 
    'f__Aerococcaceae': 'c__Bacilli', 
    'o__Lactobacillales': 'c__Bacilli', 
    'f__Christensenellaceae': 'c__Clostridia', 
    'f__Peptostreptococcaceae': 'c__Clostridia',
    'f__Clostridiaceae_1': 'c__Clostridia',
    'f__Clostridiales_vadinBB60_group': 'c__Clostridia', 
    'f__Family_XIII': 'c__Clostridia',
    'o__Clostridiales': 'c__Clostridia',
    'f__Peptococcaceae': 'c__Clostridia',
    'f__Eubacteriaceae': 'c__Clostridia',
    'f__Defluviitaleaceae': 'c__Clostridia',
    'f__Thermoanaerobacteraceae': 'c__Clostridia',
    'f__Syntrophomonadaceae': 'c__Clostridia',
    'f__Caldicoprobacteraceae': 'c__Clostridia',
    'f__Veillonellaceae': 'p__Firmicutes',
    'f__Erysipelotrichaceae': 'p__Firmicutes',
    'f__Acidaminococcaceae': 'p__Firmicutes',
    'f__Aeromonadaceae': 'c__Gammaproteobacteria',
    'f__Enterobacteriaceae': 'c__Gammaproteobacteria',
    'f__Moraxellaceae': 'c__Gammaproteobacteria',
    'f__Pasteurellaceae': 'c__Gammaproteobacteria',
    'f__Pseudomonadaceae': 'c__Gammaproteobacteria',
    'f__Succinivibrionaceae': 'c__Gammaproteobacteria',
    'f__Xanthomonadaceae': 'c__Gammaproteobacteria',
    'c__Betaproteobacteria': 'p__Proteobacteria',
    'c__Epsilonproteobacteria': 'p__Proteobacteria',
    'f__Alcaligenaceae': 'p__Proteobacteria',
    'f__Bradyrhizobiaceae': 'p__Proteobacteria',
    'f__Burkholderiaceae': 'p__Proteobacteria',
    'f__Caulobacteraceae': 'p__Proteobacteria',
    'f__Comamonadaceae': 'p__Proteobacteria',
    'f__Desulfobulbaceae': 'p__Proteobacteria',
    'f__Desulfovibrionaceae': 'p__Proteobacteria',
    'f__Methylocystaceae': 'p__Proteobacteria',
    'f__Neisseriaceae': 'p__Proteobacteria',
    'f__Oxalobacteraceae': 'p__Proteobacteria',
    'f__Phyllobacteriaceae': 'p__Proteobacteria',
    'f__Rhizobiaceae': 'p__Proteobacteria',
    'f__Rhodospirillaceae': 'p__Proteobacteria',
    'f__Rickettsiales_Incertae_Sedis': 'p__Proteobacteria',
    'f__Sphingomonadaceae': 'p__Proteobacteria',
    'o__Burkholderiales': 'p__Proteobacteria',
    'o__Rhizobiales': 'p__Proteobacteria',
    'f__Bacteroidaceae': 'f__Bacteroidaceae',
    'f__Rikenellaceae': 'f__Rikenellaceae',
    'f__Porphyromonadaceae': 'f__Porphyromonadaceae',
    'f__Prevotellaceae': 'f__Prevotellaceae',
    'p__Bacteroidetes': 'p__Bacteroidetes',
    'f__Lachnospiraceae': 'f__Lachnospiraceae',
    'f__Ruminococcaceae': 'f__Ruminococcaceae',
    'f__Family_XI (c__Clostridia)': 'c__Clostridia',
     'f__Bacilli_Family_XI': 'c__Bacilli',
    'f__Clostridia_Family_XI': 'c__Bacilli',
    'f__Family_XI (c__Bacilli)': 'c__Clostridia',
    'c__Clostridia': 'c__Clostridia',
    'c__Bacilli': 'c__Bacilli',
    'p__Firmicutes': 'p__Firmicutes',
    'c__Gammaproteobacteria': 'c__Gammaproteobacteria',
    'f__Campylobacteraceae': 'f__Campylobacteraceae',
    'p__Proteobacteria': 'p__Proteobacteria',
    'f__Bifidobacteriaceae': 'f__Bifidobacteriaceae',
    'f__Fusobacteriaceae': 'f__Fusobacteriaceae',
    'f__Verrucomicrobiaceae': 'f__Verrucomicrobiaceae',
    'f__Synergistaceae': 'f__Synergistaceae',
}

mapped_colors = {
    # Bacteriodetes - blue
    'f__Bacteroidaceae': '#616161',
    'f__Rikenellaceae': '#8B8B8B',
    'f__Porphyromonadaceae': '#B7B7B7',
    'f__Prevotellaceae': '#D6D6D6',
    'p__Bacteroidetes': '#F5F5F5',
    # Firmicutes - purple
    'f__Lachnospiraceae': '#7D3560',
    'f__Ruminococcaceae': '#A1527F',
    'c__Clostridia': '#CC79A7',
    'c__Bacilli': '#E794C1',
    'p__Firmicutes': '#EFB6D6',
    # Proteobacteriaa -- orange 
    'c__Gammaproteobacteria': '#9D654C', # f__Enterobacteriaceae, f__Pseudomonadaceae
    'f__Campylobacteraceae': '#C17754', # 
    'p__Proteobacteria': '#F09163',
    # Fusobacteria - green
    'f__Fusobacteriaceae': '#97CE2F',
    # Other - teal
    'f__Bifidobacteriaceae': '#148F77',
    'f__Verrucomicrobiaceae': '#009E73',
    'f__Synergistaceae': '#43BA8F',
    'Other': '#A3E4D7',
}


color_order = [
    pd.Series(['f__Lachnospiraceae', 'f__Ruminococcaceae', 'c__Clostridia', 'c__Bacilli', 'p__Firmicutes']), # Firmictutes
    pd.Series(['f__Bacteroidaceae', 'f__Rikenellaceae', 'f__Porphyromonadaceae', 'f__Prevotellaceae', 'p__Bacteroidetes']),
    pd.Series(['f__Fusobacteriaceae', np.nan, 'c__Gammaproteobacteria', 'f__Campylobacteraceae', 'p__Proteobacteria']), # Proteobacteria
    pd.Series(['f__Verrucomicrobiaceae', 'f__Bifidobacteriaceae', 'f__Synergistaceae', 'Other']),
]

survival_colors = {"0": '#4292c6', '1': '#08306b'}
neutral = '#587fac'