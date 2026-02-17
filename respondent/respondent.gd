class_name  Respondent
enum grades {
	A,
	B,
	C,
	D,
	E,
}

var is_male: bool
static var male_names: Array[String] = ["James", "Robert", "John", "Michael", "David", "William", "Richard", "Joseph", "Thomas", "Christopher", "Charles", "Daniel", "Matthew", "Anthony", "Mark", "Steven", "Donald", "Andrew", "Paul", "Joshua", "Kenneth", "Kevin", "Brian", "Timothy", "Ronald", "Jason", "George", "Edward", "Jeffrey", "Ryan", "Jacob", "Nicholas", "Gary", "Eric", "Jonathan", "Stephen", "Larry", "Justin", "Benjamin", "Scott", "Brandon", "Samuel", "Gregory", "Alexander", "Patrick", "Frank", "Jack", "Raymond", "Walter", "Tyler", "Danil", "Timofei", "Yaroslav", "Ivan", "Bogdan", "Gondon"]
static var female_name: Array[String] = ["Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Karen", "Sarah", "Lisa", "Nancy", "Sandra", "Ashley", "Emily", "Kimberly", "Betty", "Margaret", "Donna", "Michelle", "Carol", "Amanda", "Melissa", "Deborah", "Stephanie", "Rebecca", "Sharon", "Laura", "Cynthia", "Amy", "Kathleen", "Angela", "Dorothy", "Shirley", "Emma", "Brenda", "Nicole", "Pamela", "Samantha", "Anna", "Katherine", "Christine", "Debra", "Rachel", "Olivia", "Carolyn", "Maria", "Janet", "Heather", "Diane"]
static var second_names: Array[String] = ["Notch", "Trump", "Abortovich", "Baitman", "Afton", "Dragovich", "Debil", "Zalupovich", "Kolbosenko" ,"Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Wilson", "Anderson", "Taylor", "Thomas", "Moore", "Jackson", "Martin", "Lee", "White", "Harris", "Thompson", "Clark", "Lewis", "Robinson", "Walker", "Hall", "Allen", "Young", "King", "Wright", "Hill", "Scott", "Pinkman", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "White", "Edwards", "Gosling", "Stewart", "Sanchez"]

static var A_background: Array[String] = ["Lawyer", "Petty Bourgeoisie", "Programmer", "Engineer", "Medic", "Police officer"]
static var B_background: Array[String] = ["Factory worker", "Soldier", "Miner", "Farmer", "Scientist"]
static var C_background: Array[String] = ["Office worker", "Builder", "Seamstress", "Waiter", "Servant"]
static var D_background: Array[String] = ["Shoe shiner", "Homeless", "Unemployed", "Cleaner", "Newspaper delivery boy"]
static var E_background: Array[String] = ["Slave", "Socialist", "Murderer", "Scammer", "Prostitute"]

static var A_accusation: Array[String] = ["Bar fight", "Violated traffic rules", "Violated curfew", "Late in paying taxes", "Impolite behavior"]
static var B_accusation: Array[String] = ["Alcohol abuse", "Pickpocketing", "Sleeping outside", "Drug addict", "Disrespectful communication with the bourgeoisie"]
static var C_accusation: Array[String] = ["Spoke neutrally about socialism", "Alcoholism", "Took down the poster", "Petty theft", "An acquaintance was accused of aiding the revolutionaries"]
static var D_accusation: Array[String] = ["Illegal literature (not socialist)", "Embezzlement of funds", "Spoke unflatteringly about the government", "Escape from slavery", "Symbols of the Communists"]
static var E_accusation: Array[String] = ["Agitation to join the Communist Party", "Socialist Literature", "Refusal to work", "Participation in the strike", "Called for a revolution"]

var economy_grade: grades
var loyalty_grade: grades

var name: String
var scname: String
var age: int
var background: String
var accusation: String

static func random_respondent() -> Respondent:
	var ret: Respondent = new()
	
	ret.age = randi_range(18,75)
	
	ret.is_male = randi_range(0,1) == 0
	if ret.is_male: ret.name = male_names.pick_random()
	else: ret.name = female_name.pick_random()
	ret.scname = second_names.pick_random()
	
	ret.economy_grade = randi_range(0,4)
	match ret.economy_grade + randi_range(-1,1):
		-1:
			ret.background = A_background.pick_random()
		0:
			ret.background = A_background.pick_random()
		1:
			ret.background = B_background.pick_random()
		2:
			ret.background = C_background.pick_random()
		3:
			ret.background = D_background.pick_random()
		4:
			ret.background = E_background.pick_random()
		5:
			ret.background = E_background.pick_random()
	ret.loyalty_grade = randi_range(0,4)
	match ret.loyalty_grade + randi_range(-1,1):
		-1:
			ret.accusation = A_accusation.pick_random()
		0:
			ret.accusation = A_accusation.pick_random()
		1:
			ret.accusation = B_accusation.pick_random()
		2:
			ret.accusation = C_accusation.pick_random()
		3:
			ret.accusation = D_accusation.pick_random()
		4:
			ret.accusation = E_accusation.pick_random()
		5:
			ret.accusation = E_accusation.pick_random()
	
	return ret
