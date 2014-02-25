#!/bin/bash
bedtools intersect –abam ../scratch/Index_1.TR001_1L.to.TR001_1L.plastid.0.2.withNs.fa.sort.bam –b IRbegin.txt  >IRbegin.Index_1.TR001_1L.to.TR001_1L.plastid.0.2.withNs.fa.sort.bam           
bedtools intersect –abam ../scratch/Index_1.TR001_1L.to.TR001_1L.plastid.0.2.withNs.fa.sort.bam –b IRend.txt    >IRend.Index_1.TR001_1L.to.TR001_1L.plastid.0.2.withNs.fa.sort.bam         
bedtools intersect –abam ../scratch/Index_1.TR001_1L.to.TR001_1L.plastid.0.2.withNs.fa.sort.bam –b Nregion.txt  >Nregion.Index_1.TR001_1L.to.TR001_1L.plastid.0.2.withNs.fa.sort.bam           
