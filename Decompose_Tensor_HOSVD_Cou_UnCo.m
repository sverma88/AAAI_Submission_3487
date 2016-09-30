% Function to decompose a single tensor 
% Might be coupled or uncoupled

function [Singular_Factors_A]=Decompose_Tensor_HOSVD_Cou_UnCo(Tensor_A,Rank_A,Coupled_Modes)

%Input
% Tensor_A              : Tensor 'A' of Mode 'N' having 'O' modes coupled
%                         with Tensor_B and Tensor_C 
% Rank_A                : Rank reduction in SVD
% Coupled_Modes         : row vector containing indices of its coupled modes
%                         empty if none is coupled (OPTIONAL ARGUMENT)
% 
% Output
% Core_Tensor_A         : Core Tensor of Tensor 'A' obtained using coupled
%                         iterative HOSVD
% Singular_Factors_A    : Singular Factors of Tensor 'A' in cell array
%                         format
% 
% Author                : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update           : 25/08/2016

% % 

% Decomposing tensor HOSVD first time 

iter_A=ndims(Tensor_A);
Singular_Factors_A=cell(1,iter_A);

if nargin < 3
    Coupled_Modes=[];
end

parfor i=1:iter_A
    if(~any(i==Coupled_Modes))
        Singular_Factors_A{1,i}=find_svd_mode(Tensor_A,i,Rank_A(1,i));
    end
end

end