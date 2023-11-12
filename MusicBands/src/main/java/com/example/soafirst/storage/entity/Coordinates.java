package com.example.soafirst.storage.entity;

import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "coordinates", schema = "public")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Coordinates {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    @Column
    @NotNull
    @Max(value = 471, message = "X coordinate should be less than 471")
    private Float x;

    @Column
    @NotNull
    @Min(value = -299, message = "Y coordinate should be greater than -299")
    private Long y;
}
