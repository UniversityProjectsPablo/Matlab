function [flag, At, bt]= ownTriangulationPartialPivoting(A,b)
% [At,bt] = ownTriangulationPartialPivoting(A,b)
% Performs a forward elimination proces over the matrix [A b]
%	such that A*x = b and At*x = bt share the same solution x
%	with partial pivoting
% Inputs:
%	A: Coefficients matrix
%	b: Independent term
% Outputs:
%	flag: Flag = 0 -> The system of LE has a unique solution
%	      Flag = 1 -> The system of LE has infinite or has not a solution		 
%	At: Upper triangular matrix
% 	bt: Modified independent term
[index,~] = size(b);
At = A;
bt = b;
for i=1:1:index
 for j=i+1:1:index
 bt(j)=(bt(i)*At(j,i)-bt(j)*At(i,i));
 At(j,:) = At(i,:)*At(j,i) - At(j,:)*At(i,i);
 disp(At);
 disp(bt);
 end
end


end
