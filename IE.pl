% Define a list of past tense verbs for some common verbs
past_tense(throw, threw).
past_tense(use, used).
% ... (include other past tense forms as needed)

% Define the verbinpast/3 predicate to construct Feedback1
verbinpast(P1, VerbWord, NPWords, Feedback1) :-
    past_tense(VerbWord, PastVerb),
    atomic_list_concat([P1, PastVerb | NPWords], ' ', Feedback1).

% Define the feedback/5 predicate to construct Feedback2 and Multiplier

feedback(VerbType, NPType, EType, Intensity, Direction, Feedback, Multiplier, P1) :-

    % MOVEMENT
    %(Direction == 'forward', Feedback = 'The Pokémon moved closer to the enemy!', Multiplier = 'none', !);
    %(Direction == 'backward', Feedback = 'The Pokémon moved away from the enemy!', Multiplier = 'none', !);

    % DODGE
    %(VerbType == 'dodge', Feedback = 'The attack was dodged!', Multiplier = 'none', !);
    %(VerbType == 'nododge', Feedback = 'The Pokémon failed at dodging the attack!', Multiplier = 'none', !);

    %DEFEND
    %(VerbType == 'defend', Feedback = 'The pokemon successfully defended itself from the enemy attack!', Multiplier = 'none', !);
    %(VerbType == 'nodefend', Feedback = 'The Pokémon failed at defending! The defense was broken!', Multiplier = 'none', !);

    % Handle the "Unknown" case
    % (VerbType == 'unknown', NPType == 'unknown', Feedback = 'The pokemon is looking at you with a confused face.');
    (
    % Decide AType according to priority

    % Normal attack type
    (VerbType == 'normal', NPType == 'unknown', AType == 'normal', Error = 0);
    (VerbType == 'unknown', NPType == 'normal', AType == 'normal', Error = 0);
    
    % Fire attack type
    (VerbType == 'fire', NPType == 'normal', AType == 'fire', Error = 0);
    (VerbType == 'normal', NPType == 'fire', AType == 'fire', Error = 0);
    (VerbType == 'fire', NPType == 'unknown', AType == 'fire', Error = 0);
    (VerbType == 'unknown', NPType == 'fire', AType == 'fire', Error = 0);

    % Grass attack type
    (VerbType == 'grass', NPType == 'normal', AType == 'grass', Error = 0);
    (VerbType == 'normal', NPType == 'grass', AType == 'grass', Error = 0);
    (VerbType == 'grass', NPType == 'unknown', AType == 'grass', Error = 0);
    (VerbType == 'unknown', NPType == 'grass', AType == 'grass', Error = 0);

    % Water attack type
    (VerbType == 'water', NPType == 'normal', AType == 'water', Error = 0);
    (VerbType == 'normal', NPType == 'water', AType == 'water', Error = 0);
    (VerbType == 'water', NPType == 'unknown', AType == 'water', Error = 0);
    (VerbType == 'unknown', NPType == 'water', AType == 'water', Error = 0);

    % Special attack errors
    (VerbType == 'fire', NPType == 'water', Error = 1);
    (VerbType == 'water', NPType == 'fire', Error = 1);
    (VerbType == 'fire', NPType == 'grass', Error = 1);
    (VerbType == 'grass', NPType == 'fire', Error = 1);
    (VerbType == 'water', NPType == 'grass', Error = 1);
    (VerbType == 'grass', NPType == 'water', Error = 1).

    ),
    (
    (Error = 1);

    % Check is AType matches pokemon type and return error
    (P1 == 'Charmander', AType == 'water', Error = 1);
    (P1 == 'Charmander', AType == 'grass', Error = 1);
    (P1 == 'Charmander', AType == 'fire', Error = 0);

    (P1 == 'Squirtle', AType == 'fire', Error = 1);
    (P1 == 'Squirtle', AType == 'grass', Error = 1);
    (P1 == 'Squirtle', AType == 'water', Error = 0);

    (P1 == 'Bulbasaur', AType == 'water', Error = 1);
    (P1 == 'Bulbasaur', AType == 'fire', Error = 1);
    (P1 == 'Bulbasaur', AType == 'grass', Error = 0).
    ),
    (
    % Error feedback for each pokemon
    (Error = 1, P1 = 'Charmander', Feedback = 'Charmander did not understand the instruction.', Multiplier = 'none');
    (Error = 1, P1 = 'Squirtle', Feedback = 'Squirtle did not understand the instruction.', Multiplier = 'none');
    (Error = 1, P1 = 'Bulbasaur', Feedback = 'Bulbasaur did not understand the instruction.', Multiplier = 'none');

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

    % FIRE -> GRASS
    (AType == 'fire', EType == 'grass', Intensity == 'strong', Feedback = 'The attack was super effective!', Multiplier = 3);
    (AType == 'fire', EType == 'grass', Intensity == 'none', Feedback = 'The attack was very effective.', Multiplier = 2);
    (AType == 'fire', EType == 'grass', Intensity == 'weak', Feedback = 'The attack was effective but weak.', Multiplier = 1);

    % GRASS -> FIRE
    (AType == 'grass', EType == 'fire', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (AType == 'grass', EType == 'fire', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (AType == 'grass', EType == 'fire', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

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

    % ALL-CASE
    (Feedback = 'Unknown action', Multiplier = 'none').
    )

% Query to get the feedback and multiplier based on input parameters
parse_input(VerbType, NPType, Intensity, Direction, VerbWord, NPWords, EType, P1, P2, Feedback1, Feedback2, Multiplier) :-
    write('NPType: '), write(NPType), nl,
    write('VerbType: '), write(VerbType), nl,
    write('VerbWord: '), write(VerbWord), nl,
    write('EType: '), write(EType), nl,
    write('Intensity: '), write(Intensity), nl,
    write('Direction: '), write(Direction), nl,
    verbinpast(P1, VerbWord, NPWords, Feedback1),
    feedback(VerbType, NPType, EType, Intensity, Direction, Feedback2, Multiplier, P1).

    %write(Feedback1), write(Feedback2), write(' (Multiplier: '), write(Multiplier), write(')'), nl.

% Example usage:
% Call this query with your input parameters to get the feedback and multiplier
% get_feedback_multiplier('normal', 'water', 'strong', 'none', Feedback, Multiplier).

