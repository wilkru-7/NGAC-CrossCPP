/* Authors: André Christofferson & Wilma Krutrök */

/*  
	This example is currently not working but
	illustrates what we would want to achieve with
	combining conditions in a policy.

	Creating three users and two objects
    u1 can book o1
    u2 can book o2
    u3 can book o1 and o2
    Only allowed to book if user and object are at same location
	and the time is between business hours.
*/
policy(combine_conditions, 'combine_conditions - Book Lift', [
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

	/*
		This example does not currently work but we 
		want to have two different conditions to both be fulfilled
		in order to make the associate calls. Maybe by having them
		in an array as in this example it would be possible to even 
		add more than two conditions.
		The access call to this policy could then look somthing like this:
		http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=[is_same_location(siteA,siteA)]

	*/
	cond([is_same_location(_,_), is_business_hours], [
		associate('Group1',[book],'Fork Lifts'),
        associate('Group2',[book],'Scissor Lifts'),
	    associate('Group3',[book],'Lifts')
        ])
]).