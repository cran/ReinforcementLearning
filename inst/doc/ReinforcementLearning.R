## ---- include=FALSE------------------------------------------------------
set.seed(0)

## ----eval=FALSE----------------------------------------------------------
#  # install.packages("devtools")
#  
#  # Option 1: download and install latest version from GitHub
#  devtools::install_github("nproellochs/ReinforcementLearning")
#  
#  # Option 2: install directly from bundled archive
#  devtoos::install_local("ReinforcementLearning_1.0.0.tar.gz")

## ---- message=FALSE------------------------------------------------------
library(ReinforcementLearning)

## ------------------------------------------------------------------------
data("tictactoe")
head(tictactoe, 5)

## ---- eval=FALSE---------------------------------------------------------
#  # Define state and action sets
#  states <- c("s1", "s2", "s3", "s4")
#  actions <- c("up", "down", "left", "right")
#  
#  env <- gridworldEnvironment
#  
#  # Sample N = 1000 random sequences from the environment
#  data <- sampleExperience(N = 1000,
#                           env = env,
#                           states = states,
#                           actions = actions)

## ---- eval=FALSE---------------------------------------------------------
#  # Load dataset
#  data("tictactoe")
#  
#  # Perform reinforcement learning
#  model <- ReinforcementLearning(data = tictactoe,
#                                 s = "State",
#                                 a = "Action",
#                                 r = "Reward",
#                                 s_new = "NextState",
#                                 iter = 1)
#  

## ---- eval=FALSE---------------------------------------------------------
#  # Define control object
#  control <- list(alpha = 0.1, gamma = 0.1, epsilon = 0.1)
#  
#  # Pass learning parameters to reinforcement learning function
#  model <- ReinforcementLearning(data, iter = 10, control = control)

## ---- eval=FALSE---------------------------------------------------------
#  # Print policy
#  computePolicy(model)
#  
#  # Print state-action table
#  print(model)
#  
#  # Print summary statistics
#  summary(model)

## ---- message=FALSE------------------------------------------------------
# Define state and action sets
states <- c("s1", "s2", "s3", "s4")
actions <- c("up", "down", "left", "right")

## ---- message=FALSE------------------------------------------------------
# Load built-in environment function for 2x2 gridworld 
env <- gridworldEnvironment
print(env)

## ---- message=FALSE------------------------------------------------------
# Sample N = 1000 random sequences from the environment
data <- sampleExperience(N = 1000, 
                         env = env, 
                         states = states, 
                         actions = actions)
head(data)

## ---- message=FALSE------------------------------------------------------
# Define reinforcement learning parameters
control <- list(alpha = 0.1, gamma = 0.5, epsilon = 0.1)

# Perform reinforcement learning
model <- ReinforcementLearning(data, 
                               s = "State", 
                               a = "Action", 
                               r = "Reward", 
                               s_new = "NextState", 
                               control = control)


## ---- message=FALSE------------------------------------------------------
# Print policy
computePolicy(model)

# Print state-action function
print(model)

## ---- message=FALSE------------------------------------------------------
# Print summary statistics
summary(model)


## ---- message=FALSE------------------------------------------------------
# Example data
data_unseen <- data.frame(State = c("s1", "s2", "s1"), 
                          stringsAsFactors = FALSE)

# Pick optimal action
data_unseen$OptimalAction <- predict(model, data_unseen$State)

data_unseen

## ---- message=FALSE------------------------------------------------------
# Sample N = 1000 sequences from the environment
# using epsilon-greedy action selection
data_new <- sampleExperience(N = 1000, 
                             env = env, 
                             states = states, 
                             actions = actions, 
                             actionSelection = "epsilon-greedy",
                             model = model, 
                             control = control)

# Update the existing policy using new training data
model_new <- ReinforcementLearning(data_new, 
                                   s = "State", 
                                   a = "Action", 
                                   r = "Reward", 
                                   s_new = "NextState", 
                                   control = control,
                                   model = model)

## ---- message=FALSE, fig.width=5, fig.height=3---------------------------
# Print result
print(model_new)

# Plot reinforcement learning curve
plot(model_new)

## ---- message=FALSE, echo=FALSE------------------------------------------
cat("......X.B")

cat("|  .  |  .  |  .   |
|------------------|
|  .  |  .  |  .   |
|------------------|
|  X  |  .  |   B  |")


## ---- eval=FALSE---------------------------------------------------------
#  # Load dataset
#  data("tictactoe")
#  
#  # Define reinforcement learning parameters
#  control <- list(alpha = 0.2, gamma = 0.4, epsilon = 0.1)
#  
#  # Perform reinforcement learning
#  model <- ReinforcementLearning(tictactoe, s = "State", a = "Action", r = "Reward",
#                                 s_new = "NextState", iter = 1, control = control)
#  
#  # Calculate optimal policy
#  pol <- computePolicy(model)
#  
#  # Print policy
#  head(pol)
#  

## ---- message=FALSE, echo=FALSE------------------------------------------
cat('.XXBB..XB XXBB.B.X. .XBB..BXX BXX...B.. ..XB..... XBXBXB... 
     "c1"      "c5"      "c5"      "c4"      "c5"      "c9"')


## ---- message=FALSE, echo=FALSE------------------------------------------
cat("|  .  |  X  |  X   |
|------------------|
|  B  |  B  |  .   |
|------------------|
|  .  |  X  |   B  |")

cat("|  c1  |  c2  |  c3   |
|---------------------|
|  c4  |  c5  |  c6   |
|---------------------|
|  c7  |  c8  |   c9  |")


