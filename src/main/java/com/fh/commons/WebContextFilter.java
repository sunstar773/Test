package com.fh.commons;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class WebContextFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
              WebContext.setRequest((HttpServletRequest) servletRequest);
              try{
                  filterChain.doFilter(servletRequest,servletResponse);
              }finally {
                  WebContext.remove();
              }

    }

    @Override
    public void destroy() {

    }
}
