#!/bin/bash -l


cd ~/community_profiling_sputum/

conda activate qiime2-2021.4


out_dir="/dartfs-hpc/scratch/f002bx6/qiime_out/ITS1/"

qiime feature-table summarize \
  --i-table $out_dir/ITS-table-dada2.qza \
  --o-visualization $out_dir/table.qzv \
  --m-sample-metadata-file ITS-metadata.tsv

qiime feature-table tabulate-seqs \
  --i-data $out_dir/ITS-rep-seqs-dada2.qza \
  --o-visualization $out_dir/ITS-rep-seqs.qzv

qiime alignment mafft \
  --i-sequences $out_dir/ITS-rep-seqs-dada2.qza \
  --o-alignment $out_dir/ITS-aligned-rep-seqs.qza

qiime alignment mask \
  --i-alignment $out_dir/ITS-aligned-rep-seqs.qza \
  --o-masked-alignment $out_dir/ITS-masked-aligned-rep-seqs.qza


qiime phylogeny fasttree \
  --i-alignment $out_dir/ITS-masked-aligned-rep-seqs.qza \
  --o-tree $out_dir/ITS-unrooted-tree.qza

qiime phylogeny midpoint-root \
  --i-tree $out_dir/ITS-unrooted-tree.qza \
  --o-rooted-tree $out_dir/ITS-rooted-tree.qza

qiime tools export \
  --input-path $out_dir/ITS-rooted-tree.qza \
  --output-path $out_dir/ITS-exported-tree  





