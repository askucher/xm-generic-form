angular
 .module \dashboardApp 
 .directive do
     * \genericForm
     * (helpers)->
         restrict: \C
         transclude: yes
         template: '<div ng-transclude></div>'
         link: ($scope, element, attrs, ctrl, transclude)->
           name = element.attr(\model)
           local = {}
              ..add = (collection, template)->
                template |> angular.copy |> collection.push
                const clean = (key)->
                  template[key] = null
                template |> Object.keys |> p.each clean
              ..remove = (collection, index)->
                collection.splice(index, 1)
              ..model = $scope[name]
           transclude helpers.extend({}, local, $scope, $scope.$parent), (clone, scope)->
               element.empty!
               element.append clone
 .directive do 
    * \ngThumb 
    * ($window) ->
       const helper = 
         support: ! !($window.FileReader and $window.CanvasRenderingContext2D)
         isFile: (item) ->
           angular.isObject(item) and item instanceof $window.File
         isImage: (file) ->
           type = '|' + file.type.slice(file.type.lastIndexOf('/') + 1) + '|'
           '|jpg|png|jpeg|bmp|gif|'.indexOf(type) != -1
       
       restrict: \A
       template: '<canvas/>'
       link: (scope, element, attributes) ->
   
           const onLoadFile = (event) ->
             img = new Image
             img.onload = onLoadImage
             img.src = event.target.result
   
           const onLoadImage = ->
             width = params.width or @width / @height * params.height
             height = params.height or @height / @width * params.width
             canvas.attr do
               width: width
               height: height
             canvas.0.getContext('2d').draw-image this, 0, 0, width, height
   
           if !helper.support
             return
           const params = 
              scope.$eval(attributes.ngThumb)
           if !helper.isFile(params.file)
             return
           if !helper.isImage(params.file)
             return
           const canvas = 
              element.find \canvas
           const reader = new FileReader!
           reader.onload = onLoadFile
           reader.readAsDataURL params.file

             
      