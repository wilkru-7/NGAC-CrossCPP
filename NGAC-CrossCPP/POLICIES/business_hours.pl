/* Authors: André Christofferson & Wilma Krutrök */

policy(business_hours, 'Business Hours', [
	user('u1'),
	user('u2'),
	user('u3'),
	user('u4'),

	user_attribute('Groups'),
	user_attribute('GroupA'),
	user_attribute('GroupB'),
	user_attribute('GroupC'),

	assign('GroupA', 'Groups'),
	assign('GroupB', 'Groups'),
	assign('GroupC', 'Groups'),

	assign('Groups', 'Defining'),

	assign('u1', 'GroupA'),
	assign('u2', 'GroupB'),
	assign('u3', 'GroupC'),
	assign('u4', 'GroupC'),

	object('o1'),
	object('o2'),
	object('o3'),

	object_attribute('Sites'),
	object_attribute('SiteA'),
	object_attribute('SiteB'),
	object_attribute('SiteC'),

	policy_class('Defining'),
	connector('PM'),

	assign('o1', 'SiteA'),
	assign('o2', 'SiteB'),
	assign('o3', 'SiteC'),

	assign('SiteA', 'Sites'),
	assign('SiteB', 'Sites'),
	assign('SiteC', 'Sites'),

	assign('Sites', 'Defining'),
	%assign('Sites', 'PM'),
	assign('Defining', 'PM'),

	cond(is_business_hours, [
		associate('GroupA',[book],'SiteA'),
		associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')])
	]).
