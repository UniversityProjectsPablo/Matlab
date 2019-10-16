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
index = size(b,1);
At = A;
bt = b;
for i=1:1:index
 for j=i+1:1:index
    if (At(i,i) > -1e-8)&&(At(i,i)<1e-8)
        auxA = At(i,:);
        auxb = bt(i);
        [a,~] = max(abs(A(i:index,i)));
        a = 1+a;
        At(i,:) = At(a,:);
        bt(i) = bt(a);
        At(a,:) = auxA;
        bt(a) = auxb;
    end
 bt(j)=(bt(i)*At(j,i)-bt(j)*At(i,i));
 At(j,:) = At(i,:)*At(j,i) - At(j,:)*At(i,i);
 disp(At);
 disp(bt);
 end
end
    if At(i,i)== 0 
    flag = 1;
    else
    flag = 0;    
    end

end

%end