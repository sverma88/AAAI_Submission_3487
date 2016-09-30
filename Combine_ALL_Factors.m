% Function to Combine Singular Factors

function [Combined_Factors]=Combine_ALL_Factors(Singular_Factors_Coupled,Singular_Factors_Individuals)

%Input
% Singular_Factors_Individuals     : Singular Factors Obtained through Coupled Tensor Factorizations 
% Singular_Factors_Coupled         : Singular Factors Obtained through Individual Tensor Factorizations
%
%
% Output
% Combined_Factors                 : Combined Coupled and Individual Singular Factors 
% 
%
% Author                           : Sunny Verma (sunnyverma.iitd@gmail.com)
% Last_Update                      : 25/08/2016

% %

Iter=size(Singular_Factors_Individuals,1);

Combined_Factors=Singular_Factors_Coupled;

for i=1:Iter
     Coupled_Row_Projections=Singular_Factors_Coupled{i,2};
     Coupled_Col_Projections=Singular_Factors_Coupled{i,3};
     Individual_Row_Projections=Singular_Factors_Individuals{i,2};
     Individual_Col_Projections=Singular_Factors_Individuals{i,3};
     Combined_Factors{i,2}=[Coupled_Row_Projections Individual_Row_Projections];
     Combined_Factors{i,3}=[Coupled_Col_Projections Individual_Col_Projections];
           
end

end


