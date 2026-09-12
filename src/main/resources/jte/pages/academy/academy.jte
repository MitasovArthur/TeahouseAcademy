@import com.teahouse.teahouse_academy.model.dto.academy.AcademyDashboardResponseDto
@import com.teahouse.teahouse_academy.model.entity.TagEntity

@param java.util.List<AcademyDashboardResponseDto> dashboards
@param java.util.List<TagEntity> allTags
@param Boolean isAdmin = false

@if(isAdmin)
    @template.pages.academy.academy-admin(dashboards = dashboards, allTags = allTags)
@else
    @template.pages.academy.academy-user(dashboards = dashboards)
@endif