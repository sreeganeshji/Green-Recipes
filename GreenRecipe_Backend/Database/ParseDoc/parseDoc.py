# CREATE TABLE recipe(
# id SERIAL NOT NULL,
# name VARCHAR(50) NOT NULL,
# ingredients TEXT[] NOT NULL,
# document VARCHAR(1000),
# process TEXT[] NOT NULL,
# contributor VARCHAR(50),
# origin VARCHAR(50),
# servings INT DEFAULT 1,
# equipment TEXT[],
# images TEXT[],
# added_date DATE,
# added_by VARCHAR(50),
# nutrition TEXT[],
# category VARCHAR(50),
# PRIMARY KEY(ID)
# );


class recipe:
    def __init__(self):
        self.id = 0
        self.name = None
        self.ingredients = []
        self.document = None
        self.process = []
        self.contributor = None
        self.origin = None
        self.servings = 1
        self.equipment = []
        self.category = 'Desserts'

import sys


f = open(sys.argv[1],"r")

keywords = {"Origin:", "Ingredients:", "Servings (number or # of people):", "Process:", "Equipment:", "Contributor:"}

pointKey = "*"

# import re
def emptyLine(line):
    N = len(line)
    i = 0
    while(i<N and (line[i]==" " or line[i]=="\n")):
        i += 1
    return i==N

def getLine():
    line = f.readline()
    if line == '\n':
        return getLine()

    # pattern = re.compile('-*')
    # if pattern.match(line):
    #     continue

    if line == '––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n':
        return getLine()
    if line == '–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\n':
        return getLine()
    if emptyLine(line):
        return getLine()

    N = len(line)
    if N > 4:
        val = line[:4]
        if (val=="Adul") or (val=="Kids") or (val=="Comm") or (val == "Nutr"):
            return getLine()

    return line

def getAfter(key, line):
    if not line:
        return
    # print('line',line,'key',key)
    Nkey = len(key)
    N = len(line)
    #check if key is valid
    if N <= Nkey:
        return
    if key != line[:Nkey]:
        # print("Mismatch","key",key, "line", line,"given",line[:Nkey])
        # print(key, "equal", line[:Nkey], "?",key == line[:Nkey])
        return

    #find the last valid letter
    i,j = Nkey,N-1 #
    # print("getAfter", line)
    while((line[j]==" " or line[j]=="\n") and j>=Nkey):
        # print(line, "printing" ,line[j])
        # print("line[",j,"]",line[j])
        j -= 1

    #remove blanks inthe front
    while(i<j and line[i]==" "):
        i += 1

    # print("i", i, "j", j, "N", N, "Nkey", Nkey)
    # print("line[34]",line[34]) if (N>34) else print("")
    # print("Returning",line[i:j+1])
    return line[i:j+1]

recipe = recipe()

def getSQL(recipe):
    sql = ''
    if recipe.contributor:
        sql = "INSERT INTO recipe(name, origin,servings, ingredients, process, equipment, contributor, category) VALUES('%s', '%s', %d, ARRAY %s, ARRAY %s, ARRAY %s, '%s', '%s');"%(recipe.name,recipe.origin, recipe.servings,recipe.ingredients, recipe.process, recipe.equipment,recipe.contributor, recipe.category)
    else:
        sql = "INSERT INTO recipe(name, origin,servings, ingredients, process, equipment, category) VALUES('%s', '%s', %d,  ARRAY %s, ARRAY %s, ARRAY %s, '%s');"%(recipe.name,recipe.origin, recipe.servings,recipe.ingredients, recipe.process, recipe.equipment, recipe.category)

    print(sql)
    print("")

while(True):
    recipe.__init__()
    #name
    recipe.name = getAfter("",getLine())

    #Origin
    recipe.origin = getAfter("Origin: ",getLine())

    #Ingredients
    ingredients = getAfter("Ingredients: ",getLine())
    #if ingredients are inline
    line = ""
    if ingredients:
        ingredients = ingredients.split(", ")
        for ingredient in ingredients:
            recipe.ingredients.append(ingredient)
        line = getLine()
    else:
        ingredient = getAfter(pointKey,getLine())
        while(ingredient):
            recipe.ingredients.append(ingredient)
            line = getLine()
            ingredient = getAfter(pointKey,line)

    #servings
    servings = getAfter("Servings (number or # of people): ",line)
    recipe.servings = int(servings) if (servings and servings!="") else 1

    #process
    steps = getAfter("Process: ", getLine())
    # print("Steps",steps)
    if steps:
        #inline
        steps = steps.split(", ")
        for step in steps:
            recipe.process.append(step)
        line = getLine()
    else:
        step = getAfter(pointKey, getLine())
        while(step):
            recipe.process.append(step)
            line = getLine()
            step = getAfter(pointKey,line)

    #equipment
    equipments = getAfter("Equipment: ", line)
    equipments = equipments.split(', ')
    for equipment in equipments:
        recipe.equipment.append(equipment)

    #contributor
    recipe.contributor = getAfter("Contributor: ", getLine())

    getSQL(recipe)

# Testing getLine()
# line = getLine()
# i = 0
# while(line):
#     i += 1
#     print(i, line)
#     line = getLine()

f.close()

