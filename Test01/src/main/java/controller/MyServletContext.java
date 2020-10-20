package controller;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;

@WebServlet(name = "MyServletContext" , urlPatterns = "/myServletContext")
public class MyServletContext extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //代码编写位置
        //1.获得servletContext对象   getServletConfig() 程序提供的一个配置对象(后期当做扩展讲)
        ServletContext sc1 = this.getServletConfig().getServletContext();//原始api
        ServletContext sc2 = getServletContext(); //直接获得对象

        System.out.println(sc1);
        System.out.println(sc2);
        System.out.println(sc1 == sc2);//整个项目就一个 不管获得几次 都是同一个对象

        //2. 管理项目的资源  get 获得 Real 真是 Path 路径
        //2.1 realPath 项目在本地的绝对地址
        //D:\ideaProject\web\out\artifacts\day09_servletContext_response_war_exploded\
        String realPath = sc1.getRealPath("/img/1.jpg"); //参数是拼接的地址  \
        System.out.println(realPath);

        //2.2 直接获得流文件  get获得Resource资源 AsStream 转换成流
        InputStream is = sc1.getResourceAsStream("/img/1.jpg");
        System.out.println(is);

    }
}
