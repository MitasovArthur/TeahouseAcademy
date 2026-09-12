package com.teahouse.teahouse_academy.model.dto.submission;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
public class ResourceUploadForm {
    private Long teamId;
    private List<LinkDto> links;
    private List<MultipartFile> files;
}
