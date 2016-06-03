library('editR')

# Set the default command line invocation of the Chrome browser
# options("google.chrome.command", "google-chrome")

# launch.browser

 mod.editR <- function(file = NULL, port = NULL, chrome.app.mode = FALSE) {
   require(tools)
   require(shiny)

   if (is.null(file)) {
     assign("md_name", NULL, envir=globalenv())
     assign("md_path", NULL, envir=globalenv())
   } else {
     ext <- tolower(file_ext(file))
     if (ext != "md" & ext != "rmd") 
       stop("'file' is not a .Rmd or .md file.")
     
     file <- suppressWarnings(normalizePath(file))
     
     md_name <- basename(file)
     md_path <- dirname(file)
     assign("md_name", md_name, envir=globalenv())
     assign("md_path", md_path, envir=globalenv())
   }
   
   app_path <- paste0(find.package("editR"), "/app")

   if (.Platform$OS.type == "windows") {

     if(!is.null(port)){
       runApp(app_path, port = port, launch.browser = TRUE)
     }else{
       runApp(app_path, launch.browser = TRUE)
     }
   } else if (.Platform$OS.type == "unix" && chrome.app.mode) {

      chrome.command <- getOption("google.chrome.command", "google-chrome")

      # copied from the runApp function
      require('shiny')
       if (is.null(port)) {
           for (i in 1:20) {
               if (!is.null(shiny:::.globals$lastPort)) {
                   port <- shiny:::.globals$lastPort
                   shiny:::.globals$lastPort <- NULL
               }
               else {
                   port <- sample(3000:8000, 1)
                   # random integer between 3000 and 8000, as done by runApp
               }
               tmp <- try(startServer(host, port, list()), silent = TRUE)
               if (!inherits(tmp, "try-error")) {
                   stopServer(tmp)
                   shiny:::.globals$lastPort <- port
                   break
               }
           }
       }

      # set period of time to pause before opening window
      # to allow Shiny server to start - awkward requirement
      # due to shiny:::.globals scoping as far as I can tell
      delay.duration <- 0.2

     # http://superuser.com/questions/33548/starting-google-chrome-in-application-mode
     if(!is.null(port)){
       # function myfunc () { sleep 1; echo "slept"; } ; myfunc
       system(paste0('sleep ', delay.duration,'; ', chrome.command, ' --app=http://localhost:', port), wait = FALSE)
       runApp(app_path, port = port, launch.browser = FALSE)
     } else {
       stop("Error: could not set Shiny server port to enter Chrome 'kiosk' mode, please specify a port...")
     }     
   } else {
     if(!is.null(port)){
       print("noooo")
       runApp(app_path, port = port)
     }else{
       print("hello")
       runApp(app_path)
     }
   }
   
 }

mod.editR(file = commandArgs(TRUE)[1], chrome.app.mode = TRUE)
