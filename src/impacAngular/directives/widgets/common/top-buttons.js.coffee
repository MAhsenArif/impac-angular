module = angular.module('maestrano.analytics.widgets-common.top-buttons',['maestrano.assets'])

module.controller('CommonTopButtonsCtrl',
  ['$scope', '$rootScope', 'DhbAnalyticsSvc', 'AssetPath', 'TemplatePath',
  ($scope, $rootScope, DhbAnalyticsSvc, AssetPath, TemplatePath) ->

    w = $scope.parentWidget

    $scope.showCloseActive = false
    $scope.showEditActive = false
    $scope.showConfirmDelete = false

    $scope.closeWidgetButtonImage = AssetPath['impac/close-widget.png']
    $scope.closeWidgetButtonImageActive = AssetPath['impac/close-widget-pink.png']

    w.isEditMode = false

    $scope.deleteWidget = ->
      DhbAnalyticsSvc.widgets.delete(w.id, w.parentDashboard).then(
        (->)
        ,(errors) ->
          w.errors = Utilities.processRailsError(errors)
      )
      # Refresh needed to display the 'add a widget' message in case of no widget
      # ).finally(-> DhbAnalyticsSvc.load(true))

    $scope.toogleEditMode = ->
      if !w.isLoading
        if w.isEditMode
          # Like a press on 'Cancel' button
          w.initSettings()
        else
          # Otherwise, we pass in edit mode
          w.isEditMode = true
])

module.directive('commonTopButtons', ['TemplatePath', (TemplatePath) ->
  return {
    restrict: 'A',
    scope: {
      parentWidget: '='
    },
    templateUrl: TemplatePath['analytics/widgets/common/top-buttons.html'],
    controller: 'CommonTopButtonsCtrl'
  }
])