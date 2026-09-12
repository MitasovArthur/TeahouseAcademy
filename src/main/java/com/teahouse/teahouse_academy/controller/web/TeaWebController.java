package com.teahouse.teahouse_academy.controller.web;

import com.teahouse.teahouse_academy.facade.TeaFacade;
import com.teahouse.teahouse_academy.model.dto.tea.TeaDto;
import com.teahouse.teahouse_academy.model.dto.tea.TeaRequestDto;
import com.teahouse.teahouse_academy.model.enumProject.TypeTea;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/teas")
public class TeaWebController {

    private final TeaFacade teaFacade;

    @GetMapping
    public String showTeaNavigator(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String type,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Model model) {

        Page<TeaDto> teaPage = teaFacade.search(search, type, PageRequest.of(page, Math.min(size, 50)));

        model.addAttribute("teas", teaPage.getContent());
        model.addAttribute("searchQuery", search == null ? "" : search);
        model.addAttribute("selectedType", type == null ? "" : type);
        model.addAttribute("teaTypes", List.of(TypeTea.values()));
        model.addAttribute("groupedComponents", teaFacade.getComponentsDictionary());
        model.addAttribute("groupedCountries", teaFacade.getRegionsDictionary());
        model.addAttribute("isAdmin", true);

        return "pages/common/teas";
    }

    private void addFormAttributes(Model model) {
        model.addAttribute("teaTypes", List.of(TypeTea.values()));
        model.addAttribute("components", teaFacade.getComponents());
        model.addAttribute("countries", teaFacade.getCountries());
        model.addAttribute("regions", teaFacade.getRegions());
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("teaForm", new TeaRequestDto());
        addFormAttributes(model);
        return "pages/admin/tea-form";
    }

    @PostMapping("/new")
    public String createTea(
            @Valid @ModelAttribute("teaForm") TeaRequestDto request,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {
            addFormAttributes(model);
            return "pages/tea-form";
        }

        try {
            teaFacade.createNewTea(request);
            return "redirect:/teas";
        } catch (IllegalArgumentException e) {
            model.addAttribute("codeTeaError", "Чай з таким кодом вже існує");
            addFormAttributes(model);
            return "pages/admin/tea-form";
        }
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        model.addAttribute("teaForm", teaFacade.getRequestDtoById(id));
        model.addAttribute("teaId", id);
        addFormAttributes(model);
        return "pages/admin/tea-form";
    }

    @PostMapping("/{id}/edit")
    public String updateTea(
            @PathVariable Long id,
            @Valid @ModelAttribute("teaForm") TeaRequestDto request,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("teaId", id);
            addFormAttributes(model);
            return "pages/admin/tea-form";
        }

        teaFacade.updateTea(id, request);
        return "redirect:/teas";
    }

    @PostMapping("/{id}/delete")
    public String deleteTea(@PathVariable Long id) {
        teaFacade.deleteTea(id);
        return "redirect:/teas";
    }
}