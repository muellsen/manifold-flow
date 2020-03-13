#!/bin/bash

#SBATCH --job-name=e-gamf2-lhc
#SBATCH --output=log_evaluate_gamf2_lhc_%a.log
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64GB
#SBATCH --time=2-00:00:00
# #SBATCH --gres=gpu:1

conda activate ml
export PATH="/home/brehmer/miniconda3/envs/ml/bin/:$PATH"
export OMP_NUM_THREADS=1
dir=/home/brehmer/manifold-flow

cd $dir/experiments

run=$((task / 2))
task=$((task % 2))
echo "SLURM_ARRAY_TASK_ID = ${SLURM_ARRAY_TASK_ID}, task = ${task}, run = ${run}"

case ${task} in
0) python -u evaluate.py --modelname march --dataset lhc --algorithm gamf --modellatentdim 14 --splinebins 10 --observedsamples 100 -i ${run} --skiplikelihood --dir $dir ;;
1) python -u evaluate.py --modelname alternate_march --dataset lhc --algorithm gamf --modellatentdim 14 --splinebins 10 --observedsamples 100 -i ${run} --skiplikelihood --dir $dir ;;
*) echo "Nothing to do for job ${task}" ;;
esac