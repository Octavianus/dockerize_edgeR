## dockermized edgeR
## Note: Need to check whether the package that installed take effect
## use the dockerfile/ubuntu base image provided by https://index.docker.io/u/dockerfile/ubuntu/
# The environment is ubuntu-14.04
FROM dockerfile/python

MAINTAINER David Weng weng@email.arizona.edu
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

## Step 1: Install the basic tools to set up the environment.
# Install the wget, gcc, make tools, handling the lib dependency problem.
RUN apt-get install -y wget
RUN apt-get install -y g++
RUN apt-get install -y aptitude

## Step 2: Install R Environment	
# Back to the /home/vagrant/ directory
RUN apt-get install -y r-base
RUN aptitude install -y r-base-dev

## Step 3: Build the Batch script for R
# Make sure the working directory is Vagrant.
WORKDIR /home/vagrant
RUN echo 'source("http://www.bioconductor.org/biocLite.R")' >> batch
RUN echo 'biocLite("edgeR")' >> batch
RUN echo 'library(edgeR)' >> batch

## Step 4: Install the edgeR in R by the script. It will take for a while
RUN R CMD BATCH batch
