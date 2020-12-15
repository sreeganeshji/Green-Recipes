
-- INSERT INTO recipe(1.name, 2.description, 3.ingredients, 4.process, 5.contributor, 6.origin, 7.servings,
-- 8.equipment, 9.images, added_date, added_by, nutrition, category)
--                    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);

INSERT INTO recipe(name, ingredients, process, origin, servings, equipment
        , category)
VALUES ('Salsa', '{"4 tomato","1/4 white onion","2 cloves of garlic"}', '{"Chop everything", "Add lemon juice"}', 'Mexican', '2', '{"Knife","Cutting board"}', 'Snacks');

INSERT INTO recipe(name, ingredients, process, origin, servings, equipment
                  , category)
VALUES ('Avacado Salsa', '{"3 avacados"}', '{"Cut avacados into small pieces", "Mix in with the salsa"}', 'Mexican', '1', '{"Knife","Cutting board"}', 'Snacks');

INSERT INTO recipe(name, ingredients, process, origin, servings, equipment
                  , category)
VALUES ('Mango Salsa', '{"Avacado Salsa","1 mango"}', '{"Cut mango in small pieces", "mix in with avacado salsa"}', 'Mexican', '1', '{"Knife","Cutting board"}', 'Snacks');



-- INSERT INTO recipe(name, description, ingredients, process, contributor, origin, servings, equipment, images,
--                    added_date, added_by, nutrition, category)
-- VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);
--
-- INSERT INTO recipe(name, description, ingredients, process, contributor, origin, servings, equipment, images,
--                    added_date, added_by, nutrition, category)
-- VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);
--
-- INSERT INTO recipe(name, description, ingredients, process, contributor, origin, servings, equipment, images,
--                    added_date, added_by, nutrition, category)
-- VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);
--
-- INSERT INTO recipe(name, description, ingredients, process, contributor, origin, servings, equipment, images,
--                    added_date, added_by, nutrition, category)
-- VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);
