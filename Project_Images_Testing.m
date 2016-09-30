% Function to Project Test Images on singular factors obtained through
% tensor decomposition

function [Projected_Images_Testing,Labels]=Project_Images_Testing(Test_Tensor,Row_Projection,Col_Projection)

%Input
%
% Test_Tensor                    : Cell of size N*1, each cell contains a single Tensor
% Row_Projection                 : Low rank Singular Factors of rows computed from
%                                  Coupled Tensor decomposition using Iterative HOSVD
% Col_Projection                 : Low rank Singular Factors of columns computed from
%                                  Coupled Tensor Decomposition using Iterative HOSVD

%
% Output
% Projected_Images_Testing       : Cell of size N*1, each cell contains projected
%                                  images from each category from testing data
%
%
% Author                         : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update                    : 25/07/2016

%


Pixels_Rows=size(Row_Projection,2);
Pixels_Cols=size(Col_Projection,2);
Projected_Images_Cols=Pixels_Rows*Pixels_Cols;

Gpu_Row_Projection=gpuArray(Row_Projection);
Gpu_Col_Projection=gpuArray(Col_Projection);


    Tensor_A=Test_Tensor;
    Number_Images_Each_Instance=size(Tensor_A,1);
    Projected_Images_Rows=Number_Images_Each_Instance;
    
    Projected_Images=zeros(Projected_Images_Rows,Projected_Images_Cols);
    
    Auxillary_P_Images=gpuArray(zeros(Number_Images_Each_Instance,Projected_Images_Cols));
    for j=1:Number_Images_Each_Instance
        Auxillary_P_Images(j,:)=reshape(Gpu_Row_Projection'*(gpuArray(Tensor_A(j,:,:).data))*Gpu_Col_Projection,1,Projected_Images_Cols);
    end
    
    Projected_Images(:,:)=gather(Auxillary_P_Images);
    Projected_Images_Testing=Projected_Images;
    Labels=ones(size(Projected_Images,1),1);

end




