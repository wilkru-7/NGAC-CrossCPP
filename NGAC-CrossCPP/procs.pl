% stored "built-in" procedures

:- module(procs, [proc/2, pmproc/2]).

:- dynamic([proc/2, pmproc/2]).

%%	NGAC Command Procs
% sequences of commands defined in command module

proc(guiserver, [
         set(guiserver,on),
         guitracer,
         set(jsonresp_server,on),
         set(jsonresp,on),
         set(no_sleep,on),
         traceone,
         server(8001),
         echo(ready)
     ]).

proc(review, [ %
         proc(queryA),
         proc(queryB),
         proc(autoCombined),
	 selftest,
         server(8001)
     ]).

proc(queryA, [ % query the example Policy (a)
	 newpol('Policy (a)'),
         display_policy,
	 access('Policy (a)',(u1,r,o1)),
	 access('Policy (a)',(u1,w,o1)),
	 access('Policy (a)',(u1,r,o2)),
	 access('Policy (a)',(u1,w,o2)),
	 access('Policy (a)',(u1,r,o3)),
	 access('Policy (a)',(u1,w,o3)),
	 access('Policy (a)',(u1,r,o4)),
	 access('Policy (a)',(u1,w,o4)),
	 access('Policy (a)',(u2,r,o1)),
	 access('Policy (a)',(u2,w,o1)),
	 access('Policy (a)',(u2,r,o2)),
	 access('Policy (a)',(u2,w,o2)),
	 access('Policy (a)',(u2,r,o3)),
	 access('Policy (a)',(u2,w,o3)),
	 access('Policy (a)',(u2,r,o4)),
	 access('Policy (a)',(u2,w,o4)),
         echo('Displaying policy graph'),
         graph_policy
     ]).

proc(queryB, [ % query the example Policy (b)
	 newpol('Policy (b)'),
         display_policy,
	 access('Policy (b)',(u1,r,o1)),
	 access('Policy (b)',(u1,w,o1)),
	 access('Policy (b)',(u1,r,o2)),
	 access('Policy (b)',(u1,w,o2)),
	 access('Policy (b)',(u1,r,o3)),
	 access('Policy (b)',(u1,w,o3)),
	 access('Policy (b)',(u1,r,o4)),
	 access('Policy (b)',(u1,w,o4)),
	 access('Policy (b)',(u2,r,o1)),
	 access('Policy (b)',(u2,w,o1)),
	 access('Policy (b)',(u2,r,o2)),
	 access('Policy (b)',(u2,w,o2)),
	 access('Policy (b)',(u2,r,o3)),
	 access('Policy (b)',(u2,w,o3)),
	 access('Policy (b)',(u2,r,o4)),
	 access('Policy (b)',(u2,w,o4)),
         echo('Displaying policy graph'),
         graph_policy
     ]).

proc(autoCombined, [
	 import(policy('EXAMPLES/policy_signals_access.pl')),
	 access('Signals Access Policy', ('Ana',r,'VIN-1001 Door Signals')),
	 access('Signals Access Policy', ('Ana',r,'VIN-3001 Shift Signals')),
	 access('Signals Access Policy', ('Ana',r,'VIN-1001 Trip Signals')),
	 access('Signals Access Policy', ('Ana',r,'VIN-3001 Trip Signals')),
	 access('Signals Access Policy', ('Ana',w,'VIN-1001 Door Signals')),
	 access('Signals Access Policy', ('Ana',w,'VIN-3001 Shift Signals')),
	 access('Signals Access Policy', ('Ana',w,'VIN-1001 Trip Signals')),
	 access('Signals Access Policy', ('Ana',w,'VIN-3001 Trip Signals')),
	 import(policy('EXAMPLES/policy_vehicle_ownership.pl')),
	 access('Vehicle Ownership Policy', ('Ana',r,'VIN-1001 Door Signals')),
	 access('Vehicle Ownership Policy', ('Ana',r,'VIN-3001 Shift Signals')),
	 access('Vehicle Ownership Policy', ('Ana',r,'VIN-1001 Trip Signals')),
	 access('Vehicle Ownership Policy', ('Ana',r,'VIN-3001 Trip Signals')),
	 access('Vehicle Ownership Policy', ('Ana',w,'VIN-1001 Door Signals')),
	 access('Vehicle Ownership Policy', ('Ana',w,'VIN-3001 Shift Signals')),
	 access('Vehicle Ownership Policy', ('Ana',w,'VIN-1001 Trip Signals')),
	 access('Vehicle Ownership Policy', ('Ana',w,'VIN-3001 Trip Signals')),
	 combine('Signals Access Policy','Vehicle Ownership Policy','Combined Policy'),
	 newpol('Combined Policy'),
         echo('Using Combined Policy'),
	 access('Combined Policy', ('Ana',r,'VIN-1001 Door Signals')),
	 access('Combined Policy', ('Sebastian',r,'VIN-1001 Door Signals')),
	 access('Combined Policy', ('Ana',r,'VIN-3001 Shift Signals')),
	 access('Combined Policy', ('Ana',r,'VIN-1001 Trip Signals')),
	 access('Combined Policy', ('Ana',r,'VIN-3001 Trip Signals')),
	 access('Combined Policy', ('Ana',w,'VIN-1001 Door Signals')),
	 access('Combined Policy', ('Ana',w,'VIN-3001 Shift Signals')),
	 access('Combined Policy', ('Ana',w,'VIN-1001 Trip Signals')),
	 access('Combined Policy', ('Ana',w,'VIN-3001 Trip Signals')),
         graph_policy
     ]).

