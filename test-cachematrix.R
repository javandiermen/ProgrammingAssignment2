setwd("C:\\Users\\JaapenEllen\\Documents\\GitHub\\ProgrammingAssignment2" )
source("cachematrix.R")

# create m (a "CacheMatrix")
m<-makeCacheMatrix(matrix(1:4,nrow=2,ncol=2))

# calculate the Inverse of m  
cacheSolve(m)   #initial (has to run "Solve"-function)
cacheSolve(m)   #get from cache

# re-create another matrix (to verify that old cache is not used)
m<-makeCacheMatrix(matrix(2:5,nrow=2,ncol=2))

# re-calculate the Inverse of the "new" m
cacheSolve(m)   #initial (has to run "Solve"-function as matrix has changed)
cacheSolve(m)   #get from cache