open util/ordering[GameState]

abstract sig Marker{}

abstract sig Position{
	owner: Marker
}

sig GameState{
	board: set Position,
	turn: Marker
}

one sig Cross, Nought, Null extends Marker {}

one sig TopLeft, TopCenter, TopRight, MiddleLeft, MiddleCenter, MiddleRight, BottomLeft, BottomCenter, BottomRight extends Position{}

fact BoardConfiguration{
	GameState.board = (TopLeft + TopCenter + TopRight +
	 MiddleLeft + MiddleCenter + MiddleRight +
	 BottomLeft + BottomCenter + BottomRight)
}

pred Win[s: GameState, t: Marker] {
	t in Marker - Null
	and
(
	(
		(one p: s.board | p in TopLeft and p.owner in t)
		and
		(one p: s.board | p in TopCenter and p.owner in t)
		and
		(one p: s.board | p in TopRight and p.owner in t)
	)
	or
	(
		(one p: s.board | p in MiddleLeft and p.owner in t)
		and
		(one p: s.board | p in MiddleCenter and p.owner in t)
		and
		(one p: s.board | p in MiddleRight and p.owner in t)
	)
	or
	(
		(one p: s.board | p in BottomLeft and p.owner in t)
		and
		(one p: s.board | p in BottomCenter and p.owner in t)
		and
		(one p: s.board | p in BottomRight and p.owner in t)
	)
	or
	(
		(one p: s.board | p in TopLeft and p.owner in t)
		and
		(one p: s.board | p in MiddleLeft and p.owner in t)
		and
		(one p: s.board | p in BottomLeft and p.owner in t)
	)
	or
		(
		(one p: s.board | p in TopCenter and p.owner in t)
		and
		(one p: s.board | p in MiddleCenter and p.owner in t)
		and
		(one p: s.board | p in BottomCenter and p.owner in t)
	)
	or
	(
		(one p: s.board | p in TopRight and p.owner in t)
		and
		(one p: s.board | p in MiddleRight and p.owner in t)
		and
		(one p: s.board | p in BottomRight and p.owner in t)
	)
	or
	(
		(one p: s.board | p in TopLeft and p.owner in t)
		and
		(one p: s.board | p in MiddleCenter and p.owner in t)
		and
		(one p: s.board | p in BottomRight and p.owner in t)
	)
	or
	(
		(one p: s.board | p in TopRight and p.owner in t)
		and
		(one p: s.board | p in MiddleCenter and p.owner in t)
		and
		(one p: s.board | p in BottomLeft and p.owner in t)
	)
)
}

pred Draw[s: GameState] {
	(all p: s.board | p.owner in Marker - Null)
	and
	(not Win[s, Cross])
	and
	(not Win[s, Nought])
}

fun NextTurn[s: GameState]: Marker {
	Marker - (Null + s.turn)
}

pred Init[s: GameState, t: Marker]{
	(all p : s.board | p.owner in Null)
	and
	(t in Marker - Null)
	and
	(s.turn in t)
}

pred Transition[s, s': GameState]{
//what this is supposed to be doing but is not working correctly is:
//there is exactly one position in the first game state and exactly one position in the second game state
//such that two positions are the same position (spot on the board)
//and the position in the first gamestate is owned by no one
//and the position in the second gamestate is owned by the opposite player of the first gamestate
//and all other positions in both gamestates are the same
	(one p: s.board | one p': s'.board | p = p' and p.owner in Null and p'.owner in NextTurn[s] and (s.board - p) = (s'.board - p'))
	and
	(s'.turn = NextTurn[s])
}

fact Trace{
	Init [first]
	all s: GameState-last |
		let s' = s.next |
			Transition[s, s']
}

pred WinningTrace {
	some Win[GameState, Cross]
	or
	some Win[GameState, Nought]
}

pred DrawTrace {
	some Draw[GameState]
}


run Win for 1 GameState

run Draw for 1 GameState

run Init for 1 GameState

run Transition for 2 GameState

run WinningTrace for 5 GameState

run DrawTrace for 9 GameState
