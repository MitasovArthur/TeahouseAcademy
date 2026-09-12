package com.teahouse.teahouse_academy.controller.web;

import com.teahouse.teahouse_academy.facade.AdminAcademyFacade;
import com.teahouse.teahouse_academy.facade.LocationFacade;
import com.teahouse.teahouse_academy.facade.UserFacade;
import com.teahouse.teahouse_academy.model.dto.academy.AdminMeetingDto;
import com.teahouse.teahouse_academy.model.dto.city.CityRequestDto;
import com.teahouse.teahouse_academy.model.dto.meeting.MeetingRequestDto;
import com.teahouse.teahouse_academy.model.dto.shop.ShopRequestDto;
import com.teahouse.teahouse_academy.model.dto.submission.ResourceUploadForm;
import com.teahouse.teahouse_academy.model.dto.team.TeamManualCreateDto;
import com.teahouse.teahouse_academy.service.MeetingService;
import com.teahouse.teahouse_academy.service.TeamService;
import com.teahouse.teahouse_academy.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/academy")
@RequiredArgsConstructor
public class AdminAcademyController {

    private final AdminAcademyFacade adminAcademyFacade;

    private final UserFacade userFacade;
    private final LocationFacade locationFacade;

    private final TeamService teamService;
    private final MeetingService meetingService;
    private final UserService userService;

    @ModelAttribute("pendingCount")
    public long addPendingCountToModel() {
        return teamService.countPendingReviews();
    }

    @GetMapping
    public String getAdminAcademyPage(Model model) {
        List<AdminMeetingDto> meetings = adminAcademyFacade.getActiveMeetings();
        List<AdminMeetingDto> activeMeetings = adminAcademyFacade.getArchivedMeetings();
        model.addAttribute("activeMeetings", meetings);
        model.addAttribute("archiveMeetings", activeMeetings);

        return "pages/admin/academy";
    }

