#Prolog python ibrary https://github.com/yuce/pyswip/blob/master/INSTALL.md

import random
from pokemon import pokemons
from pokemon import Pokemon
from pokemon import checkPokemon
from pokemon import inputNames
from pokemon import selectPokemon
from parse_LM import askLanguageModel
from parse_IE import askInferenceEngine


def main():

    print("Welcome to the Pokemon Battle Simulator!")

    name1, name2 = inputNames()
    
    player1, player2 = selectPokemon(name1, name2)

    current_player = player1
    opponent = player2

    while player1.is_alive() and player2.is_alive():

        print(f"{current_player.player_name}'s turn:")
        print(f"Your Pokemon: {current_player.pokemon_name}, HP: {current_player.hp}")
        print("Enter your action:")
        user_command = input().lower()

        #Ask prolog Language model to retrieve FOL

        fol_results = askLanguageModel(user_command)
        fol = fol_results[0]
        print("First Order Logic", fol)

        #TODO: Prolog inference engine takes FOL and retrieves feedback
        ie_input = fol
        ie_input["Etype"] = player2
        ie_input["P1"] = player2
        ie_input["P2"] = player2

        # Extract values from the dictionary
        VerbType = ie_input['VerbType']
        NPType = ie_input['NPType']
        Intensity = ie_input['Intensity']
        Direction = ie_input['Direction']
        VerbWord = ie_input['VerbWord']
        NPWords = ie_input['NPWords']
        pokemon_type = next((p['type'] for p in pokemons if p['name'].lower() == current_player.pokemon_name.lower()), None)
        EType = pokemon_type
        P1 = current_player.pokemon_name
        P2 = opponent.pokemon_name
        
        #TODO: Handle case when trainer tries to command a fire pokemon to do a water attack
        #TODO: Calculate dodge / defense probabilities and handle dodge-> nododge
        
        # Create the formatted string
        formatted_ie_input = f"parse_input('{VerbType}', '{NPType}', '{Intensity}', '{Direction}', '{VerbWord}', {NPWords}, '{EType}', '{P1}', '{P2}', Feedback1, Feedback2, Multiplier)."
        print("IE input:",formatted_ie_input)
        #Get result from inference engine
        f1, f2, multiplier = askInferenceEngine(formatted_ie_input)

        print("IE Response: ", f1, f2, multiplier) #Feedback1 (verb in past), Feedback2 (Effectivenes), Multiplier (Damage)

        #TODO: Stat calculations in Python

        # Switch players
        if current_player == player1:
            current_player = player2
            opponent = player1
        else:
            current_player = player1
            opponent = player2

    print("Battle is over!")
    if player1.is_alive():
        print(f"{name1}'s {player1.name} wins!")
    else:
        print(f"{name2}'s {player2.name} wins!")

if __name__ == "__main__":
    main()
