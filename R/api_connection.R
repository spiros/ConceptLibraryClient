#' getLogin
#'
#' This function pops up a login box for username and password, with masking of the password field. It returns a vector
#' where the first item is the username and the second is the password. Clear this as soon as it is used, to avoid
#' password existing in your environment.
#'
#' This can be used for any purpose. If you want to connect to SAIL, try SAILConnect instead, which
#' uses this function and also connects to PR_SAIL and returns a database connection.
#'
#' Note that the login box may appear behind your active window.
#' @param userName A user name (optional). If provided, the login box will be prepopulated with this user name.
#' @keywords SAILDBUtils
#' @export
#' @examples details = getLogin();

getLogin<-function(userName="") {
	wnd<-tktoplevel()
	tkraise(wnd)

	tclVar(userName)->user
	tclVar("")->passVar

	#Username box
	tkgrid(tklabel(wnd,text="Username:"))
	tkgrid(tkentry(wnd,textvariable=user)->passBox)
	#Password box
	tkgrid(tklabel(wnd,text="Password:"))
	tkgrid(tkentry(wnd,textvariable=passVar,show="*")->passBox)

	#Hitting return will also submit password
	tkbind(passBox,"<Return>",function() tkdestroy(wnd))
	#OK button
	tkgrid(tkbutton(wnd,text="OK",command=function() tkdestroy(wnd)))

	#Wait for user to click OK
	tkwait.window(wnd)
	password<-tclvalue(passVar)
	userName<-tclvalue(user)

	return(c(userName,password))
}

#' connect_to_API
#'
#' This function creates a crul::HttpClient object from a url and optionally a user and password. If the user or
#' password are not provided and public is set to FALSE, then a login box is created to enter this information.
#'
#' @param user A username (optional)
#' @param password The user's password (optional)
#' @param url The URL to connect to (optional). Defaults to main Concept Library website.
#' @param public When TRUE connects to the public API (authentication not required). When set to FALSE, a username and
#' password are required to connect to the authenticated API. Default is TRUE.
#'
#' @return crul::HttpClient
#' @export
#'
connect_to_API <- function(user=NA, password=NA, url=API_URL, public=TRUE) {
  api_client = NA

  # Connect to authenticated API
  if (isFALSE(public) || !is.na(user)) {
    # Show login box if username or password not provided
    if (is.na(user) || is.na(password)) {
      message("Please log in to the Concept Library. Please note: The login window may sometimes appear behind other
              windows")
      details=getLogin(userName=user)
      user=details[1]
      password=details[2]
    }
    # Create HttpClient object
    api_client = crul::HttpClient$new(url, auth=crul::auth(user=user, pwd=password))
  }
  # Connect to public API
  else {
    # Create HttpClient object
    api_client = crul::HttpClient$new(url)
  }

  return(api_client)
}

#' check_HTTP_response
#'
#' If the response status code is not 200, this function will stop execution and print the HTTP status that
#' was returned from the request.
#'
#' If the status code is 200, the function will not return anything.
#'
#' @param response the crul::HTTPResponse object to check
#'
check_HTTP_response <- function(response) {
  if (response$status_code != 200 && response$status_code != 201) {
    warning(jsonlite::fromJSON(response$parse('utf-8')))
    stop(paste(response$status_http(),collapse=' '));
  }
}
