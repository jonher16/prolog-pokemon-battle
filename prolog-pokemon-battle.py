#Prolog python ibrary https://github.com/yuce/pyswip/blob/master/INSTALL.md

import random
from pokemon import pokemons
from pokemon import Pokemon
from pokemon import checkPokemon
from pokemon import inputNames
from pokemon import selectPokemon
from parse_LM import askLanguageModel



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
        user_command = input()

        #Ask prolog Language model to retrieve FOL

        fol_results = askLanguageModel(user_command)
        fol = fol_results[0]
        print("First Order Logic", fol)

        #TODO: Prolog inference engine takes FOL and retrieves feedback

        #TODO: Calculations in Python

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
