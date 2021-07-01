/* Authors: André Christofferson, Wilma Krutrök */

:- module(locationJson, [getUserLocation/2, getObjectLocation/2]).

:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).

/*  Reads json from FilePath, returns json as string (?) */
readJson(Json_to_string, FPath) :- open(FPath, read, Dicty), read_string(Dicty , _, Json_to_string).

/*  Converts list of form:
        [ map("id", "location"), .. ]
    into form:
        [ map('"id"', '"location"'), .. ] */
toAtomList([],[]).
toAtomList([map(Id, Location)|Tail], [map(IdNew, LocationNew)|TailNew]) :- 
    term_to_atom(Id, IdNew), term_to_atom(Location,LocationNew), toAtomList(Tail,TailNew).

/*  Takes Json and Converts it to a list containing id and location
    Form:
        map(id, location) */
getJson(FPath, JsonObject, Result) :-
    readJson(Json, FPath),
    atom_json_dict(Json, Dict, [default_tag(map)]),
    dicts_to_compounds(Dict.JsonObject, [id, location], dict_fill(null), Tmp),
    toAtomList(Tmp, Result).

% Loop through users and return location for given user if existing.
getLocation(Id, [map(Id, Location)|_], Location):- !.
getLocation(Id, [_|T], Location) :- getLocation(Id, T, Location).

% Return location for given user.
getUserLocation(User, Location) :-  getJson('users.json', users, Users), getLocation(User, Users, Location).

getObjectLocation(Object, Location) :- getJson('objects.json', objects, Objects), getLocation(Object, Objects, Location).

