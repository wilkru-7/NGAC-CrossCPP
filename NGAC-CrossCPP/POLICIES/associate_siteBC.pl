/* Authors: André Christofferson & Wilma Krutrök */

policy(associate_siteBC, 'Book Lifts', [
	%conditions([current_day_is_one_of(list)]),
    
	cond(is_same_site(_, _), [
		%associate('GroupA',[book],'SiteA')
		associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')
    ])
	
]).
