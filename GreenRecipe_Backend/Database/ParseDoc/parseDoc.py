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
        self.equipment = None
        self.images = None
        self.added_date = 

f = open("./DharmaDiet Recipes.txt","r")

line = f.readline()
categories = {'snacks','soups','lunch/dinner','salads','deserts'}
maps = {'origin':'origin',}
while(line):
