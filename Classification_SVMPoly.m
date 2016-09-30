% Function to Compute Distance of projected Images and calculate Accuracy

function [Error,Predicted_Labels]=Classification_SVMPoly(Projected_Images_Training,Train_Labels,Projected_Images_Testing,Ground_Labels)

%Input
%
% Projected_Images_Training      : Matrix containing projected training Images 
% Projected_Images_Testing       : Matrix containing projected testing Images
% Train_Labels                   : Training Labesl of Images
% Ground_Labels                  : Ground Truth for each testing Image
%
% Output
% Error                          : Error of classification using svm
% 
% 
% Author                         : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update                    : 28/08/2016
%

Testing_Images=size(Projected_Images_Testing,1);

t=templateSVM('KernelFunction','polynomial','PolynomialOrder',3,'Standardize',1);

svm_mdl=fitcecoc(Projected_Images_Training,Train_Labels,'Coding','onevsall','Learners',t,'Options',statset('UseParallel',1));

Predicted_Labels=predict(svm_mdl,Projected_Images_Testing);

Error=nnz(Predicted_Labels-Ground_Labels)/Testing_Images;

end




