%% Matlab introduction exercises :
% Based on: 
% 
% Beginning Matlab Exercises
% 
% R. J. Braun
% 
% Department of Mathematical Sciences
% 
% University of Delaware
% 
% 
%% Advice:
% If you feel lost in MatLab, remember you have a good friend called help
%% Working with scalars:
% Matlab can be used as a calculator. Some of the problems indicate the precedence 
% of arithmetic operations.
% 
% 1. 3*2^4


%% 
% 2.  (3*2)^4  % parentheses have highest priority


%% 
% 3. 3-2^4


%% 
% 4. 3^4-3


%% 
% 5. 8/2^4


%% 
% 6. 2^4\8    % same as previous! two different divisions, \ and /


%% 
% 7. 8^4/2


%% 
% Precedence of arithmetic operations is: (1) parentheses, (2) exponentiation, 
% (3) multiplication and division, and (4) addition and subtraction. Calculations 
% proceed from left to right on the line and equal precedence is settled in this 
% way.
% 
% 
%% Starting with Vectors :
% It will typically be that our basic unit for computing will be a vector. We 
% need to be able to create and manipulate them.
% 
% 1. x = [3 4 7 11]  % create a row vector (spaces)


%% 
% 2. x = 3:8 % colon generates list; default stride 1


%% 
% 3. x = 8:-1:0 % start : stride : stop specifies list


%% 
% 4. xx = [ 8 7 6 5 4 3 2 1 0];  % same as last; semicolon suppresses output


%% 
% 5. xx % display contents


%% 
% 6. x = linspace(0,1,11) % generate vector automatically


%% 
% 7. x = 0:0.1:1 % same thing


%% 
% 8. y = linspace(0,1); % note semicolon!


%% 
% 9. length(x)


%% 
% 10. length(y)


%% 
% 11. size(x)


%% 
% 12. size(y)


%% 
% 13. y(3) % access single element


%% 
% 14. y(1:12) % access first twelve elements


%% 
% 15. y([3 6 9 12]) % access values specified in a vector!


%% 
% 16. x’ % transpose


%% 
% 17. 3*[1 2 5] % factor replicated, multiplies each element


% Matlab labels the arrays (vectors and matrices) beginning with 1; this 
% will be an important programming in detail on more than one occasion.

%% Vectors and matrix arithmetic:
% We’ll now explore making matrices and doing arithmetic with them. There are 
% some new arithmetic operations that you did not see before in linear algebra, 
% but they will be useful nonetheless.
% 
% 1. g = [1; 2; 3; 4]


%% 
% 2. g = [1 2 3 4; 5 6 7 8]


%% 
% 3. g - 2


%% 
% 4. 2*g-1


%% 
% 5. g = [1 2 3 4; 5 6 7 8; 9 10 11 12]


%% 
% 6. h = [1 1 1 1; 2 2 2 2; 3 3 3 3]


%% 
% 7. g-h


%% 
% 8. g*h % What happened?


%% 
% 9. h*g


%% 
% 10. g.*h % NOT the usual matrix multiplication! Elementwise!


%% 
% 11. g./h % elementwise division; denominator below slash


%% 
% 12. h.\g % Last two same!


%% 
% 13. g*h’


%% 
% 14. g’*h


%% 
% 15. e = [ 1 2 3; 4 5 6; 7 8 0]


%% 
% 16. f = [9 8 7; 6 5 4; 3 2 1]


%% 
% 17. e*f


%% 
% 18. f*e % Not same!


%% 
% 19. q = rand(3) % matrix with elements uniformly on [0,1]


%% 
% 20. A^2 % raise matrix to a power


%% 
% 21. A^2 - A*A % verify with definition


%% 
% 22. A.^2 % square each element


%% 
% 23. A.^2 - A*A % not the same!


%% Creating standard arrays:
% There are some arrays or matrices that we will be using very often. MatLab 
% has usually shortcurts to produce them.
% 
% 1. ones(3) % All ones


%% 
% 2. zeros(2,5) % All zeros


%% 
% 3. size(zeros(2,5))


%% 
% 4. size(g)


%% 
% 5. ones(size(g))


