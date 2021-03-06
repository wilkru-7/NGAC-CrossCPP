:- module(pep, [pep_server/0, pep_server/1]).

:- use_module(library(http/http_client)).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_wrapper)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_parameters)).

:- use_module(library(uuid)).
:- use_module('../location_json.pl').
%:- use_module('../JSON/users.json').

ngac_pep_port(8005).
ngac_pdp_port(8001).

ngac_pep_peapi(PEP) :-
	ngac_pep_port(Port),
	format(atom(PEP),'http://127.0.0.1:~d/peapi/',Port).
ngac_pdp_pqapi(PDP):-
	ngac_pdp_port(Port),
	format(atom(PDP),'http://127.0.0.1:~d/pqapi/',Port).

pep_server :- ngac_pep_port(Port), pep_server(Port).

pep_server(Port) :- http_server(http_dispatch, [port(Port)]).

% Lightweight node monitor policy enforcement API
:- http_handler(root(peapi/getLastError), peapi_dispatch(getLastError), [prefix]).
:- http_handler(root(peapi/openObject), peapi_dispatch(openObject), [prefix]).
:- http_handler(root(peapi/readObject), peapi_dispatch(readObject), [prefix]).
:- http_handler(root(peapi/writeObject), peapi_dispatch(writeObject), [prefix]).
:- http_handler(root(peapi/closeObject), peapi_dispatch(closeObject), [prefix]).
:- http_handler(root(peapi/getObject), peapi_dispatch(getObject), [prefix]).
:- http_handler(root(peapi/putObject), peapi_dispatch(putObject), [prefix]).
/* WE ADDED THESE */
:- http_handler(root(peapi/book_PEP), peapi_dispatch(book_PEP), [prefix]).
:- http_handler(root(peapi/access), peapi_dispatch(access), [prefix]).
:- http_handler(root(peapi/test1), peapi_dispatch(test1), [prefix]).
:- http_handler(root(peapi/test2), peapi_dispatch(test2), [prefix]).
:- http_handler(root(peapi/test3), peapi_dispatch(test3), [prefix]).
:- http_handler(root(peapi/book_PDP), peapi_dispatch(book_PDP), [prefix]).
/* ----  */
:- http_handler(root('peapi/'), unimp_peapi, [prefix]).

