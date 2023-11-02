from pyswip import Prolog
prolog = Prolog()
prolog.consult("hello_world/hello_world.pl")
results = list(prolog.query("father(michael,X)"))
for res in results:
    print(res['X'])