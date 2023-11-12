package com.example.soafirst.storage.repo;

import com.example.soafirst.storage.entity.Coordinates;
import com.example.soafirst.storage.entity.MusicBand;
import com.example.soafirst.storage.entity.MusicGenre;
import com.example.soafirst.storage.entity.Studio;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MusicBandRepository extends JpaRepository<MusicBand, Long> {
    List<MusicBand> findAllById(Long id);

    Boolean existsByNumberOfParticipants(Long numberOfParticipants);

    void deleteAllByNumberOfParticipants(Long numberOfParticipants);

    List<MusicBand> findAllByNumberOfParticipants(Long numberOfParticipants);

    Long countMusicBandByNumberOfParticipants(Long numberOfParticipants);

    List<MusicBand> findAllByGenre(MusicGenre genre);


    List<MusicBand> findAllByCoordinates(Coordinates coordinates);

    List<MusicBand> findAllByStudio(Studio studio);

    List<MusicBand> findAllByName(String name);
}
