% Function to classify data points using K- nearest neighbor classifier


function [Error,Predicted_Labels]=Classification_KNN(Projected_Images_Training,Train_Labels,Projected_Images_Testing,Ground_Labels)

%Input
%
% Projected_Images_Training      : Matrix containing projected training Images 
% Projected_Images_Testing       : Matrix containing projected testing Images
% Train_Labels                   : Training Labesl of Images
% Ground_Labels                  : Ground Truth for each testing Image
%
% Output
% Error                          : Error of classification using KNN
% 
% 
% Author                         : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update                    : 28/08/2016
%

Testing_Images=size(Projected_Images_Testing,1);

t=templateKNN('NumNeighbors',3,'Standardize',1,'Distance','euclidean');

knn_mdl=fitcecoc(Projected_Images_Training,Train_Labels,'Coding','onevsall','Learners',t);

Predicted_Labels=predict(knn_mdl,Projected_Images_Testing);

Error=nnz(Predicted_Labels-Ground_Labels)/Testing_Images;

end




