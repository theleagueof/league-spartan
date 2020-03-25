FontName = League Spartan

# Defalut to running jobs in parallel, one for each CPU core
# Default to not echoing commands before running
MAKEFLAGS += --jobs=$(shell nproc) --output-sync=target --silent

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
	echo ufo2otf $^ -o $@

%.ttf: %.ufo
	echo ufo2ttf $^ -o $@

# Empty recipie to suppres makefile regeneration
$(MAKEFILE_LIST):;

# Special dependency to force rebuilds of up to date targets
.PHONY: force
force:;
