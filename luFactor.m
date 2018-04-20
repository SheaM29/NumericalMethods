function [L, U, P] = luFactor(A)
%luFactor determines the LU Factorization of a square
%matrix using partial pivoting
%Inputs
% A - coefficient matrix
%Outputs
% L - lower triangular matrix
% U - upper triangular matrix
% P - the pivot matrix

%Test number of inputs
if(nargin ~= 1)
    error('Enter one square matrix as input');
end

%Test if input matrix is square
[rowSize,colSize] = size(A);
if(rowSize ~= colSize)
    error('Input matrix must be a square');
end

% Set L matrix as an indentity matrix
L = eye(rowSize);

%Set U as duplicate of A
U = A;

% Set P matrix to track pivoting
P = L;


for iter=1:rowSize-1 %Runs through Gaussian Elimination
    %Check for largest value of U matrix to pivot 
    max=A(iter,iter);
    for i=iter:rowSize
        if abs(max) <= abs(A(i,iter))
            max = A(i,iter);
            rowMax=i;
        end
    end
    
    %Pivots first row of matrixes P and U with the max row
    P([iter rowMax],:) = P([rowMax iter],:);
    U([iter rowMax],:) = U([rowMax iter],:);
    
    %Pivots specific values of L matrix
    if (iter > 1) && (rowMax ~= iter)
        count = 0;
        for l=1:(iter-1)
            L([iter+(rowSize*count) rowMax+(rowSize*count)]) = L([rowMax+(rowSize*count) iter+(rowSize*count)]);
            count=count+1;
        end
    end
    
    %Elminates values from U by using Gausian Elimation
    for j = iter+1:rowSize
        multiplier=U(j,iter)/U(iter,iter);
        L(j,iter)=multiplier;
    end
    
    for k=iter+1:rowSize
        multiplierRow=U(iter,:)*L(k,iter);
        deletedRow = U(k,:)-multiplierRow;
        U(k,:)=deletedRow;
    end
end
end

