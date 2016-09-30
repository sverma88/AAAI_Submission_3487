% Function to take multple coupled tensors and their singular factors and
% reproduce their coupled Mode by using existing Factors

function [Decomposed_Coupled_Mode]=ReDecompose_Coupled_Mode_ALLTensors(Train_Tensor,Singular_Factors,Coupled_Mode,Rank)

%Input
% Tensor                       : Train Tensor of cell N*1, N: Number of Tensors
% Singular_Factors             : Singular Factors of Training Tensors in cell array
%                                format
% Coupled_Mode                 : Index of coupled modes of Tensors
% Rank                         : Rank reduction in SVD
%
%
% Output
% Decomposed_Coupled_Mode      : Reconstructed Coupled factor of the Tensor
%
% Author                       : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update                  : 24/07/2016

%

Iter=size(Train_Tensor,1);
U=[];


for i=1:Iter
    
    [Ten_A]=Tensor_Multiply_Specific_Factors(Train_Tensor{i,1},Coupled_Mode,Singular_Factors(i,:));
    
    Matricize_A=tenmat(Ten_A,Coupled_Mode);
    U=[U (Matricize_A.data)];
end

[Decomposed_Coupled_Mode,~,~]=svds(U,Rank);

end