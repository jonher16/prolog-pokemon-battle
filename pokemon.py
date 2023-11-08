import random

pokemons = [
    {
        "pokemon_name": "Bulbasaur",
        "type": "grass",
    },
    {
        "pokemon_name": "Squirtle",
        "type": "water",
    },
    {
        "pokemon_name": "Charmander",
        "type": "fire",
    }
]

class Pokemon:
    def __init__(self, pokemon_name, player_name):
        self.pokemon_name = pokemon_name
        self.player_name = player_name
        self.hp = 100  
        self.distance = 2
        self.is_defending = False
        self.is_dodging = False
        self.base_damage = 10
        self.avoid_chance = 0.5

    def __str__(self):
        str = f"Pokemon: {self.pokemon_name}\nHP: {self.hp}\nDistance to enemy pokemon: {self.distance}"
        return str

    def is_alive(self):
        return self.hp > 0

    def attack(self, opponent, multiplier):

        #TODO Add miss chance depending on the adjective (NOT multiplier!!)

        dmg = self.base_damage * multiplier
        opponent.hp -= dmg

        print(f"{self.pokemon_name} dealt to {opponent.pokemon_name} {dmg} HP damage!")

    def move(self, opponent, direction):
        if direction == "forward":
            self.distance -= 1
            opponent.distance -= 1
        elif direction == "backward":
            self.distance += 1
            opponent.distance += 1
        else:
            print("Error: no direction specified. Skipping turn.")

        print(f"{self.pokemon_name} moved {direction} to the opponent!")

    def defend(self):
        self.is_defending = True
        print(f"{self.pokemon_name} is defending for the next attack!")

    def dodge(self):
        self.is_dodging = True
        print(f"{self.pokemon_name} will try to avoid the next attack!")

## Utility functions

def checkPokemon(pokemon, pokemon_names):
    if pokemon in pokemon_names:
        return pokemon
    else:
        print('Error: This pokemon is not on the list. Please select another one.')
        return None

def selectPokemon(name1, name2):

    pokemon_names = [pokemon["pokemon_name"] for pokemon in pokemons]
    print(f"Available Pokemons: {', '.join(pokemon_names)}")

    while True:
        pokemon_name1 = input(f"{name1}, choose your Pokemon: ")
        isPokemon1 = checkPokemon(pokemon_name1, pokemon_names)
        if isPokemon1:
            break
        else:
            "This Pokemon is not in the list. Please try again."

    while True:
        pokemon_name2 = input(f"{name2}, choose your Pokemon: ")
        isPokemon2 = checkPokemon(pokemon_name2, pokemon_names)
        if isPokemon2:
            break
        else:
             "This Pokemon is not in the list. Please try again."

    player1 = Pokemon(pokemon_name1, name1)
    player2 = Pokemon(pokemon_name2, name2) 

    return player1, player2

def inputNames():

    name1 = input("Enter Player 1's name: ")
    name2 = input("Enter Player 2's name: ")
    return name1, name2

def handle_defend(opponent, intensity):
        
        defend_success = True
        if (opponent.distance <=2 and intensity == "strong" ):
            defend_success = False
        #TODO add more rules in which defense is broken
        return defend_success

def handle_dodge(opponent):
        
        random_no = random.random()
        return True if random_no <= opponent.avoid_chance else False #Succeed avoiding if random number within the avoiding chancess