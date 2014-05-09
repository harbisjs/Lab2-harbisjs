module sample

pred p{}
pred q{}

fact Premises {
	p implies q
	p
}

assert Conclusion{
	q
}

check Conclusion for 4
