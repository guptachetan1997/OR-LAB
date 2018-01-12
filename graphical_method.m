c = [3 8]';
A = [1 1; -2 3; -1 -2; 3 -1; -1 0; 0 1];
b = [8; 0; -30; 0; -10; 9];

[x_min z_min] = glpk(c, A, b, [0,0]', [], 'LLLLLL', 'CC', 1);

printf('x1 = %d and x2 = %d \n', x_min);
printf('Solution = %d \n', z_min);
