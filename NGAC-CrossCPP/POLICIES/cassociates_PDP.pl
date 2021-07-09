/* Authors: André Christofferson & Wilma Krutrök */

policy(cond_associates_PDP, 'Defining conditional operations', [
	conditions([is_same_location(name, name)]),
	% policy_class('Defining'),
	% connector('PM'),

	% assign('Defining', 'PM'),

	cond(is_same_location(_, _), [
		associate('GroupA',[book],'SiteA'),
		associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')])
	]).