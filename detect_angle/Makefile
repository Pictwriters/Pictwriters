
OCAMLFLAGS= -I +sdl -I +site-lib/sdl bigarray.cmxa sdl.cmxa sdlloader.cmxa

detect_angle: detect_angle.ml
	ocamlopt ${OCAMLFLAGS} -c detect_angle.ml

clean::
	rm -f *~ *.o *.cm?
