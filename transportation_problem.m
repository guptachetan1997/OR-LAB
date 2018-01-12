% cij = [61 72 45 55 66; 69 78 60 49 56; 59 66 63 61 47;];

% si = [15 20 15]';

% dj = [11 12 9 10 8]';

function output = transportation_problem(cij, si, dj)
	printf('The parameter table is : \n')
	display(cij)
	printf('The supply is :')
	display(si')
	printf('The demand is :')
	display(dj')
	c = cij'(:);
	[m, n] = size(cij);
	A = zeros(m, m*n);
	for i=1:m
		starting = (i-1)*n +1;
		ending = i*n;
		A(i, starting:ending) = ones(1, n);
	end
	for j=1:n
		nows = zeros(m, n);
		for i=1:m
			nows(i, j) = 1;
		end
		A(m+j, :) = nows'(:);
	end
	b = cat(1, si, dj);
	ind = zeros(m+n, 1);
	ctype = [];
	vartype = [];
	for i=1:m+n
		ctype(i) = 'S';
	end
	for i=1:m*n
		vartype(i) = 'I';
	end
	[xopt, fmin, errnum, extra] = glpk(c, A, b,[], [], char(ctype), char(vartype));
	printf('The optimal solution is %d, using : \n', fmin);
	idx = 1;
	for i=1:m
		for j=1:n
			if xopt(idx) ~= 0
				printf('X%d%d = %d, ', i, j,xopt(idx))
			end
			idx+=1;
		end
	end
end