%% 
% 6. eye(4) % Identity matrix


%% 
% 7. eye(2,4)


%% 
% 8. eye(4,2)


%% 
% 9. rand(3) % Random elements uniformly distributed between 0 and 1


%% 
% 10. b = eye(3)


%% 
% 11. rand(size(b))


%% 
% 12. a = 1:4


%% 
% 13. a = 1:2:9


%% 
% 14. diag(a)


%% 
% 15. diag(a,1)


%% 
% 16. diag(a,-2)


%% 
% 17. linspace(1,10,10)


%% Array manipulation
% Many times we just want to alterate part of an array or creating a new one 
% from the content of an existing one. MatLab has nice and effective ways to do 
% that
% 
% g = [1 2 3 4; 5 6 7 8; 9 10 11 12]


%% 
% 2. g(3,2) % single element


%% 
% 3. g(:,2) % all rows, second column


%% 
% 4. g(2,:) % second row, all columns


%% 
% 5. g(1:2,:)


%% 
% 6. g(2,:) = [1 1 1 1] % replace row


%% 
% 7. g(:,2) = [2; 2; 2] % replace column


%% 
% 8. G = [g; 9 10 11 12]


%% 
% 9. G = [G [1;2;3;4] ]


%% Some usefull comands:
% 1. clc


%% 
% 2. clear g G


%% 
% 3. clear all


%% 
% 
%% Reserved words:
% Matlab has a list of reserved words that has a prescribed value or that corresponds 
% to internal functions.
% 
% The following words are already used in Matlab and they must be avoided: 
% for, end, if, while, function, return, elseif, case, otherwise, switch, continue, 
% else, try, catch, global, persistent, break. (You can use similar words by capitalizing 
% one or more letters if your system is case sensitive.) the following variable 
% names are special in Matlab and you should avoid changing them unless you are 
% very careful about what you are doing: ans, beep, pi, eps, inf, NaN, nan, i, 
% j, nargin, nargout, realmin, realmax, bitmax, varargin, vararout.
% 
% 1. end = 1 % you should get an error


%% 
% 2. End = 1 % could get error, depending on system


%% 
% 3. pi = 3 % forgetting thousands of years of progress!


%% 
% 4. pi


%% 
% 5. clear pi


%% 
% 6. pi % back to the present!


%% Functions:
% MatLab has a very big internal library  which offers many implementations 
% of the more required computer sc ience and mathematical solutions. You can use 
% them anytime you want without the need of including them. You can find a list 
% in the help menu. 
% 
% 1. help elfun % An short list of the most elemental functions


%% 
%  2. Run the next box and observe the results

n = 11;
u = linspace(0,2*pi,n)
v = cos(u) % all function evaluations done at once!
%% 
% You can create new functions, they are (generally) separate files that 
% has to be on the MatLab path in order to be callable. 
% 
% 3. Take a look on the attatched function 'DummyFunction.m' and execute 
% the next box

[s,m] = dummyFunction(a,b);
%% 
% 4. Create a function named 'evaluateMyFcn(x)' that given a column vector 
% x, returns the value of the function
% 
% $$f(x) = \frac{1 +x^2}{1+abs(x)}$$
% 
% for every entry of x. Try to do it in only one line

x = linspace(-10,10,25)';

[f] = evaluateMyFcn(x)
%% 
% 
%% Logical and relational operators:
% MatLab is not only a powerfull calculator, but a programming language. In 
% order to control the flux execution of a program we need to evaluate logic conditions.
% 
% Relational operators carry out comparisons or tests and the result is to 
% return logical values True (1) or
% 
% False (0). The relational operators that are available (and their Matlab 
% form) are: less than (<), less than
% 
% or equal to (<=), greater than (<), greater than or equal to (>=), equal 
% to (==), and not equal to (∼=).
% 
% Note that == is a test between two quantities, while = assigns a value 
% to a variable. We can use these to
% 
% compare scalars and arrays; try out the following.
% 
% 1. a = 4; b = -1; c = 1;


%% 
% 2. a > b % note that the output is a logical value


%% 
% 3. a < b


%% 
% 4. a >= b


