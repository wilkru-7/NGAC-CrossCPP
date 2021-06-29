/* After loading this er package this response can be invoked by 
making the following call to the server:
localhost:8001/epp/report_event?event=event(test_event,user(u1),policy_class(pc),operation(add_user),object(o1))&token=epp_token */
er_package(er_example1, [
    er( 
        ev_pat(user(any), policy_class(any), operation(add_user), object(any)), [
            add(example3, user(u5))
        
        ]),
    er( 
        ev_pat(user(any), policy_class(any), operation(add_object), object(any)), [
            add(example3, object(o5))
    
    ]),
    er( 
        ev_pat(user(any), policy_class(any), operation(add_objects), object(any)), [
            add(example3, object(o6)),
            add(example3, object(o7))
    
    ]),
    er( 
        ev_pat(user(any), policy_class(any), operation(add_assignment), object(any)), [
            %user_attribute('admin'),
            %assign(u1, admin)
            addm(example3,[
                user_attribute(admin),
                assign(u1, admin)
               ])
    ])
]).