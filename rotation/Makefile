
OCAMLFLAGS= -I +sdl -I +site-lib/sdl bigarray.cmxa sdl.cmxa sdlloader.cmxa

main_rotation: main_rotation.ml rotation.cmx
	ocamlopt ${OCAMLFLAGS} -c main_rotation.ml

rotation: rotation.ml
	ocamlopt ${OCAMLFLAGS} -c rotation.ml

build: rotation.cmx main_rotation.cmx
	ocamlopt ${OCAMLFLAGS} -o main rotation.cmx main_rotation.cmx

clean::
	rm -f *~ *.o *.cm?
