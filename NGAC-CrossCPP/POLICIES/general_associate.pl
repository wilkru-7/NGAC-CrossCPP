/* Authors: André Christofferson & Wilma Krutrök */

policy(general_associate, 'Defining Access For Same Location', [
	cond(is_same_location(_, _), [
		associate('GroupA',[book],'SiteA'),
		associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')])
	]).