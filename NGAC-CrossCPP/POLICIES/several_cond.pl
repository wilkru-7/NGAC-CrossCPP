/* Authors: André Christofferson & Wilma Krutrök */

policy(several_cond, 'Defining several conditional', [
	%conditions([is_same_location(name, name), is_business_hours]),
	% policy_class('Defining'),
	% connector('PM'),

	% assign('Defining', 'PM'),

	cond(is_same_location(_, _), [
		associate('GroupA',[book],'SiteA'),
		associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')]),

    cond(is_business_hours, [
        associate('GroupA',[book],'SiteA'),
        associate('GroupB',[book],'SiteB'),
        associate('GroupC',[book],'Sites')])
	]).