proc(modelTestA, [
	 newpol('Policy (a)'),
	 los('Policy (a)'),
	 dps('Policy (a)'),
	 aoa(u1),
	 minaoa(u1),
	 userlos('Policy (a)',u1),
	 aoa(u2),
	 minaoa(u2),
	 userlos('Policy (a)',u2)
     ]).

proc(modelTestB, [
	 newpol('Policy (b)'),
	 los('Policy (b)'),
	 dps('Policy (b)'),
	 aoa(u1),
	 minaoa(u1),
	 userlos('Policy (b)',u1),
	 aoa(u2),
	 minaoa(u2),
	 userlos('Policy (b)',u2)
     ]).

proc(demo1, [ %
	 import(policy('EXAMPLES/policy3.pl')),
	 newpol('Policy3'),
	 access('Policy3',(jones,read,mrec1)),
	 access('Policy3',(jones,write,mrec1)),
	 access('Policy3',(smith,read,mrec1)),
	 access('Policy3',(smith,write,mrec1)),
	 access('Policy3',(smith,read,'Medical Records')) % OA not Object
     ]).

proc(demo2, [ % convert a declarative policy file to a PM command file
	 import(policy('EXAMPLES/Policy3.pl')),
	 newpol('Policy3'),
	 decl2imp('EXAMPLES/policy3.pl','EXAMPLES/policy3.pm')
     ]).

proc(demo3, [ %
	 combine('Policy (a)','Policy (b)','Policy (ab)'),
	 dps('Policy (ab)')
     ]).

proc(marketdemo, [ % demo the market policy
         setpol(mpolicy1),
         load_cond('EXAMPLES/market_cond.pl'),
         users('device_95b40cf9-a9fc-4bd8-b695-99773b6f25e4',r,
               [devid='95b40cf9-a9fc-4bd8-b695-99773b6f25e4', mchan=2,
                tstart='2020-09-08T08:00:00Z', tstop='2020-09-09T08:00:00Z', tsubmit='2020-09-09T08:03:22.350069Z',
                loMin=3.419216, loMax=3.519216, laMin=40.062069, laMax=40.072069]
              ),
         noop
     ]).

proc(test_echo, [
	 echo('hello world')
     ]).

proc(auto1, [
	 import(policy('EXAMPLES/policy_signals_access.pl')),
	 access('Signals Access Policy', ('Ana',r,'VIN-1001 Door Signals')),
	 access('Signals Access Policy', ('Ana',r,'VIN-3001 Shift Signals')),
	 access('Signals Access Policy', ('Ana',r,'VIN-1001 Trip Signals')),
	 access('Signals Access Policy', ('Ana',r,'VIN-3001 Trip Signals')),
	 access('Signals Access Policy', ('Ana',w,'VIN-1001 Door Signals')),
	 access('Signals Access Policy', ('Ana',w,'VIN-3001 Shift Signals')),
	 access('Signals Access Policy', ('Ana',w,'VIN-1001 Trip Signals')),
	 access('Signals Access Policy', ('Ana',w,'VIN-3001 Trip Signals'))
     ]).

proc(auto2, [
	 import(policy('EXAMPLES/policy_vehicle_ownership.pl')),
	 access('Vehicle Ownership Policy', ('Ana',r,'VIN-1001 Door Signals')),
	 access('Vehicle Ownership Policy', ('Ana',r,'VIN-3001 Shift Signals')),
	 access('Vehicle Ownership Policy', ('Ana',r,'VIN-1001 Trip Signals')),
	 access('Vehicle Ownership Policy', ('Ana',r,'VIN-3001 Trip Signals')),
	 access('Vehicle Ownership Policy', ('Ana',w,'VIN-1001 Door Signals')),
	 access('Vehicle Ownership Policy', ('Ana',w,'VIN-3001 Shift Signals')),
	 access('Vehicle Ownership Policy', ('Ana',w,'VIN-1001 Trip Signals')),
	 access('Vehicle Ownership Policy', ('Ana',w,'VIN-3001 Trip Signals'))
     ]).

