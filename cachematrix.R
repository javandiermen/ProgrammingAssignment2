##  functions to store a matrix with the ability to cache it's inverse
##  makeCacheMatrix(x)    stores the matrix and make it possible to cache its inverse
##  cacheSolve(x)         calculates the inverse of the CacheMatrix (or retrieves it from the cache if it already was calculated) 
##
## TO TEST
##    source("cachematrix.R")
##
##    # create m (a "CacheMatrix")
##    m<-makeCacheMatrix(matrix(1:4,nrow=2,ncol=2))
##
##    # calculate the Inverse of m  
##    cacheSolve(m)   #initial (has to run "Solve"-function)
##    cacheSolve(m)   #get from cache
##
##    # re-create another matrix (to verify that old cache is not used)
##    m<-makeCacheMatrix(matrix(2:5,nrow=2,ncol=2))
##
##    # re-calculate the Inverse of the "new" m
##    cacheSolve(m)   #initial (has to run "Solve"-function as matrix has changed)
##    cacheSolve(m)   #get from cache
##
##
## makeCacheMatrix(x) stores the matrix and make it possible to cache its inverse
##  arguments:
##    x   a matrix
##  returns a list of 4 functions to be used.

makeCacheMatrix <- function(x = matrix()) {

  m_inverse <- NULL

  #initialise-function
  set <- function(y) {
    x <<- y
    #clean any potential already calculated previous inverse
    m_inverse <<- NULL
  }
  
  #retrieve-function
  get <- function() x
  
  #store the calculated inverse to be retrieved from cache
  setinverse <- function(inverse) m_inverse <<- inverse
  
  #retrieve the stored m_inverse
  getinverse <- function() m_inverse
  
  #makeCacheMatrix returns the following lists of functions
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}



## cacheSolve calculates the inverse of the CacheMatrix (or retrieves it from the cache if it already was calculated) 
##  arguments:
##    x   a Cached Matrix (it has to have the function x$getinverse())
##
##  returns a matrix that is the inverse of 'x'

cacheSolve <- function(x, ...) {

  #call function getinverse from CachedMatrix (is the already calculated inverse if available)
  m_inverse <- x$getinverse()
  
  #if available -> return the cached result
  if(!is.null(m_inverse)) {
    message("getting cached data")
    return(m_inverse)
  }
  
  #if not available
  #retrieve the matrix from x
  data <- x$get()
  #calculate the inverse using the solve-function
  m_inverse <- solve(data, ...) 
  #store the inverse in the cache
  x$setinverse(m_inverse)
  #return the calculated inverse matrix
  m_inverse
  
}
