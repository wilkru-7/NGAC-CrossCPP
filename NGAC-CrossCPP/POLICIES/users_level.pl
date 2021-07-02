/* Authors: André Christofferson & Wilma Krutrök */
policy(users_level, 'Defining management level for users', [
	user('u1'),
	user('u2'),
	user('u3'),
    user('u4'),

	user_attribute('Levels'),
	user_attribute('Level1'),
	user_attribute('Level2'),
	user_attribute('Level3'),
	
	policy_class('Defining'),
	connector('PM'),

	assign('Level1', 'Levels'),
	assign('Level2', 'Levels'),
	assign('Level3', 'Levels'),

	assign('u1', 'Level1'),
	assign('u2', 'Level2'),
	assign('u3', 'Level3'),
    assign('u4', 'Level3'),

	assign('Levels', 'Defining'),
	assign('Defining', 'PM')
	]).
