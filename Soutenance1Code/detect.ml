(*dessine un cadre avec pour coin gauche (x,y) et coin bas droite (w,h) *)
let cadre img ((x,y),(w,h))=
 for i =x to w do
  Sdlvideo.put_pixel_color img i y (255,0,0);
  Sdlvideo.put_pixel_color img i h (255,0,0);
 done;
 for j = y to h do
  Sdlvideo.put_pixel_color img x j (255,0,0);
  Sdlvideo.put_pixel_color img w j (255,0,0);
 done

(*detecte le bloc racine*)
let detect img dimw dimh=
 let x = ref 0 and y = ref 0 and w = ref 0 and h = ref 0 and b = ref true and c = ref true in
  let recdec () =
   for i = 0 to dimw -1 do
    for j = 0 to dimh -1 do
     if Sdlvideo.get_pixel_color img i j= (0,0,0) then
      if !b then
begin
  x:= i;w:=i; b:=false;
end
      else
 w:=i;
    done;
   done;
   for j2 =0 to dimh-1 do
    for i2 = 0 to dimw-1 do
     if Sdlvideo.get_pixel_color img i2 j2= (0,0,0) then
      if !c then
begin
  y:= j2;h:=j2; c:=false;
end
      else
 h:=j2;
    done;
   done;
((!x-1,!y-1),(!w+1,!h+1))
  in
 recdec ()

(*met dans une liste 0 si ligne blanche, 1 si il y a au moins un pisel noir*)
(*version des lignes verticale (l'index du tableau est l'abscisse et tab[i] est l'état de la ligne verticale)*)
let detec_vert img ((x,y),(w,h)) =
 let _array = Array.make (w - x + 1) 0 in
  for i = x to w do
   for j = y to h do
    if Sdlvideo.get_pixel_color img i j = (0,0,0) then
     _array.(i - x) <- _array.(i-x) + 1;
  done;
 done;
_array

(*version des lignes horizontales meme chose que au dessus mais pour horizontale*)
let detect_hor img ((x,y),(w,h)) =
 let _array = Array.make (h - y + 1) 0 in
  for i = y to h do
   for j = x to w do
    if Sdlvideo.get_pixel_color img j i = (0,0,0) then
     _array.(i - y) <- _array.(i-y) + 1;
   done;
  done;
_array

let cut _array =
 let exit_array = ref [] in
  exit_array := [];
  for i = 1 to Array.length _array - 3 do
   if (_array.(i-1) = 1 && _array.(i) = 0 && _array.(i+1) = 0 && _array.(i+2) = 0) then
    exit_array := i+1 :: !exit_array;
  done;
!exit_array

let isCut _array =
let b = ref false in
 for i = 1 to Array.length _array - 3 do
  if (_array.(i-1) = 1 && _array.(i) = 0 && _array.(i+1) = 0 && _array.(i+2) = 0) then
  b := true
done;
b

let trouveCoup _array = 
  let a = ref 0 in
   a := 0;
    for i = 0 to Array.length _array -4 do
      if (_array.(i) = 1 && _array.(i+1) = 0 && _array.(i+2) = 0 && _array.(i+3) = 0 && !a = 0) then
       a:=i+2;
    done;
!a

let smallCutLinesUp img ((x,y),(w,h)) =
 let _array = detect_hor img ((x+1,y+1),(w-1,h-1)) in
  for i = 0 to Array.length _array-4 do
   if (_array.(i) > 0 && _array.(i+1) <= 0 && _array.(i+2) <= 0 && _array.(i+3) <= 0) then
    for j = x to w do
     Sdlvideo.put_pixel_color img j (i+1+y) (255,0,0)
   done;
  done

let smallCutLinesDown img ((x,y),(w,h)) = 
  let _array = detect_hor img ((x+1,y+1),(w-1,h-1)) in
  for i = 0 to Array.length _array-3 do
   if (_array.(i) <= 0 && _array.(i+1) <= 0 && _array.(i+2) > 0) then
    for j = x to w do
     Sdlvideo.put_pixel_color img j (i+1+y) (255,0,0)
   done;
  done

let bigCutLinesUp img ((x,y),(w,h)) =
 let _array = detect_hor img ((x+1,y+1),(w-1,h-1)) in
  for i = 0 to Array.length _array-7 do
   if (_array.(i) > 3 && _array.(i+1) <= 3 && _array.(i+2) <= 3 && _array.(i+3) <= 3 && _array.(i+4) <= 3 && _array.(i+5) <= 3 && _array.(i+6) <= 3) then
    for j = x to w do
     Sdlvideo.put_pixel_color img j (i+1+y) (255,0,0)
   done;
  done

let bigCutLinesDown img ((x,y),(w,h)) =
  let _array = detect_hor img ((x+1,y+1),(w-1,h-1)) in
  for i = 0 to Array.length _array-6 do
   if (_array.(i) <= 3  && _array.(i+1) <= 3 && _array.(i+2) <= 3 && _array.(i+3) <= 3 && _array.(i+4) <= 3 && _array.(i+5) > 3) then
    for j = x to w do
     Sdlvideo.put_pixel_color img j (i+1+y) (255,0,0)
   done;
  done

(*
let smallCut img ((x,y),(w,h)) =
 let l = [] in
  let b = ref false in
   for i = 0 to*) 

let cutLines img ((x,y),(w,h)) =
 if (w-x) < 1500 && (h-y) <1800 then
begin
  smallCutLinesUp img ((x,y),(w,h));
  smallCutLinesDown img ((x,y),(w,h))
end
else
begin
  bigCutLinesUp img ((x,y),(w,h));
  bigCutLinesDown img ((x,y),(w,h))
end
