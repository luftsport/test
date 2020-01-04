# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = docs-source
BUILDDIR      = docs


# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

gh-pages:
	git checkout gh-pages
	# rm -rf $(SOURCEDIR) $(BUILDDIR)
	git checkout master $(SOURCEDIR)
	git reset HEAD
	# make html
	sphinx-build -b html ./docs-source ./
	rm -rf $(SOURCEDIR)
	rm -rf $(BUILDDIR)
	git add -A
	git commit -m "Generated gh-pages for `git log master -1 --pretty=short --abbrev-commit`" && git push origin gh-pages ; git checkout master

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# How to setup repo
# https://nikhilism.com/post/2012/automatic-github-pages-generation-from/
# # 1. Config repo
# cd repo
# # Make a branch use gh-pages magic github
# git checkout --orphan gh-pages
# # remove everything except .gitignore
# git rm -rf .
# # Make a commit?
# echo "First commit" > index.html
# git add --all
# git commit -m "Just to create the branch."
# git push origin gh-pages
#
# # 2. Config makefile (this)
# # make sure it checks out everything needed for document generation
#
# # 3. Templates
# # Add layout options to layout - github ribbon
# # Add footer to add footer for repo
#
# # 4. Can still build in master if needed!!! 