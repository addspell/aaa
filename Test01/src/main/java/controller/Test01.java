package controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Test01 {
    public static void main(String[] args) {
        System.out.println("第一次传输");
        Integer[] myArray = {1, 2, 3};
        List myList = Arrays.asList(myArray);
        ArrayList list = new ArrayList<>(myList);
        list.add(4);
        System.out.println(list);

    }
}
