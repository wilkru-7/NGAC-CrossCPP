% ------------------------------------------------------------------------
% CONDITION VARIABLE DECLARATIONS
%   condition_variable(VariableName : VariableType)
%   Type is one of: list, boolean, number, name

/* WE ADDED THIS!!! */
:- use_module(location_json).
/* END OF WE ADDED THIS!!! */

condition_variable(weekday:boolean).
condition_variable(business:boolean).
%condition_variable(is_business_hours:boolean).
%condition_variable(condVar1:number).
%condition_variable(condVar2:name).
%condition_variable(condVar3:boolean).
%condition_variable(lockdown:boolean).
%condition_variable(today:name).

/* WE ADDED THESE */
condition_variable(location_user:name).
condition_variable(location_object:name).

% condition variables for marketplace
condition_variable(devid:name).
condition_variable(mchan:number).
condition_variable(tstart:timetext).
condition_variable(tstop:timetext).
condition_variable(tsubmit:timetext).
condition_variable(loMin:number).
condition_variable(loMax:number).
condition_variable(laMin:number).
condition_variable(laMax:number).

% ------------------------------------------------------------------------
% CONDITION PREDICATE DECLARATIONS & DEFINITIONS
%   condition_predicate(PredicateName,PredicateArgs)
%   PredicateArgs is a list of Types
%   Each Type is one of: list, boolean, number, name, timestamp,
%                        timetext, time, date, datetime, var, any
%

condition_predicate(is_weekday, []).
condition_predicate(is_business, []).
condition_predicate(current_day_is_one_of, [list]).
condition_predicate(is_business_hours, []).
%condition_predicate(not_lockdown, []).

/* WE ADDED THESE */
condition_predicate(is_same_site, [name, name]).
condition_predicate(is_same_location, [name, name]).

% condition predicate declarations for the marketplace
% NOTE dr name ends in 1 for the example in policies.pl
condition_predicate(dr_offer_5f5a39f2b559dcf200f424d1, [name,number,timetext,timetext,timetext,number,number,number,number]).

% condition predicate definitions for marketplace
dr_offer_5f5a39f2b559dcf200f424d1(Dev,Chan,Start,Stop,Submit,LoMin,LoMax,LaMin,LaMax) :-
    Dev == '95b40cf9-a9fc-4bd8-b695-99773b6f25e4', channel_in_channels( Chan, [1,2] ),
    timetextrange_in_range( Start, Stop, '2019-09-10T14:36:34.682Z', '2020-09-10T14:36:34.682Z' ),
    timetext_in_range( Submit, '2019-09-10T14:36:34.682Z', '2020-09-10T14:36:34.682Z' ),
    gbox_in_gbox( LoMin, LoMax, LaMin, LaMax, -9.39, 4.3, 35.95, 43.75).

is_weekday :-
    condition_variable_value(weekday,W), W == true.

is_business :-
    condition_variable_value(business,B), B == true.

current_day_is_one_of(SetOfDays) :-
    condition_variable_value(day_now,Today),
    memberchk(Today,SetOfDays).

/* WE ADDED THIS */

/* Checks if localhost time is between 07-18 */
is_business_hours :-
    condition_variable_value(hour_now, Hour),
    Hour =< 18, Hour >= 7.

/* Checks if user and objects is at same site, retrives location from files from Json/ folder */
is_same_location(User, Object) :- getUserLocation(User, Site), getObjectLocation(Object, Site).

/* Would be used if PEP retrives location */
is_same_site(Site, Site).