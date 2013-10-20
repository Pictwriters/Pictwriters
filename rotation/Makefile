
main_rotation: rotation.ml main_rotation.ml
	ocamlopt -I +sdl -I +site-lib/sdl bigarray.cmxa sdl.cmxa sdlloader.cmxa -o main_rotation rotation.ml main_rotation.ml

rotation: rotation.ml
	ocamlopt -I +sdl -I +site-lib/sdl bigarray.cmxa sdl.cmxa sdlloader.cmxa -o rotation rotation.ml

clean::
	rm -f *~ *.o *.cm? rotation main_rotation