%% 
% 5. mytest = (abs(b) == c) % parentheses optional but clearer


%% 
% Things get a little more complicated with arrays. Using the g and h behind, 
% try out the following.

g = [1 2 3 4; 5 6 7 8; 9 10 11 12];
h = [3 3 4 4; 5 5 6 6; 7 7 8 8];

%% 
% 3. h >= g


%% 
% 4. g == h % note that the output is a logical value


%% 
% 5. bigger = (g >= h)


%% 
% 6. g(bigger)


%% 
% 7. g([0 0 0 1; 1 1 1 1; 1 1 1 1]) % array argument not logical!


%% 
% We can string relational operators together and manipulate logical variables 
% using logical operators. They are (Matlab in parentheses): logical AND (&), 
% logical OR (|) and logical NOT (~) (Alt Gr 4) .  The NOT operator just changes 
% the value of the logical variable to the other value. A truth table shows what 
% the AND and OR operators do; it will be given in class. The upshot is that the 
% both parts from an AND operator must be True to return a True; only one of the 
% inputs for the OR operator need be True for it to return True. 
% 
% Continuing with the last set of Matlab commands, try these out.
% 
% 1. h >= g


%% 
% 2. p = ~(h >= g)


%% 
% 3. ~p


%% 
% 4. (g == h) & (g > h)


%% 
% 5. (g == h) | (g > h)


%% 
% 6. g >= h


%% *For loop* 
% The *for loop* repeats the commands that are inside of it. The basic structure 
% is
% 
% for <list-of-values>
% 
%     <statements-to-be-done>
% 
% end
% 
% Use this structure to repeat output, or do calculations
% 
% 1. % for loop now

x = rand(10,1)
for k = 1:5
    x(k)
end
%% 
% 2. % for loop doing a calculation

total = 0;
for k = 1:10
    total = total + x(k);
    fprintf('Total for k=%i is %g',k,total)
end
%% 
% 3. sum(x) % built in matlab command sums components of vector


%% 
% Here the command sum can replace the loop; it adds up the elements of 
% a vector.
%% If-else statement
% Sometimes we want to compute one set of commands or another depending on the 
% result of a relational test.
% 
% There are several forms that this sort of construct can take.
% 
% *The simplest is*:
% 
% _if <expression>_
% 
% _    <commands evaluated if True>_
% 
% _end_
% 
% An example follows; given a positive number of pens, a cost is computed 
% and displayed.

pens = 8;

if (pens >= 0)
    cost = pens*1.99;
    fprintf('Cost of %i pens is $ %f',pens,cost)
end
%% 
% *Intermediate*
% 
% _if <expression>_
% 
% _  <commands evaluated if True>_
% 
% _else_
% 
% _    <commands evaluated if False>_
% 
% _end_
% 
% __
% 
% The example now prints a warning for negative numbers of pens. Try to change 
% the value associated to pens and see what happen

pens = -1;

if (pens >= 0)
    cost = pens*1.99;
    fprintf('Cost of %i pens is $ %f',pens,cost)
else
    disp('An invalid number of pens was specified.')
end
%% 
% The most general form is:
% 
% 
% 
% _if <expression1>_
% 
% _        <commands evaluated if expression1 is True>_
% 
% _elseif <expression2>_
% 
% _        <commands evaluated if expression2 is True>_
% 
% _elseif <expression3>_
% 
% _        <commands evaluated if expression3 is True>_
% 
% _elseif <expression4>_
% 
% _        <commands evaluated if expression4 is True>_
% 
% _else_
% 
% _        <commands evaluated if all other expressions are False>_
% 
% _end_
% 
% __
% 
% We aren’t limited to 4 expressions here; we could add more. We could use 
% this to price pens according to
% 
% quantity, as follows.

sale = false;
pens = 25
if (pens >= 0) && (pens < 20)
    cost = pens;
    sale = true;
elseif (pens >= 20) && (pens < 40)
    cost = pens*0.95;
    sale = true;
elseif (pens >= 40) && (pens <= 100)
    cost = pens*0.90;
    sale = true;
else
    disp('not a valid number of pens')
end

