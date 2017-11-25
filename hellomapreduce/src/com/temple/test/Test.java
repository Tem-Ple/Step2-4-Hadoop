package com.temple.test;

public class Test {
    public static void main(String[] args) {
        String str = "asdf qwefqw  qwregre  q qwe";
        String[] arr = str.split("\\s+");
        for (String i : arr) {
            System.out.println(i);
        }
    }
}
