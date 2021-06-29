/* After loading this er package this response can be invoked by 
making the following call to the server:
localhost:8001/epp/report_event?event=event(test_event,user(u1),policy_class(pc),operation(add_user),object(o1))&token=epp_token */
er_package(er_example1, [
    er( 
        ev_pat(user(any), policy_class(any), operation(add_user), object(any)), [
            add(example3, user(u5))
        
        ])
]).