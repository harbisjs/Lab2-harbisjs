module sample

pred p{}
pred q{}
pred r{}

fact Premises {
	not not (p and r)
	not not (q and r)
}

assert Conclusion{
	p and (not not q)
}

check Conclusion for 4
