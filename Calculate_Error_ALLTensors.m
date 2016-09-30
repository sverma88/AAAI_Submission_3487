%% Function to compute total Error

function [Error]=Calculate_Error_ALLTensors(Train_Tensor,Reconstructed_Tensors)

%Input
% Train_Tensor            : Cell of size N*1, each cell contains a single Tensor
% Reconstructed_Tensors   : Cell of size N*1, each cell contains a Reconstructed Tensor
%
%
% Output
% Error                   : Total Reconstruction Error between original Tensor
%                           and reconstructed tensor 
%
%
% Author                : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update           : 22/07/2016

%

Iter=size(Train_Tensor,1);

Error=zeros(Iter,1);

parfor i=1:Iter
    Error(i,1)=abs(norm(Train_Tensor{i,1})-norm(Reconstructed_Tensors{i,1}));
end

end