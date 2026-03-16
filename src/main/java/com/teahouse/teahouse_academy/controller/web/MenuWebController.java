package com.teahouse.teahouse_academy.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MenuWebController {

    @GetMapping("/")
    public String showMenu(){
        return"pages/menu";
    }

    @GetMapping("/contacts")
    public String showContacts() {
        return "pages/contacts";
    }

}
