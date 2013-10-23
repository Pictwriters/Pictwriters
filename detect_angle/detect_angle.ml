(* Dimensions d'une image *)

	let get_dims img =
((Sdlvideo.surface_info img).Sdlvideo.w, (Sdlvideo.surface_info img).Sdlvideo.h)

(*moyenne de pixel noir par ligne*)
	let moyenne_pixel_noir_ligne img y =
	let dims = get_dims img in
	let w =
	match dims with
	|(w,h) -> w
	in
	let nb_pixel_black = ref 0 in
	for x = 0 to w do
(* Int32.zero estle pixel noir (a verifier) *)
	if(Int32.compare (Sdlvideo.get_pixel img x y) (Int32.zero)) = 1 then
Pervasives.incr (nb_pixel_black)
	done;
	!nb_pixel_black
