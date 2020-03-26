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
FontVersion ?= $(shell git describe --tags | sed 's/-.*//g')
FontVersionMeta ?= $(shell git describe --tags | sed 's/-/\\; r/;s/-/ [/')]

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
	echo O: $(TARGETS)

.PHONY: fonts
fonts: otf ttf

.PHONY: otf
otf: $(addsuffix .otf,$(TARGETS))

.PHONY: ttf
otf: $(addsuffix .ttf,$(TARGETS))

%.otf: %.ufo
	cat <<- EOF | $(PYTHON)
		from defcon import Font
		from ufo2ft import compileOTF
		ufo = Font('$<')
		otf = compileOTF(ufo)
		otf.save('$@')
	EOF

%.ttf: %.ufo
	cat <<- EOF | $(PYTHON)
		from defcon import Font
		from ufo2ft import compileTTF
		ufo = Font('$<')
		otf = compileTTF(ufo)
		otf.save('$@')
	EOF

# Empty recipie to suppres makefile regeneration
$(MAKEFILE_LIST):;

# Special dependency to force rebuilds of up to date targets
.PHONY: force
force:;
