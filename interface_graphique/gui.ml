let _ = GMain.init ()

let window =
	GWindow.window
		~height:50
		~width:50
		()

let _ =
	window#connect#destroy ~callback:GMain.quit;
	window#show ();
	GMain.main ()
	
