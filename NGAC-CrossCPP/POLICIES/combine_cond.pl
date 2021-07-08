/* Authors: André Christofferson & Wilma Krutrök */

policy(level_location, 'Defining Management Level and Location', [
	object('o1'),
	object('o2'),
    object('o3'),

	object_attribute('objects'),
	object_attribute('object1'),
	object_attribute('object2'),
	object_attribute('object3'),

	policy_class('Defining'),
	connector('PM'),

	assign('o1', 'object1'),
	assign('o2', 'object2'),
	assign('o3', 'object3'),

	assign('object1', 'objects'),
	assign('object2', 'objects'),
	assign('object3', 'objects'),

	assign('objects', 'Defining'),
	%assign('objects', 'PM'),
	assign('Defining', 'PM'),

    /* Level 1 is the lowest and 4 is the highest */
	cond(location_and_business(_, _), [
        associate('Level1',[book],'object1'),
        associate('Level2',[book],'object1'),
        associate('Level2',[book],'object2'),
        associate('Level3',[book],'object1'),
        associate('Level3',[book],'object2'),
        associate('Level3',[book],'object3')
        
	    ])
	]).
