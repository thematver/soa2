package com.example.soafirst.service;

import com.example.soafirst.storage.entity.MusicBand;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface MusicBandService {
    Boolean deleteMusicBandById(Long id);

    List<MusicBand> getMusicBandById(Long id);

    void addMusicBand(MusicBand musicBand);

    Boolean deleteAllByParticipants(Long numberOfParticipants);

    List<MusicBand> getAllMusicBandByParticipants(Long nop);

    Long getCountOfMusicBands(Long nop);

    List<MusicBand> findAll(HttpServletRequest httpServletRequest, Integer page, Integer limit);
}
