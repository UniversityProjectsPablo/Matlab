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
[index,~] = size(b);
At = A;
bt = b;
for i=1:1:index-1
 for j=i:1:index-1
 bt(j+1)=b(j+1)*A(i,1)- b(i)*A(j+1,1);
 At(j+1,:) = A(j+1,:)*A(i,1) - A(i,:)*A(j+1,1);
 disp(At);
 disp(bt);
 end
 A = At;
 b = bt;
end
