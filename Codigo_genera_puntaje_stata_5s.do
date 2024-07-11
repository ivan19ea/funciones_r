
* EM algorithm for record linkage based on the Fellegi-Sunter model
* In this implementation the emlink program requires 7 binary variables 
* Each indicate agreement (=1) or disagreement (=0) for its corresponding attribute
* These variables must be named as s1, s2, s3, s4, s5, s6 and s7
* Program options:
* tol - Specify tol where tolerance is equal to 10^(-tol)
* priorp - Set up prior value for parameter p 
* save - Specify a dta datafile name to save m-probabilities, u-probabilities and p 
* score - Specify the name of the similarity score variable to be generated
* A priori m and u probabilities are specified in the first lines of the program



emlink , tol(6) priorp(.07) save("directorio") score(puntaje)



program define emlink
syntax, tol(numlist) priorp(numlist) save(string) score(string)
	local a = 5	
	forvalues x=1/`a' {
		* Set up m and u a-priori probabilities
		* m_i = 0.95, u_i = 0.20 for i!=5 and u_i=0.5 for i==5		
		local m`x' = .95
		if `x' == 2 {
			local u`x' = .5
			}
		else {
			local u`x' = .2
			}	
		* Generate temporary variables		
		tempvar _g`x'
		gen double `_g`x'' = .
		local m`x'i0 `m`x''
		local u`x'i0 `u`x''
		local tolm`x' = 0
		local tolu`x' = 0	
		sum s`x'
		local s`x' = r(sum)			
		}
	* Tolerance
	local tolerancia = 10^(-`tol')		
	tempvar g
	gen double `g' = .		
	local p = `priorp'
	local pi0 = `p'
	cou
	local N = r(N)
	* Iterations
	local h = 0
	while `tolm1'==0 | `tolm2'==0 | `tolm3'==0 | `tolm4'==0 | `tolm5'==0  | `tolu1'==0 | `tolu2'==0 | `tolu3'==0 | `tolu4'==0 | `tolu5'==0  {
		local h = `h'+1
		local r = `h'-1
		di "Iteration `h':"
		* E Step
		replace `g' = `p'*((`m1'^s1)*(1-`m1')^(1-s1))*((`m2'^s2)*(1-`m2')^(1-s2))*((`m3'^s3)*(1-`m3')^(1-s3))*((`m4'^s4)*(1-`m4')^(1-s4))*((`m5'^s5)*(1-`m5')^(1-s5))
		replace `g' = `g'/(`g'+(1-`p')*((`u1'^s1)*(1-`u1')^(1-s1))*((`u2'^s2)*(1-`u2')^(1-s2))*((`u3'^s3)*(1-`u3')^(1-s3))*((`u4'^s4)*(1-`u4')^(1-s4))*((`u5'^s5)*(1-`u5')^(1-s5))  )
		* M Step
		* p parameter
			sum `g'	
			local p = r(mean)
			di "p parameter, iteration `h' = " `p'
		* m and u probabilities
		forvalues x=1/`a' {
			replace `_g`x'' = `g'*s`x'
			sum `_g`x''
			local g`x' = r(sum)
			local m`x' = (`g`x'')/(`p'*`N')
			local u`x' = (`s`x''-`g`x'')/((1-`p')*`N')
			di "m`x' prob = " `m`x''
			di "u`x' prob = " `u`x''
			if `m`x'' > 1-`tolerancia' {
				local m`x' = 1-`tolerancia'
				}
			if `u`x'' > 1-`tolerancia' {
				local u`x' = 1-`tolerancia'
				}				
			* Tolerance
			if abs(`m`x''-`m`x'i`r'') < `tolerancia' {
				local tolm`x' = 1
				di "Tolerance achieved in iteration `h' for attribute `x'"
				}	
			if abs(`u`x''-`u`x'i`r'') < `tolerancia' {
				local tolu`x' = 1
				di "Tolerance achieved in iteration `h' for attribute `x'"
				}				
			}
		* Save probabilities from the iteration
		forvalues x=1/`a' {
			local m`x'i`h' `m`x''
			local u`x'i`h' `u`x''	
			}
		local pi`h' `p'
		}
	* Save probabilities
	preserve
	clear
	local nobs = `h'+1
	set obs `nobs'
	forvalues x=1/5 {
		gen double m`x' = .
		gen double u`x' = .
		forvalues j=1/`nobs' {
			local r = `j'-1
			replace m`x' =  `m`x'i`r'' in `j'
			replace u`x' =  `u`x'i`r'' in `j'
			}
		}
	gen double p = .
		forvalues j=1/`nobs' {
			local r = `j'-1
			replace p =  `pi`r'' in `j'
			}		
	save "`save'", replace
	restore
	* Weights
	forvalues x=1/`a' { 
	local w`x'm = ln(`m`x''/`u`x'')/ln(2) 
	local w`x'u = ln((1-`m`x'')/(1-`u`x''))/ln(2)	
	n: di "w`x' match = " `w`x'm'
	n: di "w`x' unmatch = " `w`x'u'		
	}
	* Calculate score 
	gen double `score' = s1*`w1m'+(1-s1)*`w1u' + s2*`w2m'+(1-s2)*`w2u' + s3*`w3m'+(1-s3)*`w3u' + s4*`w4m'+(1-s4)*`w4u' + s5*`w5m'+(1-s5)*`w5u' 
end

* Example:
* emlink, tol(5) priorp(0.1122) save(probabilities) score(simscore)
