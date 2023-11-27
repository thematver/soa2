package com.example.soafirst.storage.entity;

import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Entity
@Table(name = "music_band", schema = "public")
@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MusicBand {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    @Column
    @NotBlank
    private String name;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "coordinates_id", referencedColumnName = "id", nullable = false)
    @NotNull
    private Coordinates coordinates;

    @Column(name = "creation_date")
    @NotNull
    private LocalDateTime creationDate;

    @Column(name = "number_of_participants")
    @Min(value = 0, message = "NumberOfParticipants should be greater than 0")
    private Long numberOfParticipants;

    @Column(name = "music_genre")
    @Enumerated(EnumType.STRING)
    private MusicGenre musicGenre;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "studio_id", referencedColumnName = "id", nullable = false)
    @NotNull
    private Studio studio;
}
