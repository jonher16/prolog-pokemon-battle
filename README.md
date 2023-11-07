# Pokemon Battle Simulator using Prolog and Python

This is a project for the Computational lingustics course which tries to simulate a Pokemon Battle with a more "lingustic" perspective.
There is a few changes we did to the original game that makes the game more interesting with this perspective:

- **"Free sentence"-like commands**. As a trainer, you can freely tell the Pokemon what to do, without the need to show action options.
- **Avoid and defend actions**. Trainers can tell the pokemon to try to defend from the foe pokemon's attack or try to dodge it. However, the more dodge is used, the more chance of missing.
- **Addition of power variable**. Attack power can be specified in your sentence using adverbs such as "strongly", "weakly", "powerfully"...
- **Addition of distance variable**. Pokemons can move forward or backward to get closer or further away from their enemy.
- The stronger the attack, the further it reaches and the more likely to break enemy defense. However, the more chance of missing.

## Usage

Just run ```prolog-pokemon-battle.py``` in your terminal.

## To-Do's

- Add installation requirements to readme
- Add architecture to readme
- Add normal attacks
- Add more defense breaking rules
- Add dodge chance decrement rule
- Add attack miss chance rule depending on power
- Add a graphical interface?
