module.exports =
   hasPermission: (permission, permissionList) ->
      for p in permissionList
         regex = @regexForPermission p
         return yes if regex.test permission
      no

   regexForPermission: (permission) ->
      p = permission.replace /[\-\[\]\/\{\}\(\)\+\?\.\\\^\$\|]/g, '\\$&'
      p = p.replace '**', '.+'
      p = p.replace '*', '(?:(?!::).)+'

      new RegExp "^#{p}$"

