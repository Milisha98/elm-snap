<Query Kind="Statements" />

//
// elm-snap - shuffle
//
var rnd = new System.Random();
var cards = new List<string> { "Cow","Dog","Duck","Fish","Horse","Rooster" };
int clone = 4;


var p1 = new List<string>();
var p2 = new List<string>();

// Create Deck (non-randomized)
var deck = cards;
for (int i = 1; i < clone; i++) deck = deck.Concat(cards).ToList();

int count = deck.Count();
bool isP1 = true;
while (count > 0)
{
	int index = rnd.Next(0, count - 1);
	string card = deck[index];
	if (isP1)	
		p1.Add(card);
	else
		p2.Add(card);
	isP1 = !isP1;
	deck.RemoveAt(index);
	count -= 1;
}

var p1List = $"[{string.Join(", ", p1)}]";
var p2List = $"[{string.Join(", ", p2)}]";

p1List.Dump();
p2List.Dump();