package com.example.soafirst.storage.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.ws.rs.DefaultValue;
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
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime creationDate;

    @Column(name = "number_of_participants")
    @Min(value = 0, message = "NumberOfParticipants should be greater than 0")
    private Long numberOfParticipants;

    @Column(name = "music_genre")
    @Enumerated(EnumType.STRING)
    private MusicGenre genre;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "studio_id", referencedColumnName = "id", nullable = false)
    @NotNull
    private Studio studio;

    @Column(name = "is_nominated_to_grammy")
    @NotNull
    @ColumnDefault("false")
    private boolean isNominatedToGrammy;
}
