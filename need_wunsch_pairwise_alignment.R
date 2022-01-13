
##====================================
##Streptococci
##====================================
###split  every CRIPSR into indiviual files

rm -r /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/CRISPRspacersRaw_new
mkdir -p /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/CRISPRspacersRaw_new

sed 's/__.*$//g' /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples |sed 's/:/__/g' > /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples_newNAMED

samtools faidx /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples_newNAMED

for spacer in $(grep "^>" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples_newNAMED|sed 's/>//g')
do

#spacer1_final=$(echo ${spacer} |awk -F "__" '{OFS="_"}{print $1,2}' |sed 's/:/_/g')
samtools faidx /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples_newNAMED ${spacer} > /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/CRISPRspacersRaw_new/${spacer}.fasta

done

##-------------
##pairwise needle-wunsch alignment
##-------------

rm -r /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new
mkdir -p /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new

for spacer1 in $(grep "^>" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples_newNAMED|sed 's/>//g')
do

spacer1_final=$(echo ${spacer1})

for spacer2 in $(grep "^>" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples_newNAMED|sed 's/>//g')
do

spacer2_final=$(echo ${spacer2} )

needle -asequence /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/CRISPRspacersRaw_new/${spacer1_final}.fasta \
-bsequence /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/CRISPRspacersRaw_new/${spacer2_final}.fasta -gapopen 20 -gapextend 0 -outfile /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa

length=$(grep "Length" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa | cut -d ':' -f 2 | sed -e 's/^[ \t]*//' )
Identity=$(grep "Identity" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa | cut -d ':' -f 2 | cut -d '/' -f 1| sed -e 's/^[ \t]*//' )
Gaps=$(grep "Gaps" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa | cut -d ':' -f 2 | cut -d '/' -f 1| sed -e 's/^[ \t]*//' )
Score=$(grep "Score" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa | cut -d ':' -f 2 | sed -e 's/^[ \t]*//' )

echo -e ${spacer1_final}"\t"${spacer2_final}"\t"${length}"\t"${Identity}"\t"${Gaps}"\t"${Score} >> /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/final_pairwise_alignment.txt

rm /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa
done

done


##-------------do parallel
###------define TASK



task(){ 
  spacer2_final=$(echo ${spacer2} )
  needle -asequence /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/CRISPRspacersRaw_new/${spacer1_final}.fasta \
  -bsequence /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/CRISPRspacersRaw_new/${spacer2_final}.fasta -gapopen 20 -gapextend 0 -outfile /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa
  
  length=$(grep "Length" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa | cut -d ':' -f 2 | sed -e 's/^[ \t]*//' )
  Identity=$(grep "Identity" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa | cut -d ':' -f 2 | cut -d '/' -f 1| sed -e 's/^[ \t]*//' )
  Gaps=$(grep "Gaps" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa | cut -d ':' -f 2 | cut -d '/' -f 1| sed -e 's/^[ \t]*//' )
  Score=$(grep "Score" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa | cut -d ':' -f 2 | sed -e 's/^[ \t]*//' )
  
  echo -e ${spacer1_final}"\t"${spacer2_final}"\t"${length}"\t"${Identity}"\t"${Gaps}"\t"${Score} >> /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/final_pairwise_alignment.txt
  
  rm /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new/${spacer1_final}__${spacer2_final}.msa
  
}



###------Run parallel in batches



rm -r /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new
mkdir -p /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/pairwiseID/needle_new
counts=$(wc -l /data/Project/CRISPRspacers/02_PilerCR/20200217/all/pilerCR_out_repeats_short|cut -d ' ' -f 1)
N=300
for spacer1 in $(grep "^>" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples_newNAMED|sed 's/>//g')
do

spacer1_final=$(echo ${spacer1})

for spacer2 in $(grep "^>" /archiv/Projects/2019_pilotplant/02_annotation/CRISPR/mapping2phageGenome/CRISPR_alltogether_new_withOLDsamples_newNAMED|sed 's/>//g')
do

((i=i%N)); ((i++==0)) && wait
##--------------run task
task &
  
  done

done