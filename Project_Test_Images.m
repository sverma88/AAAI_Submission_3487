% Function to Project Testing points on SingularTraining

function [Test_Images,Ground_Labels]=Project_Test_Images(Test_Tensor,Row_Projections,Col_Projections)

%Input
% Tensor_Test           : Cell of size N*1, N: number of Tensors, each cell contains
%                         testing images of that category
% Row_Projections       : Cell of size N*1, N: number of Tensors, each cell contains
%                         singular factors from row projections of training images 
% Col_Projections       : Cell of size N*1, N: number of Tensors, each cell contains
%                         singular factors from col projections of training images
%
% Output
% Projected_Images_Testing  : Testing Images projected on each singular factor
%
% Author                : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update           : 25/08/2016

%

Iter=size(Row_Projections,1);
Ground_Labels=[];
Test_Images=[];

parfor i=1:Iter
    [Projected_Images_Testing,Labels]=Project_Images_Testing(Test_Tensor{i,1},Row_Projections{i,1},Col_Projections{i,1});
    Ground_Labels=[Ground_Labels;Labels*i];
    Test_Images=[Test_Images;Projected_Images_Testing];
end

end

