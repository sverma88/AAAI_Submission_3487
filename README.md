# Common and Unique Tensor Factorization, AAAI 2017 
Extracting Highly Effective Features for Supervised Learning via Simultaneous Tensor Factorization, Proceedings of the Thirty-First {AAAI} Conference on Artificial Intelligence, February 4-9, 2017, San Francisco, California, {USA.}

## Tensor Toolbox
Please download tensor toolbox from http://www.sandia.gov/~tgkolda/TensorToolbox/index-2.6.html

## Matlab Codes for CUTF, AAAI17 
Please contact the first author of the poster for any difficulties

## The main Executable File is CUTF.m

Size of training and testing data can be changed manually, line: 12-13
Total_Training_images=5000;
Total_Testing_images=1000;


Parameters for obtaining low rank are located between lines: 15-19
Row_Rank_Coupled=8;
Row_Rank_Individual=8;
Col_Rank_Coupled=8;
Col_Rank_Individual=8;

## Requires Parallel computing toolbox of Matlab

## Classification categories are manually selected 
Line no: 44
index=[9 10;4 6;1 2;3 8;1 9;5 6;6 8;2 9;2 10;3 4;5 8;3 7;6 7];
