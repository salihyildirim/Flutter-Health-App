import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:womenhealth/Model/User_Diet.dart';
import 'package:womenhealth/Model/user.dart';
import 'package:womenhealth/Service/FirestoreService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:womenhealth/Utils/data/local_food_database.dart';

class FoodViewModel with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService('userdiet');
  LocalFood localFood = LocalFood();
  final nutritionApiKey = "fU9y72p/j2sGb2Tdw0j6/g==E0H80ltgZ4HNggFB";

  List<String> foods = [
    "milk",
    "buttermilk",
    "kefir",
    "goat milk",
    "soy milk",
    "almond milk",
    "rice milk",
    "coconut milk",
    "yogurt",
    " chipotle sauce",
    "dill sauce",
    "onion sauce",
    "ranch sauce",
    "spinach sauce",
    "zatziki sauce",
    "vegetable sauce",
    "yogurt parfait",
    "frozen yogurt",
    "frozen yogurt sandwich",
    "frozen yoghurt bar",
    "frozen yoghurt cone",
    "chocolate milk",
    "hot chocolate / cocoa",
    "strawberry milk",
    "eggnog",
    "milk shake",
    "licuado",
    "fruity smoothie",
    "fruity smoothie juice drink",
    "chocolate milk drink",
    "baby food",
    "whey",
    "cocoa powder",
    "chocolate drink powder",
    "strawberry drink powder",
    "coffee cream",
    "whipped topping",
    "sour cream",
    "dip",
    "ice cream",
    "gelato",
    "ice cream bar",
    "ice cream bar",
    "ice cream sandwich",
    "ice cream cookie sandwich",
    "ice cream cone",
    "ice cream soda ",
    "ice cream sundae",
    "banana split",
    "light ice cream",
    "light ice cream sandwich",
    "light ice cream stick",
    "cream",
    "light ice cream cone",
    "pudding",
    "rice pudding",
    "custard",
    "creme brulee",
    "firni",
    "banana pudding",
    "mousse",
    "milk dessert",
    "tiramisu",
    " custard pudding",
    "white sauce",
    "cheese",
    "queso anejo",
    "queso asadero",
    "queso fresco",
    "queso cotija",
    "cottage cheese",
    "puerto rican feta cheese",
    "cheese spread",
    "cream cheese",
    "cheese spread",
    "cream cheese paste",
    "imitation cheese",
    "cheese ball",
    "artichoke sauce",
    "spinach",
    "seafood sauce",
    "cheese sauce",
    "cheese pizza topping",
    "vegetable pizza topping",
    "meat pizza topping",
    "meat topping",
    "cheese fondue",
    "cheese soufflé",
    "welsh rarebit",
    "cheese sandwich",
    "grilled cheese sandwich",
    "cheese sauce",
    "alfredo sauce",
    "mozzarella sticks",
    "mozzarella cheese",
    "cheddar cheese soup",
    "beer cheese soup",
    "meat",
    "meat sticks",
    "minced meat",
    "beef",
    "steak",
    "beef steak",
    "corned beef",
    "beef brisket",
    "ground beef",
    "ground beef",
    "beef jerky",
    "pork",
    "pork jerky",
    "pork chop",
    "pork steak",
    "ham",
    "pork roast",
    "roast pork pieces",
    "pork roll",
    "canadian bacon",
    "bacon",
    "salt pork",
    "pork ears",
    "pork skin shells",
    "pork skin",
    "meat stick",
    "lamb",
    "lamb chop",
    "lamb knees",
    "goat",
    "goat head",
    "goat ribs",
    "veal",
    "veal cutlet",
    "fake chicken leg",
    "beef patties",
    "rabbit",
    "venison sausage",
    "venison chop",
    "deer",
    "bison",
    "opossum",
    "ostrich",
    "chicken",
    "chicken breast",
    "chicken legs",
    "chicken drumstick",
    "chicken legs",
    "chicken wings",
    "chicken skin",
    "chicken feet",
    "chicken patties",
    "chicken fillet",
    "chicken wings",
    "chicken tenders",
    "fried chicken pieces",
    "turkey",
    " turkey light",
    "turkey bacon",
    "duck",
    "goose",
    "cornish game hen",
    "quail",
    "pheasant",
    "chicken stick",
    "turkey stick",
    "beef liver",
    "chicken liver",
    "liver pate",
    "sweet rolls",
    "tongue roast",
    "tripe",
    "chitterlings",
    "pork maw",
    " gizzard",
    "frankfurter",
    "beef sausage",
    "blood sausage",
    "bratwurst",
    "bologna",
    "chorizo",
    "head cheese",
    "knockwurst",
    "mortadella",
    "bacon",
    "pepperoni",
    "polish sausage",
    "italian sausage",
    "sausage",
    "pork sausage",
    "pork sausage rice links",
    "vienna sausage",
    " lunch meat",
    "lunch meat with ham",
    "liver sausage",
    "turkey ham",
    "meat paste",
    "chicken salad paste",
    "ham salad paste",
    "fish",
    "fish stick",
    "anchovy",
    "carp",
    "catfish",
    "cod",
    "eel",
    "haddock",
    "halibut",
    "herring",
    "mackerel",
    "ocean perch",
    "pike",
    "pork",
    "salmon",
    "sardine",
    "sea bass",
    "swordfish",
    "trout",
    "tuna",
    "whiting",
    "tilapia",
    "frog legs",
    "octopus",
    "roe",
    "squid",
    "turtle",
    "crab",
    "crawfish",
    "lobster",
    "mussels",
    "oysters",
    "scallops",
    "shrimps",
    "snails",
    "beef claret",
    "beef stew",
    "chili con carne",
    "chili con carne without beans",
    "beef sloppy joe",
    "salisbury steak",
    "beef stroganoff",
    "swedish meatballs",
    "steak teriyaki",
    "beef curry",
    " boiled seasoned minced meat",
    "steak tartare",
    "boiled dried beef",
    "stuffed roast",
    "ham stroganoff",
    "sausage sauce",
    "pork stew",
    "frankfurters",
    "boiled pork",
    "boiled goat",
    "veal scallops",
    "veal marsala",
    "veal parmigiana",
    "veal cordon bleu",
    "venison",
    "spaghetti sauce",
    "boiled chicken",
    "curry chicken",
    "orange chicken",
    "sesame chicken",
    "chicken kiev",
    "stuffed chicken",
    "crab empire",
    "fish timbale",
    "lobster newburg",
    "shrimp cocktail",
    "seafood newburg",
    "seafood sauce",
    "fish sauce",
    "shrimp scampi",
    "fish moochim",
    "fish curry",
    "shrimp teriyaki",
    "ceviche",
    "tomato based crabs in sauce",
    "prawns in garlic sauce",
    "boiled cod",
    "corned beef hash browns",
    "biryani",
    "made into meatballs",
    "beef wellington",
    "corned beef patties",
    "boiled corned beef",
    "ham croquettes",
    "boiled pork feet",
    "stuffed pork roast",
    "cod ball",
    "crab cake",
    "fish cake",
    "gefilte fish ",
    "salmon cake",
    "salmon loaf",
    "tuna loaf",
    "tuna cake",
    "oyster cake",
    "oyster spring rolls",
    "oyster casino",
    "mackerel cake",
    "widd fish cake",
    "shrimp cakes",
    "shrimp toast",
    "seafood reconstructed",
    "seafood soufflé",
    "tuna noodle casserole",
    "poached salmon",
    "viennese sausages boiled",
    "liver dumpling",
    "shepherd's pastry",
    "beef pastry",
    "stuffed cabbage",
    "stuffed grape leaves",
    "beef pastry",
    "stuffed green peppers",
    "ham pastry",
    " pork fricassee",
    "beef fricassee",
    "beef stew",
    "rabbit stew",
    "boiled rabbit",
    "chicken fricassee",
    "paella",
    "seafood stew",
    "shrimp chow mein",
    "shrimp creole",
    "tuna fritter",
    "bouillabaisse",
    "oyster pie",
    "biscayne cod",
    "casserole",
    "goulash",
    "meat pie",
    "chow mein",
    "brunswick casserole",
    "boiled various meats",
    "boiled tripe",
    "jambalaya",
    "beef shish kebab",
    "swiss steak",
    "beef rolls",
    "sichuan beef",
    "hunan beef",
    "kung pao beef",
    "pepper steak",
    "beef salad",
    "seasoned shredded soup meat",
    "cabbage",
    "greens",
    "kung pao pork",
    "moo shu pork",
    "pork hash",
    "pork shish kebab",
    "pork chop boiled",
    "beef goulash",
    "lamb shish kebab",
    "kebab",
    "general tso chicken",
    "kung pao chicken",
    "almond chicken",
    "asian chicken",
    "lobster salad",
    "salmon salad",
    "tuna salad",
    "shrimp salad",
    "seafood salad",
    "crab salad",
    "garden salad",
    "oyster rockefeller",
    "lomi salmon",
    "shrimp shish kebab",
    "kung pao shrimp",
    "tuna casserole",
    "fish shish kebab",
    "fried fish",
    "octopus salad",
    "cod",
    "lau lau",
    "julienne salad",
    "liver",
    "boiled chitterlings",
    "boiled gizzards",
    "sandwich",
    "beef sandwich",
    "wrap sandwich",
    "beef sandwich",
    "beef barbecue submarine sandwich",
    "cheeseburger slider",
    "cheeseburger",
    "cheeseburger submarine sandwich",
    "double cheeseburger",
    "hamburger slider",
    "hamburger",
    "double hamburger",
    "meatball",
    "chiliburger",
    "corned beef sandwich",
    "reuben sandwich",
    "bacon sandwich",
    "roast beef sandwich",
    "roast beef submarine sandwich",
    "steak submarine sandwich",
    "steak sandwich",
    "fajita style beef sandwich",
    " gyro sandwich",
    "hamburger wrap sandwich",
    "bacon on a biscuit",
    "ham on a biscuit",
    "ham sandwich",
    "ham salad sandwich",
    "hot ham",
    "cuban sandwich",
    "night half sandwich",
    "pork sandwich",
    "pork barbecue sandwich",
    "chicken salad",
    "chicken barbecue sandwich",
    "chicken fillet sandwich",
    "chicken fillet biscuit",
    "chicken fillet wrap sandwich",
    "chicken sub sandwich",
    "buffalo chicken sub sandwich",
    "turkey sandwich",
    "turkey salad",
    "turkey sub sandwich",
    "fish sandwich",
    "crab cake sandwich",
    "salmon cake sandwich",
    "salmon fried produce sandwich",
    "fish roll sandwich",
    "sardine sandwich",
    "tuna salad sandwich",
    "seafood salad sandwich",
    "lunch meat sandwich",
    "bologna sandwich",
    "corn dog",
    "pig in a blanket",
    "puerto rican sandwich",
    "hami sandwich",
    "sausage on a biscuit",
    "hot dog grilled cake sandwich",
    "sausage balls",
    "hot dog",
    "cold cut",
    "chicken noodle dish",
    "chicken stew",
    "chicken soup",
    "frozen dinner",
    "beef dinner",
    "sirloin",
    "salisbury steak dinner",
    "beef short ribs",
    "chicken dish",
    "teriyaki chicken",
    "chicken with cream sauce",
    "chicken with butter sauce",
    "chicken with mushroom sauce",
    "chicken with soy-based sauce",
    "turkey dish",
    "fish with lemon butter sauce",
    "beef loaf dish",
    "oxtail soup",
    "meatball soup",
    "beef noodle soup",
    "pho",
    "pepperpot soup",
    "menudo soup",
    "beef vegetable soup",
    "italian wedding soup",
    "beef stroganoff soup",
    "pork vegetable soup",
    "bacon soup",
    "mexican chicken stock soup broth",
    "chicken rice soup",
    "bird's nest soup",
    "fish broth",
    "crab soup",
    "oyster soup",
    "fish soup",
    "cod fish soup",
    "lobster bisque ",
    "lobster gumbo",
    "oyster stew",
    "salmon soup",
    "shrimp soup",
    "shrimp gumbo",
    "seafood soup",
    "broth",
    "spanish vegetable soup",
    "oysters sauce",
    "mole sauce",
    "egg",
    "duck egg",
    "goose egg",
    "quail egg",
    "egg salad",
    "huevos rancheros",
    "egg casserole",
    "egg foo yung",
    "chicken egg foo yung",
    "pork egg foo yung",
    "shrimp egg foo yung",
    "beef egg foo yung",
    "ripe banana omelette",
    "scrambled egg",
    "egg a la malaguena",
    "egg omelette",
    "egg salad sandwich",
    "scrambled egg sandwich",
    "egg drop soup",
    "garlic egg soup",
    "egg white omelette",
    "egg white",
    "meringue",
    "egg replacer",
    "white beans",
    "black beans",
    "broad beans",
    "lima beans",
    "pink beans",
    "pinto beans",
    "peruvian beans",
    "soybeans",
    "mung beans",
    "dried beans",
    "dried beans from fast food / restaurant",
    "black bean salad",
    "fried beans",
    "bean sauce",
    "layered sauce",
    "hummus",
    "black bean sauce",
    "falafel",
    "bean cake",
    "black-eyed peas",
    "chickpeas",
    "wasabi peas",
    "lentils",
    "bean chips",
    "papad",
    "sambar",
    "lentils curry",
    "soy nuts",
    "soy chips",
    "tofu",
    "miso sauce",
    "miso",
    "natto",
    "hoisin sauce",
    "soy sauce",
    "teriyaki sauce",
    "worcestershire sauce",
    "textured vegetable protein",
    "frozen dessert",
    "bean soup",
    "beans",
    "black bean soup",
    "lima bean soup",
    "soy soup",
    "pinto bean soup",
    "liquid from boiled kidney beans",
    "garbanzo beans",
    "peas",
    "lentil soup",
    "bacon strip",
    "bacon pieces",
    "vegetarian burger",
    "sandwich spread",
    "vegetarian pot pie",
    "vegetarian chili",
    "tofu",
    "vegetarian casserole",
    "vegetarian stroganoff",
    "soy burger",
    "hazelnut",
    "almonds",
    "brazil nuts",
    "cashews",
    "chestnuts",
    "coconuts",
    "macadamia nuts",
    "mixed nuts",
    "peanuts",
    "pine nuts",
    "pistachios",
    "walnuts",
    "almond butter",
    "cashew butter",
    "peanut butter",
    "soy nut butter",
    "peanut sauce",
    "peanut butter sandwich",
    "coconut cream",
    "coconut water",
    "pumpkin seeds",
    "sunflower seeds",
    "tahini",
    "flax seeds",
    "chia seeds",
    "carob chips ",
    "roll",
    "focaccia",
    "naan",
    "garlic bread",
    "bruschetta",
    "pan dulce",
    "coffee cake",
    "croissant",
    "pastry",
    "bagel",
    " stuffed bread",
    "breadsticks",
    "croutons",
    "muffin",
    "melba toast",
    "anisette toast",
    "pannetone",
    "zwieback toast",
    "biscuit",
    "crumpet",
    "muffin",
    "cornbread",
    "cornbread stuffing",
    "cornbread muffin",
    "cornmeal patties",
    "corn pone",
    "hush puppy ",
    "johnnycake",
    "spoon bread",
    "tortilla",
    "taco shell",
    "arepa dominicana",
    "popover",
    "cake batter",
    "cake",
    "cheesecake",
    "snack cake",
    "ice cream cake ",
    "rum cake",
    "cookie",
    "cookie bar",
    "pocky",
    "marie biscuit",
    "mixed berry tart filling",
    "sweet pizza",
    "pie crust",
    "vanilla wafer dessert base",
    "blintz",
    "cobbler",
    "fritter",
    "cream puff",
    "wheat flour pastry",
    "crepe",
    "tamale ",
    "pie",
    "baklava",
    "basbousa",
    "turnover",
    "cheese pastry puffs",
    "empanada",
    "breakfast pastry",
    "danish pastry",
    "doughnut",
    "donut holes",
    "churros",
    "breakfast tart",
    "cereal",
    "snack bar",
    "breakfast bar",
    "nutrition bar",
    "cereal bar",
    "crackers",
    "graham crackers",
    "chips",
    "rice cake",
    "popcorn cake",
    "rice paper",
    "corn nuts",
    "corn chips",
    " cheese flavored corn snacks",
    "tortilla chips",
    "snack mix",
    "potato chips",
    "pita chips",
    "popcorn",
    "popcorn chips",
    "onion flavor rings",
    "shrimp chips",
    "pretzel",
    "pretzel chips",
    "multigrain chips",
    "bagel chips",
    "cracker chips",
    "waffles",
    "french toast",
    "french toast sticks",
    "chinese pancake",
    "cake making",
    "dosa",
    "funnel cake",
    "pasta",
    "long rice noodles",
    "rice noodles",
    "barley",
    "buckwheat groats",
    "semolina",
    "corn flour porridge",
    "corn flour",
    "corn flour dumpling",
    "masa harina",
    "millet",
    "oatmeal",
    "quinoa",
    "rice",
    "congee",
    "yellow rice",
    "cream of wheat",
    "wheat",
    "bulgur",
    "couscous",
    "whole wheat flakes",
    "wheat flakes",
    "oat bran flakes",
    "cream of rye",
    "granola",
    "wheat germ",
    "wheat bran",
    "oats",
    "oat bran",
    "barley flakes",
    "oatmeal cereal",
    "rice flakes",
    "brown rice flakes",
    "gerber alumni finger snack cereal",
    "burrito",
    "chilaquiles",
    "enchilada",
    "taco",
    "soft taco",
    "mexican casserole",
    "tamale casserole",
    "nachos",
    "gordita",
    "chimichanga",
    "quesadilla",
    "taquito",
    "fajita",
    "pupusa",
    "pizza",
    "white pizza",
    "calzone",
    "pizza rolls",
    "breakfast pizza",
    "egg roll",
    "wonton",
    "tamal on a sheet",
    "meat turnover",
    "cheese turnover",
    "cornmeal roll",
    "codfish roll",
    "hayacas",
    "cornflour coconut dessert",
    "gnocchi",
    "knish",
    "sweet bread dough",
    "spanakopitta",
    "quiche",
    "spinach quiche",
    "cheese quiche",
    "turnover filling",
    "vegetables in pastries",
    "vegetables",
    "croissant sandwich",
    "vegetable submarine sandwich",
    "chicken cornbread",
    "cornmeal sauce",
    "sauce",
    "lasagna",
    "ravioli",
    "manicotti",
    "stuffed shells",
    "tortellini",
    "cannelloni",
    "chow fun noodles",
    "lo mein",
    "pad thai",
    "spaghetti",
    "flavored pasta",
    "noodle pudding",
    "bibimbap",
    " sushi",
    "sushi roll",
    "sushi roll tuna",
    "seafood paella",
    "soup rice",
    "soup rice mixture",
    "rice flour dumpling",
    "boiled rice",
    "fried rice",
    "raisins stuffed leaves",
    "rice croquette",
    "stuffed peppers",
    "stuffed tomatoes",
    "rice pilaf",
    "dirty rice",
    "flavored rice mix",
    "flavored rice",
    "spanish rice",
    "rice sauce",
    "rice dessert",
    "upma",
    "vada",
    "tabbouleh",
    "jelly sandwich",
    "vegetable lasagna",
    "pumpkin lasagna",
    "linguini",
    "beef enchilada dish",
    "beef enchilada",
    "cheese enchilada",
    "soup",
    "noodle soup",
    "rice soup",
    "barley soup",
    "beef dumpling soup",
    "beef rice soup",
    "noodles",
    "matzo ball soup",
    "instant soup",
    " wonton soup",
    "sopa seca",
    "sopa seca de fideo",
    "sopa de fideo aguada",
    "sopa seca de arroz",
    "sopa de tortilla",
    "meat substitute",
    "clementine",
    "grapefruit",
    " kumquat",
    "lemon",
    "lemon pie filling",
    "lime",
    "orange",
    "tangerine",
    "grapefruit juice",
    "lemon juice",
    "orange juice",
    "tangerine juice",
    "juice mix ",
    "fruit mix",
    "apricot",
    "blueberry",
    "cherry",
    "currants",
    "cranberry",
    "date",
    "fig",
    "mango",
    "papaya",
    "peach",
    "pear",
    "persimmon",
    "pineapple",
    "raisins",
    "fruit",
    "applesauce",
    "apple pie filling",
    "avocado",
    "melon",
    "star fruit",
    "cassaba melon",
    "scherry pie filling",
    "grape",
    "guava",
    "kiwi fruit",
    "lychee",
    "honeydew melon",
    "nectarine",
    "pomegranate",
    "rhubarb",
    "watermelon",
    "strawberry",
    "blackberry",
    "blueberry filling",
    "cranberry sauce",
    "raspberry",
    "fruit salad",
    "fruit cocktail",
    "apple salad",
    "lime soufflé",
    "guacamole",
    "chutney",
    "pineapple salad",
    "frozen juice bar",
    "sorbet ",
    "juice",
    "cranberry juice blend",
    "cider",
    "apple juice",
    "blackberry juice",
    "blueberry juice",
    "cranberry juice",
    "grape juice",
    "papaya juice",
    " passion fruit juice",
    "pineapple juice",
    "pomegranate juice",
    "prune juice",
    "strawberry juice",
    "watermelon juice",
    "fruit nectar",
    "apricot nectar",
    "banana nectar",
    "melon nectar",
    "guava nectar",
    "mango nectar",
    "peach nectar",
    "papaya nectar",
    "passion fruit",
    "pear nectar",
    "cinnamon apple",
    "vinegar",
    "fruit bar",
    "tropical fruit mix ",
    "apple",
    "prune",
    "mixed fruit juice",
    "pear juice",
    "banana juice",
    "plum",
    "fruit dessert",
    "mixed fruit",
    "cherry cobbler",
    "peach cobbler",
    "vanilla pudding",
    "potatoes",
    "boiled potatoes",
    "potato sticks",
    " vegetable chips",
    "potato skins",
    "potato patties",
    "potato tots",
    "potato salad",
    "potato pancakes",
    "lefse",
    "potato soup",
    "banana soup",
    "banana",
    "ripe banana",
    "banana chips",
    "cassava",
    "yuca fries",
    "yam",
    "celery",
    "taro",
    "poi",
    "taro chips",
    "beet greens",
    "broccoli raab",
    "chard",
    "dandelion greens",
    "lettuce",
    "caesar salad",
    "escarole",
    "lamb quarter",
    "mustard sprouts",
    "mustard greens",
    "poke greens",
    "radicchio",
    "spinach soufflé ",
    "palak paneer",
    "channa saag",
    "taro leaves",
    "turnip greens",
    "turrnip greens",
    "watercress",
    "bitter melon",
    "sweet potato",
    "broccoli",
    "broccoli casserole",
    "roast broccoli",
    "broccoli soup",
    "broccoli cheese soup",
    "watercress broth",
    "spinach soup",
    "carrot",
    " beetroot juice",
    "carrot juice",
    "pumpkin",
    "winter squash",
    "pumpkin pie",
    "sweet potato fries",
    "sweet potato chips",
    "sweet potatoes tots",
    "carrot soup",
    "tomato",
    "green tomatoes",
    "sun dried tomatoes",
    "tomato juice",
    "tomato juice cocktail",
    "ketchup",
    "tomato chili sauce",
    "salsa",
    "taco sauce",
    "enchilada sauce",
    "salsa verde",
    "hot thai sauce",
    "vodka sauce",
    "bbq sauce",
    "buffalo sauce",
    "steak sauce",
    "cocktail sauce",
    "tomato aspic",
    "tomato soup",
    "tomato sandwich",
    "raw vegetables",
    "sprout",
    "alfalfa sprouts",
    "artichoke",
    "asparagus",
    "bean sprouts",
    "green beans",
    "beets",
    "brussels sprouts",
    "cactus",
    "cauliflower",
    "fennel bulb",
    "basil",
    "chives",
    "coriander",
    "corn",
    "cucumber",
    "eggplant",
    "garlic",
    "jicama",
    "kohlrabi",
    "leek",
    "mixed salad greens",
    "mushroom",
    "onion",
    "parsley",
    "green peas",
    "turnip",
    "seaweed",
    "snow peas",
    "summer squash",
    "mixed vegetable broth",
    "celery juice",
    "broccoli salad",
    "broccoli coleslaw",
    "coleslaw",
    "cucumber salad",
    "cucumber salad made",
    "seven-layer salad",
    "greek salad",
    "spinach salad",
    "cobb salad",
    "aloe vera juice drink",
    "bamboo sprouts",
    "fried green beans",
    "yellow string beans",
    "breadfruit",
    "hominy",
    "lotus root",
    "okra",
    " luffa",
    "hearts of palm",
    "parsnip",
    "peppers",
    "hot peppers",
    "pimiento",
    "daikon radish",
    "sauerkraut",
    "snow peas",
    "spaghetti squash",
    "water chesnut",
    "winter melon",
    "yeast",
    "yeast extract spread",
    "bean salad",
    "classic mixed vegetables",
    "ratatouille",
    "vegetable mix",
    "green bean casserole",
    "fried cauliflower",
    "chiles rellenos",
    "stuffed jalapeno peppers",
    "corn fritters",
    "fried eggplant",
    "eggplant sauce",
    "eggplant parmesan",
    "fried mushrooms",
    " fried okra",
    "fried onion rings",
    "pea salad",
    "fried summer squash",
    "vegetable tempura",
    "pakora",
    "vegetable curry",
    "kimchi",
    "pickle",
    "ginger root",
    "horseradish",
    "mustard",
    "olive",
    "olive tapenade",
    "hot pepper sauce",
    "radish",
    "wasabi paste ",
    "asparagus soup",
    "beetroot soup",
    "cabbage soup",
    "celery soup",
    "corn soup",
    "gazpacho",
    "leek soup",
    "mushroom soup",
    "onion soup",
    "pea soup",
    "vegetable soup",
    "pumpkin soup",
    "chav soup",
    "seaweed soup",
    "vegetable noodle soup",
    "vegetable noodle soup",
    "vegetable rice soup",
    "vegetarian vegetable soup",
    "vegetable broth",
    "mixed vegetables",
    "vegetables",
    "stuffed fried potatoes",
    " chicken fritters with potatoes",
    "green bananas",
    "ripe banana fritters",
    "cassava pastels",
    "stuffed cassava fritters",
    "stuffed plate fritters",
    "puerto rican pastels",
    "spanish stew",
    " puerto rican stew",
    "herbal smoothie",
    "table butter",
    "butter",
    "margarine",
    "butter substitute",
    "oil",
    "pork fat",
    "ghee",
    "garlic sauce",
    "lemon butter sauce",
    "hollandaise sauce",
    "tartar sauce",
    "horseradish sauce",
    "pesto sauce",
    "frying sauce",
    "curry sauce",
    "honey oil",
    "vegetable oil",
    "almond oil",
    "coconut oil",
    "corn oil",
    "cottonseed oil",
    "linseed oil",
    "olive oil",
    "peanut oil",
    "canola oil",
    "safflower oil",
    "sesame oil",
    "soybean oil",
    "sunflower oil",
    "walnut oil",
    "wheat germ oil",
    "salad dressing",
    "caesar dressing",
    "cole salad dressing",
    "honey mustard dressing",
    "italian dressing",
    "mayonnaise",
    "vegan mayonnaise",
    "russian dressing",
    "avocado dressing",
    "cream dressing",
    "poppyseed seed sauce",
    "sesame sauce",
    "yogurt sauce",
    "korean sauce",
    "cream sauce",
    "soy-based sauce",
    "tomato sauce",
    "sugar",
    "sugar substitute",
    "syrup",
    "prepe syrup",
    "corn syrup",
    "blueberry syrup",
    "chocolate syrup",
    "simple syrup",
    "strawberry drink syrup",
    "honey",
    "agave liquid sweetener",
    "molasses",
    "caramel sauce",
    "chocolate sauce",
    "dessert dip",
    "sweet sauce",
    "duck sauce",
    "jelly",
    "jam",
    "fruit butter",
    "marmalade",
    "guava paste",
    "sweet potato paste",
    "bean paste",
    "gelatin dessert",
    "gelatin salad",
    "coconut cream cake",
    "italian ice",
    "popsicle",
    "freezer pop",
    "snow cone",
    "caramel bites",
    "caramel",
    "caramel candy",
    "rolo",
    "toblerone",
    "twix",
    "espresso coffee beans",
    "milk chocolate",
    "kit kat",
    "chocolate",
    "chocolate candy",
    "mexican chocolate",
    "coconut sugar",
    "fondant",
    "fruit peel",
    "date sugar",
    "soft fruit candies",
    "fruit leather",
    "tamarind",
    "fruit snack candy",
    "gummies",
    "fudge",
    "snickers bar",
    "baby ruth",
    "100 grand bar",
    "halva ",
    "honey combed hard candy",
    "butterfinger",
    "butterfinger crisp",
    "chocolate flavored sprinkles",
    "dark chocolate",
    "ladoo",
    "licorice",
    "marshmallow",
    "milky way bar",
    "milky way midnight bar",
    "mars almond bar",
    "3 musketeers bar",
    "3 musketeers truffle crisp bar",
    "hazelnut roll",
    "candied pecans",
    "planters peanut bar",
    "peanut brittle",
    "peanut bar",
    "peanut butter bites",
    "pralines",
    "pineapple candy",
    "sesame crunch",
    "hard candy",
    "butterscotch hard candy",
    "skittles",
    "easter egg",
    "toffee",
    "truffle",
    "wax candy ",
    "gum",
    "coffee",
    "frozen coffee drink",
    "frozen mocha coffee drink",
    "iced coffee",
    "coffee substitute",
    "chicory drink",
    "cereal drink",
    "tea",
    "corn drink",
    "iced tea",
    "soft drink",
    "soda water",
    "tamarind drink",
    "fruit punch",
    "lemonade",
    "fruit flavored drink",
    "juice drink",
    "frozen daiquiri mix",
    "pina colada",
    "margarita mix",
    "cranberry juice drink",
    "grape juice drink",
    "orange juice drink",
    "apple juice drink",
    "pomegranate juice drink",
    "horchata drink",
    "oatmeal drink",
    "cane sugar drink",
    "wine",
    "non-alcoholic malt drink",
    "shirley temple",
    "sports drink ",
    "beer",
    "alcoholic malt beverage",
    "hard cider",
    "cocktail",
    "bacardi cocktail",
    "bloody mary",
    "canadian club",
    "cape cod",
    "daiquiri",
    "gelatin shot",
    "gimlet",
    "gin",
    "kamikaze",
    "manhattan",
    "margarita",
    "martini",
    "mimosa",
    "mint julep",
    "mojito",
    "old fashioned",
    "orange blossom",
    "rusty nail",
    "salt dog",
    "screwdriver",
    "tom collins",
    "whiskey sour",
    "whisky",
    "rum",
    "brandy",
    "vodka",
    "sloe gin fizz",
    "black russian",
    "white russian",
    "champagne punch",
    "mai tai",
    "tequila sunrise",
    "gin rickey",
    "irish coffee",
    "liqueur",
    "frozen daiquiri",
    "frozen margarita",
    "gin fizz",
    "wine cooler",
    "sangria",
    "scotch",
    "rum cooler",
    "tequila",
    "water",
    "energy drink",
    "fish fillet",
    "bread"
  ];

  Future<void> createDataWithCustomId(
      Map<String, dynamic> data, String documentId) async {
    await _firestoreService.createDataWithCustomId(documentId, data);
  }

  Future<void> createSubcollectionData(
      {required String documentId,
      String subcollectionName = "daily_calculations",
      required Map<String, dynamic> data}) async {
    _firestoreService.createSubcollectionData(
        documentId: documentId, data: data);
  }

  Future<List<Map<String, dynamic>>> readUserDietDaily(String documentId) async {
    return await _firestoreService.readDataFromSubcollection(documentId);
  }

  Future<void> updateUserDiet(
      String documentId, Map<String, dynamic> newData) async {
    await _firestoreService.updateData(documentId, newData);
  }

  Future<void> deleteUserDiet(String documentId) async {
    await _firestoreService.deleteData(documentId);
  }

  Future<String?> fetchNutritionBody(String foodName) async {
    String query = foodName.toLowerCase().tr().toString();
    String encodedQuery = Uri.encodeQueryComponent(query);

    var url = Uri.parse(
        "https://api.api-ninjas.com/v1/nutrition?query=$encodedQuery");

    var response = await http.get(
      url,
      headers: {
        'X-Api-Key': nutritionApiKey,
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  //getCaloriesFromFood
  Future<Map<String, dynamic>?> getNutritionFromFood(String foodName) async {
    var foodBody = await fetchNutritionBody(foodName);

    if (foodBody != null) {
      var jsonResponse = json.decode(foodBody);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        var firstItem = jsonResponse[0];
        if (firstItem is Map<String, dynamic>) {
          return firstItem; // İlk öğeyi Map<String, dynamic> olarak döndür
        }
      }
    }
    return null;
  }

  // Future<void> removeNullValues() async {
  //   List<String> foodsToRemove = [];
  //
  //   for (var food in foods) {
  //     var calories = await getCaloriesFromFood(food);
  //     if (calories == null) {
  //       foodsToRemove.add(food);
  //     }
  //   }
  //
  //   // Test etmek için konsola yazdırabiliriz
  //   print("Yanit Yok Listesi :");
  //   print(foodsToRemove);
  // }
  //fetchDailyCalculations
  Future<List<Map<String, dynamic>>?> fetchUserDiet(String documentId) async {
    List<Map<String, dynamic>> dailyCalculationsList =
        await readUserDietDaily(documentId);
    if (dailyCalculationsList.isNotEmpty) {
      return dailyCalculationsList;
    } else {
      return null;
    }
  }

  Future<UserDiet> addFirebaseUserDietCaloriesTaken(
      User user, String foodName, int gram) async {

    double? caloriesPer100Gram;

    Map<String, dynamic>? nutritionMap = await getNutritionFromFood(foodName);

    if (nutritionMap != null) {
      caloriesPer100Gram = nutritionMap['calories'];
    }

    List<Map<String, dynamic>>? dailyCalculations =
        await fetchUserDiet(user.eMail);
    DateTime today = DateTime.now();

    DateTime lastDocumentDate =
        DateTime.parse(dailyCalculations!.last['calculation_date']);

    if (caloriesPer100Gram != null) {
      double newCalories = (caloriesPer100Gram / 100) * gram;

      if (user.userDiet == null ||
          lastDocumentDate.year != today.year &&
              lastDocumentDate.month != today.month &&
              lastDocumentDate.day != today.day) {

        UserDiet userDiet = UserDiet(
          calories_taken: newCalories,
          calculation_date: DateTime.now(),
          carbohydrates_total_g: nutritionMap?['carbohydrates_total_g'],
          cholesterol_mg: nutritionMap?['cholesterol_mg'],
          fat_total_g: nutritionMap?['fat_total_g'],
          fiber_g: nutritionMap?['fiber_g'],
          potassium_mg: nutritionMap?['potassium_mg'],
          protein_g: nutritionMap?['protein_g'],
          sodium_mg: nutritionMap?['sodium_mg'],
          sugar_g: nutritionMap?['sugar_g'],
        );

        user.userDiet = userDiet;
        createSubcollectionData(
            documentId: user.eMail, data: user.userDiet!.toMap());
        //tam burada yeni oluşturduğumuz userdiet'i kaydet.
      } else {
        user.userDiet!.calories_taken =
            (user.userDiet!.calories_taken ?? 0) + newCalories;
        user.userDiet!.carbohydrates_total_g = nutritionMap?['carbohydrates_total_g'];
        user.userDiet!.cholesterol_mg = nutritionMap?['cholesterol_mg'];
        user.userDiet!.fat_total_g = nutritionMap?['fat_total_g'];
        user.userDiet!.fiber_g = nutritionMap?['fiber_g'];
        user.userDiet!.potassium_mg = nutritionMap?['potassium_mg'];
        user.userDiet!.protein_g = nutritionMap?['protein_g'];
        user.userDiet!.sodium_mg = nutritionMap?['sodium_mg'];
        user.userDiet!.sugar_g = nutritionMap?['sugar_g'];

        //user.userDiet 'i database'e kaydet.
        _firestoreService.updateSubCollectionData(newData: user.userDiet!.toMap(), documentId: user.eMail,);
      }
    }
    return user.userDiet!;
  }

  Future<List<String>> getAllTurkishFoods() async {
    List<String> foods = await localFood.turkceYemekler();
    return foods;
  }

  bool checkNameEquality(String response, String food) {
    var jsonResponse = json.decode(response);

    if (jsonResponse is Map<String, dynamic> &&
        jsonResponse.containsKey('name')) {
      var name = jsonResponse['name'];

      if (name is String) {
        return name.toLowerCase() != food.toLowerCase();
      }
    }

    return false;
  }
}
