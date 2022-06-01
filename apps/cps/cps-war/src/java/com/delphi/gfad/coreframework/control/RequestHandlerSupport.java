
package com.delphi.gfad.coreframework.control;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;


/**
 * This class is the default implementation of the RequestHandler
 *
*/
public abstract class RequestHandlerSupport implements RequestHandler {

    protected ServletContext context;

    public void setServletContext(ServletContext context) {
        this.context  = context;
    }

    public void doStart(HttpServletRequest request){}
    public void doEnd(HttpServletRequest request){}
    public abstract void processRequest(HttpServletRequest request) throws java.lang.Exception;
}
