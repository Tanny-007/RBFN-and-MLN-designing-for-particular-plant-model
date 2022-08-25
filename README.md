# RBFN and MLN designing for particular plant model
The plant is described by 
𝑥(𝑘 + 1) = 𝑥(𝑘)/(1+𝑥(𝑘)^2) + (𝑢(𝑘))^3
Generate 1000 input-output pairs of training data by exciting the plant by random input of uniform 
distribution from -1 to +1 and normalize the data. Model this plant data using an RBFN as well as an 
MLN network.
Take the number of centres of RBFN to be 100 and fix them by taking random values of uniform 
distribution from 0 to 1. 
Take a single hidden layer of 10 neurons for the MLN. Add a bias both in the input and hidden layer.
Train their weights using the gradient-descent algorithm with adaptive learning rate. 
Validate the model while taking the input to the system as 𝑢(𝑘) = sin (0.2 𝑘) where k= 1 to 1000.
Plot the desired and actual output of the network while training and also, while testing. Plot the 
mean square error across number of epochs while training.
