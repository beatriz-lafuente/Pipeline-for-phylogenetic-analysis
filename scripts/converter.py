#!/usr/bin/env python3

import sys
from Bio import SeqIO


seqrec = list(SeqIO.parse(sys.argv[1], "fasta"))

for recidx in range(len(seqrec)):
    seqrec[recidx].annotations = {"molecule_type": "DNA"}

SeqIO.write(seqrec, sys.argv[2], "nexus")