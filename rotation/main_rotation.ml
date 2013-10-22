let main ()=
  begin
    (* Nous voulons 2 arguments l'image et l'angle *)
    if Array.length (Sys.argv) < 1 + 2 then (* 1 etant le nom de la commande et 2 les 2 arguments attendu*)
      begin 
        failwith "Il manque des arguments,argument 1 le nom de l'image 2 l angle de rotation";
      end
    else
        begin
          (* on charge l'image*)
          print_string "chargement de l'image...";
          print_newline();
          (*la fonction*)
          let surface1 = Rotation.charger_image "duke.bmp" in

            print_string "OK";
            print_newline();

            (*on met l angle en radian*)      
            print_string "transformation de l angle...";
            print_newline();
            (*la fonction*)
            let angle_en_rad = Rotation.deg_to_rad 90. in
            print_string "OK";
            print_newline();

            (*on lance la rotation*)
            print_string "rotation en cour...";
            print_newline();
            (*la fonction*)
            print_string "OK";
            print_newline();

            (*on enregistre le resultat*)
            print_string "sauvegarde en cour...";
            print_newline();
            (*la fonction*)
            Rotation.sauvegarde_image surface1;

            print_string "OK";
            print_newline();
        end
  end

let _ = main ()

