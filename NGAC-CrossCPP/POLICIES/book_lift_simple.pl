/* Authors: André Christofferson & Wilma Krutrök */

policy('example1', 'Book Lifts', [
	%conditions([current_day_is_one_of(list)]),
	user('u1'),
	user('u2'),

	user_attribute('Alice'),
	user_attribute('Bob'),
	user_attribute('Users'),

	object('o1'),
	object('o2'),
	object('o3'),

	object_attribute('Lifts'),

	policy_class('Book Lifts'),
	connector('PM'),

	assign('u1','Alice'),
	assign('u2','Bob'),
	assign('Alice','Users'),
	assign('Bob','Users'),

	assign('o1','Lifts'),
	assign('o2','Lifts'),
	assign('o3','Lifts'),

	assign('Users','Book Lifts'),
	assign('Lifts','Book Lifts'),

    assign('Book Lifts','PM'),

	operation(book,'Lift'),

	cond( current_day_is_one_of(['Monday','Tuesday','Wednesday','Thursday','Friday']),
		[associate('Alice',[book],'o2'),
		associate('Alice',[book],'o3')]  ),

	associate('Bob',[book],'Lifts')
	
]).