proc(autocomb, [
	 combine('Signals Access Policy','Vehicle Ownership Policy','Combined Policy'),
	 newpol('Combined Policy'),
	 access('Combined Policy', ('Ana',r,'VIN-1001 Door Signals')),
	 access('Combined Policy', ('Sebastian',r,'VIN-1001 Door Signals')),
	 access('Combined Policy', ('Ana',r,'VIN-3001 Shift Signals')),
	 access('Combined Policy', ('Ana',r,'VIN-1001 Trip Signals')),
	 access('Combined Policy', ('Ana',r,'VIN-3001 Trip Signals')), % <==
	 access('Combined Policy', ('Ana',w,'VIN-1001 Door Signals')),
	 access('Combined Policy', ('Ana',w,'VIN-3001 Shift Signals')),
	 access('Combined Policy', ('Ana',w,'VIN-1001 Trip Signals')),
	 access('Combined Policy', ('Ana',w,'VIN-3001 Trip Signals'))
     ]).

proc(example2, [
	 import(policy('POLICIES/example2.pl')),
	 access('example2', ('u1',book,'o2')), % Returns grant or deny
	 %user('o1'), % Not working
	 %user(object,mode), % Not working
	 aoa('u1'), % Return objects user is allowed to do action on ([book])
	 aua('o1') % Return users allowed to do action ([book]) on object (Return both Bob and u2 (same user))
     ]).

proc(example3, [
	 import(policy('POLICIES/example3.pl')), % Imports policy from file and sets it as current policy
	 access('example3', ('u1',book,'o2'), is_same_site('SiteA', 'SiteA')), % Returns grant or deny
	 access('example3', ('u1',book,'o2')), % Conditional policies expecting argument returns deny if not given
	 %aoa('u1'), % Not working for policy requiring condition argument
	 %aua('o1'), % Not working for policy requiring condition argument
	 conditions, % Displays ALL conditions existing, not the one used, can have arguments ‘predefined’, ‘static’, ‘dynamic’, a user-defined condition group, or ‘all’
	 echo('Prints line'),
	 nl, % Prints empty line
	 getpol, % Return name of current policy
	 %halt % Closes the policy tool and swipl
	 %help % Returns all commands available
	 help('aoa'), % Returns desciption of command 
	 % policy_graph % Not working
	 % policy_graph( <policy name> ) % Not working
	 % policy_graph( <policy name>, <file base name> ) % Not working
	 policy_spec, % Prints out whole policy
	 % policy_spec( <policy name> ) % Displays another policy
	 % policy_spec( <policy name>, <file base name>, [silent]) % Prints policy to file
	 %users('o1', book), % Not working for condtional policy
	 %users('o1', book, is_same_site), % CAN NOT GET TO WORK
	 setpol('example2'), % Change policy
	 access('example2', ('u1',book,'o2')),
	 version, % Displays current version
	 versions, % Displays all versions
	 users('o1'), % Returns users that have access to object and access mode [(u2,[book])]
	 users('o1', book)
     ]).

proc(combine_examples, [
import(policy('POLICIES/example2.pl')),
import(policy('POLICIES/example3.pl')),
combine('example2', 'example3', 'combined_examples'),
setpol('combined_examples'),
access('combined_examples', ('u1', book, 'o1')),
access('combined_examples', ('u1', book, 'o2')),
access('combined_examples', ('u2', book, 'o1')),
access('combined_examples', ('u2', book, 'o2')),
access('combined_examples', ('u1', book, 'o2'), is_same_site('SiteA', 'SiteA')),
access('combined_examples', ('u1', book, 'o2'), is_same_site('SiteA', 'SiteB')),
access('combined_examples', ('u2', book, 'o2'), is_same_site('SiteA', 'SiteA')),
access('combined_examples', ('u2', book, 'o2'), is_same_site('SiteA', 'SiteB'))
]).
/* Methods not tested yet */
% activate_erp( <er package name> ).
% admin.
% advanced.
% combine( <policy name 1>, <policy name 2>, <combined policy name> ).
% current_erp.
% deactivate_erp( <er package name> ).
% epp(<port>).
% epp(<port>, <token>).
% load_cond( <cond file> ).
% load_cond( <cond file>, <condition name> ).
% load_erf( <erp file> ).
% unload_erp( <er package name> )

% script( <file name> [, step] ).
% script( <file name> [, verbose] ).
% server( <port >, <admin token> ).
% server( <port >, <admin token>, <epp token> ).
% time( <ngac command> ).
% time( <ngac command>, <reps> ).