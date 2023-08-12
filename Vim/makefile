win_dir := /mnt/c/
# variables for linux
PLUGIN_DIR := /usr/share/vim/vim90/pack/plugins/start
# PLUGIN_DIR := $(shell vim --cmd 'echo $$VIMRUNTIME|q' --cmd 'qall!' 2>/dev/null)/pack/plugins/start
VIM_DIR := /etc/vim
# VIM_DIR := $(shell vim --cmd 'echo $$VIM|q' --cmd 'qa!')

# Define urls for fetching later
FETCH_PLUGIN = curl -L -o $(PLUGIN_DIR)/$(notdir$(1)) $(1)
# PLUGINS_FILE = $(VIM_DIR)/plugins.txt
PLUGINS_FILE = $(VIM_DIR)/plugins.txt
VIMRC_FILE = $(VIM_DIR)/vimrc
MAKE_FILE = $(VIM_DIR)/makefile

PLUGINS_SRC = "https://raw.githubusercontent.com/joacortez/AHK_Scripts/main/Vim/plugins.txt"
VIMRC_SRC = "https://raw.githubusercontent.com/joacortez/AHK_Scripts/main/Vim/vimrc"
MAKE_SRC = "https://raw.githubusercontent.com/joacortez/AHK_Scripts/main/Vim/makefile"

FETCH_PLUGIN = git clone $(1) 
FETCH_PLUGIN = git clone $(1) $(PLUGIN_DIR)/$(2)

FETCH_SRCS = curl -L $(PLUGINS_SRC) > $(PLUGINS_FILE) 
FETCH_VIMRC = curl -L $(VIMRC_SRC) > $(VIMRC_FILE) 
FETCH_MAKE = curl -L $(MAKE_SRC) > $(MAKE_FILE) 

.PHONY: all install clean list dir vim update  wupdate

all: install 

winstall: VIM_DIR := $(win_dir)/Program\ Files/Vim
winstall: PLUGIN_DIR := $(VIM_DIR)/vim90/pack/plugins/start
winstall: install

install: 
	@echo creating dir $(PLUGIN_DIR)
	@mkdir -p $(PLUGIN_DIR) 
	@$(FETCH_SRCS)
	@while IFS=, read -r plugin_url plugin_name; do \
		$(call FETCH_PLUGIN, $$plugin_url,$$plugin_name); \
	done < $(PLUGINS_FILE)

list: 
	@cat $(PLUGINS_FILE)

wupdate: VIM_DIR := $(win_dir)/Program\ Files/Vim
wupdate: PLUGIN_DIR := $(VIM_DIR)/vim90/pack/plugins/start
wupdate: update

update:
	@$(FETCH_MAKE)
	@$(FETCH_SRCS)
	@$(FETCH_VIMRC)

vim:
	@echo $(VIM_DIR)

dir:
	@echo $(PLUGIN_DIR)
