
# TP sdl
 
OCAML=ocamlopt
OCAMLFLAGS= -I +sdl -I +site-lib/sdl
OCAMLLD= bigarray.cmxa sdl.cmxa sdlloader.cmxa
 
main: main.ml
	${OCAML} ${OCAMLFLAGS} ${OCAMLLD} -c rotation.ml
	${OCAML} ${OCAMLFLAGS} ${OCAMLLD} -c traitement.ml
	${OCAML} ${OCAMLFLAGS} ${OCAMLLD} -c detect.ml
	${OCAML} ${OCAMLFLAGS} ${OCAMLLD} -o main detect.cmx traitement.cmx rotation.cmx main.ml
 
clean::
	rm -f *~ *.o *.cm?
 
# FIN
