function [x] = backSubs(A,b)
% [x] = backSubs(A,b)
% Performs a backsubstitution process over the matrix [A b]
%	to find x such that A*x = b with A upper triangular
% Inputs:
%	A: Upper triangular coefficients matrix
%	b: Independent term
% Outputs:
%	x: Solution of A*x = b

index = size(b,1); %first que get the size of the matrix
x = zeros(1,index); %we make a vector full of zeroes 

x(index) = b(index)/A(index,index); %we find the solutuion of the last variable

    for i = index-1:-1:1
    x(i) = (b(i)-dot(A(i,:),x))/A(i,i); 
    disp(x);
    %once we find the solution que can 
    %substitute and iteratively find the other solutions
    end
end

