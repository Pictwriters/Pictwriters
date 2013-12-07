(* Dimensions d'une image *)
let get_dims img =
  ((Sdlvideo.surface_info img).Sdlvideo.w, (Sdlvideo.surface_info img).Sdlvideo.h)

(* init de SDL *)
let sdl_init () =
  begin
    Sdl.init [`EVERYTHING];
    Sdlevent.enable_events Sdlevent.all_events_mask;
  end

(* attendre une touche ... *)
let rec wait_key () =
  let e = Sdlevent.wait_event () in
    match e with
    Sdlevent.KEYDOWN _ -> ()
    | _ -> wait_key ()
 
(*
  show img dst
  affiche la surface img sur la surface de destination dst (normalement l'écran)
*)
let show img dst =
  let d = Sdlvideo.display_format img in
    Sdlvideo.blit_surface d dst ();
    Sdlvideo.flip dst

  (* main *)
  let main () =
    begin
      if Array.length (Sys.argv) < 3 then
	failwith "Il manque le nom du fichier ou l'angle (ou les deux !)";
     
      sdl_init ();
      
      let img = Sdlloader.load_image Sys.argv.(1) in
      let (w,h) = get_dims img in
      let display = Sdlvideo.set_video_mode w h [`DOUBLEBUF] in
      show img display;      
      wait_key ();

      let angle_rad = Rotation.deg_to_rad(float_of_string(Sys.argv.(2))) in
	let img2 = Rotation.rotation angle_rad img in
	show img2 display;
	wait_key ();
      Traitement.image2grey img2 img;
      show img display;
      wait_key ();

      Traitement.filtre1 img img2;
      show img2 display;
      wait_key ();

      Traitement.binarise img2 img;
      show img display;
      wait_key ();

      Detect.cadre img (Detect.detect img w h);
      show img display;
      wait_key ();

      Detect.cutLines img (Detect.detect img w h);
      show img display;
      wait_key ();
      
      exit 0
    end
 
let _ = main ()
