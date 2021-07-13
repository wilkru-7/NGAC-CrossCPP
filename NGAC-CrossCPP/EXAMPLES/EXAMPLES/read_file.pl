/* Authors: André Christofferson & Wilma Krutrök */

/*  Creating three users and two objects
    u1 can read o1
    u2 can read o2
    u3 can read o1 and o2
    only allowed to read during business hours (07-18)
*/
policy(read_file, 'Read File', [
	user('u1'),
	user('u2'),
    user('u3'),

	user_attribute('Group1'),
	user_attribute('Group2'),
    user_attribute('Group3'),
	user_attribute('Groups'),

	object('o1'),
	object('o2'),

    object_attribute('Reports'),
	object_attribute('Proposals'),
    object_attribute('Files'),

	policy_class('Read File'),
	connector('PM'),

	assign('u1','Group1'),
	assign('u2','Group2'),
    assign('u3','Group3'),
	assign('Group1','Groups'),
	assign('Group2','Groups'),
    assign('Group3','Groups'),

	assign('o1','Reports'),
	assign('o2','Proposals'),
    assign('Reports','Files'),
    assign('Proposals','Files'),

	assign('Groups','Read File'),
	assign('Files','Read File'),

    assign('Read File','PM'),

	operation(read,'File'),

	cond(is_business_hours, [
		associate('Group1',[read],'Reports'),
        associate('Group2',[read],'Proposals'),
	    associate('Group3',[read],'Files')
        ])
]).