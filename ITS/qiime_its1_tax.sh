#!/bin/bash -l



cd ~/community_profiling_sputum/

conda activate qiime2-2021.4


out_dir="/dartfs-hpc/scratch/f002bx6/qiime_out/ITS1"

qiime feature-classifier classify-sklearn \
  --i-classifier $out_dir/unite-ver8-99-classifier-04.02.2020.gza \
  --i-reads $out_dir/ITS-rep-seqs.qza \
  --o-classification $out_dir/ITS-taxonomy.qza

qiime metadata tabulate \
  --m-input-file $out_dir/ITS-taxonomy.qza \
  --o-visualization $out_dir/ITS-taxonomy.qzv

qiime taxa barplot \
  --i-table $out_dir/ITS-table-dada2.qza \
  --i-taxonomy $out_dir/ITS-taxonomy.qza \
  --m-metadata-file ITS-metadata.tsv \
  --o-visualization $out_dir/ITS-taxa-bar-plots.qzv

#qiime2rename_tree.pl metadata.tsv $out_dir/exported-tree/tree.nwk >$out_dir/trees.nwk



