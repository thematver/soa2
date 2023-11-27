package com.example.soafirst.storage.repo;

import com.example.soafirst.storage.entity.MusicBand;
import com.example.soafirst.storage.entity.MusicGenre;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface MusicBandRepository extends JpaRepository<MusicBand, Long> {
    List<MusicBand> findAllById(Long id);

    Boolean existsByNumberOfParticipants(Long numberOfParticipants);

    void deleteAllByNumberOfParticipants(Long numberOfParticipants);

    List<MusicBand> findAllByNumberOfParticipants(Long numberOfParticipants);

    Long countMusicBandByNumberOfParticipants(Long numberOfParticipants);
}
