
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

  let button_item2 = GButton.button
    ~packing: item2#add()
    ~stock: `EXECUTE
  in

  let item3 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item3 = GButton.button ~stock:`HELP ~packing:item3#add () in

  let item4 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item4 = GButton.button ~stock:`ABOUT ~packing:item4#add () in

  let about_window = GWindow.about_dialog
    ~name:"Pictwriters"
    ~authors:["ARCHER Stéphane, Melanie Ey, Daniel Petrov, Ugo Lorenzini"]
    ~copyright:"2013"
    ~license:"Public License"
    ~version:"1.0"
    ~website:"http://pictwriters.wordpress.com/"
    ~website_label:"pictwriters.com"
    ~parent:main_window
    ~destroy_with_parent:false
    ~title:"Pictwriters"
    ~deletable:true
    ~position:`CENTER_ON_PARENT
    ~resizable:true
    ~border_width:2
    ()
  in

  button_item4#connect#clicked ~callback:(fun () -> about_window#show ());

  let box_image = GPack.hbox ~packing:main_box#add () in

  let name_of_image = ref "duke.bmp" in

  let box_view_image = GBin.scrolled_window
    ~packing:box_image#add ()
  in

  let view_image = GMisc.image
    ~file:!name_of_image
    ~packing:box_view_image#add_with_viewport ()
  in

  let box_texte = GPack.hbox ~packing:main_box#add () in

  let text_to_display = ref "le texte de l'image" in

  let buffer_texte = GText.buffer ~text:(!text_to_display) () in

  let box_view_texte = GText.view ~buffer:buffer_texte ~editable:true ~packing:box_texte#add () in

  let box_avancement = GPack.hbox ~packing:main_box#add () in

  let bar_avancement = GRange.progress_bar ~orientation:`LEFT_TO_RIGHT ~pulse_step:0.5 ~packing:box_avancement#add () in
  (*bar_avancement#pulse (); *)

  let box_bouton_quitter = GPack.hbox ~packing:main_box#add () in

  let button_quitter = GButton.button ~stock:`QUIT ~packing:box_bouton_quitter#add () in

  button_quitter#connect#clicked ~callback:(GMain.Main.quit);

  main_window#show ();

  GMain.Main.main ()

let _ = main ()
