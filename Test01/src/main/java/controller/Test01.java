package controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class Test01 {
    public static void main(String[] args) {
        System.out.println("测试冲突");
        int a=10;
        int b=20;
        if(b>a){
            a=b;
        }
        System.out.println(a,b);
        HashMap<Object, Object> HashMap = new HashMap<>();
        HashMap.put("1","测试1");
        HashMap.put("2","测试2");
        HashMap.put("2","测试2");

    }
}
