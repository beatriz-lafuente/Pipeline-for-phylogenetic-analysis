# Positive Selection Project

## Pipeline to performe phylogenetic analysis and calculate the ratio of synonymous and non synonymous substitutions in cichlids to find evidence of positive selection.

<div align="center">
  <img width="600px" src="https://images.tcdn.com.br/img/img_prod/749804/aulonocara_orange_blue_super_red_5_a_7_cm_ciclideos_lago_malawi_2111_1_0eb5998f95547e24eeb1d6fdb02b3043.jpg">
</div>

## In this repository you will find...

<ul>
  <li> A <a href="https://github.com/beatriz-lafuente/Phylogenetic-Analysis/blob/main/report/internship_report_22_positive_selection_cichlids.pdf"> Project report</a> explaining all the steps of the project. </li>
  <li> A <strong>data</strong> folder with:
    <ul>
      <li> Excel file containing all the species of cichlids used in the project; </li>
      <li> Fasta file with the sequences of cichlids; </li>
      <li> A file with the parameters used in HyPhy software; </li>
      <li> Fasta file of the species without stop codons. </li>
    </ul>
  <li> A <strong>HyPhy</strong> folder containing the results of the maximum likelihood analysis. </li>
  <li> A <strong>nexus</strong> folder containing a file converted from fasta to nexus for MrBayes. </li>
  <li> A <strong>scripts</strong> folder containing a python script to convert fasta into nexus. </li>
  <li> A <strong>Dockerfile</strong> in case you want to run this project. </li>
  <li> A <strong>Snakefile</strong> containing all the rules and workflow of the data analysis. </li>
</ul>

