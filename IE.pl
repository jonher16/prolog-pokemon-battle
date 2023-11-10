% Define a list of past tense verbs for some common verbs
:- consult('vocabulary/verbsinpast.pl').

% Define the verbinpast/3 predicate to construct Feedback1
verbinpast(P1, VerbWord, NPWords, Feedback1) :-
    past_tense(VerbWord, PastVerb),
    atomic_list_concat([P1, PastVerb | NPWords], ' ', Feedback1).

% Define the predicates that will go into the feedback predicate

determine_atype(VerbType, NPType, AType, Error):-
    % Decide AType according to priority

    % Normal attack type
    (VerbType == 'normal', NPType == 'unknown', AType = 'normal', Error = 0);
    (VerbType == 'unknown', NPType == 'normal', AType = 'normal', Error = 0);
    
    % Fire attack type
    (VerbType == 'fire', NPType == 'normal', AType = 'fire', Error = 0);
    (VerbType == 'normal', NPType == 'fire', AType = 'fire', Error = 0);
    (VerbType == 'fire', NPType == 'unknown', AType = 'fire', Error = 0);
    (VerbType == 'unknown', NPType == 'fire', AType = 'fire', Error = 0);
    (VerbType == 'fire', NPType == 'fire', AType = 'fire', Error = 0);

    % Grass attack type
    (VerbType == 'grass', NPType == 'normal', AType = 'grass', Error = 0);
    (VerbType == 'normal', NPType == 'grass', AType = 'grass', Error = 0);
    (VerbType == 'grass', NPType == 'unknown', AType = 'grass', Error = 0);
    (VerbType == 'unknown', NPType == 'grass', AType = 'grass', Error = 0);
    (VerbType == 'grass', NPType == 'grass', AType = 'grass', Error = 0);

    % Water attack type
    (VerbType == 'water', NPType == 'normal', AType = 'water', Error = 0);
    (VerbType == 'normal', NPType == 'water', AType = 'water', Error = 0);
    (VerbType == 'water', NPType == 'unknown', AType = 'water', Error = 0);
    (VerbType == 'unknown', NPType == 'water', AType = 'water', Error = 0);
    (VerbType == 'water', NPType == 'water', AType = 'water', Error = 0);

    % Electric attack type
    (VerbType == 'electric', NPType == 'normal', AType = 'electric', Error = 0);
    (VerbType == 'normal', NPType == 'electric', AType = 'electric', Error = 0);
    (VerbType == 'electric', NPType == 'unknown', AType = 'electric', Error = 0);
    (VerbType == 'unknown', NPType == 'electric', AType = 'electric', Error = 0);
    (VerbType == 'electric', NPType == 'water', AType = 'electric', Error = 0);

    % Special attack errors
    (VerbType == 'fire', NPType == 'water', AType = 'error', Error = 1);
    (VerbType == 'water', NPType == 'fire', AType = 'error', Error = 1);
    (VerbType == 'fire', NPType == 'grass', AType = 'error', Error = 1);
    (VerbType == 'grass', NPType == 'fire', AType = 'error', Error = 1);
    (VerbType == 'fire', NPType == 'electric', AType = 'error', Error = 1);
    (VerbType == 'electric', NPType == 'fire', AType = 'error', Error = 1);
    (VerbType == 'water', NPType == 'grass', AType = 'error', Error = 1);
    (VerbType == 'grass', NPType == 'water', AType = 'error', Error = 1);
    (VerbType == 'water', NPType == 'electric', AType = 'error', Error = 1);
    (VerbType == 'electric', NPType == 'water', AType = 'error', Error = 1);
    (VerbType == 'electric', NPType == 'grass', AType = 'error', Error = 1);
    (VerbType == 'grass', NPType == 'electric', AType = 'error', Error = 1).

determine_error(AType, P1, Error):-
    (Error = 1);

    % Check is AType matches pokemon type and return error
    (P1 == 'charmander', AType == 'water', Error = 1);
    (P1 == 'charmander', AType == 'grass', Error = 1);
    (P1 == 'charmander', AType == 'fire', Error = 0);
    (P1 == 'charmander', AType == 'electric', Error = 0);
    (P1 == 'charmander', AType == 'normal', Error = 0);

    (P1 == 'squirtle', AType == 'fire', Error = 1);
    (P1 == 'squirtle', AType == 'grass', Error = 1);
    (P1 == 'squirtle', AType == 'water', Error = 0);
    (P1 == 'squirtle', AType == 'electric', Error = 0);
    (P1 == 'squirtle', AType == 'normal', Error = 0);

    (P1 == 'bulbasaur', AType == 'water', Error = 1);
    (P1 == 'bulbasaur', AType == 'fire', Error = 1);
    (P1 == 'bulbasaur', AType == 'grass', Error = 0);
    (P1 == 'bulbasaur', AType == 'electric', Error = 0);
    (P1 == 'bulbasaur', AType == 'normal', Error = 0).

