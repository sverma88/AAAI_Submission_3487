%% Function to find converged singular factors of coupled and uncoupled modes of all Tensors

function [Final_Factors]=Decompose_Tensor_Coupled_Uncoupled_HOSVD_iteratively_ALLTensors(Train_Tensor,Rank_Coupled,Rank_Individuals,Error_Threshold,Max_iterations,Coupled_Modes)

%Input
% Train_Tensor          : Cell of size N*1, each cell contains a single taining Tensor
% Rank_Coupled          : Rank reductions of coupled mode
% Rank_Individuals      : Rank Reductions of Individual modes
% Error_Threshold       : Allowable error tolerance limit
% Max_iterations        : Maximum allowable iterations
% Coupled_Modes         : Array of order N*P, each column specifies the
%                         modes of Tensor coupled together
%
% Output
% Final_Factors        : Converged Singular Factors of all Tensor in cell array
%                       (combined coupled and Individual)
%
%
% Author                : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update           : 25/08/2016

%%

% Setting Initial parameters
Number_coupled_modes=size(Coupled_Modes,2);
Iter=size(Train_Tensor,1);
S_Factors=cell(Iter,size(Rank_Coupled,2));

% Computing Common factors
% Find Singular Factors of Uncoupled Modes only (All tensors)
parfor i=1:Iter
    S_Factors(i,:)=Decompose_Tensor_HOSVD_Cou_UnCo(Train_Tensor{i,1},Rank_Coupled,Coupled_Modes);
end

% Find Singular Factors of coupled modes

[Singular_Factors]=Decompose_Tensor_Coupled_Modes_HOSVD_ALLTensors(Train_Tensor,Rank_Coupled,Coupled_Modes,S_Factors);

% Computing unique singular factors 

Singular_Factors_Individuals=cell(Iter,ndims(Train_Tensor{1,1}));

parfor i=1:Iter
Tensor_A=Train_Tensor{i,1};
[Singular_Factors_Ind]=Decompose_Tensor_HOSVD_Cou_UnCo(Tensor_A,Rank_Individuals);
Singular_Factors_Individuals(i,:)=Singular_Factors_Ind;
end

[Combined_Factors]=Combine_ALL_Factors(Singular_Factors,Singular_Factors_Individuals);

% Computing the core tensors
[Core_Tensors]=find_Core_Tensor_AllTensors(Train_Tensor,Combined_Factors);

% Reconstrcut Tensor
[Reconstructed_Tensors]=Reconstruct_Tensor_ALLTensors(Core_Tensors,Combined_Factors);
%%

% initiallizing things before moving to iterative error reduction

Error=Calculate_Error_ALLTensors(Train_Tensor,Reconstructed_Tensors);
Error_Prev=Error;
iter_number=1;
Singular_Factors=Combined_Factors;


%%
% converging singular factors

while((sum(Error) > Error_Threshold) && (iter_number <= Max_iterations))
   
    % Computing the Factors of Coupled Modes
    Singular_Factors_Coupled=cell(Iter,ndims(Train_Tensor{1,1}));
    Decomposed_Coupled_Mode=cell(1,Number_coupled_modes);
    
    parfor i=1:Number_coupled_modes
        
        Coupled_Mode_INDEX=Coupled_Modes(1,i);
        [Decomposed_Factor]=ReDecompose_Coupled_Mode_ALLTensors(Train_Tensor,Singular_Factors,Coupled_Mode_INDEX,Rank_Coupled(1,Coupled_Mode_INDEX));
        Decomposed_Coupled_Mode{1,i}=Decomposed_Factor;
    end
    
    parfor i=1:Iter
    Singular_Factors_Coupled(i,Coupled_Modes)=Decomposed_Coupled_Mode;
    end
    
    [Combined_new_Factors]=ReDecompose_ALL_Modes_ALLTensor(Train_Tensor,Singular_Factors,Rank_Individuals,Coupled_Modes,Singular_Factors_Coupled);
    
    %     Reconstructing Tensors based on iterative Calculations
    
    [Core_Tensors]=find_Core_Tensor_AllTensors(Train_Tensor,Combined_new_Factors);
    [Reconstructed_Tensors]=Reconstruct_Tensor_ALLTensors(Core_Tensors,Combined_new_Factors);
        
    %     New Error
    
    
    Error_New=Calculate_Error_ALLTensors(Train_Tensor,Reconstructed_Tensors);
    Error=sum(abs(Error_Prev-Error_New))
    
    Error_Prev=Error_New;
    iter_number=iter_number+1
    
    Singular_Factors=Combined_new_Factors;
end

 Final_Factors=Singular_Factors;
end

