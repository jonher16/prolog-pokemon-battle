#Prolog python ibrary https://github.com/yuce/pyswip/blob/master/INSTALL.md

import random
from pokemon import pokemons
from pokemon import Pokemon
from parse_LM import askLanguageModel

def main():
    print("Welcome to the Pokemon Battle Game!")
    name1 = input("Enter Player 1's name: ")
    name2 = input("Enter Player 2's name: ")

    pokemon_names = [pokemon["name"] for pokemon in pokemons]
    print(f"Available Pokemons: {', '.join(pokemon_names)}")

    pokemon_name1 = input(f"{name1}, choose your Pokemon: ")
    pokemon_name2 = input(f"{name2}, choose your Pokemon: ")

    player1 = Pokemon(pokemon_name1)
    player2 = Pokemon(pokemon_name2)

    current_player = player1
    opponent = player2

    while player1.is_alive() and player2.is_alive():
        print(f"{current_player.name}'s turn:")
        print("Enter your action (<action> <strength>):")
        user_command = input()
        print(f"{current_player.name} commanded ", user_command)
        fol = askLanguageModel(user_command)
        print("First order logic", fol)


        # This part can be replaced with Prolog's inference in the future
        # if action == "normal_attack":
        #     current_player.normal_attack(opponent, strength)
        # elif action == "special_attack":
        #     current_player.special_attack(opponent)
        # elif action == "move":
        #     current_player.move(strength[0])
        # elif action == "defend":
        #     current_player.defend()

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
