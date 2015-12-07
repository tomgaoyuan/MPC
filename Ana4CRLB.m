clear all;
close all;
clc;

load('data');
parameters;
X = [150 50]; 
sNew = MPCMaker(X, S, SYSTEM.NTDOPA);
re = CRLBCalculator(X, sNew, SYSTEM.C, SYSTEM.SIGMA);
trace(re)