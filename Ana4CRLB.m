clear all;
close all;
clc;

% load('data');
parameters;
% X = [150 50]; 
% X = [250 50]; 
% X = [250 150]; 
% X = [350 50]; 
% X = [350 150]; 
X = [350 250]; 
sNew = MPCMaker(X, SYSTEM.S, SYSTEM.NTDOPA);
re = CRLBCalculator(X, sNew, SYSTEM.C, SYSTEM.SIGMA);
trace(re)