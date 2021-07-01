/* Authors: André Christofferson & Wilma Krutrök */
policy(objects, 'Defining Objects', [
	object('o1'),
	object('o2'),

	object_attribute('Sites'),
	object_attribute('SiteA'),
	object_attribute('SiteB'),

	policy_class('Defining'),
	connector('PM'),

	assign('o1', 'SiteA'),
	assign('o2', 'SiteB'),

	assign('SiteA', 'Sites'),
	assign('SiteB', 'Sites'),

	assign('Sites', 'Defining'),
	%assign('Sites', 'PM'),
	assign('Defining', 'PM')
	]).
