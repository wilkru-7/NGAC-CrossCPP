/* Authors: André Christofferson & Wilma Krutrök */

policy(general_business_hours, 'Book Lifts', [
	%conditions([current_day_is_one_of(list)]),
    
	cond(is_business_hours, [
		associate('GroupA',[book],'SiteA'),
		associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')
    ])
	
]).
