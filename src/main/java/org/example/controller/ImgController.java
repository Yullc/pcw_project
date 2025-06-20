package org.example.controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.example.service.MemberService;
import org.example.vo.Rq;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class ImgController {

    private final Cloudinary cloudinary;
    private final MemberService memberService;

    @PostMapping("/usr/home/uploadProfileImg")
    @ResponseBody
    public String uploadProfileImg(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        try {
            Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
            String imageUrl = (String) uploadResult.get("secure_url");

            // 로그인된 사용자 ID 가져오기
            Rq rq = (Rq) request.getAttribute("rq");
            int memberId = rq.getLoginedMemberId();

            // DB에 프로필 이미지 URL 저장
            memberService.updateProfileImg(memberId, imageUrl);

            return imageUrl;

        } catch (IOException e) {
            e.printStackTrace();
            return "업로드 실패: " + e.getMessage();
        }
    }
}
