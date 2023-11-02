% Characters
subjects([
    'charmander',
    'Charmander', 
    'bulbasaur',
    'Bulbasaur', 
    'squirtle',
    'Squirtle'
]). 

% Fire words
fire_words([
    'burn', 
    'fire', 
    'ember', 
    'blaze', 
    'incinerate',
    'heat', 
    'inferno', 
    'lava', 
    'magma', 
    'scorch', 
    'ignite', 
    'ember',
    'pyro', 
    'combust', 
    'flame',
    'hot',
    'torch',
    'kindle',
    'enkindle',
    'flamethrower',
    'cinder',
    'flare',
    'flicker',
    'glow',
    'char',
    'smolder',
    'fireball',
    'firestorm',
    'blister',
    'sizzle',
    'spark',
    'conflagrate',
    'firebrand',
    'flare-up',
    'ash'
]).


% Grass words
grass_words([
    'grass', 
    'leaf', 
    'leaves', 
    'vine',
    'vines', 
    'solar', 
    'whip',
    'whips', 
    'seed',
    'seeds',
    'petals', 
    'petal', 
    'drain', 
    'spore',
    'spores', 
    'plant',
    'plants',
    'chlorophyll',
    'sprout',
    'bud',
    'bloom',
    'herb',
    'herbal',
    'flora',
    'foliage',
    'thicket',
    'stalk',
    'branch',
    'twig',
    'ferns',
    'moss',
    'root',
    'roots',
    'shrub',
    'shrubs',
    'undergrowth',
    'sap',
    'photosynthesis'
]).

% Water words
water_words([
    'water',
    'pump',
    'stream',
    'streams',
    'vapor',
    'bubble',
    'bubbles',
    'splash',
    'surf',
    'aqua',
    'hydro',
    'rain',
    'soak',
    'pool',
    'liquid',
    'wave',
    'waves',
    'pee',
    'ocean',
    'oceanic',
    'sea',
    'lake',
    'river',
    'brook',
    'current',
    'tide',
    'dew',
    'mist',
    'fog',
    'hail',
    'drizzle',
    'drench',
    'pour',
    'spray',
    'gush',
    'cascade',
    'whirlpool',
    'moist',
    'moisture',
    'humid',
    'tsunami',
    'flood',
    'deluge'
]).


% Normal words
normal_words([
    'kick',
    'kicks',
    'punch',
    'punches',
    'slap',
    'slaps',
    'hit',
    'attack',
    'attacks',
    'tackle',
    'slam',
    'chop',
    'strike',
    'jab',
    'slash',
    'cut',
    'bash',
    'smash',
    'thrust',
    'headbutt',
    'thump',
    'knock',
    'swing',
    'stomp',
    'whack',
    'pummel',
    'wallop',
    'shove',
    'push',
    'nudge',
    'lunge',
    'poke',
    'prod',
    'smack',
    'bump',
    'tap',
    'clash',
    'crash',
    'butt',
    'swipe',
    'spit',
    'bite',
    'throw'
]).


% Dodge words
dodge_words([
    'avoid',
    'evade',
    'dodge',
    'jump',
    'be careful',
    'care',
    'sidestep',
    'elude',
    'escape',
    'swerve',
    'shift',
    'move aside',
    'skirt',
    'bypass',
    'duck',
    'flee',
    'retreat',
    'recoil',
    'back away',
    'step back'
]).


% Defend words
defend_words([
    'resist',
    'defend',
    'shield',
    'fortify',
    'endure',
    'hold out',
    'stand',
    'protect',
    'guard',
    'cover',
    'reinforce',
    'secure',
    'strengthen',
    'harden',
    'brace',
    'block',
    'ward off',
    'fight off',
    'parry',
    'safeguard',
    'uphold',
    'preserve',
    'resilient',
    'withstand',
    'fend off',
    'repel',
    'repulse',
    'resolute',
    'stave off',
    'deflect',
    'keep at bay'
]).


% Move words
move_words([
    'move',
    'run',
    'walk',
    'go',
    'step',
    'stroll',
    'jog',
    'sprint',
    'dash',
    'hurry',
    'advance',
    'proceed',
    'march',
    'traverse',
    'wander',
    'amble',
    'stride',
    'gallop',
    'hike',
    'scuttle',
    'skip',
    'hop',
    'leap',
    'bound',
    'travel',
    'navigate',
    'journey'
]).


% Intensity types
intensity_type('strongly', strong).
intensity_type('strong', strong).
intensity_type('powerfully', strong).
intensity_type('powerful', strong).
intensity_type('heavily', strong).
intensity_type('heavy', strong).
intensity_type('drastically', strong).
intensity_type('drastic', strong).
intensity_type('seriously', strong).
intensity_type('serious', strong).
intensity_type('extremely', strong).
intensity_type('extreme', strong).
intensity_type('forcefully', strong).
intensity_type('forceful', strong).
intensity_type('intensely', strong).
intensity_type('intense', strong).
intensity_type('energetically', strong).
intensity_type('energetic', strong).
intensity_type('vigorously', strong).
intensity_type('vigorous', strong).
intensity_type('potently', strong).
intensity_type('potent', strong).
intensity_type('fiercely', strong).
intensity_type('fierce', strong).
intensity_type('hard', strong).
intensity_type('mightily', strong).
intensity_type('mighty', strong).
intensity_type('robustly', strong).
intensity_type('robust', strong).
intensity_type('sturdily', strong).
intensity_type('sturdy', strong).
intensity_type('vehemently', strong).
intensity_type('vehement', strong).
intensity_type('vividly', strong).
intensity_type('vivid', strong).
intensity_type('staunchly', strong).
intensity_type('staunch', strong).
intensity_type('turbulently', strong).
intensity_type('turbulent', strong).



intensity_type('weakly', weak).
intensity_type('weak', weak).
intensity_type('a little', weak).
intensity_type('little', weak).
intensity_type('somewhat', weak).
intensity_type('a bit', weak).
intensity_type('bit', weak).
intensity_type('softly', weak).
intensity_type('soft', weak).
intensity_type('gently', weak).
intensity_type('gentle', weak).
intensity_type('slightly', weak).
intensity_type('slight', weak).
intensity_type('mildly', weak).
intensity_type('mild', weak).
intensity_type('barely', weak).
intensity_type('faintly', weak).
intensity_type('faint', weak).
intensity_type('meagerly', weak).
intensity_type('meager', weak).
intensity_type('moderately', weak).
intensity_type('moderate', weak).
intensity_type('feebly', weak).
intensity_type('feeble', weak).
intensity_type('timidly', weak).
intensity_type('timid', weak).
intensity_type('sparingly', weak).
intensity_type('sparing', weak).
intensity_type('hesitantly', weak).
intensity_type('hesitant', weak).



% Direction types
direction_type('forward', forward).
direction_type('towards', forward).
direction_type('straight', forward).
direction_type('ahead', forward).
direction_type('onward', forward).
direction_type('forth', forward).


direction_type('away', backward).
direction_type('back', backward).
direction_type('backwards', backward).
direction_type('reverse', backward).

