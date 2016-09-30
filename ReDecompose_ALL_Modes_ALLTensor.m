
% Function to reconstruct uncoupled Modes of ALL Tensor

function [Combined_Factors]=ReDecompose_ALL_Modes_ALLTensor(Train_Tensor,Singular_Factors,Rank_Individuals,Coupled_Modes,Singular_Factors_Coupled)

%Input
% Train_Tensor               : Cell structure of size N*1, containing N Tensors one in each cell
% Rank_Individuals           : Rank reduction of Individual modes 
% Coupled_Modes              : index to the coupled modes of Tensors
% Singular_Factors_Coupled   : Singular Factors of the Coupled Modes
%                              reconstrcuted Earlier
% Singular_Factors           : Singular Factors of Tensors in cell array format
%
% Output
% Combined_Factors           : Combined Unique and Coupled Factors for all Tensors
% 
% 
% Author                     : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update                : 24/07/2016

%

Number_Tensors=size(Train_Tensor,1);

Iter=ndims(Train_Tensor{1,1});
S_FactorsA=cell(size(Singular_Factors));


parfor i=1:Number_Tensors
    
    for j=1:Iter
        
            [Ten_A]=Tensor_Multiply_Specific_Factors(Train_Tensor{i,1},j,Singular_Factors(i,:));
            Reconstrcued_Mode_I=tenmat(Ten_A,j);
            [U,~,~]=svds(Reconstrcued_Mode_I.data,Rank_Individuals(1,j));
            S_FactorsA{i,j}=(U);
            
    end
end

Combined_Factors=S_FactorsA;

for i=1:length(Coupled_Modes)
    target_mode=Coupled_Modes(1,i);
    for j=1:Number_Tensors
            A=Singular_Factors_Coupled{j,target_mode};
            B=S_FactorsA{j,target_mode};
            Combined_Factors{j,target_mode}=[A B];
    end
end

end