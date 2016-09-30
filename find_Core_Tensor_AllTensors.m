% Function to find core tensor utilizing Factors Matrices of each Mode of
% Tensor and the Tensor itself

function [Core_Tensor]=find_Core_Tensor_AllTensors(Train_Tensors,Singular_Factors)

% Inputs
% Train_Tensor         : Tensors in training, Cell array containing a single tensor in each cell
% Singular_Factors     : Left Singular values obtained by using HOSVD on each
%                        tensor (cell array or N*M : N tensors and M modes)
%
% Outputs
% Core_Tensor          : Core Tensor of each Tensor cell array of size
%                        equal to Tensors
%
% Author               : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update          : 24/07/2016

% %


Iter=ndims(Train_Tensors{1,1});
Total_Tensors=size(Train_Tensors,1);
Core_Tensor=cell(Total_Tensors,1);

parfor j=1:Total_Tensors
    CT=Train_Tensors{j,1};
    for i=1:Iter
        CT= ttm(CT,Singular_Factors{j,i}',i);
    end
    Core_Tensor{j,1}=CT;
end

end