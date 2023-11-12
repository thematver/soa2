package xyz.anomatver.grammy;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Coordinates {
    private Long id;
    private double x;
    private int y;

    // getters and setters for each field
}