#!/bin/sh

pn=$0
if [ $# -ne 2 ]
then
        echo "USAGE: $pn <gzipped fastq file> <log dir>";
        exit;
fi

#pJ2_s67_TGACCA_L004_R1_001

q=33 #64 for casava <=1.7 && GA Pipeline >= 1.0; 33 for CASAVA 1.8 and GA Pipeline 0.3
FILE=$1
IFILE=$1".fastq.gz"
LOGS=$2

min_qual=23
min_length=40
percent_high_quality=95

zcat ${IFILE} |\
fastq_quality_trimmer -Q $q  -t $min_qual -l $min_length -v 2> ${LOGS}/${FILE}_qt.log |\
fastq_quality_filter -Q $q -p $percent_high_quality -q $min_qual  -v 2> ${LOGS}/${FILE}_qt_qf.log |\
cutadapt \
-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
-o ${FILE}_qt_qf_ad.fq \
-n 2 -O 2 -m ${min_length} - > ${LOGS}/${FILE}_qt_qf_ad.log
