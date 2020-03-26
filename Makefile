FontName = League Spartan

# Defalut to running jobs in parallel, one for each CPU core
MAKEFLAGS += --jobs=$(shell nproc) --output-sync=target
# Default to not echoing commands before running
MAKEFLAGS += --silent
# Disable as much built in file type builds as possible
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

# Run recipies in zsh, and all in one pass
SHELL := zsh
.SHELLFLAGS := +o nomatch -e -c
.ONESHELL:
.SECONDEXPANSION:

# Some Makefile shinanigans to avoid aggressive trimming
space := $() $()

# Allow overriding each executable we use
PYTHON ?= python3
FONTV ?= font-v

# Determine font version automatically from repository git tags
FontVersion ?= $(shell git describe --tags --abbrev=6 | sed 's/-.*//g')
FontVersionMeta ?= $(shell git describe --tags --abbrev=6 --long | sed 's/-[0-9]\+/\\;/;s/-g/[/')]
GitVersion ?= $(shell git describe --tags --abbrev=6 | sed 's/-/-r/')
isTagged := $(if $(subst $(FontVersion),,$(GitVersion)),,true)

# Look for what fonts & styles are in this repository that will need building
FontBase = $(subst $(space),,$(FontName))
FontStyles = $(subst $(FontBase)-,,$(basename $(wildcard $(FontBase)-*.ufo)))

TARGETS = $(foreach BASE,$(FontBase),$(foreach STYLE,$(FontStyles),$(BASE)-$(STYLE)))

.PHONY: default
default: all

.PHONY: all
all: fonts
	echo N: $(FontName)
	echo B: $(FontBase)
	echo S: $(FontStyles)
	echo V: $(FontVersion)
	echo M: $(FontVersionMeta)
	echo G: $(GitVersion)
	echo t: $(isTagged)
	echo O: $(TARGETS)

.PHONY: fonts
fonts: otf ttf

.PHONY: otf
otf: $(addsuffix .otf,$(TARGETS))

.PHONY: ttf
ttf: $(addsuffix .ttf,$(TARGETS))

%.ufo: .last-commit
	cat <<- EOF | $(PYTHON)
		from defcon import Font, Info
		ufo = Font('$@')
		major, minor = "$(FontVersion)".split(".")
		ufo.info.versionMajor, ufo.info.versionMinor = int(major), int(minor) + 7
		ufo.save('$@')
	EOF

%.otf: %.ufo
	cat <<- EOF | $(PYTHON)
		from ufo2ft import compileOTF
		from defcon import Font
		ufo = Font('$<')
		otf = compileOTF(ufo)
		otf.save('$@')
	EOF
	$(normalizeVersion)

%.ttf: %.ufo
	cat <<- EOF | $(PYTHON)
		from ufo2ft import compileTTF
		from defcon import Font
		ufo = Font('$<')
		ttf = compileTTF(ufo)
		ttf.save('$@')
	EOF
	$(normalizeVersion)

.PHONY: .last-commit
.last-commit:;
	git update-index --refresh --ignore-submodules ||:
	git diff-index --quiet --cached HEAD
	ts=$$(git log -n1 --pretty=format:%cI HEAD)
	touch -d "$$ts" -- $@

DISTDIR = $(FontBase)-$(GitVersion)

$(DISTDIR):
	mkdir -p $@

.PHONY: clean
clean:
	git clean -dxf

.PHONY: dist
dist: $(DISTDIR).zip $(DISTDIR).tar.bz2

.PHONY: install-dist
install-dist: all $(DISTDIR)
	install -Dm644 -t "$(DISTDIR)/OTF/" *.otf
	install -Dm644 -t "$(DISTDIR)/TTF/" *.ttf

$(DISTDIR).zip: install-dist
	zip -r $@ $(DISTDIR)

$(DISTDIR).tar.bz2: install-dist
	tar cvfj $@ $(DISTDIR)

install-local: install-dist
	install -Dm755 -t "$${HOME}/.local/share/fonts/OTF/" $(DISTDIR)/OTF/*.otf
	install -Dm755 -t "$${HOME}/.local/share/fonts/TTF/" $(DISTDIR)/TTF/*.ttf

define normalizeVersion =
	font-v write --ver=$(FontVersion) $(if $(isTagged),--rel,--dev --sha1) $@
endef

# Empty recipie to suppres makefile regeneration
$(MAKEFILE_LIST):;

# Special dependency to force rebuilds of up to date targets
.PHONY: force
force:;
