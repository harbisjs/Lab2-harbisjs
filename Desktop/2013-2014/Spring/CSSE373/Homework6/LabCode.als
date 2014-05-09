module chapter6/ringElection2 --- the final version (as depicted in Fig 6.1)

open util/ordering[Time] as TO
open util/ordering[Process] as PO

sig Time {} //this reprsents a period of time

sig Process { //this represents a protocol process
	succ: Process, //every process has a successor
	toSend: Process -> Time, //a relation of processes at time t
	elected: set Time //a set of times when the process elects itself as leader
	}

fact ring { //ensure that the processes form a ring by making sure a process can connect to itself by going through successor repeatedly
	all p: Process | Process in p.^succ
	}

pred init [t: Time] {//initially a process can send only itself
	all p: Process | p.toSend.t = p
	}

pred step [t, t': Time, p: Process] {//describes the allowed state transitions
	let from = p.toSend, to = p.succ.toSend |
		some id: from.t {
			from.t' = from.t - id //remove id from the "from"
			to.t' = to.t + (id - p.succ.prevs) //add the id to the "to" if the ordering is greater than the current processes id
		}
	}

fact defineElected {
	no elected.first //initially nothing is elected
	all t: Time-first | elected.t = {p: Process | p in p.toSend.t - p.toSend.(t.prev)} //the processes that are elected are the ones that just were sent their own ids back
	}

fact traces {
	init [first]//for the first period of time the initial conditions are true
	all t: Time-last |//for any subsequent period of time
		let t' = t.next |
			all p: Process |
				step [t, t', p] or step [t, t', succ.p] or skip [t, t', p] // all processes either step, have their successor take a step, or do nothing
	}

pred skip [t, t': Time, p: Process] { //represents doing nothing by keeping it the same through the next iteration of time
	p.toSend.t = p.toSend.t'
	}

pred show { some elected } //is there an instance where a process is elected
run show for 3 Process, 4 Time //try answering the pred show with 3 processes and 4 periods of time


assert AtMostOneElected { lone elected.Time } //there is at most one elected process
check AtMostOneElected for 3 Process, 7 Time //check the validity of the assertion given 3 processes and 7 periods of time


pred progress  {//a process can't skip if it has id's in its pool
	all t: Time - TO/last |
		let t' = TO/next [t] |
			some Process.toSend.t => some p: Process | not skip [t, t', p] //if a process can send an id then it has to send and id and can't skip
	}

assert AtLeastOneElected { progress => some elected.Time } //given progress eventually something will be elected
check AtLeastOneElected for 3 Process, 7 Time //check the validity of the assertion given 3 processes and 7 periods of time


pred looplessPath { no disj t, t': Time | toSend.t = toSend.t' } //we never visit a state twice by saying that two points in time in a trace are equal if their pools of ids are equal


run looplessPath for 3 Process, 12 Time //find an answer to the predicate given 3 processes and 12 periods of time


run looplessPath for 3 Process, 13 Time//find an answer to the predicate given 3 processes and 13 periods of time

