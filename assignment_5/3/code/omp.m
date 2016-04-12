function [ S_t ] = omp( Y,A,sd )
	% If there is noise, then epsilon should
	% be set, based on the noise variance
	epsilon = sd^2 ;
	S_t = zeros(size(A,2),size(Y,2));
	normA =  sqrt(sum(abs(A.^2))); 
	for i = 1: size(Y,2)
		% Taking the columns of the signal 
		y = Y(:,i);
		r_i = y;
		% Support set .It gets successively updated
		T_i = zeros(64,1); 
		s_t_i = zeros(64,1);
		
		while(norm(r_i)^2 > epsilon)
			% Find j corresponding to max of the expression
		    [~,j] = max( abs(r_i' * A)./normA );
		    T_i(j) = T_i(j) + 1;
		    A_t = A(:,T_i>0);
			% Take inverse
		    s_t_i( T_i>0 ) = A_t \ y;
			% update r_i
		    r_i = y - A_t*s_t_i(T_i>0);
		end  
		S_t(:,i) = s_t_i;
	end
end

