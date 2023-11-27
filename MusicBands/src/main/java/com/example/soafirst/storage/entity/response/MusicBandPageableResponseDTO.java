package com.example.soafirst.storage.entity.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor(staticName = "of")
@NoArgsConstructor
public class MusicBandPageableResponseDTO {
    List<MusicBandResponseDTO> musicBandResponseDTOList;
    Integer pageNumber;
}
