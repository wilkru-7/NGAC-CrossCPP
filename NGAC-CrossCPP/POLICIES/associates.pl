/* Authors: André Christofferson & Wilma Krutrök */
policy(associates, 'Defining Operations', [
	policy_class('Defining'),
	connector('PM'),

	assign('Defining', 'PM'),

	associate('GroupA',[book],'SiteA'),
	associate('GroupB',[book],'SiteB'),
	associate('GroupC',[book],'Sites')
	]).
