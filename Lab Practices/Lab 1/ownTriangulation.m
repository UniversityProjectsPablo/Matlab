function [At, bt]= ownTriangulation(A,b)
% [At,bt] = ownTriangulation(A,b)
% Performs a forward elimination proces over the matrix [A b]
%	such that A*x = b and At*x = bt share the same solution x
% Inputs:
%	A: Coefficients matrix
%	b: Independent term
% Outputs:
%	At: Upper triangular matrix
% 	bt: Modified independent term
index = size(b,1); %we find how many rows we have to triangulate
At = A;
bt = b;
    for i=1:1:index
        for j=i+1:1:index
        bt(j)=(bt(i)*At(j,i)-bt(j)*At(i,i));
        At(j,:) = At(i,:)*At(j,i) - At(j,:)*At(i,i);
        %by multiplying we iteratively find the other results
        end
    end
end
