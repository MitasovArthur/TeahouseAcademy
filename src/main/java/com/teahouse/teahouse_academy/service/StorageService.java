package com.teahouse.teahouse_academy.service;

import org.springframework.web.multipart.MultipartFile;

public interface StorageService {

    UploadResult uploadFile(MultipartFile file, String folder);

    void deleteFile(String fileKey);

    record UploadResult(String fileKey, String url) {}

}