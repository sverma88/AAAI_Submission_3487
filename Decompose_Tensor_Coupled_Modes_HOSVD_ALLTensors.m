% Function to decompose tensor in coupled modes utilizing factors of
% independent modes computed earlier

function [Singular_Factors]=Decompose_Tensor_Coupled_Modes_HOSVD_ALLTensors(Train_Tensor,Rank_Coupoled,Coupled_Modes,S_Factors)

%Input
% Tarin_Tensor          : Cell of size N*1, each cell contains a single tarining Tensor
% Rank_Coupled          : Rank reductions of coupled modes
% Coupled_Modes         : row vectors specifing coupled modes indices
% S_Factors             : Singular Factors of all Tensor in cell array
%                         each cell contains Singular Factors of a single
%                         tensor but only of their independent Modes
%
%
% Output
% Singular_Factors      : Singular Factors of all Tensor in cell array
%                         format after decomposing in coupled modes
%
% Author                : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update           : 25/08/2016

% %
Number_coupled_modes=size(Coupled_Modes,2);

Iter=size(Train_Tensor,1);

% Copying Individual factors
Singular_Factors=S_Factors;
S=cell(1,Number_coupled_modes);

% Computing the coupled Singular vectors

for i=1:Number_coupled_modes
    
    index=Coupled_Modes(1,i);
    M=[];
    
    parfor j=1:Iter
        
        Matricize=tenmat(Train_Tensor{j,1},index);
        M=[M Matricize.data]
    end
    [U,~,~]=svds(M,Rank_Coupoled(1,index));
    
    S{1,i}=U;
    
end

parfor i=1:Iter
    Singular_Factors(i,Coupled_Modes)=S;
end

end