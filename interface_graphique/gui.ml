
let main () =
  let main_window = GWindow.window ~title:"Pictwriters" ~border_width:10 ~position:`CENTER ~resizable:true ~width:400 ~height:600 () in

  main_window#connect#destroy ~callback:GMain.Main.quit;

  let main_box = GPack.vbox ~spacing:2 ~border_width:2 ~packing:main_window#add () in

  let toolbar = GButton.toolbar
                ~orientation:`HORIZONTAL
                ~style:`ICONS
                ~packing:(main_box#pack ~expand:false) () in

  let item1 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item1 = GFile.chooser_button
                 ~action:`OPEN
                 ~packing:item1#add ()
  in

  let item2 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item2 = GFile.chooser_button
                 ~action:`OPEN
                 ~packing:item2#add ()
  in

  let item3 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item3 = GFile.chooser_button
                 ~action:`OPEN
                 ~packing:item3#add ()
  in

  let item4 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item4 = GFile.chooser_button
                 ~action:`OPEN
                 ~packing:item4#add ()
  in

  let box_image = GPack.hbox ~packing:main_box#add () in

  let name_of_image = ref "duke.bmp" in

  let button_image = GButton.button ~label:"image" ~packing:box_image#pack () in

  let box_texte = GPack.hbox ~packing:main_box#add () in

  let name_of_text = ref "" in

  let zone_texte = GEdit.entry ~text:"le texte de l'image" ~packing:box_texte#add () in

  let box_avancement = GPack.hbox ~packing:main_box#add () in

  let button_avancement = GButton.button ~label:"0%" ~packing:box_avancement#pack () in

  let box_bouton_quitter = GPack.hbox ~packing:main_box#add () in

  let button_quitter = GButton.button ~label:"quitter" ~packing:box_bouton_quitter#pack () in

main_window#show ();

GMain.Main.main ()

let _ = main ()
