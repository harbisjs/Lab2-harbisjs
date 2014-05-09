module tour/addressBook1

sig Name, Addr{}
sig Book {
	addr: Name->lone Addr
	}

pred show (b: Book) {
	#b.addr > 1
	#Name.(b.addr) > 1
	}
run show for 3 but 1 Book

pred add [b, b': Book, n: Name, a: Addr] {
	b != b'
	b.addr + n->a = b'.addr
	}
run add for 3 but 2 Book

pred showAdd (b, b': Book, n: Name, a: Addr) {
	add [b, b', n, a]
	#Name.(b'.addr) > 1
	}
run showAdd for 3 but 2 Book

pred del (b, b': Book, n: Name) {
	b'.addr = b.addr - n->Addr
	}

fun lookup (b: Book, n: Name): set Addr {
	n.(b.addr)
	}

assert delUndoesAdd {
	all b,b',b'': Book, n: Name, a: Addr |
		no n.(b.addr) and add [b,b',n,a] and del [b',b'',n]
			implies b.addr = b''.addr
	}
check delUndoesAdd for 10 but 3 Book
