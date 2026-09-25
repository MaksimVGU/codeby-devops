package ru.lesson26.helloworld;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class AppTest {
    @Test
    void messageReturnsExpectedText() {
        assertEquals("Hello World!", App.message());
    }
}