if sale
    fprintf('Cost of %i pens is $ %f',pens,cost)
end
%% 
% Note that leaving off the last part (else and the related commands following 
% it) will result in no action being taken if none of the previous expressions 
% result in True values
% 
% 
%% While operator
% Sometimes, we want to repeat commands until a condition is satisfied. If we 
% don’t know how many repetitions are required in advance, a while loop is preferable 
% over a for loop. The general structure is
% 
% _while <expression>_
% 
% _        <commands>_
% 
% _end_
% 
% The commands inside the while loop will be repeated as long as the expression 
% returns a value of True, provided that expression returns a scalar. If the expression 
% evaluates to an array, then all of the values that result from it must be True 
% for commands to be evaluated. An example follows; it could be typed into a script 
% file or at the command prompt. In the example, we halve a number until it is 
% so small that the computer can’t detect it when added to 1; the last number 
% before this occurs is called machine epsilon and we’ll talk about it more in 
% class.

num = 0; myeps = 1;
while (1+myeps) > 1
    myeps = myeps/2;
    num = num + 1;
end
num
myeps = 2*myeps
eps % matlab’s preset variable for machine epsilon
%% 
% The result is that myeps = eps = 2 −52 .
%% Plots
% 1. Observe the output of the next code box:

n = 11;
u = linspace(0,2*pi,n);
v = cos(u);
% all function evaluations done at once!
plot(u,v);
%% 
% 
% 
% 2. The last plot had a crude “curve” representing the cosine function; 
% repeat the last example with n=101
% 
% to improve the curve.


%% 
% 
% 
% 3. Add these commands to clean up the plot by adding axis labels and a 
% title. The text inside the single
% 
% quotes is a string which we intend to be the labels, etc.
% 
% xlabel(’u’); ylabel(’v’); title(’v = cos(u)’);


%% 
% 4.  The next box approximates the exponential function by :
% 
% $$<math xmlns="http://www.w3.org/1998/Math/MathML" display="block"><mrow><mi 
% mathvariant="italic">f</mi><mrow><mo>(</mo><mrow><mi mathvariant="italic">x</mi></mrow><mo>)</mo></mrow><mo>=</mo><mfrac><mrow><mn>1</mn><mo>&minus;</mo><mfrac><mrow><mn>3</mn></mrow><mrow><mn>5</mn></mrow></mfrac><mi 
% mathvariant="italic">x</mi><mo>+</mo><mfrac><mrow><mn>3</mn></mrow><mrow><mn>20</mn></mrow></mfrac><msup><mrow><mi 
% mathvariant="italic">x</mi></mrow><mrow><mn>2</mn></mrow></msup><mo>&minus;</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>60</mn></mrow></mfrac><msup><mrow><mi 
% mathvariant="italic">x</mi></mrow><mrow><mn>3</mn></mrow></msup></mrow><mrow><mn>1</mn><mo>+</mo><mfrac><mrow><mn>2</mn></mrow><mrow><mn>5</mn></mrow></mfrac><mi 
% mathvariant="italic">x</mi><mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>20</mn></mrow></mfrac><msup><mrow><mi 
% mathvariant="italic">x</mi></mrow><mrow><mn>2</mn></mrow></msup></mrow></mfrac></mrow></math>$$
% 
% Observe what the legend function does

n= 150;
x = linspace(0,1,n);
xsqd = x.^2;
num = 1-(3/5)*x+(3/20)*xsqd -(x/60).*xsqd
den = 1+(2/5)*x+(1/20)*xsqd
y = num./den;
plot(x,y,x,exp(-x))
xlabel('x');
ylabel('e^{-x}');
title('Rational function approximation to e^{-x}')
legend('Rational Function','e^{-x}')

%% 
% The commands _figure(), hold on _and _hold off _will allow to create new 
% figures and superpose curves

x = linspace(0,1);
y = 1 - x + x.^2/2 - x.^3/6;
exact = exp(-x);
figure % create new figure  window for plotting y
plot(x,y)
figure % create new figure
plot(x,exact)
hold on
% causes subsequent curves to be added to current figure
plot(x,y,'r-.')
hold off  % returns to normal plotting mode