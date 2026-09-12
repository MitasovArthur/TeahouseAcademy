package com.teahouse.teahouse_academy.controller.web;

import com.teahouse.teahouse_academy.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class MenuWebController {

    private final UserService userService;

    @GetMapping("/")
    public String showMenu(Model model){
        Long currentUserId = 1L;

        boolean isAdmin = userService.getById(currentUserId).getRole() == com.teahouse.teahouse_academy.model.enumProject.RoleUser.ADMIN;
        model.addAttribute("isAdmin", isAdmin);

        return "pages/common/menu";
    }

    @GetMapping("/contacts")
    public String showContacts(Model model) {
        Long currentUserId = 1L;

        boolean isAdmin = userService.getById(currentUserId).getRole() == com.teahouse.teahouse_academy.model.enumProject.RoleUser.ADMIN;
        model.addAttribute("isAdmin", isAdmin);

        return "pages/common/contacts";
    }
}