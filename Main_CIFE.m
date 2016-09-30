% Main Script to execute iterative tensor decomposition

clc
clear all
load('CIFAR-10-GCNZCA.mat')

rng('default');

Train_Classes=2;
Total_Categories=10;
Total_Instances=6000;
Total_Training_images=5000;
Total_Testing_images=1000;

Rank_Coupled=[30,8,8];
Rank_Individuals=[30,8,8];
Max_iterations=1500;
Error_Threshold=10^-6;
Coupled_Modes=[2 3];

Iterate_experiments=13;

Row_Projections=cell(Train_Classes,Iterate_experiments);
Col_Projections=cell(Train_Classes,Iterate_experiments);
Train_Tensor=cell(Train_Classes,Iterate_experiments);
Test_Tensor=cell(Train_Classes,Iterate_experiments);

Prediction=cell(Iterate_experiments,1);
Error_SVM_Poly=[];
Error_LR=[];
Error_SVM=[];
Error_KNN=[];

svm_test_3=[];
svm_test_2=[];

train_CIFE=[];
test_CIFE_svm=[];
index=[9 10;4 6;1 2;3 8;1 9;5 6;6 8;2 9;2 10;3 4;5 8;3 7;6 7];


for j=1:Iterate_experiments

 
for i=1:Train_Classes
    Train_Tensor{i,j}=Tensor_Data(index(j,i),1:5000,:,:);
    Test_Tensor{i,j}=Tensor_Data(index(j,i),5001:6000,:,:);
end

tic
[Singular_Factors]=Decompose_Tensor_Coupled_Uncoupled_HOSVD_iteratively_ALLTensors(Train_Tensor(:,j),Rank_Coupled,Rank_Individuals,Error_Threshold,Max_iterations,Coupled_Modes);
train_CIFE=[train_CIFE;toc];

Row_Projections(:,j)=Singular_Factors(:,2);
Col_Projections(:,j)=Singular_Factors(:,3);

[Test_Images,Ground_Labels]=Project_Test_Images(Test_Tensor(:,j),Row_Projections(:,j),Col_Projections(:,j));
[Projected_Images_Training,P_Train,Train_Labels]=Project_Images_Training(Train_Tensor(:,j),Row_Projections(:,j),Col_Projections(:,j));

[r,~]=find(Train_Labels==2);
Train_Labels(r,:)=-1;

[r,~]=find(Ground_Labels==2);
Ground_Labels(r,:)=-1;

[Error,~]=Classification_SVMPoly(P_Train,Train_Labels,Test_Images,Ground_Labels); 

Error_SVM_Poly=[Error_Iter;Error];


[Error,~]=Classification_SVM(P_Train,Train_Labels,Test_Images,Ground_Labels); 
Error_SVM=[Error_SVM;Error];

[Error,~]=Classification_LR(P_Train,Train_Labels,Test_Images,Ground_Labels); 
Error_LR=[Error_LR;Error];

[Error,~]=Classification_KNN(P_Train,Train_Labels,Test_Images,Ground_Labels); 
Error_KNN=[Error_KNN;Error];

end

save('CIFE.mat','Error_SVM_Poly','Error_LR','Error_SVM','Error_KNN','Row_Projections','Col_Projections');