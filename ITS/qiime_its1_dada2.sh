#!/bin/bash -l



cd ~/community_profiling_sputum/

conda activate qiime2-2021.4

manifest_file="ITS1_manifest_for_disco.csv"
export TMPDIR="/dartfs-hpc/scratch/f002bx6/qiime_out/ITS1/temp"

out_dir="/dartfs-hpc/scratch/f002bx6/qiime_out/ITS1"

qiime tools import   \
  --type 'SampleData[PairedEndSequencesWithQuality]'   \
  --input-path $manifest_file   \
  --output-path $out_dir/ITS-demux.qza   \
  --input-format PairedEndFastqManifestPhred33

qiime demux summarize \
  --i-data $out_dir/ITS-demux.qza \
  --o-visualization $out_dir/ITS-demux-vis.qzv

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs $out_dir/ITS-demux.qza \
  --p-trim-left-f 0 --p-trim-left-r 0 \
  --p-trunc-len-f 0 --p-trunc-len-r 0 \
  --p-min-overlap 4 \
  --p-n-threads 1 \
  --p-n-reads-learn 100 \
  --o-table $out_dir/ITS-table-dada2.qza \
  --o-representative-sequences $out_dir/ITS-rep-seqs-dada2.qza \
  --o-denoising-stats $out_dir/ITS-stats-dada2.qza
