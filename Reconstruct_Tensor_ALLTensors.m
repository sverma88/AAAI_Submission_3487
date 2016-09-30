% Function to Reconstruct Tensor, given its factors Matrices and core
% tensor

function [Reconstructed_Tensors]=Reconstruct_Tensor_ALLTensors(Core_Tensors,Singular_Factors)

%Input
% Core_Tensor           : Core Tensor of the original Tensor obtained using coupled
%                         HOSVD
% Singular_Factors      : Singular Factors of the Tensor in cell array
%
% Output
% Reconstructed_Tensor  : Tensor reconstructed using core tensor and
%                         singular factors
%
% Author                : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update           : 24/07/2016

% %

Iter=ndims(Core_Tensors{1,1});

Total_Tensors=size(Core_Tensors,1);

Reconstructed_Tensors=cell(Total_Tensors,1);

parfor j=1:Total_Tensors
    A=Core_Tensors{j,1};
    for i=1:Iter
        A= ttm(A,Singular_Factors{j,i},i);
    end
    Reconstructed_Tensors{j,1}=A;
end

end