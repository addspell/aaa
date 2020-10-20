package controller;

public class Test01 {
    public static void main(String[] args) {
        System.out.println("测试冲突");
        int a=10;
        int b=20;
        if(b>a){
            a=b;
        }
        System.out.println(a,b);
    }
}
