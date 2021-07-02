/* Authors: André Christofferson & Wilma Krutrök */

policy(general_cond_location, 'Defining Objects Cond', [
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

	cond(is_same_location(_, _), [
		associate('GroupA',[book],'SiteA'),
		associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')])
	]).
