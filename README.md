# EMN_dysfunction

This github page contains code for the "Dysfunction of the episodic memory network in the Alzheimer's disease cascade" (Lattmann et al., 2026, Nature Communications, available at nature.com/articles/s41467-026-71831-z). 

- "GGPlots_DysfunctionPaper.R" contains the plot functions for the main figures of the manuscript.
- "Parallel_mediation.R" contains the Lavaan model syntax for the parallel mediation analysis. 
- "SandwichEstimation.m" contains the sandwich estimator model used to extract the second-level estimates of activation differences along the Alzheimer's disease progression model established in DELCODE.
- "rl_results2surf.m" generates individuals gii representations of either SPM or SWE niis.
- "rl_surf_results_bidirectional.m" plots effects both in the same map and thresholds the maps to a desired threshold. 

In the paper, we made use of the disease progression model (DPM) by Lorenzi et al. (2019). Details for the DPM can be found at this website: https://disease-progression-modelling.github.io/pages/models/non_parametric_DPM.html 
The code itself can be found at https://gitlab.inria.fr/epione/GP_progression_model_V2

Additionally, we provide the source data accompanying the manuscript. 

For any questions, please send an inquiry to rene.lattmann@dzne.de
