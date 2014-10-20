var spyApp = angular.module('spyApp', []);

spyApp.run(['$http', function ($http) {
  $http.defaults.headers.common.Accept = 'application/json';
}]);

spyApp.controller('MainCtrl', ['$scope', '$http', function ($scope, $http) {

  $scope.host = 'landregistry.local';

  $scope.apps = [
    {"name": 'system-of-record', "href": "http://system-of-record." + $scope.host, "path": "/titles/"},
    {"name": 'property-frontend', "href": "http://property-frontend." + $scope.host, "path": "/property/" },
    {"name": 'search-api (public)', "href": "http://search-api." + $scope.host, "path": "/titles/" },
    {"name": 'search-api (private)', "href": "http://search-api." + $scope.host, "path": "/auth/titles/" },
    {"name": 'search-api (query)', "href": "http://search-api." + $scope.host, "path": "/search?query=" },
    {"name": 'service-frontend', "href": "http://service-frontend." + $scope.host, "path": "/property/" },
    {"name": 'historian', "href": "http://historian." + $scope.host, "path": "/titles/" }
  ];

  $scope.results = {};
  $scope.show = function (key) {
    return $scope.results[key.replace('-','')] || 'dontknow';
  }

  $scope.spy = function() {
    for (var j=0; j<$scope.apps.length; j++) {
      (function (i) {
        var app = $scope.apps[i];
        var url = app.href + app.path + $scope.title;
        var key = app.name.replace('-', '');
        try {
          if (app.name === 'service-frontend') {
            $scope.results[key] = 'needslogin';
          } else {
            $http.get(url).
              success(function(data, status, headers, config) {
                $scope.results[key] = 'good';
              }).
              error(function(data, status, headers, config) {
                $scope.results[key] = 'bad';
              });
          }
        } catch (err) {
          console.log("fatal", err);
        }
      })(j);
    }
  };
}]);
