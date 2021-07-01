/* Authors: André Christofferson & Wilma Krutrök */

policy(location, 'Policy for location', [
	object('o1'),

	object_attribute('Sites'),
	object_attribute('SiteA'),

	policy_class('Defining'),
	connector('PM'),

	assign('o1', 'SiteA'),

	assign('SiteA', 'Sites'),

	assign('Sites', 'Defining'),
	assign('Defining', 'PM'),
	
	cond(is_same_site(_, siteA), [
		associate('GroupA',[book],'SiteA')])
	]).