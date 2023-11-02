#Prolog python ibrary https://github.com/yuce/pyswip/blob/master/INSTALL.md

import random

class Pokemon:
    def __init__(self, name):
        self.name = name
        self.hp = 100  
        self.pp = 10  
        self.distance = 0  
        self.is_defending = False

    def is_alive(self):
        return self.hp > 0

    def normal_attack(self, opponent, intensity):
        damage, miss_chance = self.calculate_damage_and_chance(intensity)
        
        # Handle defense and avoidance here
        damage, miss_chance = calculate_consequences(opponent, damage, miss_chance, intensity)
        
        if random.random() < miss_chance:
            print(f"{self.name}'s attack missed!")
            return

        opponent.hp -= damage
        self.pp -= 1
        print(f"{self.name} attacked {opponent.name} for {damage} damage!")

    def calculate_damage_and_chance(self, intensity):
        base_damage = 10
        if intensity == "strong":
            return base_damage * 1.5, 0.3
        elif intensity == "weak":
            return base_damage * 0.5, 0.1
        return base_damage, 0.2

    def special_attack(self, opponent):
        damage = 20
        # Handle defense and avoidance here
        damage, miss_chance = calculate_consequences(opponent, damage, 0.2, "special")
        if random.random() < miss_chance:
            print(f"{self.name}'s attack missed!")
            return

        opponent.hp -= damage
        self.pp -= 1
        print(f"{self.name} used a special attack on {opponent.name} for {damage} damage!")

    def move(self, direction):
        if direction == "forward":
            self.distance -= 1
        else:
            self.distance += 1
        print(f"{self.name} moved {direction} to the opponent!")

    def defend(self):
        self.is_defending = True
        print(f"{self.name} is defending!")

    def avoid(self, intensity):
        avoid_chance = 0.5
        if intensity == "strong":
            avoid_chance = 0.3
        elif intensity == "weak":
            avoid_chance = 0.7
        return random.random() < avoid_chance

def calculate_consequences(opponent, damage, miss_chance, intensity):
    # TODO: Replace with Prolog for better inference

    # Handling defense
    if opponent.is_defending:
        if intensity == "strong" and opponent.distance == 0:
            print(f"{opponent.name}'s defense was broken!")
            opponent.is_defending = False
        else:
            damage = 0
            print(f"{opponent.name} defended the attack!")
    
    # Handling avoidance
    avoided = opponent.avoid(intensity)
    if avoided:
        damage = 0
        miss_chance = 1
        print(f"{opponent.name} avoided the attack!")

    return damage, miss_chance

def main():
    print("Welcome to the Pokemon Battle Game!")
    name1 = input("Enter Player 1's name: ")
    name2 = input("Enter Player 2's name: ")

    pokemons = ["Bulbasaur", "Charmander", "Squirtle"]
    print(f"Available Pokemons: {', '.join(pokemons)}")

    pokemon_name1 = input(f"{name1}, choose your Pokemon: ")
    pokemon_name2 = input(f"{name2}, choose your Pokemon: ")

    player1 = Pokemon(pokemon_name1)
    player2 = Pokemon(pokemon_name2)

    current_player = player1
    opponent = player2

    while player1.is_alive() and player2.is_alive():
        print(f"{current_player.name}'s turn:")
        print("Enter your action (<action> <strength>):")
        action, *strength = input().split()
        strength = strength[0] if strength else ""

        # This part can be replaced with Prolog's inference in the future
        if action == "normal_attack":
            current_player.normal_attack(opponent, strength)
        elif action == "special_attack":
            current_player.special_attack(opponent)
        elif action == "move":
            current_player.move(strength[0])
        elif action == "defend":
            current_player.defend()

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
