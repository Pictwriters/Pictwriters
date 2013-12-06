
OCAMLFLAGS= -I +lablgtk2
GTKFLAGS= lablgtk.cma gtkInit.cmo

build: gui.ml
	ocamlc ${OCAMLFLAGS} -o interface ${GTKFLAGS} gui.ml

clean::
	rm -f *~ *.o *.cm?
