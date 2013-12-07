(* Dimensions d'une image *)
let get_dims img =
  ((Sdlvideo.surface_info img).Sdlvideo.w, (Sdlvideo.surface_info img).Sdlvideo.h)

(* init de SDL *)
let sdl_init () =
  begin
    Sdl.init [`EVERYTHING];
    Sdlevent.enable_events Sdlevent.all_events_mask;
  end

(*prend e parametre un triplet r,g,b et renvoie le niveau de gris en float*)
let level (r, g, b) =
 (float_of_int(r)*.0.3 +. 0.59*.float_of_int(g) +. 0.11*.float_of_int(b)) /. 255.

let getrgb (r,g,b) =
 (r + g + b)/3

(*prend en parametre un triplet rgb et renvoie un triplet passé au niveau de gris avec level*)
let color2grey (r,g,b) =
  let rgb = int_of_float(level(r,g,b)*.255.) in
  (rgb,rgb,rgb)

(*prend deux images en parametre et renvoie dans l'image 2 l'image 1 grise*)
let image2grey img img2=
  let (w,h) = get_dims img in
    for i = 0 to h-1 do
      for j = 0 to w-1 do
        Sdlvideo.put_pixel_color img2 j i (color2grey(Sdlvideo.get_pixel_color img j i ))
      done
    done

let binarise img img2 =
 let (w,h) = get_dims img in
  for i=0 to w-1 do
   for j=0 to h-1 do
    if Sdlvideo.get_pixel_color img i j < (220,220,220) then
    Sdlvideo.put_pixel_color img2 i j (0,0,0)
    else
    Sdlvideo.put_pixel_color img2 i j (255,255,255)
   done
  done


let rec tri = function (*tri une liste en croissant*)
   | [] -> []
   | t::l -> insert t (tri l)
 
and insert e = function
  | [] -> [e]
  | x::l -> if e < x then e::x::l else x::insert e l
 
let filtre1 src dst = (*filtre médian*)
    for x = 1 to ((Sdlvideo.surface_info src).Sdlvideo.w - 2) do  
        for y = 1 to ((Sdlvideo.surface_info src).Sdlvideo.h - 2) do
 
        let liste1 = ref [] in
        liste1 := [
                  (Sdlvideo.get_pixel_color src (x-1) (y));
                  (Sdlvideo.get_pixel_color src (x) (y-1));
                  (Sdlvideo.get_pixel_color src (x) (y));
                  (Sdlvideo.get_pixel_color src (x) (y+1));
                  (Sdlvideo.get_pixel_color src (x+1) (y))
							   ];

        Sdlvideo.put_pixel_color dst x y (List.nth (tri (!liste1)) ((List.length (tri (!liste1)))/2));
        done
    done 

let filtre2 src dst = (*filtre haut non fonctionel*)
    for x = 1 to ((Sdlvideo.surface_info src).Sdlvideo.w - 2) do
        for y = 1 to ((Sdlvideo.surface_info src).Sdlvideo.h - 2) do

        let var1 = ref 0 in (*somme coefficienté des 5 pixels concernés*)
        var1 := ((-getrgb (Sdlvideo.get_pixel_color src (x-1) (y)))-
                   (getrgb (Sdlvideo.get_pixel_color src (x) (y-1)))+
                   5 * (getrgb (Sdlvideo.get_pixel_color src (x) (y)))-
                   (getrgb (Sdlvideo.get_pixel_color src (x) (y+1)))-
                   (getrgb (Sdlvideo.get_pixel_color src (x+1) (y))));

        Sdlvideo.put_pixel_color dst x y (!var1,!var1,!var1);
        done
    done

