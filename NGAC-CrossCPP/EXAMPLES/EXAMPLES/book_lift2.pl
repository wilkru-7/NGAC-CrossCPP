/* Authors: André Christofferson & Wilma Krutrök */

/*  Creating three users and two objects
    u1 can book o1
    u2 can book o2
    u3 can book o1 and o2
    only allowed to book if user and object are at same location
*/
policy(book_lift2, 'Book Lift 2', [
	user('u1'),
	user('u2'),
    user('u3'),

	user_attribute('Group1'),
	user_attribute('Group2'),
    user_attribute('Group3'),
	user_attribute('Groups'),

	object('o1'),
	object('o2'),

    object_attribute('Fork Lifts'),
    object_attribute('Scissor Lifts'),
    object_attribute('Lifts'),

	policy_class('Book Lift'),
	connector('PM'),

	assign('u1','Group1'),
	assign('u2','Group2'),
    assign('u3','Group3'),
	assign('Group1','Groups'),
	assign('Group2','Groups'),
    assign('Group3','Groups'),

	assign('o1','Fork Lifts'),
	assign('o2','Scissor Lifts'),
    assign('Fork Lifts','Lifts'),
    assign('Scissor Lifts','Lifts'),

	assign('Groups','Book Lift'),
	assign('Lifts','Book Lift'),

    assign('Book Lift','PM'),

	operation(book,'Lift'),

	cond(is_business_hours, [
		associate('Group1',[book],'Fork Lifts'),
        associate('Group2',[book],'Scissor Lifts'),
	    associate('Group3',[book],'Lifts')
        ])
]).