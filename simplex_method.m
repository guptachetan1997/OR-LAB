function [T, BV] = simplex_method(c, A, b, ind)
		[m,n] = size(A);
		index = 1;
		addedCost = [];
		BV = [];
		XB = [];
		augA = A;
		M = 10000;
		for i=1:length(ind)
			switch ind(i)
			case -1
				addedCost(index) = 0;
				XB(i) = 0;
				BV(i) = index+m;
				temp = zeros(m, 1);
				temp(i) = 1;
				A(:, n+index:n+index) = temp;
				index+=1;
			case 0
				addedCost(index) = -M;
				XB(i) = -M;
				BV(i) = index+m;
				temp = zeros(m, 1);
				temp(i) = 1;
				A(:, n+index:n+index) = temp;
				index+=1;
			case 1
				addedCost(index) = 0;
				addedCost(index+1) = -M;
				XB(i) = -M;
				BV(i) = index+m+1;
				temp = zeros(m, 1);
				temp(i) = -1;
				A(:, n+index:n+index) = temp;
				temp(i) = 1;
				A(:, n+index+1:n+index+1) = temp;
				index+=2;
			end
		end
		T = [1 c' addedCost 0;
			XB' A b];
	end