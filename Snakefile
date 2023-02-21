import re

inputfile = os.environ.get("INPUT")
outputdir = os.environ.get("OUTPUTDIR")
outgroup = os.environ.get("OUTGROUP")
num_cores = os.environ.get("CORES")
nboot = os.environ.get("BOOT")
nboot = 100 if nboot is None else nboot
num_cores = 1 if num_cores is None else num_cores
input_basename = os.path.basename(re.sub("\..*?$", "", inputfile))
output_fullpath = os.path.abspath(outputdir)
output_basename = f'{outputdir}/{input_basename}'

rule prepare:
	shell:
		'mkdir -p outputs'
		'mkdir -p hyphy'

rule all:
	input:
		f'{outputdir}/RAxML_bipartitions.{input_basename}'
		f'nexus/{inputfile}.nex'
		f'{output_basename}_zebra.con.tre'
		f'hyphy/results_selection.json'
		f'hyphy/results_estimates.json'
		f'hyphy/results.txt'
	message:
		'Run sucessfully! :) Your analysis is ready.'

rule clean:
	shell:
		'rm -rf outputs/*'

rule raxml:
	input:
		f'data/{inputfile}.fas'
	output:
		[f'{outputdir}/RAxML_bipartitions.{input_basename}',f'{outputdir}/RAxML_bestTree.{input_basename}']
	run:
		shell(f'mkdir -p {outputdir}')
		cmd = f'raxmlHPC-PTHREADS-AVX -f a -m GTRCAT -p 112358 -x 112358 -N {nboot} -s {input} -n {input_basename} -w {output_fullpath} -T {num_cores}'
		shell(cmd)

rule converter:
	input:
		f'data/{inputfile}.fas'
	output:
		f'nexus/{inputfile}.nex'
	shell:
		'mkdir -p nexus && python3 scripts/converter.py {input} {output}'

rule parameters:
	run:
		shell(f'echo "begin mrbayes;" >> nexus/{inputfile}.nex') 
		shell(f'echo "	lset nst=6 rates=invgamma;" >> nexus/{inputfile}.nex') 
		shell(f'echo "	set autoclose=yes;" >> nexus/{inputfile}.nex') 
		shell(f'echo "	mcmc ngen=1000000 samplefreq=500 printfreq=1000 diagnfreq=1000 relburnin=yes burninfrac=0.25 filename={inputfile}_zebra;" >> nexus/{inputfile}.nex') 
		shell(f'echo "	sump filename={inputfile}_zebra;" >> nexus/{inputfile}.nex')  
		shell(f'echo "	sumt filename={inputfile}_zebra;" >> nexus/{inputfile}.nex') 
		shell(f'echo "end;" >> nexus/{inputfile}.nex') 

rule mrbayes:
	input:
		f'nexus/{inputfile}.nex'
	shell:
		'cd outputs && mb ../{input}'
		
rule hyphy:
	input:
		fasta = f'data/{inputfile}.fas', 
		tree = f'{outputdir}/RAxML_bestTree.{input_basename}', 
		params = f'data/hyphy_parameters'

	output:
		results = f'hyphy/results.txt' ,
		res_json = f'hyphy/results_selection.json', 
		estimates = f'hyphy/results_estimates.json'
	shell:
		'mkdir -p hyphy && hyphy aBSREL --code Universal --alignment {input.fasta} --tree {input.tree} > {output.results}'
		'grep "^Likelihood" {output.results}'