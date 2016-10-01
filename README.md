# AAAI_Submission_3487
AAAI Submission Poster 3487

# Tensor Toolbox
Please download tensor toolbox from http://www.sandia.gov/~tgkolda/TensorToolbox/index-2.6.html

# Matlab Codes for AAAI17 Students Poster Submission-3487
Please contact the first author of the poster for any difficulties

# The main Executable File is CUTF.m

Size of training and testing data can be changed manually, line: 12-13
Total_Training_images=5000;
Total_Testing_images=1000;


Parameters for obtaining low rank are located between lines: 15-19
Row_Rank_Coupled=8;
Row_Rank_Individual=8;
Col_Rank_Coupled=8;
Col_Rank_Individual=8;

# Requires Parallel computing toolbox of Matlab

# Classification categories are manually selected 
Line no: 44
index=[9 10;4 6;1 2;3 8;1 9;5 6;6 8;2 9;2 10;3 4;5 8;3 7;6 7];
