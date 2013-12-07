
let main () =
  let main_window = GWindow.window ~title:"Pictwriters" ~border_width:10 ~position:`CENTER () in

  main_window#connect#destroy ~callback:GMain.Main.quit;

  let main_box = GPack.hbox ~packing:main_window#add () in

  let box_boutons = GPack.hbox ~packing:main_box#add () in

  let button_ouvrir = GButton.button ~label:"open" ~packing:box_boutons#pack () in

  let button_traitement = GButton.button ~label:"traitement" ~packing:box_boutons#pack () in

  let box_image = GPack.hbox ~packing:main_box#add () in

  let button_image = GButton.button ~label:"image" ~packing:box_image#pack () in

  let box_texte = GPack.hbox ~packing:main_box#add () in

  let zone_texte = GEdit.entry ~text:"le texte de l'image" ~packing:box_texte#add () in

  let box_avancement = GPack.hbox ~packing:main_box#add () in

  let button_avancement = GButton.button ~label:"0%" ~packing:box_avancement#pack () in

  let box_bouton_quitter = GPack.hbox ~packing:main_box#add () in

  let button_quitter = GButton.button ~label:"quitter" ~packing:box_bouton_quitter#pack () in

main_window#show ();

GMain.Main.main ()

let _ = main ()
