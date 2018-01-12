% c = [-3 1 1]';
% a = [1 -2 1; -4 1 1];
% b = [11 3]';
% lb = [];
% ub = [1 1 1]';
% ctype = 'UL';
% vartype = 'III';

% [xopt, fmin, errnum, extra] = glpk(c, a, b,lb, ub, char(ctype), char(vartype), 1);

printf('The optimal solution is %d\n', fmin);
printf('At : \n');
display(xopt);

cij = [1000000 3 5;7 4 9;1 8 6];
dj = [5 6 19]';
si = [4 7 19]';