package com.example.soafirst.service;

import com.example.soafirst.storage.entity.MusicBand;

import java.util.List;

public interface MusicBandService {
    Boolean deleteMusicBandById(Long id);

    List<MusicBand> getMusicBandById(Long id);

    void addMusicBand(MusicBand musicBand);

    List<MusicBand> getAllMusicBands(String filterBy, String filterValue);
    List<MusicBand> getAllMusicBands();

    Boolean deleteAllByParticipants(Long numberOfParticipants);

    List<MusicBand> getAllMusicBandByParticipants(Long nop);

    Long getCountOfMusicBands(Long nop);

    void updateMusicBand(MusicBand band);


}