    @PostMapping("/generate-single-team/{meetingId}")
    public String generateSingleTeam(@PathVariable Long meetingId,
                                     RedirectAttributes redirectAttributes) {
        try {
            teamService.generateSingleTeamForAll(meetingId);
            redirectAttributes.addFlashAttribute("successMessage", "Команду успішно створено!");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/academy?openModal=" + meetingId;
    }

    @PostMapping("/generate-teams/{meetingId}")
    public String generateTeams(@PathVariable Long meetingId) {
        teamService.generateTeamsByShops(meetingId);
        return "redirect:/admin/academy?openModal=" + meetingId;
    }

    @PostMapping("/manual-team/{meetingId}")
    public String createManualTeam(
            @PathVariable Long meetingId,
            @RequestParam String name,
            @RequestParam(required = false) String topic,
            @RequestParam(required = false) List<Long> userIds
    ) {
        TeamManualCreateDto dto = new TeamManualCreateDto();
        dto.setName(name);
        dto.setSubtopic(topic);
        dto.setMeetingId(meetingId);
        dto.setUserIds(userIds != null ? userIds : new ArrayList<>());
        teamService.createManualTeam(dto);
        return "redirect:/admin/academy?openModal=" + meetingId;
    }

    @PostMapping("/create")
    public String createMeeting(
            @RequestParam String name,
            @RequestParam(required = false) String description,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(defaultValue = "false") Boolean isOnline
    ) {
        MeetingRequestDto requestDto = new MeetingRequestDto(name, description, date, isOnline);
        meetingService.create(requestDto);
        return "redirect:/admin/academy";
    }

    @PostMapping("/edit/{meetingId}")
    public String editMeeting(
            @PathVariable Long meetingId,
            @RequestParam String name,
            @RequestParam(required = false) String description,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(defaultValue = "false") Boolean isOnline
    ) {
        MeetingRequestDto requestDto = new MeetingRequestDto(name, description, date, isOnline);
        meetingService.update(meetingId, requestDto);
        return "redirect:/admin/academy";
    }

    @PostMapping("/edit-team/{teamId}")
    public String editTeam(
            @PathVariable Long teamId,
            @RequestParam Long meetingId,
            @RequestParam String name,
            @RequestParam(required = false) String topic,
            @RequestParam(required = false) List<Long> userIds
    ) {
        teamService.updateTeam(teamId, name, topic, userIds != null ? userIds : new ArrayList<>());
        return "redirect:/admin/academy?openModal=" + meetingId;
    }

    @PostMapping("/delete/{meetingId}")
    public String deleteMeeting(@PathVariable Long meetingId) {
        meetingService.delete(meetingId);
        return "redirect:/admin/academy";
    }

    @PostMapping("/materials/add/{meetingId}")
    public String addMaterials(
            @PathVariable Long meetingId,
            @ModelAttribute ResourceUploadForm form
    ) {
        meetingService.addMaterialsMulti(meetingId, form.getLinks(), form.getFiles());

        return "redirect:/admin/academy";
    }

    @PostMapping("/materials/delete/{resourceId}")
    public String deleteMaterial(@PathVariable Long resourceId, @RequestParam Long meetingId) {
        meetingService.deleteResource(resourceId);
        return "redirect:/admin/academy?openMaterialsModal=" + meetingId;
    }

    @PostMapping("/delete-team/{teamId}")
    public String deleteTeam(@PathVariable Long teamId, @RequestParam Long meetingId) {
        teamService.delete(teamId);
        return "redirect:/admin/academy?openModal=" + meetingId;
    }

    @PostMapping("/meetings/complete/{meetingId}")
    public String completeMeeting(
            @PathVariable Long meetingId,
            @RequestParam(required = false) List<String> tagNames
    ) {
        try {
            meetingService.completeMeeting(meetingId, tagNames);
            return "redirect:/admin/academy";
        } catch (RuntimeException e) {
            if ("pending_reviews".equals(e.getMessage())) {
                return "redirect:/admin/academy?error=pending_reviews";
            }
            throw e;
        }
    }

    @GetMapping("/users")
    public String showUsers(Model model) {
        model.addAttribute("users", userFacade.getAllUsersForAdmin());
        model.addAttribute("shops", locationFacade.getAllShopsWithStats());
        return "pages/admin/employee";
    }

    @PostMapping("/users/update/{id}")
    public String updateUser(
            @PathVariable Long id,
            @RequestParam(required = false) Long shopId,
            @RequestParam String role
    ) {
        userService.updateFromAdmin(id, shopId, role);
        return "redirect:/admin/academy/users";
    }

    @GetMapping("/shops")
    public String showShops(Model model) {
        model.addAttribute("shops", locationFacade.getAllShopsWithStats());
        model.addAttribute("cities", locationFacade.getAllCities());
        return "pages/admin/shops";
    }

    @PostMapping("/shops/create")
    public String createShop(
            @RequestParam String name,
            @RequestParam String address,
            @RequestParam Long cityId
    ) {
        locationFacade.createShop(new ShopRequestDto(name, address, cityId));
        return "redirect:/admin/academy/shops";
    }

    @PostMapping("/shops/edit/{id}")
    public String editShop(
            @PathVariable Long id,
            @RequestParam String name,
            @RequestParam String address,
            @RequestParam Long cityId
    ) {
        locationFacade.updateShop(id, new ShopRequestDto(name, address, cityId));
        return "redirect:/admin/academy/shops";
    }

    @PostMapping("/shops/delete/{id}")
    public String deleteShop(@PathVariable Long id) {
        try {
            locationFacade.deleteShop(id);
        } catch (Exception e) {
            return "redirect:/admin/academy/shops?error=active_workers";
        }
        return "redirect:/admin/academy/shops";
    }

    @PostMapping("/cities/create")
    public String createCity(@RequestParam String name) {
        locationFacade.createCity(new CityRequestDto(name));
        return "redirect:/admin/academy/shops";
    }

    @GetMapping("/verification")
    public String showVerificationPage(Model model) {
        model.addAttribute("pendingTeams", teamService.getTeamsPendingReview());
        return "pages/admin/verification";
    }

    @PostMapping("/teams/approve/{id}")
    public String approveTeamWork(@PathVariable Long id,
                                  @RequestParam(required = false) String feedback,
                                  @RequestParam String action) {
        teamService.handleAdminFeedback(id, feedback, action);
        return "redirect:/admin/academy/verification?success=approved";
    }

}