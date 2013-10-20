(*
 Arrondire un float en un int
 *)

let int_of_float_arrondie x =
  if x > 0. then
    if (x >= float_of_int(int_of_float x) +. 0.5) then 
      int_of_float(x) + 1
    else 
      int_of_float x
  else
    if (x >= float_of_int(int_of_float(x)) -. 0.5) then
      int_of_float x
    else int_of_float(x) - 1

(* Dimensions d'une image *)

let get_dims img =
  ((Sdlvideo.surface_info img).Sdlvideo.w, (Sdlvideo.surface_info img).Sdlvideo.h)

(*
 show img dst
 affiche la surface img sur la surface de destination dst
 (normalement l'écran)
 *)

let show img dst =
  let d = Sdlvideo.display_format img in
    Sdlvideo.blit_surface d dst ();
    Sdlvideo.flip dst

(*on charge l image*)
let charger_image x =
  Sdlvideo.load_BMP x

(*on sauvegarde l image*)
let sauvegarde_image surface =
  Sdlvideo.save_BMP surface "output.bmp"

