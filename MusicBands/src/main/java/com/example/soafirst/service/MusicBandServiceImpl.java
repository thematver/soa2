package com.example.soafirst.service;

import com.example.soafirst.storage.entity.MusicBand;
import com.example.soafirst.storage.entity.MusicGenre;
import com.example.soafirst.storage.entity.Studio;
import com.example.soafirst.storage.repo.MusicBandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Service
public class MusicBandServiceImpl implements MusicBandService{
    @Autowired
    private MusicBandRepository musicBandRepository;

    @Override
    public Boolean deleteMusicBandById(Long id) {
        if (musicBandRepository.existsById(id)) {
            musicBandRepository.deleteById(id);
            return true;
        }
        return false;
    }

    @Override
    public List<MusicBand> getMusicBandById(Long id) {
        return musicBandRepository.findAllById(id);
    }

    @Override
    public void addMusicBand(MusicBand musicBand) {
        musicBandRepository.save(musicBand);
    }

    @Override
    public List<MusicBand> getAllMusicBands(String filterBy, String filterValue) {
        if (filterBy != null && filterValue != null) {
            switch (filterBy) {
                case "name":
                    return musicBandRepository.findAllByName(filterValue);
                case "genre":
                    return musicBandRepository.findAllByGenre(MusicGenre.valueOf(filterValue));
                case "studio":
                    return musicBandRepository.findAllByStudio(Studio.builder().name(filterValue).build());

            }
        }
        return musicBandRepository.findAll();
    }

    @Override
    public List<MusicBand> getAllMusicBands() {
        return musicBandRepository.findAll();
    }

    @Override
    @Transactional
    public Boolean deleteAllByParticipants(Long numberOfParticipants) {
        if (musicBandRepository.existsByNumberOfParticipants(numberOfParticipants)) {
            musicBandRepository.deleteAllByNumberOfParticipants(numberOfParticipants);
            return true;
        }

        return false;
    }

    @Override
    public List<MusicBand> getAllMusicBandByParticipants(Long nop) {
        return musicBandRepository.findAllByNumberOfParticipants(nop);
    }

    @Override
    public Long getCountOfMusicBands(Long nop) {
        return musicBandRepository.countMusicBandByNumberOfParticipants(nop);
    }

    @Override
    public void updateMusicBand(MusicBand band) {
        if (musicBandRepository.existsById(band.getId())) {
            musicBandRepository.save(band);
        } else {
            throw new IllegalArgumentException("MusicBand with id " + band.getId() + " does not exist");
        }
    }
}
