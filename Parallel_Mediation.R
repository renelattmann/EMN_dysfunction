###################################################################
##################### Lavaan Model syntax for #####################
#######  Dysfunction of the episodic memory network in  the ####### 
################### Alzheimer's disease cascade ################### 
###################################################################

# packages
library(lavaan)
library(tidySEM)


##### Parallel Mediation models #####

# Please find the pseudocode for the parallel mediation models generated 
# in Lattmann et al. below. All variables were corrected for age, sex, and 
# years of education before entering the model. Afterwards, the variables were z-transformed.
# White Matter Hyperintensities were Log10 transformed. 
#
# - René Lattmann (last updated  23.02.2026)


model <- '
  # Direct effect
  Cognition ~ c_prime*Deactivation

  # Mediation paths
  Hippocampal_Volume ~ a1*Deactivation
  Entorhinal_Volume ~ a2*Deactivation
  
  WhiteMatterHyperintensities ~ a3*Deactivation
  Effective_Connectivity ~ a4*Deactivation

  Cognition ~ b1*Hippocampal_Volume + b2*Entorhinal_Volume + b3*WhiteMatterHyperintensities + b4*Effective_Connectivity

  # Indirect effects
  indirect_HC := a1 * b1
  indirect_EC := a2 * b2
  indirect_WMH := a3 * b3
  indirect_EffConn := a4 * b4
  total_indirect := indirect_HC + indirect_EC + indirect_WMH + indirect_EffConn

  # Direct effect 
  direct := c_prime

  # Total effect
  total := c_prime + total_indirect
  
  # Covariances
  Entorhinal_Volume ~~ Hippocampal_Volume
  
'