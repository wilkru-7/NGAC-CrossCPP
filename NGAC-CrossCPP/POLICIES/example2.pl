policy('example2', 'Book Lifts Business Hours', [
	conditions([is_business_hours]),
	user('u1'),
	user('u2'),

	user_attribute('Alice'),
	user_attribute('Bob'),
	user_attribute('Users'),

	object('o1'),
	object('o2'),
	object('o3'),

	object_attribute('Lifts'),
	object_attribute('Sites'),

	policy_class('Book Lifts Business Hours'),
	connector('PM'),

	assign('u1','Alice'),
	assign('u2','Bob'),
	assign('Alice','Users'),
	assign('Bob','Users'),

	assign('o1','Lifts'),
	assign('o2','Lifts'),
	assign('o3','Lifts'),

	assign('Users','Book Lifts Business Hours'),
	assign('Lifts','Book Lifts Business Hours'),

    assign('Book Lifts Business Hours','PM'),

	operation(book,'Lift'),

	cond( is_business_hours,
		associate('Alice',[book],'o2') ),

	associate('Bob',[book],'Lifts')
]).