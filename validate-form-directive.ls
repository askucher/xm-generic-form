angular
 .module \dashboardApp 
 .directive do
     * \validateForm
     * ($parse, helpers)->
         restrict: \C
         link: ($scope, $element, $attrs)->
           set = (valid)->
               window.$invalids = window.$invalids ? []
               arr = window.$invalids
               index = 
                 arr.index-of($attrs.test)
               if !valid
                 if index is -1
                   arr.push $attrs.test
               else
                 arr.splice(index, 1)
               window.$invalid = window.$invalids.length > 0
               console.log \valid, valid, window.$invalid
           name =
             $element.closest(\form).attr(\model)
           test =
             $parse $attrs.test
           changed = ->
               #console.log(\changed, $scope)
               local =
                 helpers.extend {}, $scope[name], $scope
               res = test local
               callback = (bool)->
                  if bool
                    $element.remove-class \active
                    $element.empty!
                    set yes
                  else
                    $element.add-class \active
                    $element.html($attrs.error)
                    set no
               switch typeof! res
                 case \Boolean
                  callback res
                 case \Object
                  res.then callback
           $scope.$watch name, changed, yes
               