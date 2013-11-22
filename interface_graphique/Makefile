
OCAMLFLAGS= -I +sdl -I +site-lib/sdl bigarray.cmxa -I +lablgtk2 lablgtk.cmxa

gui: gui.ml
	ocamlopt ${OCAMLFLAGS} -c gui.ml

build: gui.cmx gui.ml
	ocamlopt ${OCAMLFLAGS} -o main gui.cmx

clean::
	rm -f *~ *.o *.cm?
