makeAccessCall(User, Operation, Object) :- 
    getUserLocation(User, UserLocation), 
    getObjectLocation(Object, ObjectLocation),

    combine('users', 'general', 'combined'),
    setpol('combined'),
    access('combined', (User, Operation, Object), is_same_site(UserLocation, ObjectLocation)).