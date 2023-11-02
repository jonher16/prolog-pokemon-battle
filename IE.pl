% Rule for super effective attack
feedback('The attack was super effective!', 3) :-
    NPType = 'water',
    EType = 'fire',
    Intensity = 'strong'.

% Rule for very effective attack
feedback('The attack was very effective.', 2) :-
    NPType = 'water',
    EType = 'fire',
    Intensity = 'normal'.

% Rule for effective but weak attack
feedback('The attack was effective but weak.', 1) :-
    NPType = 'water',
    EType = 'fire',
    Intensity = 'weak'.

% Rule for not effective attack
feedback('The attack was not effective...', 0.5) :-
    NPType = 'fire',
    EType = 'water'.

% Rule for attack dodge
feedback('The attack was dodged!', none) :-
    (VerbType = 'dodge' ; NPType = 'dodge').

% Rule for unsuccessful dodge
feedback('The dodge was not successful!', none) :-
    (VerbType = 'nododge' ; NPType = 'nododge').

% Rule for successful defense
feedback('The Pokémon successfully defended.', none) :-
    (VerbType = 'defend' ; NPType = 'defend').

% Rule for broken defense
feedback('The Pokémon defense was broken!', none) :-
    (VerbType = 'nodefend' ; NPType = 'nodefend').

% Rule for moving forward without defense or dodge
feedback('Pokemon moved forward.', none) :-
    Direction = 'forward',
    \+ (VerbType = 'defend' ; NPType = 'defend' ; VerbType = 'dodge' ; NPType = 'dodge').

% Rule for moving backward without defense or dodge
feedback('Pokemon moved backward.', none) :-
    Direction = 'backward',
    \+ (VerbType = 'defend' ; NPType = 'defend' ; VerbType = 'dodge' ; NPType = 'dodge').

% Default rule
feedback('Unknown action', none).


% Define a list of past tense verbs for some common verbs
past_tense(throw, threw).
past_tense(use, used).
% Add more past tense forms for other verbs as needed.

% Define the verbinpast/5 predicate
verbinpast(P1, P2, VerbWord, NPWords, Feedback1) :-
    % Convert the verb to past tense
    past_tense(VerbWord, PastVerb),
    
    % Combine the elements to form the feedback
    atomic_list_concat([P1, PastVerb | NPWords], ' ', Feedback1).



% Query to get the feedback and multiplier based on input parameters
parse_input(VerbType, NPType, Intensity, Direction, VerbWord, NPWords, EType, P1, P2, Feedback1, Feedback2, Multiplier) :-
    verbinpast(P1,P2,VerbWord, NPWords, Feedback1), 
    feedback(Feedback2, Multiplier),
    write(Feedback1), write(Feedback2), write(' (Multiplier: '), write(Multiplier), write(')'), nl.

% Example usage:
% Call this query with your input parameters to get the feedback and multiplier
% get_feedback_multiplier('normal', 'water', 'strong', 'none', Feedback, Multiplier).

