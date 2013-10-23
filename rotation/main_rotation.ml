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
          let img_in = Rotation.charger_image (Array.get Sys.argv 1) in (* "lenna.bmp" *) (* "duke.bmp" *)

            print_string "OK";
            print_newline();

            (*on met l angle en radian*)      
            print_string "transformation de l angle...";
            print_newline();
            (*la fonction*)
            let angle_en_rad = Rotation.deg_to_rad (float_of_string(Array.get Sys.argv 2)) in
              print_string "OK";
              print_newline();

              (*on lance la rotation*)
              print_string "rotation en cour...";
              print_newline();
              (*la fonction*)
              let resultat = Rotation.rotation angle_en_rad img_in in
                print_string "OK";
                print_newline();

                (*on enregistre le resultat*)
                print_string "sauvegarde en cour...";
                print_newline();
                (*la fonction*)
                Rotation.sauvegarde_image resultat;

                print_string "OK";
                print_newline();
        end
  end

let _ = main ()

