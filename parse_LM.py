from pyswip import Prolog

def askLanguageModel(user_input):

    # Initialize Prolog
    prolog = Prolog()

    # Load Prolog program
    prolog.consult('LM.pl')

    # Define query
    str(user_input)
    query = f'parse_input("{user_input}", VerbType, NPType, Intensity, Direction, VerbWord, NPWords).'

    # Query Prolog
    results = list(prolog.query(query))

    # Extract the string values from Prolog atoms
    parsed_results = []
    for result in results:
        parsed_result = {
            'VerbType': str(result['VerbType']),
            'NPType': str(result['NPType']),
            'Intensity': str(result['Intensity']),
            'Direction': str(result['Direction']),
            'VerbWord': str(result['VerbWord']),
            'NPWords': [str(atom) for atom in result['NPWords']]
        }
        parsed_results.append(parsed_result)

    # Now parsed_results contains the extracted string values
    return parsed_results
