import random

pokemons = [
    {
        "name": "Bulbasaur",
        "type": "grass",
    },
    {
        "name": "Squirtle",
        "type": "water",
    },
    {
        "name": "Charmander",
        "type": "fire",
    }
]

class Pokemon:
    def __init__(self, pokemon_name, player_name):
        self.pokemon_name = pokemon_name
        self.player_name = player_name
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

def checkPokemon(pokemon, pokemon_names):
    if pokemon in pokemon_names:
        return pokemon
    else:
        print('Error: This pokemon is not on the list. Please select another one.')
        return None

def selectPokemon(name1, name2):

    pokemon_names = [pokemon["name"] for pokemon in pokemons]
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