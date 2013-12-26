package org.k33g;

import java.lang.Override;
import java.lang.String;
import java.lang.System;

public class Human {
  public String firstName="John";
  public String lastName="Doe";

  public Human(String firstName, String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }

  public Human() {
    System.out.println("=== Human Constructor ===");
  }

  @Override
  public String toString() {
    return "Human{" +
            "firstName=" + firstName +
            ", lastName=" + lastName +
            '}';
  }
}