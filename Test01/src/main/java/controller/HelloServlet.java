package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "HelloServlet"  , urlPatterns = "/hello")
public class HelloServlet extends HttpServlet {
    //service每次执行的方法

    /**
     * 放置post请求代码 , 只要没有特殊说明的都是get请求
     * (目前而言学过post请求  表单 method="post" 或者 $.post ajax提交的时候 进入post)
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    /**
     * 放置get请求代码
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


    //子类没写service代码 使用父类  执行过程中  子类代码 跟父类代码一抹一样(将父类代码copy一份放在自己的内部)
    /*@Override
    public void destroy() {
        //编写自己的代码即可
    }*/



}
