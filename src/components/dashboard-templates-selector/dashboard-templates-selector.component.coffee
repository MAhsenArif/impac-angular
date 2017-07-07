module = angular.module('impac.components.dashboard-templates-selector', [])
module.component('dashboardTemplatesSelector', {
  templateUrl: 'dashboard-templates-selector/dashboard-templates-selector.tmpl.html'
  bindings:
    onSelect: '&'
  controller: (toastr, ImpacDhbTemplatesSvc)->
    ctrl = this

    ctrl.$onInit = ->
      ctrl.templates = []
      ctrl.selectedTemplate = {}
      ImpacDhbTemplatesSvc.index().then(
        (templates)->
          ctrl.templates = templates
        ->
          toastr.error('Failed to retrieve dashboard templates', 'Error')
      )

    ctrl.hasTemplates = ->
      ctrl.templates.length

    ctrl.templateOnClick = (template)->
      ctrl.selectedTemplate = if ctrl.isSelected(template) then {} else template
      ctrl.onSelect($event: { template: angular.copy(ctrl.selectedTemplate) })

    ctrl.isSelected = (template)->
      _.isEqual(template, ctrl.selectedTemplate)

    return ctrl
})
