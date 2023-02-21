#Dockerfile

#Image used for our docker
FROM snakemake/snakemake:main

#The maintainer of this dockerfile
LABEL MAINTAINER = beatriz.fuente.santos@gmail.com

#Install all needings and dependencies
RUN apt-get update && \
	apt-get install apt-utils -y &&\
	apt-get install raxml -y && \
	apt-get install mrbayes -y
	
#Instal miniconda
RUN conda config --add channels defaults && \
	conda config --add channels bioconda && \
	conda config --add channels conda-forge

#instal mamba
RUN mamba install r-base hyphy -y

#Directorys creation
WORKDIR /dockTree
COPY scripts/ /dockTree/scripts/
COPY data/ /dockTree/data/
COPY outputs/ /dockTree/outputs/
COPY Snakefile /dockTree/