:- consult('vocabulary.pl').

% Identification of subject
identify_subject(Subject) :-
    subjects(ValidSubjects),
    member(Subject, ValidSubjects).

% Identification of the Verb Type
identify_verb_type(Word, move) :- 
    move_words(MoveWords),
    member(Word, MoveWords),
    !.
identify_verb_type(Word, dodge) :- 
    dodge_words(DodgeWords),
    member(Word, DodgeWords),
    !.
identify_verb_type(Word, defend) :- 
    defend_words(DefendWords),
    member(Word, DefendWords),
    !.
identify_verb_type(Word, fire) :-
    fire_words(FireWords),
    member(Word, FireWords),
    !.
identify_verb_type(Word, grass) :- 
    grass_words(GrassWords),
    member(Word, GrassWords),
    !.
identify_verb_type(Word, water) :- 
    water_words(WaterWords),
    member(Word, WaterWords),
    !.
identify_verb_type(Word, normal) :- 
    normal_words(NormalWords),
    member(Word, NormalWords),
    !.
identify_verb_type(_, unknown).

% Identification of the NP
identify_np_type(NPWords, move) :-
    move_words(MoveWords),
    intersection(NPWords, MoveWords, [_|_]),  
    !.
identify_np_type(NPWords, dodge) :-
    dodge_words(DodgeWords),
    intersection(NPWords, DodgeWords, [_|_]),  
    !.
identify_np_type(NPWords, defend) :-
    defend_words(DefendWords),
    intersection(NPWords, DefendWords, [_|_]),  
    !.
identify_np_type(NPWords, fire) :-
    fire_words(FireWords),
    intersection(NPWords, FireWords, [_|_]),  
    !.
identify_np_type(NPWords, grass) :-  
    grass_words(GrassWords),
    intersection(NPWords, GrassWords, [_|_]),  
    !.
identify_np_type(NPWords, water) :-  
    water_words(WaterWords),
    intersection(NPWords, WaterWords, [_|_]),  
    !.
identify_np_type(NPWords, normal) :-
    normal_words(NormalWords),
    intersection(NPWords, NormalWords, [_|_]),  
    !.
identify_np_type(_, unknown).


% Identification of the intensity
identify_intensity(Words, Intensity) :-
    intensity_type(Keyword, Intensity),
    member(Keyword, Words),
    !.
identify_intensity(_, none).

% Identification of the direction
identify_direction(Words, Direction) :-
    direction_type(Keyword, Direction),
    member(Keyword, Words),
    !.
identify_direction(_, none).

% DGC
s_with_subject([Subject|Rest], Rest) --> subject(Subject), verb(_), noun_phrase(_).
s_without_subject --> verb(_), noun_phrase(_).

subject(_) --> [Sub], { atom_string(_, Sub) }.

verb(VerbWord) --> [VerbWord].
noun_phrase(NPWords) --> np_list(NPWords).

np_list([Word|Rest]) --> [Word], np_list(Rest).
np_list([]) --> [].

% Output
parse_input(Input, VerbType, NPType, Intensity, Direction, VerbWord, NPWords) :-
    split_string(Input, " ", "", Words),
    maplist(atom_string, Atoms, Words),  % Convert strings to atoms
    ( 
        (phrase(s_with_subject(Subject, Rest), Atoms), identify_subject(Subject));
        phrase(s_without_subject, Atoms)
    ),
    extract_verb_np(Atoms, VerbWord, NPWords),
    identify_verb_type(VerbWord, VerbType),
    identify_np_type(NPWords, NPType),
    identify_intensity(NPWords, Intensity),
    identify_direction(NPWords, Direction).

% Helper to extract verb and NP words based on list structure
extract_verb_np([_, VerbWord | NPWords], VerbWord, NPWords).
extract_verb_np([VerbWord | NPWords], VerbWord, NPWords).

input(Input) :-
    parse_input(Input, VerbType, NPType, Intensity, Direction, VerbWord, NPWords),
    format("Results: VerbType: ~w, NPType: ~w, Intensity: ~w, Direction: ~w, VerbWord: ~w, NPWords: ~w~n" ,[VerbType, NPType, Intensity, Direction, VerbWord, NPWords]).



