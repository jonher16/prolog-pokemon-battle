from pyswip import Prolog

def askInferenceEngine(fol):
    # Initialize Prolog
    prolog1 = Prolog()

    # Load your Prolog file
    prolog1.consult('IE.pl')  # Replace 'your_prolog_file.pl' with the actual file path

    #TODO-INSIDE-PROLOG: Handle cases like P1: Squirtle P2: Charmander and user command is "use water against Bulbasaur" -> in reality its getting the foe pokemon always no matter what

    # Query Prolog to get feedback1, feedback2, and multiplier
    results = list(prolog1.query(fol))
    result = results[0]
    feedback1 = result['Feedback1']
    feedback2 = result['Feedback2']
    multiplier = result['Multiplier']
    return feedback1, feedback2, multiplier
