er_package(er_example1, [
    er( 
        ev_pat(user(any), policy_class(any), operation(add_user), object(any)), [
            add('example3', [user(u5)])
        ])
]).