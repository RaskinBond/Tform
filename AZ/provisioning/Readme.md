# Typically, a flag is passed or some method to determine if you want a windows vm or a linux vm while executing "terraform apply"

This flag would be assigned to count on the resource using a ternary operator "?" return 1 or 0 to build it or not build it.

*Recommended:* Break the module up into a separate module.

__Eg-__ count = var.createdb ? 1 : 0

terraform apply -var "createdb=false" -var "createapp=false"
