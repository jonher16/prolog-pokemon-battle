#Prolog python ibrary https://github.com/yuce/pyswip/blob/master/INSTALL.md

import random
from pokemon import pokemons
from pokemon import Pokemon
from pokemon import checkPokemon
from pokemon import inputNames
from pokemon import selectPokemon
from pokemon import handle_defend
from pokemon import handle_dodge
from parse_LM import askLanguageModel
from parse_IE import askInferenceEngine


def main():

    print("Welcome to the Pokemon Battle Simulator!")

    name1, name2 = inputNames()
    
    player1, player2 = selectPokemon(name1, name2)

    current_player = player1
    opponent = player2

    while player1.is_alive() and player2.is_alive():

        print(f"\n{current_player.player_name}'s turn:")
        print(current_player)
        print("Enter your action:")
        user_command = input().lower()

        #Ask prolog Language model to retrieve FOL

        fol_results = askLanguageModel(user_command)
        fol = fol_results[0]
        print("First Order Logic", fol)

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
        op_pokemon_type = next((p['type'] for p in pokemons if p['pokemon_name'].lower() == opponent.pokemon_name.lower()), None)
        EType = op_pokemon_type
        P1 = current_player.pokemon_name
        P2 = opponent.pokemon_name
        
        #TODO: Handle case when trainer tries to command a fire pokemon to do a water attack

        flag_skip = False #Flag for skipping attack phase


        if opponent.is_dodging and ((VerbType != 'defend') or (VerbType != 'dodge') or (VerbType != 'move')): #Only If opponent is dodging and current pokemon attacks
            success = handle_dodge(opponent)
            if success == True:
                flag_skip = True
                print(f"{opponent.pokemon_name} avoided the attack!")
                opponent.avoid_chance *= 0.9
            else:
                print(f"{opponent.pokemon_name} did not succeed avoiding the attack!")
                #VerbType == 'nododge'
        
        if opponent.is_defending and ((VerbType != 'defend') or (VerbType != 'dodge') or (VerbType != 'move')): #Only If opponent is defending and current pokemon attacks
            success = handle_defend(opponent, Intensity)
            if success == True:
                flag_skip = True
                print(f"{opponent.pokemon_name} protected from the attack!")
                #VerbType == 'nodefense'
            else:
                print(f"{opponent.pokemon_name}'s defense was broken!")
        
        if opponent.is_defending:
            opponent.is_defending = False # Opponent Stop defending no matter what after this turn

        if opponent.is_dodging:
            opponent.is_dodging = False # Opponent Stop dodging no matter what after this turn

        if (VerbType == 'move' or NPType == 'move'):
            current_player.move(opponent, Direction)
            flag_skip = True

        elif (VerbType == 'dodge' or NPType == 'dodge'):
            current_player.dodge()
            flag_skip = True
        
        elif (VerbType == 'defend' or NPType == 'defend'):
            current_player.defend()
            flag_skip = True

        #In case the command is actually an attack
        elif flag_skip == False:
            
            # Create the formatted string
            formatted_ie_input = f"parse_input('{VerbType}', '{NPType}', '{Intensity}', '{Direction}', '{VerbWord}', {NPWords}, '{EType}', '{P1.lower()}', '{P2.lower()}', Feedback1, Feedback2, Multiplier)."
            print("IE input:",formatted_ie_input)

            # Get result from inference engine
            f1, f2, multiplier = askInferenceEngine(formatted_ie_input)

            #In case inference engine does not return anything, skip the attack
            if f1 == "unknown" and f2 == "unknown": 
                flagskip2 = True 
            else: 
                flagskip2 = False

            #In case the Inference engine returns something, keep carrying out the attack
            if flagskip2 == False:

                flag_skip3 = current_player.attack(opponent, multiplier, Intensity)

                # In case the attack does not miss (because of attack intensity-varible miss chance)
                if not flag_skip3:
                    print("IE Response: ", f1, f2, multiplier) #Feedback1 (verb in past), Feedback2 (Effectiveness), Multiplier (Damage)
            else:
                print(f"{current_player.pokemon_name} did not understand your command!")

        # Switch players
        if current_player == player1:
            current_player = player2
            opponent = player1
        else:
            current_player = player1
            opponent = player2

    print("Battle is over!")
    if player1.is_alive():
        print(f"{player1.player_name}'s {player1.pokemon_name} wins!")
    else:
        print(f"{player2.player_name}'s {player2.pokemon_name} wins!")

if __name__ == "__main__":
    main()
