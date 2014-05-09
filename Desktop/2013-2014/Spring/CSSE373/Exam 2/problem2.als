open util/ordering[Time] as TO

sig Time{}

//under the assumption that a Core cannot exist without at least one Bus,
//I do not specificially model if each Core is visited because this criteria will
//be met if all Buses are visited given the assumption holds
abstract sig Core{
	buses: set Bus
}

abstract sig Bus{
	connection: Core -> Core
	visitState: Time -> one VisitState
}

abstract sig VisitState{}
one sig Visted, NotVisited extends VisitState{}

one sig Neo, Oracle, Smith, Architect extends Core{}

one sig Bus1, Bus2, Bus3, Bus4, Bus5, Bus6, Bus7 extends Bus{}

fact BusesInCores {
	(Bus1 + Bus2 + Bus3) in Neo.buses
	(Bus1 + Bus2 + Bus4 + Bus5 + Bus7) in Oracle.buses
	(Bus3 + Bus4 + Bus6) in Smith.buses
	(Bus5 + Bus6 + Bus7) in Architect.buses
}

fact ConnectionsInBuses {
	Neo -> Oracle in Bus1.connection
	Neo -> Oracle in Bus2.connection
	Neo -> Smith in Bus3.connection
	Oracle -> Smith in Bus4.connection
	Oracle -> Architect in Bus5.connection
	Smith -> Architect in Bus6.connection
	Oracle -> Architect in Bus7.connection
}

fact ConnectionIsSymmetic {
	all disj c1, c2: Core |
		c1 -> c2 in Bus.connection =>
			c2->c1 in Bus.connection
}


pred Init [t: Time] {
	all b: Bus | b.visitState.t = NotVisited
}

fact Initial {
	Init[first]
}

//need a pred to handle transitions from one state to another
//this pred will need to make sure transitions only occur on buses that have not been visted yet
//and it also needs to change a bus to 'visited' once it has been used

//need an assertion to see if all buses have been visited
