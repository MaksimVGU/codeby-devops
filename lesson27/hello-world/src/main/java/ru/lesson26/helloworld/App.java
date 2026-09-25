package ru.lesson26.helloworld;

public class App {
    public static String message() {
        return "Hello " + "World".concat("!");
    }

    public static void main(String[] args) {
        System.out.println(message());
    }
}
