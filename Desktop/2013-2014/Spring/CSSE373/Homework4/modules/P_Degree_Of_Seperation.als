module Degree_Of_Seperation


// Models the super set of all persons
abstract sig Person{}

// Models the super set of all social networks
abstract sig SocialNetwork{
	// Models the friendship relation between two friends
	// for all of the social networks
	friendship: Person -> Person	
}

// Here is how you can model individual persons. Note that the set 
// Person = {Shawn, Cary, Chandan, Buffalo} with this declaration.
// TODO: Model other CSSE faculty and staffs as well based on the question.
one sig Shawn, Cary, Chandan, Buffalo, Sriram, Micah, Steve, Claude, Nadine, Lynn, Matt, Michael, Darryl, Delvin, David, JP, Mike extends Person{}
 
// Let's model all of the social networks
one sig Facebook, Twitter, GooglePlus extends SocialNetwork {}

// TODO: Complete the partial model
fact{

{Shawn->Cary} in Facebook.friendship
{Shawn->Chandan} in Facebook.friendship
{Shawn->Buffalo} in Facebook.friendship
{Chandan->Sriram} in Facebook.friendship
{Chandan->Micah} in Facebook.friendship
{Chandan->Steve} in Facebook.friendship

{Sriram->Claude} in Twitter.friendship
{Sriram->Nadine} in Twitter.friendship
{Sriram->Lynn} in Twitter.friendship
{Nadine->Matt} in Twitter.friendship
{Nadine->Michael} in Twitter.friendship
{Nadine->Shawn} in Twitter.friendship

{Cary->Mike} in GooglePlus.friendship
{Cary->Darryl} in GooglePlus.friendship
{Cary->Buffalo} in GooglePlus.friendship
{Darryl->Delvin} in GooglePlus.friendship
{Darryl->David} in GooglePlus.friendship
{Darryl->JP} in GooglePlus.friendship

//irreflexive
//Couldn't figure it out

//symmetric
all s:SocialNetwork| ~{s.friendship} in s.friendship

//transitive
//(violates irreflexive)
all s:SocialNetwork| ^{s.friendship} in s.friendship



}

// A Friend is not friends with itself
//fact {
//	no f: SocialNetwork.friendship | f in f.friendship
//}

//pred degreeOfSeperation[person: Person] {
//	all s: SocialNetwork | p in socialnetwork.^friendship
//}

pred show[] {}

run show for 6


