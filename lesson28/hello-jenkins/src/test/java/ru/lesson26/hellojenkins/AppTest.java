package ru.lesson26.hellojenkins;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class AppTest {
    @Test
    void messageReturnsExpectedText() {
        assertEquals("Hello Jenkins!", App.message());
    }
}
