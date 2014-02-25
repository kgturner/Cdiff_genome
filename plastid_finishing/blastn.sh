#!/bin/bash
#ln -s ../ref/TR001_1L.plastid.0.2.withNs.fa ./
#makeblastdb -dbtype nucl -in TR001_1L.plastid.0.2.withNs.fa
#blastn -db TR001_1L.plastid.0.2.withNs.fa -query cat.TR001_1L.TO.78675147.K.19.Contigs.fasta -outfmt 7 >cat.TR001_1L.TO.78675147.K.19.Contigs.fasta.TO.TR001_1L.plastid.0.2.withNs.fa.b7
#makeblastdb -dbtype nucl -in Lactuca_sativa_cp_sequence.fasta
#blastn -db Lactuca_sativa_cp_sequence.fasta -query cat.TR001_1L.TO.78675147.K.19.Contigs.fasta -outfmt 7 >cat.TR001_1L.TO.78675147.K.19.Contigs.fasta.TO.Lactuca_sativa_cp_sequence.fasta.b7
#makeblastdb -dbtype nucl -in Helianthus_annuus_cp.fasta
#blastn -db Helianthus_annuus_cp.fasta -query cat.TR001_1L.TO.78675147.K.19.Contigs.fasta -outfmt 7 >cat.TR001_1L.TO.78675147.K.19.Contigs.fasta.TO.Helianthus_annuus_cp.fasta.b7
#blastn -db Helianthus_annuus_cp.fasta -query cat.TR001_1L.TO.78675147.K.19.Contigs.no5.fasta -outfmt 7 >cat.TR001_1L.TO.78675147.K.19.Contigs.no5.fasta.TO.Helianthus_annuus_cp.fasta.b7
#makeblastdb -dbtype nucl -in TR001_1L.plastid.0.3.withNs.fa
#blastn -db TR001_1L.plastid.0.3.withNs.fa -query ray.k31.contigs.fa -outfmt 7 >ray.k31.contigs.fa.TO.TR001_1L.plastid.0.3.withNs.fa.b7
blastn -db TR001_1L.plastid.0.3.withNs.fa -query ray.k19.contigs.fa -outfmt 7 >ray.k19.contigs.fa.TO.TR001_1L.plastid.0.3.withNs.fa.b7
blastn -db TR001_1L.plastid.0.3.withNs.fa -query ray.k25.contigs.fa -outfmt 7 >ray.k25.contigs.fa.TO.TR001_1L.plastid.0.3.withNs.fa.b7
#blastn -db TR001_1L.plastid.0.2.withNs.fa -query supercontigSequences.x.fna -outfmt 7 >supercontigSequences.x.fna.TO.TR001_1L.plastid.0.2.withNs.fa.b7


