package com.example.soafirst.storage.entity.request;

import com.example.soafirst.storage.entity.MusicGenre;
import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
@Data
public class MusicBandRequestDTO {
    @NotBlank
    private String name;
    @NotNull
    private CoordinatesRequestDTO coordinates;
    @NotNull
    @Min(value = 0, message = "NumberOfParticipants should be greater than 0")
    private Long numberOfParticipants;
    private MusicGenre musicGenre;
    @NotNull
    private StudioRequestDTO studio;


    private boolean nominatedToGrammy;

    @Data
    public static class CoordinatesRequestDTO {
        @NotNull
        @Max(value = 471, message = "X coordinate should be less than 471")
        private Float x;
        @NotNull
        @Min(value = -299, message = "Y coordinate should be greater than -299")
        private Long y;
    }

    @Data
    public static class StudioRequestDTO {
        private String name;
    }
}
