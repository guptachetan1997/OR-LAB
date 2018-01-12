function [z_max, x_max, status] = simplex_lp_solver(c, A, b, maxiter=100)
	[T, BV] = first_simplex_tableau(c, A, b);
	status = 'unknown';
	iter = 1;
	while(iter < maxiter && !strcmp(status, 'unbounded') && !strcmp(status, 'optimal'))
		fprintf('Iteration %d : \n', iter);
		disp(T);
		fprintf('\n');
		[T, BV, status] = new_tableau(T, BV, c);
		iter = iter + 1;
	end;
	if(iter >= maxiter || strcmp(status, 'unbounded'))
		z_max = 0;
		x_max = zeros(length(c), 1);
		return;
	end;
	z_max = T(1:end, 1)' * T(1:end, columns(T));
	x_max = zeros(length(c) + length(b), 1);
	x_max(BV) = T(2 : (length(b) + 1), columns(T));
	x_max = x_max(1 : length(c));
	fprintf('Maximum Value = %d \n', z_max);
	fprintf('Optimal Position : ');
	for i=1:length(x_max)
		fprintf('x%d = %d, ', i, x_max(i));
	end

	function [T, BV] = first_simplex_tableau(c, A, b)
		[m,n] = size(A);
		T = [1 c' zeros(1, m) 0;
			zeros(m, 1) A eye(m) b];
		BV = ( (n+1):(n+m) )';
	end

	function [T, BV, status] = new_tableau(T, BV)
		status = 'unknown';
		B = T(2:end, columns(T):columns(T));
		CB = T(2:end, 1:1);
		Aij = T(2:end, 2:columns(T)-1);
		Cj = T(1:1, 2:columns(T)-1);
		Zj = CB'*Aij;
		Cbar = Cj - Zj;

		if( all(Cbar <= 0) )
			status = 'optimal';
			return;
		end

		[_, enteringVariable] = max(Cbar);
		keyColumn = T(2:end, 1+enteringVariable:1+enteringVariable);
		if(all(keyColumn <= 0))
			status = 'unbounded';
			return;
		end
		minRatio = 10000000;
		leavingVariable = 0;
		for i=1:length(keyColumn)
			if(keyColumn(i) > 0)
				curRatio = B(i)/keyColumn(i);
				if(curRatio < minRatio)
					minRatio = min(curRatio, minRatio);
					leavingVariable = i;
				end
			end
		end
		pivot = T(leavingVariable+1, enteringVariable+1);
		keyRow = T(leavingVariable+1, 2:columns(T))/ pivot;
		BV(leavingVariable) = enteringVariable;
		pivotThing = repmat(keyColumn, 1,length(keyRow)) .* repmat(keyRow, length(keyColumn), 1);
		newT = T;
		newT(2:end, 2:end) = T(2:end, 2:end) - pivotThing;
		newT(leavingVariable+1, 2:end) = keyRow;
		newT(leavingVariable+1, 1) = Cj(enteringVariable);
		T = newT;		
	end
end