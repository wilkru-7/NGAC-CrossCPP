/* Authors: André Christofferson & Wilma Krutrök */

/* Code copied from pdp_test.pl */
own_startup_tests([test1, test2, test3, test4, 
	test5, test6, test7, test8, test9, test10, 
	test11, test12]).
own_regression_tests([]).

self_test :-
	own_startup_tests(Tests),
	forall(member(T,Tests), test:report_test(pdp:T)).

regression_test :-
	own_startup_tests(Startup),
	own_regression_tests(Regression),
	append(Startup,Regression,AllTests),
	forall(member(T,AllTests), test:report_test(pdp:T)).

/* Access calls checking if simple policies are working */
test1 :- \+ access_check('example1',(u1,book,o1)).
test2 :- access_check('example1',(u1,book,o2)).
test3 :- \+ access_check('example1',(u1,book,o3)).
test4 :- access_check('example1',(u2,book,o1)).
test5 :- access_check('example1',(u2,book,o2)).
test6 :- access_check('example1',(u2,book,o3)).

test7 :- \+ access_check('example2',(u1,book,o1)).
test8 :- access_check('example2',(u1,book,o2)).
test9 :- \+ access_check('example2',(u1,book,o3)).
test10 :- access_check('example2',(u2,book,o1)).
test11 :- access_check('example2',(u2,book,o2)).
test12 :- access_check('example2',(u2,book,o3)).