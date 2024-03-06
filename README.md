# **Analysis pipeline:  Genomic and phenotypic imprints of Neolithic domestication on Cheese Starter cultures**

This is the script repository for the following manuscript:


Vincent Somerville, Florent Mazel, Nadine Thierer, Remo S. Schmidt, Alexandra Roetschi, Laurianne Braillard, Monika Haueter, Hélène Berthoud, Noam Shani , Ueli von Ah, Philipp Engel 2024. “Genomic and phenotypic imprints of Neolithic domestication on Cheese Starter cultures” *BioRXiv*


## Abstract

Domestication – the artificial selection of wild species to obtain variants with traits of human interest– was integral to the rise of civilization. During the neolithic, the oversupply of food enabled by the domestication of crop plants and farm animals was associated with the invention of food preservation strategies by microbial fermentation. However, apart from a few charismatic examples (e.g. yeasts used in mantou or wine), it remains unclear whether, as for plants and animals, fermented food microbes have also been domesticated by humans, and if so when and how did this happen.
Here, we propose to test if cheese starter cultures harbour typical hallmarks of domestication by phenotypically and genetically characterising over 100 community samples and >100 individual strains isolated from historical and modern traditional Swiss cheese starter cultures. We find that cheese starter cultures have low genetic diversity both at the species and strain-level and are taxonomically and phenotypically stable. Moreover, our analyses suggest that the evolutionary origin of cheese starter bacteria coincided with the start of cheesemaking as reported from archeological records, that these bacteria show signs of ongoing genome decay and pseudogenization via transposon insertion, and suboptimal performance in natural settings.
Taken collectively, these hallmarks suggest that cheese starter cultures have been unintentionally domesticated by humans, potentially starting as early as the neolithic. This domestication history in cheese starter culture contrasts with other microbes found in  other types of fermented food for which signs of domestication are currently lacking. We suggest that this discrepancy partly arose because cheese making practices employs “backslopping” to propagate microbes and provide highly stable and controled environmental conditions for the microbes. Future work documenting the prevalence of these hallmarks across diverse  fermented food systems and regions of the globe will be key to unveil the joint history of humanity with fermented food microbes.

![Graphical abstract](figures/graphical_abstract.png)

## Script overview

The scripts are divided into 8 subscripts. Each on is saved and compiled in the 240126_main_starterCultureDiverstiy.html Rmarkdown with extensive comments. The 8 parts consist of:

1. Setup
2. Phenotypic analysis
3. Metagenome analysis
4. Genome analysis
5. Pseudogene analysis
6. Phylogenies
7. RNA-seq
8. Appendix

## Data availability

All data is stored on zenodo under the following doi:

10.5281/zenodo.10783581

The genomic data is further stored under the following Bioprojects:

- PRJNA717134
- PRJNA717134
- PRJNA1048529
- PRJNA1083966


## Disclaimer

The analysis pipeline presented here should be complete however it has not been created as a standalone script. The purpose of the paper was not to generate a tool. Many dependencies are expected.
