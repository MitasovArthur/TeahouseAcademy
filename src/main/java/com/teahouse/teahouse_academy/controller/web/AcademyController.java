package com.teahouse.teahouse_academy.controller.web;

import com.teahouse.teahouse_academy.facade.DashboardFacade;
import com.teahouse.teahouse_academy.facade.KnowledgeBaseFacade;
import com.teahouse.teahouse_academy.model.dto.academy.AcademyDashboardResponseDto;
import com.teahouse.teahouse_academy.model.dto.submission.ResourceUploadForm;
import com.teahouse.teahouse_academy.model.entity.MeetingEntity;
import com.teahouse.teahouse_academy.model.entity.TeamEntity;
import com.teahouse.teahouse_academy.model.enumProject.RoleUser;
import com.teahouse.teahouse_academy.service.MeetingService;
import com.teahouse.teahouse_academy.service.SubmissionService;
import com.teahouse.teahouse_academy.service.TagService;
import com.teahouse.teahouse_academy.service.TeamService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/academy")
@RequiredArgsConstructor
public class AcademyController {

    private final KnowledgeBaseFacade knowledgeBaseFacade;
    private final DashboardFacade dashboardFacade;

    private final MeetingService meetingService;
    private final SubmissionService submissionService;
    private final TeamService teamService;
    private final TagService tagService;

    @GetMapping
    public String getAcademyPage(
            @AuthenticationPrincipal com.teahouse.teahouse_academy.security.CustomUserDetails currentUser,
            Model model) {

        Long currentUserId = currentUser.getId();
        boolean isAdmin = currentUser.getUserEntity().getRole() == RoleUser.ADMIN;

        List<AcademyDashboardResponseDto> dashboards = dashboardFacade.getDashboardData(currentUserId);

        model.addAttribute("dashboards", dashboards);
        model.addAttribute("isAdmin", isAdmin);
        model.addAttribute("allTags", tagService.getAllTags());

        return "pages/academy/academy";
    }

    @GetMapping("/submit/{meetingId}")
    public String getSubmitPage(
            @PathVariable Long meetingId,
            @AuthenticationPrincipal com.teahouse.teahouse_academy.security.CustomUserDetails currentUser,
            Model model) {

        Long currentUserId = currentUser.getId();
        boolean isAdmin = currentUser.getUserEntity().getRole() == RoleUser.ADMIN;

        MeetingEntity meeting = meetingService.getById(meetingId);

        TeamEntity userTeam = meeting.getTeams().stream()
                .filter(team -> team.getUsers().stream().anyMatch(u -> u.getId().equals(currentUserId)))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Ви не є учасником жодної команди на цьому зібранні!"));

        model.addAttribute("meeting", meeting);
        model.addAttribute("team", userTeam);
        model.addAttribute("isAdmin", isAdmin);

        return "pages/academy-submit";
    }

    @PostMapping("/submit/{meetingId}")
    public String submitWork(
            @PathVariable Long meetingId,
            @ModelAttribute ResourceUploadForm form
    ) {
        submissionService.submitWorkMulti(form.getTeamId(), form.getLinks(), form.getFiles());

        return "redirect:/academy";
    }

    @PostMapping("/submit/delete/{submissionId}")
    public String deleteSubmission(@PathVariable Long submissionId, @RequestParam Long meetingId) {
        submissionService.deleteById(submissionId);
        return "redirect:/academy/submit/" + meetingId;
    }

    @PostMapping("/admin/feedback")
    public String submitAdminFeedback(
            @RequestParam Long teamId,
            @RequestParam String feedback,
            @RequestParam String action
    ) {
        teamService.handleAdminFeedback(teamId, feedback, action);
        return "redirect:/academy";
    }

    @GetMapping("/knowledge-base")
    public String knowledgeBase(
            @RequestParam(required = false) String q,
            @RequestParam(required = false) List<String> tags,
            Model model
    ) {
        model.addAttribute("meetings", knowledgeBaseFacade.getKnowledgeBaseMeetings(q, tags));
        model.addAttribute("currentQuery", q);
        model.addAttribute("currentTags", tags != null ? tags : new ArrayList<>());
        model.addAttribute("popularTags", tagService.getAllTags());

        return "pages/knowledge-base";
    }

    @GetMapping("/knowledge-base/{id}")
    public String knowledgeBaseDetail(@PathVariable Long id, Model model) {
        model.addAttribute("meeting", knowledgeBaseFacade.getKnowledgeBaseMeetingDetail(id));
        return "pages/knowledge-base-detail";
    }
}