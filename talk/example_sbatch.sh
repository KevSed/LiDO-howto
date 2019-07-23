#!/bin/bash -l
#SBATCH --partition=short
#SBATCH --nodes=1
# #SBATCH --constraint=cquad01
#SBATCH --mem=30G
#SBATCH -c 20
#SBATCH --job-name=hello_world
#SBATCH --mail-user=<username>@tu-dortmund.de
#SBATCH --mail-type=ALL
#SBATCH --output=/work/<username>/job_output.txt
echo "sbatch: START SLURM_JOB_ID $SLURM_JOB_ID \
    (SLURM_TASK_PID $SLURM_TASK_PID) on $SLURMD_NODENAME"
echo "sbatch: SLURM_JOB_NODELIST $SLURM_JOB_NODELIST"
echo "sbatch: SLURM_JOB_ACCOUNT $SLURM_JOB_ACCOUNT"
cd $HOME
source .bash_profile
source .bashrc
module purge
module add root python/3.6.4 texlive/2017 make/4.2.1 cmake/3.8.2 git tensorflow
export MG="MG5_aMC_v2_6_5"
conda activate py2r616




make CTG=$CTG -B generator
cd MG5_aMC_v2_6_5
./bin/mg5_aMC /work/smkesedl/sensitivity_studies/generator_scripts/pp2ttbarctg$CTG.mg5
cd /work/smkesedl/sensitivity_studies/
cd /work/<username>/hello_world/
make EVENTS=10000 all
cd ../hello_universe/$MG
bin/madevent run_card.mg5
echo "sbatch: STOP"
