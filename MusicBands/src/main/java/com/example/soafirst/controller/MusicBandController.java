package com.example.soafirst.controller;

import com.example.soafirst.service.MusicBandService;
import com.example.soafirst.storage.entity.Coordinates;
import com.example.soafirst.storage.entity.MusicBand;
import com.example.soafirst.storage.entity.Studio;
import com.example.soafirst.storage.entity.request.MusicBandRequestDTO;
import com.example.soafirst.storage.entity.response.CountResponseDTO;
import com.example.soafirst.storage.entity.response.Error;
import com.example.soafirst.storage.entity.response.MusicBandResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/musicbands")
public class MusicBandController {
    @Autowired
    MusicBandService musicBandService;

    @GetMapping("")
    public ResponseEntity<?> getMusicBands(@RequestParam(required = false) String filterBy, @RequestParam(required = false) String filterValue) {
        List<MusicBand> musicBandList = musicBandService.getAllMusicBands(filterBy, filterValue);

        if (musicBandList.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Error.builder()
                            .message("No MusicBands are here.")
                            .code(String.valueOf(HttpStatus.NOT_FOUND.value()))
                            .build());
        }



        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(musicBandList);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getMusicBandById(@PathVariable Long id) {
        List<MusicBand> musicBandList = musicBandService.getMusicBandById(id);
        if (musicBandList.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Error.builder()
                            .message("MusicBand with id = " + id + " does not exist.")
                            .code(String.valueOf(HttpStatus.NOT_FOUND.value()))
                            .build());
        }

        MusicBand musicBand = musicBandList.get(0);
        MusicBandResponseDTO musicBandResponseDTO = new MusicBandResponseDTO();

        toDTO(musicBand, musicBandResponseDTO);

        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(musicBandResponseDTO);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteMusicBandById(@PathVariable Long id) {
        Boolean result = musicBandService.deleteMusicBandById(id);
        if (!result) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Error.builder()
                            .message("MusicBand with id = " + id + " does not exist.")
                            .code(String.valueOf(HttpStatus.NOT_FOUND.value()))
                            .build());
        }

        return ResponseEntity.ok("MusicBand with id = " + id + " was successfully deleted.");
    }

    @PostMapping
    public ResponseEntity<?> addMusicBand(@Valid @RequestBody MusicBandRequestDTO musicBandRequestDTO) {
        MusicBand musicBand = new MusicBand();

        musicBand.setCreationDate(LocalDateTime.now());

        musicBandService.addMusicBand(fromDTO(musicBand, musicBandRequestDTO));

        MusicBandResponseDTO musicBandResponseDTO = new MusicBandResponseDTO();

        toDTO(musicBand, musicBandResponseDTO);

        return ResponseEntity.ok(musicBandResponseDTO);
    }

    @DeleteMapping("/filter")
    public ResponseEntity<?> deleteAllMusicBandsByNumberOfParticipants(@RequestParam Long numberOfParticipants) {
        Boolean result = musicBandService.deleteAllByParticipants(numberOfParticipants);
        if (!result) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Error.builder()
                            .message("MusicBand with numberOfParticipants = " + numberOfParticipants + " does not exist.")
                            .code(String.valueOf(HttpStatus.NOT_FOUND.value()))
                            .build());
        }

        return ResponseEntity.ok("All musicBands were successfully deleted");
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateMusicBandById(@PathVariable Long id, @RequestBody MusicBandRequestDTO musicBandRequestDTO) {
        List<MusicBand> musicBandList = musicBandService.getMusicBandById(id);
        if (musicBandList.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Error.builder()
                            .message("MusicBand with id = " + id + " does not exist.")
                            .code(String.valueOf(HttpStatus.NOT_FOUND.value()))
                            .build());
        }

        MusicBand musicBand = musicBandList.get(0);

        musicBandService.updateMusicBand(fromDTO(musicBand, musicBandRequestDTO));

        MusicBandResponseDTO musicBandResponseDTO = new MusicBandResponseDTO();
        toDTO(musicBand, musicBandResponseDTO);

        return ResponseEntity.ok(musicBandResponseDTO);
    }

    @DeleteMapping("/filter/first")
    public ResponseEntity<?> deleteFirstByParticipants(@RequestParam Long numberOfParticipants) {
        List<MusicBand> musicBandList = musicBandService.getAllMusicBandByParticipants(numberOfParticipants);
        if (musicBandList.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Error.builder()
                            .message("MusicBand with numberOfParticipants = " + numberOfParticipants + " does not exist.")
                            .code(String.valueOf(HttpStatus.NOT_FOUND.value()))
                            .build());
        }

        musicBandService.deleteMusicBandById(musicBandList.get(0).getId());
        return ResponseEntity.ok("MusicBand was deleted successfully");
    }

    @GetMapping("/count")
    public ResponseEntity<?> countMusicBand(@RequestParam Long numberOfParticipants) {
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(new CountResponseDTO(musicBandService.getCountOfMusicBands(numberOfParticipants)));
    }

    private MusicBand fromDTO(MusicBand musicBand, MusicBandRequestDTO musicBandRequestDTO) {

        musicBand.setName(musicBandRequestDTO.getName());

        Coordinates coordinates = new Coordinates();
        coordinates.setX(musicBandRequestDTO.getCoordinates().getX());
        coordinates.setY(musicBandRequestDTO.getCoordinates().getY());
        musicBand.setCoordinates(coordinates);

        musicBand.setNumberOfParticipants(musicBandRequestDTO.getNumberOfParticipants());
        musicBand.setGenre(musicBandRequestDTO.getGenre());

        Studio studio = new Studio();
        if (musicBandRequestDTO.getStudio().getName() != null) {
            studio.setName(musicBandRequestDTO.getStudio().getName());
        }
        musicBand.setStudio(studio);
        musicBand.setNominatedToGrammy(musicBandRequestDTO.isNominatedToGrammy());
        return musicBand;
    }

    private void toDTO(MusicBand musicBand, MusicBandResponseDTO musicBandResponseDTO) {
        musicBandResponseDTO.setId(musicBand.getId());
        musicBandResponseDTO.setName(musicBand.getName());

        MusicBandResponseDTO.CoordinatesResponsesDTO coordinatesResponsesDTO = new MusicBandResponseDTO.CoordinatesResponsesDTO();
        coordinatesResponsesDTO.setX(musicBand.getCoordinates().getX());
        coordinatesResponsesDTO.setY(musicBand.getCoordinates().getY());
        musicBandResponseDTO.setCoordinates(coordinatesResponsesDTO);

        musicBandResponseDTO.setCreationDate(musicBand.getCreationDate());
        musicBandResponseDTO.setNumberOfParticipants(musicBand.getNumberOfParticipants());
        musicBandResponseDTO.setGenre(musicBand.getGenre());
        musicBandResponseDTO.setNominatedToGrammy(musicBand.isNominatedToGrammy());

        MusicBandResponseDTO.StudioResponseDTO studioResponseDTO = new MusicBandResponseDTO.StudioResponseDTO();
        studioResponseDTO.setName(musicBand.getStudio().getName());
        musicBandResponseDTO.setStudio(studioResponseDTO);
    }
}
