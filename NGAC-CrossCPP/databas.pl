/* :- dynamic (location/2).
assertz(location(u1, siteA)). */
:- module(databas, [getUserLocation/2, getObjectLocation/2]).

:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
readJson(Dicty) :- FPath = 'users.json', open(FPath, read, Stream), json_read_dict(Stream, Dicty).
readJson(Dicty, read) :- FPath = 'users.json', open(FPath, read, Stream), json_read(Stream, Dicty).
readJson(Dicty, atom) :- FPath = 'users.json', open(FPath, read, Stream), atom_json_dict(Stream, Dicty).

user_json('{
    "users": [
    {
        "id":"u1",
        "location":"siteA"
    },
    {
        "id":"u2",
        "location":"siteB"
    },
    {
        "id":"u3",
        "location":"siteB"
    },
    {
        "id":"u4",
        "location":"siteB"
    }]
}
').

object_json('{
    "objects": [
    {
        "id":"o1",
        "location":"siteA"
    },
    {
        "id":"o2",
        "location":"siteB"
    },
    {
        "id":"o3",
        "location":"siteC"
    }]
}
').

/*  Takes Json and Converts it to a list containing user and location
    Form:
        user(id, location) */
getUsers(Users2) :-
    user_json(Json), 
    atom_json_dict(Json, Dict, [default_tag(user)]),
    dicts_to_compounds(Dict.users, [id, location], dict_fill(null), Users),
    newList(Users, Users2).


% Loop through users and return location for given user if existing.
getLocation(User, [user(User, Location)|_], Location):- !.
getLocation(User, [_|T], Location) :- getLocation(User, T, Location).

% Return location for given user.
getUserLocation(User, Location) :-  getUsers(Users), getLocation(User, Users, Location).

/*  Takes Json and Converts it to a list containing object and location
    Form:
        object(id, location) */
getObjects(Objects2) :-
    object_json(Json), 
    atom_json_dict(Json, Dict, [default_tag(object)]),
    dicts_to_compounds(Dict.objects, [id, location], dict_fill(null), Objects),
    newList(Objects, Objects2).

getLocationObject(Object, [object(Object, Location)|_], Location):- !.
getLocationObject(Object, [_|T], Location) :- getLocationObject(Object, T, Location).

getObjectLocation(Object, Location) :- getObjects(Objects), getLocationObject(Object, Objects, Location).

newList([],[]).
newList([user(X, Y)|T], [user(X2, Y2)|T2]) :- term_to_atom(X, X2), term_to_atom(Y,Y2), newList(T,T2).
newList([object(X, Y)|T], [object(X2, Y2)|T2]) :- term_to_atom(X, X2), term_to_atom(Y,Y2), newList(T,T2).