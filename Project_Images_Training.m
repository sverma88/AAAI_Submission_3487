% Function to Project Training Images on singular factors obtained through
% tensor decomposition

function [Projected_Images_Training,P_Train,Train_Labels]=Project_Images_Training(Train_Tensor,Row_Projections,Col_Projections)

%Input
%
% Train_Tensor                   : Cell of size N*1, each cell contains a single Tensor
% Row_Projection                 : Low rank Singular Factors of rows computed from
%                                  Coupled Tensor decomposition using Iterative HOSVD
% Col_Projection                 : Low rank Singular Factors of columns computed from
%                                  Coupled Tensor Decomposition using Iterative HOSVD

%
% Output
% Projected_Images_Training      : Cell of size N*1, each cell contains projected
%                                  images from each category from trainng data
%
%
% Author                         : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update                    : 28/07/2016

%


Iter=size(Train_Tensor,1);
Projected_Images_Training=cell(Iter,1);
P_Train=[];
Train_Labels=[];

Pixels_Rows=size(Row_Projections{1,1},2);
Pixels_Cols=size(Col_Projections{1,1},2);
Projected_Images_Cols=Pixels_Rows*Pixels_Cols;

parfor k=1:Iter
    Tensor_A=Train_Tensor{k,1};
    Number_of_Instances=size(Tensor_A,1);
    
 
    Gpu_Row_Projection=gpuArray(Row_Projections{k,1});
    Gpu_Col_Projection=gpuArray(Col_Projections{k,1});
    
    Auxillary_P_Images=gpuArray(zeros(Number_of_Instances,Projected_Images_Cols));
    
    for i=1:Number_of_Instances
        Auxillary_P_Images(i,:)=reshape(Gpu_Row_Projection'*(gpuArray(Tensor_A(i,:,:).data))*Gpu_Col_Projection,1,Projected_Images_Cols);
        
    end
    Projected_Images=gather(Auxillary_P_Images);
    P_Train=[P_Train;Projected_Images];
    Labels=ones(size(Projected_Images,1),1);
    Train_Labels=[Train_Labels;Labels*k];
    Projected_Images_Training{k,1}=Projected_Images;
end

end




