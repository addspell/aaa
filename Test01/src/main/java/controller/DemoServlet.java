package controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet( name = "xxx" ,urlPatterns = "/demo1")
public class DemoServlet implements Servlet {

    /**
     *  该方法  servlet的入口方法
     * 对方法的描述
     * @parameter 参数 servletRequest
     * @param servletResponse
     * @throws ServletException 抛出的异常
     * @throws IOException
     */
    @Override
    public void service(ServletRequest servletRequest, ServletResponse servletResponse) throws ServletException, IOException {
        System.out.println("2.5的servlet执行了");
        System.out.println("3.0后的注解形式开发");
    }


    @Override
    public void init(ServletConfig servletConfig) throws ServletException {

    }

    @Override
    public ServletConfig getServletConfig() {
        return null;
    }



    @Override
    public String getServletInfo() {
        return null;
    }

    @Override
    public void destroy() {

    }
}
