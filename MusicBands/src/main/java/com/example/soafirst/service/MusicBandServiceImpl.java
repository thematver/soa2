package com.example.soafirst.service;

import com.example.soafirst.storage.entity.MusicBand;
import com.example.soafirst.storage.repo.MusicBandPageableRepository;
import com.example.soafirst.storage.repo.MusicBandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class MusicBandServiceImpl implements MusicBandService{
    @Autowired
    private MusicBandRepository musicBandRepository;

    @Autowired
    private MusicBandPageableRepository musicBandPageableRepository;

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
    public List<MusicBand> findAll(HttpServletRequest httpServletRequest, Integer page, Integer limit) {
        HashMap<String, String> fields = new HashMap<>();
        if (httpServletRequest.getParameter("id") != null) {
            fields.put("id", httpServletRequest.getParameter("id"));
        }
        if (httpServletRequest.getParameter("name") != null) {
            fields.put("name", httpServletRequest.getParameter("name"));
        }
        if (httpServletRequest.getParameter("x") != null) {
            fields.put("x", httpServletRequest.getParameter("x"));
        }
        if (httpServletRequest.getParameter("y") != null) {
            fields.put("y", httpServletRequest.getParameter("y"));
        }
        if (httpServletRequest.getParameter("creationDate") != null) {
            fields.put("creationDate", httpServletRequest.getParameter("creationDate"));
        }
        if (httpServletRequest.getParameter("numberOfParticipants") != null) {
            fields.put("numberOfParticipants", httpServletRequest.getParameter("numberOfParticipants"));
        }
        if (httpServletRequest.getParameter("musicGenre") != null) {
            fields.put("musicGenre", httpServletRequest.getParameter("musicGenre"));
        }
        if (httpServletRequest.getParameter("studio") != null) {
            fields.put("studio", httpServletRequest.getParameter("studio"));
        }
        List<MusicBand> musicBandList;

        if (httpServletRequest.getParameter("sortParam") == null) {
            musicBandList = musicBandPageableRepository.getAllFilterPageable(fields, page, limit);
        }
        else {
            musicBandList = musicBandPageableRepository.getAllFilterSortedPageable(fields, page, limit, httpServletRequest.getParameter("sortParam"), httpServletRequest.getParameter("direction"));
        }
        return musicBandList;
    }
}
