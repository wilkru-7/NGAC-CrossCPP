/* Authors: André Christofferson & Wilma Krutrök */

/*  Creating three users and two objects
    u1 can book o1
    u2 can book o2
    u3 can book o1 and o2
    only allowed to book if user and object are at same location
*/
policy(book_room, 'Book Room', [
	user('u1'),
	user('u2'),
    user('u3'),

	user_attribute('Group1'),
	user_attribute('Group2'),
    user_attribute('Group3'),
	user_attribute('Groups'),

	object('o1'),
	object('o2'),

    object_attribute('RoomA'),
    object_attribute('RoomB'),
    object_attribute('Rooms'),

	policy_class('Book Room'),
	connector('PM'),

	assign('u1','Group1'),
	assign('u2','Group2'),
    assign('u3','Group3'),
	assign('Group1','Groups'),
	assign('Group2','Groups'),
    assign('Group3','Groups'),

	assign('o1','RoomA'),
	assign('o2','RoomB'),
    assign('RoomA','Rooms'),
    assign('RoomB','Rooms'),

	assign('Groups','Book Room'),
	assign('Rooms','Book Room'),

    assign('Book Room','PM'),

	operation(book,'Room'),

	cond(is_same_location(_,_), [
		associate('Group1',[book],'RoomA'),
        associate('Group2',[book],'RoomB'),
	    associate('Group3',[book],'Rooms')
        ])
]).