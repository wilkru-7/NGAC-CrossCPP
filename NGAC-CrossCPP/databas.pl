/* :- dynamic (location/2).
assertz(location(u1, siteA)). */
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
readJson(Dicty) :- FPath = 'users.json', open(FPath, read, Stream), json_read_dict(Stream, Dicty).
readJson(Dicty, read) :- FPath = 'users.json', open(FPath, read, Stream), json_read(Stream, Dicty).
readJson(Dicty, atom) :- FPath = 'users.json', open(FPath, read, Stream), atom_json_dict(Stream, Dicty).

sample_json('{
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
        "location":"siteC"
    },
    {
        "id":"u4",
        "location":"siteC"
    }]
}
').

/*  Takes Json and Converts it to a list containing user and location
    Form:
        user(id, location) */
getUsers(Users) :-
    sample_json(Json), 
    atom_json_dict(Json, Dict, [default_tag(user)]),
    dicts_to_compounds(Dict.users, [id, location], dict_fill(null), Users).

getLocation(User, [user(User, Location)|_], Location):- !.
getLocation(User, [_|T], Location) :- getLocation(User, T, Location).

getUserLocation(User, Location) :- getUsers(Users), getLocation(User, Users, Location).


