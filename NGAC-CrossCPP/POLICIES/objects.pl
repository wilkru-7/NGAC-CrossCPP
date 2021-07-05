/* Authors: André Christofferson & Wilma Krutrök */
policy(objects, 'Defining Objects', [
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
	assign('Defining', 'PM')
	]).
