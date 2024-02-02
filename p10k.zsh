'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
emulate -L zsh -o extended_glob
unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
[[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
# =========================[ Line #1 ]=========================
os_icon                 # os identifier
dir                     # current directory
vcs                     # git status
# =========================[ Line #2 ]=========================
newline                 # \n
prompt_char             # prompt symbol
)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
)

typeset -g POWERLEVEL9K_MODE=nerdfont-complete
typeset -g POWERLEVEL9K_ICON_PADDING=none
typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=true
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%238F╭─'
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%238F├─'
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%238F╰─'
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=' '
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=' '
typeset -g POWERLEVEL9K_SHOW_RULER=false
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '

  #################################[ os_icon: os identifier ]##################################
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=13

  ################################[ prompt_char: prompt symbol ]################################
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=10
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=1
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='⮚'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=

  ##################################[ dir: current directory ]##################################
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=14
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=103

typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
function my_git_formatter() {
    emulate -L zsh
    if [[ -n $P9K_CONTENT ]]; then
        typeset -g my_git_format=$P9K_CONTENT
        return
    fi

    if (( $1 )); then
        # Styling for up-to-date Git status.
        local       meta='%f'     # default foreground
        local      clean='%76F'   # green foreground
        local   modified='%178F'  # yellow foreground
        local  untracked='%39F'   # blue foreground
        local conflicted='%196F'  # red foreground
    else
        # Styling for incomplete and stale Git status.
        local       meta='%244F'  # grey foreground
        local      clean='%244F'  # grey foreground
        local   modified='%244F'  # grey foreground
        local  untracked='%244F'  # grey foreground
        local conflicted='%244F'  # grey foreground
    fi

    local res

    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
        local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
        (( $#branch > 32 )) && branch[13,-13]="…"  # <-- this line
        res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
    fi

    if [[ -n $VCS_STATUS_TAG
        && -z $VCS_STATUS_LOCAL_BRANCH  # <-- this line
        ]]; then
        local tag=${(V)VCS_STATUS_TAG}
        (( $#tag > 32 )) && tag[13,-13]="…"  # <-- this line
        res+="${meta}#${clean}${tag//\%/%%}"
    fi
    [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&  # <-- this line
        res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"
            if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
                res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
            fi
            if [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]]; then
                res+=" ${modified}wip"
            fi
            (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
            (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
            (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
            (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
            (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
            (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
            (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
            [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
            (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
            (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
            (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
            (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
            (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"
            typeset -g my_git_format=$res
        }
        functions -M my_git_formatter 2>/dev/null
        typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
        typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'
        typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
        typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
        typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
        typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
        typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=76
        typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR=244
        typeset -g POWERLEVEL9K_VCS_PREFIX='%fon '
        typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
        typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=6
        typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=6
        typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=3

        typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always
        typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

        typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

        (( ! $+functions[p10k] )) || p10k reload
    }

    typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

    (( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
    'builtin' 'unset' 'p10k_config_opts'
