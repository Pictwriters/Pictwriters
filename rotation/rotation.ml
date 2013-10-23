(*
 Arrondire un float en un int
 *)

let float_to_int_arrondie x =
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


(* donne x apres rotation avec le centre *)

let rotx i j cx cy ang =
  cx + float_to_int_arrondie( float_of_int(i-cx)*.(cos ang)
                 -. float_of_int(j-cy)*.(sin ang))

(* donne y apres rotation avec le centre *)

let roty i j cx cy ang =
  cy + float_to_int_arrondie( float_of_int(i-cx)*.(sin ang)
                 +. float_of_int(j-cy)*.(cos ang))

(* Converti les radians en degres *)

let rad_to_deg rad =
  rad*.(180.0)/.(3.14)

(* Converti les degres en radians *)

let deg_to_rad deg =
  deg*.(3.14)/.(180.0)

(*coordone du centre*)
let coordone_centre img =
  let dimention_de_image = get_dims img in
    match dimention_de_image with
      | (w,h) -> (w/2,h/2)

(*est ce que ce nouveau point est bien dans la photo *)
let point_valide x y img_in =
  let dim = get_dims img_in in
  let w =
    match dim with
      |(w,h) -> w
  in
  let h =
    match dim with
      |(w,h) -> h
  in
    if(((0 <= x) && (x < w)) || ((0 <= y) && (y < h)))then
      true
    else
      false


(*rotation d un pixel *)
let rot_pixel i j angle img_in img_out =
  let color_pixel = Sdlvideo.get_pixel img_in i j in
  let centre = coordone_centre img_in in
  let cx =
    match centre with
      |(w,h) -> w
  in
  let cy =
    match centre with
      |(w,h) -> h
  in
  let new_x = rotx i j cx cy angle in
  let new_y = roty i j cx cy angle in
    if(point_valide new_x new_y img_in)then
      Sdlvideo.put_pixel img_out new_x new_y color_pixel


(*rotation de toute l image*)
let rotation_toute_image angle img_in img_out =
  let dim = get_dims img_in in
  let w =
    match dim with
      |(w,h) -> w
  in
  let h =
    match dim with
      |(w,h) -> h
  in
    for j = 0 to (h - 1) do
      for i = 0 to (w - 1) do
        rot_pixel i j angle img_in img_out
      done
    done;
    img_out


(*rotation*)
let rotation angle img_in =
  let dim = get_dims img_in in
  let w =
    match dim with
      |(w,h) -> w
  in
  let h =
    match dim with
      |(w,h) -> h
  in
  let img_out = Sdlvideo.create_RGB_surface_format img_in [] w h in
    rotation_toute_image angle img_in img_out
