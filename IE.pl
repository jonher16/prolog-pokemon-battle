% Define a list of past tense verbs for some common verbs
past_tense(throw, threw).
past_tense(use, used).
% ... (include other past tense forms as needed)

% Define the verbinpast/3 predicate to construct Feedback1
verbinpast(P1, VerbWord, NPWords, Feedback1) :-
    past_tense(VerbWord, PastVerb),
    atomic_list_concat([P1, PastVerb | NPWords], ' ', Feedback1).

% Define the feedback/5 predicate to construct Feedback2 and Multiplier

feedback(VerbType, NPType, EType, Intensity, Direction, Feedback, Multiplier) :-

     % MOVEMENT
    %(Direction == 'forward', Feedback = 'The Pokémon moved closer to the enemy!', Multiplier = 'none', !);
    %(Direction == 'backward', Feedback = 'The Pokémon moved away from the enemy!', Multiplier = 'none', !);

    % DODGE
    %(VerbType == 'dodge', Feedback = 'The attack was dodged!', Multiplier = 'none', !);
    %(VerbType == 'nododge', Feedback = 'The Pokémon failed at dodging the attack!', Multiplier = 'none', !);

    %DEFEND
    %(VerbType == 'defend', Feedback = 'The pokemon successfully defended itself from the enemy attack!', Multiplier = 'none', !);
    %(VerbType == 'nodefend', Feedback = 'The Pokémon failed at defending! The defense was broken!', Multiplier = 'none', !);

    % WATER -> FIRE
    (NPType == 'water', EType == 'fire', Intensity == 'strong', Feedback = 'The attack was super effective!', Multiplier = 3);
    (NPType == 'water', EType == 'fire', Intensity == 'none', Feedback = 'The attack was very effective.', Multiplier = 2);
    (NPType == 'water', EType == 'fire', Intensity == 'weak', Feedback = 'The attack was effective but weak.', Multiplier = 1);

    % FIRE -> WATER
    (NPType == 'fire', EType == 'water', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (NPType == 'fire', EType == 'water', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (NPType == 'fire', EType == 'water', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % WATER -> GRASS
    (NPType == 'water', EType == 'grass', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (NPType == 'water', EType == 'grass', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (NPType == 'water', EType == 'grass', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % GRASS -> WATER
    (NPType == 'grass', EType == 'water', Intensity == 'strong', Feedback = 'The attack was super effective!', Multiplier = 3);
    (NPType == 'grass', EType == 'water', Intensity == 'none', Feedback = 'The attack was very effective.', Multiplier = 2);
    (NPType == 'grass', EType == 'water', Intensity == 'weak', Feedback = 'The attack was effective but weak.', Multiplier = 1);

    % FIRE -> GRASS
    (NPType == 'fire', EType == 'grass', Intensity == 'strong', Feedback = 'The attack was super effective!', Multiplier = 3);
    (NPType == 'fire', EType == 'grass', Intensity == 'none', Feedback = 'The attack was very effective.', Multiplier = 2);
    (NPType == 'fire', EType == 'grass', Intensity == 'weak', Feedback = 'The attack was effective but weak.', Multiplier = 1);

    % GRASS -> FIRE
    (NPType == 'grass', EType == 'fire', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (NPType == 'grass', EType == 'fire', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (NPType == 'grass', EType == 'fire', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % WATER -> WATER
    (NPType == 'water', EType == 'water', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (NPType == 'water', EType == 'water', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (NPType == 'water', EType == 'water', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % FIRE -> FIRE
    (NPType == 'fire', EType == 'fire', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (NPType == 'fire', EType == 'fire', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (NPType == 'fire', EType == 'fire', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % GRASS -> GRASS
    (NPType == 'grass', EType == 'grass', Intensity == 'strong', Feedback = 'The attack was not very effective but dealt some damage!', Multiplier = 1);
    (NPType == 'grass', EType == 'grass', Intensity == 'none', Feedback = 'The attack was not very effective...', Multiplier = 0.5);
    (NPType == 'grass', EType == 'grass', Intensity == 'weak', Feedback = 'The attack was not effective at all...', Multiplier = 0.25);

    % ALL-CASE
    (Feedback = 'Unknown action', Multiplier = 'none').

% Query to get the feedback and multiplier based on input parameters
parse_input(VerbType, NPType, Intensity, Direction, VerbWord, NPWords, EType, P1, P2, Feedback1, Feedback2, Multiplier) :-
    write('NPType: '), write(NPType), nl,
    write('VerbType: '), write(VerbType), nl,
    write('VerbWord: '), write(VerbWord), nl,
    write('EType: '), write(EType), nl,
    write('Intensity: '), write(Intensity), nl,
    write('Direction: '), write(Direction), nl,
    verbinpast(P1, VerbWord, NPWords, Feedback1),
    feedback(VerbType, NPType, EType, Intensity, Direction, Feedback2, Multiplier).

    %write(Feedback1), write(Feedback2), write(' (Multiplier: '), write(Multiplier), write(')'), nl.

% Example usage:
% Call this query with your input parameters to get the feedback and multiplier
% get_feedback_multiplier('normal', 'water', 'strong', 'none', Feedback, Multiplier).

