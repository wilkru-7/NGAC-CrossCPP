/* Authors: André Christofferson & Wilma Krutrök */

policy(cond_associates, 'Defining conditional operations', [
	conditions([is_same_site(name, name)]),
	% policy_class('Defining'),
	% connector('PM'),

	% assign('Defining', 'PM'),

	cond(is_same_site(_, _), [
		associate('GroupA',[book],'SiteA'),
		associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')])
	]).