package com.teahouse.teahouse_academy.service.impl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.teahouse.teahouse_academy.service.StorageService;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
@Profile("dev")
public class CloudinaryStorageService implements StorageService {

    private Cloudinary cloudinary;

    @Value("${cloudinary.cloud-name}")
    private String cloudName;

    @Value("${cloudinary.api-key}")
    private String apiKey;

    @Value("${cloudinary.api-secret}")
    private String apiSecret;

    @Value("${cloudinary.max-file-size-mb:100}")
    private int maxFileSizeMb;

    @PostConstruct
    public void init() {
        if (cloudName == null || apiKey == null || apiSecret == null) {
            throw new IllegalStateException("Cloudinary credentials are not configured properly.");
        }

        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key", apiKey,
                "api_secret", apiSecret,
                "secure", true
        ));
    }

    @Override
    public UploadResult uploadFile(MultipartFile file, String folder) {
        validateFile(file);
        try {
            String safeName = sanitizeFileName(file.getOriginalFilename());

            Map<?, ?> uploadResult = cloudinary.uploader().upload(file.getBytes(),
                    ObjectUtils.asMap(
                            "folder", folder,
                            "resource_type", "auto",
                            "public_id", safeName
                    ));

            return new UploadResult(
                    uploadResult.get("public_id").toString(),
                    uploadResult.get("secure_url").toString()
            );
        } catch (IOException e) {
            throw new IllegalStateException("Error loading file in Cloudinary", e);
        }
    }

    @Override
    public void deleteFile(String fileKey) {
        try {
            cloudinary.uploader().destroy(fileKey, ObjectUtils.emptyMap());
        } catch (IOException e) {
            throw new IllegalStateException("Error deleting file from Cloudinary", e);
        }
    }

    private void validateFile(MultipartFile file) {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("File is empty");
        }

        String contentType = file.getContentType();
        if (contentType == null) {
            throw new IllegalArgumentException("Unable to determine file type");
        }
        List<String> allowedTypes = List.of(
                "image/jpeg",
                "image/png",
                "application/pdf",
                "application/msword",
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                "application/vnd.ms-powerpoint",
                "application/vnd.openxmlformats-officedocument.presentationml.presentation",
                "video/mp4",
                "video/quicktime"
        );

        if (!allowedTypes.contains(contentType)) {
            throw new IllegalArgumentException("Invalid file type: " + contentType);
        }

        long maxSize = maxFileSizeMb * 1024L * 1024L;
        if (file.getSize() > maxSize) {
            throw new IllegalArgumentException(
                    "The file size exceeds the limit of " + maxFileSizeMb + " MB. Minify the file before uploading."
            );
        }
    }

    private String sanitizeFileName(String originalName) {
        if (originalName == null || originalName.isBlank()) {
            return "file_" + System.currentTimeMillis();
        }

        int dotIndex = originalName.lastIndexOf(".");
        String nameWithoutExtension = dotIndex > 0 ? originalName.substring(0, dotIndex) : originalName;
        String safeName = nameWithoutExtension.replaceAll("[^\\p{L}\\p{N}_\\-]", "_");

        return safeName + "_" + System.currentTimeMillis();
    }
}