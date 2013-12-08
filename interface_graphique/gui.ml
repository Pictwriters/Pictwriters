
let main () =
  let main_window = GWindow.window ~title:"Pictwriters" ~border_width:10 ~position:`CENTER ~resizable:true ~width:400 ~height:600 () in

  main_window#connect#destroy ~callback:GMain.Main.quit;

  let main_box = GPack.vbox ~spacing:2 ~border_width:2 ~packing:main_window#add () in

  let box_toolbar = GPack.vbox ~packing:main_box#add () in

  let box_image = GPack.hbox ~packing:main_box#add () in

  let name_of_image = ref "duke.bmp" in

  let box_view_image = GBin.scrolled_window
    ~packing:box_image#add ()
  in

(*
  (*l image par defaut a l ouverture *)
  let view_image = GMisc.image
    ~file:!name_of_image
    ~packing:box_view_image#add_with_viewport ()
  in
*)

  let box_texte = GPack.hbox ~packing:main_box#add () in

  let text_to_display = ref "le texte de l'image" in

  let buffer_texte = GText.buffer ~text:(!text_to_display) () in

  let box_view_texte = GText.view ~buffer:buffer_texte ~editable:true ~packing:box_texte#add () in

  let box_avancement = GPack.hbox ~packing:main_box#add () in

  let bar_avancement = GRange.progress_bar ~orientation:`LEFT_TO_RIGHT ~pulse_step:0.25 ~packing:box_avancement#add () in
  (*bar_avancement#pulse (); *)

  let toolbar = GButton.toolbar
    ~orientation:`HORIZONTAL
    ~style:`ICONS
    ~packing:box_toolbar#pack
    ()
  in

  let item1 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item1 = GFile.chooser_button
    ~action:`OPEN
    ~packing:item1#add ()
  in

  let changer_image boutton =
    match boutton#filename with
    | Some n ->
      GMisc.image
	~file:n
	~packing:box_view_image#add_with_viewport ()
    | None ->
      GMisc.image
	~file:(!name_of_image)
	~packing:box_view_image#add_with_viewport ()
  in

  button_item1#connect#selection_changed (fun () -> changer_image (button_item1); () );

  let item2 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item2 = GButton.button
    ~packing: item2#add()
    ~stock: `EXECUTE
  in

  let changer_le_texte str =
    buffer_texte#set_text (str);
    bar_avancement#pulse ();
  in

  let new_text_to_display = ref "A la musique

Place de la Gare, à Charleville.

Sur la place taillée en mesquines pelouses,
Square où tout est correct, les arbres et les fleurs,
Tous les bourgeois poussifs qu'étranglent les chaleurs
Portent, les jeudis soirs, leurs bêtises jalouses.

- L'orchestre militaire, au milieu du jardin,
Balance ses schakos dans la Valse des fifres :
Autour, aux premiers rangs, parade le gandin ;
Le notaire pend à ses breloques à chiffres.

Des rentiers à lorgnons soulignent tous les couacs :
Les gros bureaux bouffis traînant leurs grosses dames
Auprès desquelles vont, officieux cornacs,
Celles dont les volants ont des airs de réclames ;

Sur les bancs verts, des clubs d'épiciers retraités
Qui tisonnent le sable avec leur canne à pomme,
Fort sérieusement discutent les traités,
Puis prisent en argent, et reprennent : En somme !...

Épatant sur son banc les rondeurs de ses reins,
Un bourgeois à boutons clairs, bedaine flamande,
Savoure son onnaing d'où le tabac par brins
Déborde - vous savez, c'est de la contrebande ; -" in

  button_item2#connect#clicked ~callback:(fun () -> changer_le_texte !new_text_to_display; () );

  let item3 = GButton.tool_item ~packing:toolbar#insert () in

  let button_item3 = GButton.button ~stock:`HELP ~packing:item3#add () in

  let message_help_window =ref "Manuel d'utilisation

Introduction

Pictwriters est un OCR (Optical Character Recognition) développé sous FreeBSD et a été codé intégralement en Ocaml. C'est le projet de quatre étudiants d'EPITA : une école d'ingénieurs en informatique. Vous pouvez trouver plus d'informations sur le site internet du projet : http://pictwriters.wordpress.com/

Logiciels nécessaires :

Afin que l'OCR fonctionne vous devez installer obligatoirement : - Ocaml - GTK pour utiliser l'interface graphique - Libsdl et Ocaml SDL

Utilisation de Pictwriters avec l'interface graphique

Sélection d'une image :

Pour sélectionner une image cliquez sur l'icone [Exécuter].

Récupération du texte:

Pour récupérer le texte de l'image, sélectionner le texte dans le cadre s'affichant sous votre image puis faites un copier / coller (ctrl a / ctrl c) dans le document ou vous voulez insérer votre texte.

Vous pouvez à présent fermer l'application à l'aide du bouton [Quitter]" in

  let help_window = GWindow.message_dialog
    ~message:(!message_help_window)
    ~message_type:`INFO
    ~buttons:(GWindow.Buttons.ok)
    ~parent:main_window
    ~destroy_with_parent:false
    ~title:"help Pictwriters"
    ~deletable:true
    ~position:`CENTER_ON_PARENT
    ~resizable:true
    ~border_width:2
    ()
  in

  button_item3#connect#clicked ~callback:(fun () -> help_window#run (); help_window#misc#hide () );

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

  button_item4#connect#clicked ~callback:(fun () -> about_window#run (); about_window#misc#hide () );

  let box_bouton_quitter = GPack.hbox ~packing:main_box#add () in

  let button_quitter = GButton.button ~stock:`QUIT ~packing:box_bouton_quitter#add () in

  button_quitter#connect#clicked ~callback:(GMain.Main.quit);

  main_window#show ();

  GMain.Main.main ()

let _ = main ()
