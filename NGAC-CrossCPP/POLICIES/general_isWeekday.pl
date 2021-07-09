/* Authors: André Christofferson & Wilma Krutrök */

policy(general_isWeekday, 'Book Lifts', [
	%conditions([current_day_is_one_of(list)]),
    
	cond(current_day_is_one_of(['Monday','Tuesday','Wednesday','Thursday','Friday']),[
        associate('GroupA',[book],'SiteA'),
        associate('GroupB',[book],'SiteB'),
		associate('GroupC',[book],'Sites')
    ])
]).