peapi(getLastError,[],[]).
peapi(openObject,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(readObject,[handle(Handle,[atom])],[Handle]).
peapi(writeObject,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(closeObject,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(getObject,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(putObject,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
/* WE ADDED THESE */
peapi(book_PEP,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(access,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(test1,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(test2,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(test3,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).
peapi(book_PDP,[objname(ObjName,[atom]),operations(Operations,[atom])],[ObjName,Operations]).

peapi_dispatch(API,Request) :-
	peapi(API,Parameters,Positional),
	catch(
	    http_parameters(Request,Parameters),
	    E, setlastError('missing parameter')),
	!,
	(   nonvar(E)
	->  writeln(failure)
	;   atom_concat('peapi_',API,Peapi_API),
	     API_call =.. [Peapi_API | Positional],
	     format('Content-type: text/plain~n~n'),
	    %  format('Calling ~w~n',API_call),
	     call(API_call),
	    true
	).

% demonstration PEP pseudocode:
%
%   pep(Op,Object,Data)
%     get User from the session environment
%     construct PDP call access( User, Op, Object )
%     access_result = make PDP call access( User, Op, Object )
%     if access_result == 'grant' then
%       construct RAP call Op( Object, Data )
%       rap_result = make RAP call Op( Object, Data )
%       return rap_result
%     else /* access_result == 'deny' */
%       return 'Op on Object denied'

/* WE ADDED THESE */
peapi_book_PEP(ObjName, Operations):-
	pep(Operations, ObjName, "").

peapi_book_PDP(ObjName, Operations):-
	pdp(Operations, ObjName, "").

peapi_access(ObjName, Operations):-
	User = u1,
	getUserLocationPEP(User, UL),
	getObjectLocationPEP(ObjName, OL),
	format(atom(Cond), 'is_same_site(~a,~a)', [UL, OL]),
	pep_test(User, Operations, ObjName, Cond, Res).

/* With u3 instead of u1 */
peapi_test1(ObjName, Operations):-
	User = u3,
	getUserLocationPEP(User, UL),
	getObjectLocationPEP(ObjName, OL),
	format(atom(Cond), 'is_same_site(~a,~a)', [UL, OL]),
	pep_test(User, Operations, ObjName, Cond, Res).

/* Using the combine_cond_PEP policy where two conditions is combined into one */
peapi_test2(ObjName, Operations):-
	User = u1,
	getUserLocationPEP(User, UL),
	getObjectLocationPEP(ObjName, OL),
	format(atom(Cond), 'site_and_business(~a,~a)', [UL, OL]),
	pep_test(User, Operations, ObjName, Cond, Res).

and(true,true).
/* Combines the results from two access calls, two grants = grant, otherwise deny (Might not follow NGAC) */
peapi_test3(ObjName, Operations):-
	User = u1,
	getUserLocationPEP(User, UL),
	getObjectLocationPEP(ObjName, OL),
	format(atom(Cond), 'is_same_site(~a,~a)', [UL, OL]),
	pep_test(User, Operations, ObjName, Cond, Res),
	http_get('http://127.0.0.1:8001/paapi/loadpol?policyfile=POLICIES/business_hours.pl&token=admin_token', _, []),
	http_get('http://127.0.0.1:8001/paapi/setpol?policy=business_hours&token=admin_token', _, []),
	pep_test(User, Operations, ObjName, 'is_business_hours', Res2),
	(and(Res, Res2)) -> writeln('Granted') ; writeln('Denied').

/* Used to easier test the PEP from sh script */
pep_test(User, Op, Object, Cond, Result) :-
	PDP='http://127.0.0.1:8001/pqapi/',
	format(atom(Query),'access?user=~a&ar=~a&object=~a&cond=~a',[User,Op,Object,Cond]),
	atom_concat(PDP,Query,PDPq),
	% format(PDPq),
	http_get(PDPq,PDPresult,[]), % query the PDP

	(   sub_atom(PDPresult, 0, _, _, grant)
	->  writeln('Access granted'),
		Result = true
	    % call Resource Access Point and return data
	    %(	Op == r -> Data = 'placeholder data'; true)
	;   writeln('Access denied'),
		Result = false
	).

pep(Op,Object,Data) :-
	PDP='http://127.0.0.1:8001/pqapi/',
	% dummy arguments for demonstration
	U=u1,
	%U1=u2, % from the session environment
	AR=Op, O=Object, % from the request
	%format(atom(O1), ~a, [Object]),
	getUserLocationPEP(U, UL),
	getObjectLocationPEP(O, OL),
	%term_to_atom(OL, OLNew),
	%term_to_atom(UL, ULNew),
	%format(atom(Query),'access?user=~a&ar=~a&object=~a',[U,AR,O]),
	format(atom(Query),'access?user=~a&ar=~a&object=~a&cond=is_same_location(~a,~a)',[U,AR,O,UL,OL]),
	atom_concat(PDP,Query,PDPq),
	
	% e.g. PDPq='http://127.0.0.1:8001/pqapi/access?user=u1&ar=w&object=o2'
	http_get(PDPq,PDPresult,[]), % query the PDP

	(   sub_atom(PDPresult, 0, _, _, grant)
	->  writeln('Access granted'),
	    % call Resource Access Point and return data
	    (	Op == r -> Data = 'placeholder data'; true)
	;   writeln('Access denied')
	).

pdp(Op,Object,Data) :-
	PDP='http://127.0.0.1:8001/pqapi/',
	% dummy arguments for demonstration
	U=u1,
	%U1=u2, % from the session environment
	AR=Op, O=Object, % from the request
	%format(atom(O1), ~a, [Object]),
	% getUserLocationPEP(U, UL),
	% getObjectLocationPEP(O, OL),
	%term_to_atom(OL, OLNew),
	%term_to_atom(UL, ULNew),
	%format(atom(Query),'access?user=~a&ar=~a&object=~a',[U,AR,O]),
	format(atom(Query),'access?user=~a&ar=~a&object=~a&cond=is_same_location(~a,~a)',[U,AR,O,U,O]),
	atom_concat(PDP,Query,PDPq),
	
	% e.g. PDPq='http://127.0.0.1:8001/pqapi/access?user=u1&ar=w&object=o2'
	http_get(PDPq,PDPresult,[]), % query the PDP

	(   sub_atom(PDPresult, 0, _, _, grant)
	->  writeln('Access granted'),
	    % call Resource Access Point and return data
	    (	Op == r -> Data = 'placeholder data'; true)
	;   writeln('Access denied')
	).
/* ------------------------- */

/* Original pep method */
% pep(Op,Object,Data) :-
% 	PDP='http://127.0.0.1:8001/pqapi/',
% 	% dummy arguments for demonstration
% 	U=u1, % from the session environment
% 	AR=Op, O=Object, % from the request
% 	format(atom(Query),'access?user=~a&ar=~a&object=~a',[U,AR,O]),
% 	atom_concat(PDP,Query,PDPq),

% 	% e.g. PDPq='http://127.0.0.1:8001/pqapi/access?user=u1&ar=w&object=o2'
% 	http_get(PDPq,PDPresult,[]), % query the PDP

% 	(   sub_atom(PDPresult, 0, _, _, grant)
% 	->  writeln('Access granted'),
% 	    % call Resource Access Point and return data
% 	    (	Op == r -> Data = 'placeholder data'; true)
% 	;   writeln('Access denied')
% 	).

:- dynamic openObject/5.
% openObject(Name,Handle,Operations,Stream,SessionId)
openObject('','','','','').

:- dynamic lastError/1.
lastError('').

setlastError(E) :- retractall( lastError(_) ), assert( lastError(E) ).

peapi_getLastError :-
	lastError(LE),
	format('last error:~a~n',LE).

peapi_openObject(ObjName,Operations) :-
	(   openObject(ObjName,Handle,Ops,Stream,Sess)
	->  format('object already open: object=~a,handle=~a,ops=~a,stream=~w,session=~a~n',
		   [ObjName,Handle,Ops,Stream,Sess])
	;   % new open
	    ngac_pdp_pqapi(PDP),
	    format(atom(Query),'getobjinfo?object=~a',[ObjName]),
	    atom_concat(PDP,Query,PDPquery), format('sending query ~w~n',PDPquery),
	    http_get(PDPquery,PDPresult,[]), % query the PDP
	    format('PDP query result=~w~n',PDPresult),
	    %read_term_from_atom(PDPresult,Term,[]),
	    %format('PDP result term=~q~n',Term)
		
	    read_term_from_atom(PDPresult,objectinfo(O,Oclass,Inh,Host,Path,BaseType,BaseName),[]),
		writeln('1'),
	    format('object=~a,oclass=~a,inh=~a,host=~a,path=~a,basetype=~a,basename=~a~n',
		   [O,Oclass,Inh,Host,Path,BaseType,BaseName]),
		writeln('2'),
	    rap:file_open(Path,Operations,Stream),
	    uuid(Handle), assert(openObject(ObjName,Handle,Operations,Stream,1)),
	    writeln(Handle)
	).

peapi_readObject(Handle) :-
	format('readObject called arg=~q~n',Handle),
	(   openObject(ObjName,Handle,_Ops,Stream,_Sess)
	->  format('calling RAP for ~a ~w ~a~n',[ObjName,Stream,read]),
	    rap:file_read(Stream,Data),
	    format('data read: ~w~n',Data)
	;   setlastError('object not open'),
	    format('object not open ~a~n',Handle)
	).

peapi_writeObject(_Handle) :- unimp_peapi(_),
	true.

peapi_closeObject(Handle) :-
	(   openObject(ObjName,Handle,Ops,_Stream,Sess)
	->  format('closing: object=~a,handle=~a,ops=~a,stream=~a,session=~a~n',
		   [ObjName,Handle,Ops,_Stream,Sess]),
	    rap:file_close(_Stream),
	    retractall( openObject(_,Handle,_,_,_) )
	;   % not an open Handle
	    setlastError('Handle not an open object.'),
	    format('not an open handle=~q~n',Handle)
	),
	true.

peapi_getObject(_ObjName) :- unimp_peapi(_),
	true.

peapi_putObject(_ObjName) :- unimp_peapi(_),
	true.

unimp_peapi(_) :-
	format('Content-type: text/plain~n~n'),
	format('Unimplemented PEP API~n').