determine_feedback(AType, EType, Intensity, P1, Feedback, Multiplier, Error):-
    % Error feedback for each pokemon
    (Error == 1, P1 == 'charmander', Feedback = 'Charmander did not understand the instruction.', Multiplier = 'none');
    (Error == 1, P1 == 'squirtle', Feedback = 'Squirtle did not understand the instruction.', Multiplier = 'none');
    (Error == 1, P1 == 'bulbasaur', Feedback = 'Bulbasaur did not understand the instruction.', Multiplier = 'none');
    (Error == 1, P1 == 'pikachu', Feedback = 'Pikachu did not understand the instruction.', Multiplier = 'none');

    % WATER -> FIRE
    (AType == 'water', EType == 'fire', Intensity == 'strong', Feedback = 'The attack was super effective!', Multiplier = 3);
    (AType == 'water', EType == 'fire', Intensity == 'none', Feedback = 'The attack was very effective.', Multiplier = 2);
    (AType == 'water', EType == 'fire', Intensity == 'weak', Feedback = 'The attack was effective but weak.', Multiplier = 1);

    % FIRE -> WATER
    (AType == 'fire', EType == 'water', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'fire', EType == 'water', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'fire', EType == 'water', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % WATER -> GRASS
    (AType == 'water', EType == 'grass', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'water', EType == 'grass', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'water', EType == 'grass', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % GRASS -> WATER
    (AType == 'grass', EType == 'water', Intensity == 'strong', Feedback = 'The attack was super effective!', Multiplier = 3);
    (AType == 'grass', EType == 'water', Intensity == 'none', Feedback = 'The attack was very effective.', Multiplier = 2);
    (AType == 'grass', EType == 'water', Intensity == 'weak', Feedback = 'The attack was effective but weak.', Multiplier = 1);

    % WATER -> ELECTRIC
    (AType == 'water', EType == 'electric', Intensity == 'strong', Feedback = 'The attack was effective!', Multiplier = 2);
    (AType == 'water', EType == 'electric', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 1);
    (AType == 'water', EType == 'electric', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.5);

    % ELECTRIC -> WATER
    (AType == 'electric', EType == 'water', Intensity == 'strong', Feedback = 'The attack was super effective!', Multiplier = 3);
    (AType == 'electric', EType == 'water', Intensity == 'none', Feedback = 'The attack was very effective.', Multiplier = 2);
    (AType == 'electric', EType == 'water', Intensity == 'weak', Feedback = 'The attack was effective but weak.', Multiplier = 1);

    % FIRE -> GRASS
    (AType == 'fire', EType == 'grass', Intensity == 'strong', Feedback = 'The attack was super effective!', Multiplier = 3);
    (AType == 'fire', EType == 'grass', Intensity == 'none', Feedback = 'The attack was very effective.', Multiplier = 2);
    (AType == 'fire', EType == 'grass', Intensity == 'weak', Feedback = 'The attack was effective but weak.', Multiplier = 1);

    % GRASS -> FIRE
    (AType == 'grass', EType == 'fire', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'grass', EType == 'fire', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'grass', EType == 'fire', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % FIRE -> ELECTRIC
    (AType == 'fire', EType == 'electric', Intensity == 'strong', Feedback = 'The attack was effective!', Multiplier = 2);
    (AType == 'fire', EType == 'electric', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 1);
    (AType == 'fire', EType == 'electric', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.5);

    % ELECTRIC -> FIRE
    (AType == 'electric', EType == 'fire', Intensity == 'strong', Feedback = 'The attack was effective!', Multiplier = 2);
    (AType == 'electric', EType == 'fire', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 1);
    (AType == 'electric', EType == 'fire', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.5);

    % GRASS -> ELECTRIC
    (AType == 'grass', EType == 'electric', Intensity == 'strong', Feedback = 'The attack was effective!', Multiplier = 2);
    (AType == 'grass', EType == 'electric', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 1);
    (AType == 'grass', EType == 'electric', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.5);

    % ELECTRIC -> GRASS
    (AType == 'electric', EType == 'grass', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'electric', EType == 'grass', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'electric', EType == 'grass', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % WATER -> WATER
    (AType == 'water', EType == 'water', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'water', EType == 'water', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'water', EType == 'water', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % FIRE -> FIRE
    (AType == 'fire', EType == 'fire', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'fire', EType == 'fire', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'fire', EType == 'fire', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % GRASS -> GRASS
    (AType == 'grass', EType == 'grass', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'grass', EType == 'grass', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'grass', EType == 'grass', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % ELECTRIC -> ELECTRIC
    (AType == 'electric', EType == 'electric', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'electric', EType == 'electric', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'electric', EType == 'electric', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % NORMAL
    (AType == 'normal', Intensity == 'strong', Feedback = 'The attack was effective!', Multiplier = 2);
    (AType == 'normal', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 1);
    (AType == 'normal', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.5);

    % ALL-CASE
    (Feedback = 'Unknown action', Multiplier = 'none').

% Define the feedback/5 predicate to construct Feedback2 and Multiplier

feedback(VerbType, NPType, EType, Intensity, P1, Feedback2, Multiplier) :-
    determine_atype(VerbType, NPType, AType, Error),
    determine_error(AType, P1, Error),
    determine_feedback(AType, EType, Intensity, P1, Feedback2, Multiplier, Error).

% Query to get the feedback and multiplier based on input parameters
parse_input(VerbType, NPType, Intensity, Direction, VerbWord, NPWords, EType, P1, P2, Feedback1, Feedback2, Multiplier) :-
    write('NPType: '), write(NPType), nl,
    write('VerbType: '), write(VerbType), nl,
    write('VerbWord: '), write(VerbWord), nl,
    write('EType: '), write(EType), nl,
    write('Intensity: '), write(Intensity), nl,
    write('Direction: '), write(Direction), nl,
    verbinpast(P1, VerbWord, NPWords, Feedback1),
    feedback(VerbType, NPType, EType, Intensity, P1, Feedback2, Multiplier).

    %write(Feedback1), write(Feedback2), write(' (Multiplier: '), write(Multiplier), write(')'), nl.

% Example usage:
% Call this query with your input parameters to get the feedback and multiplier
% get_feedback_multiplier('normal', 'water', 'strong', 'none', Feedback, Multiplier).

