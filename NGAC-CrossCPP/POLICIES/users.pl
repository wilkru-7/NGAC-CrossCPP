/* Authors: André Christofferson & Wilma Krutrök */
policy(users, 'Defining Users', [
	user('u1'),
	user('u2'),
	user('u3'),
	user('u4'),

	user_attribute('Groups'),
	user_attribute('GroupA'),
	user_attribute('GroupB'),
	user_attribute('GroupC'),
	
	policy_class('Defining'),
	connector('PM'),

	assign('GroupA', 'Groups'),
	assign('GroupB', 'Groups'),
	assign('GroupC', 'Groups'),

	assign('u1', 'GroupA'),
	assign('u2', 'GroupB'),
	assign('u3', 'GroupC'),
	assign('u4', 'GroupC'),

	assign('Groups', 'Defining'),
	%assign('Groups', 'PM')
	assign('Defining', 'PM')
	
	]).
