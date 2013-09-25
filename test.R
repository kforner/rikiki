# should be in rikiki directory
if (!basename(getwd()) == 'rikiki') stop('bad current dir')

if (file.exists('man/foo.Rd')) file.remove('man/foo.Rd')

# use foo1.Rd
file.copy('foo1.Rd', 'man/foo.Rd')
system("R CMD INSTALL -l ../lib/ .", intern=TRUE)

library(rikiki, lib = '../lib')
help(foo)

# change the libpath so that the statET help can see the rikiki package
.libPaths(c(.libPaths(), '../lib'))
# index manually 
#[INFO] Updating the R environment index started...
#
#[INFO] The R environment index was updated successfully.

help(foo, verbose = TRUE, help_type = 'text') 
# does not work

help(foo)


unloadNamespace('rikiki')
if (file.exists('man/foo.Rd')) file.remove('man/foo.Rd')
file.copy('foo2.Rd', 'man/foo.Rd')
system("R CMD INSTALL -l ../lib/ .", intern=TRUE)

library(rikiki, lib = '../lib')
.libPaths(c(.libPaths(), '../lib'))
help(foo)