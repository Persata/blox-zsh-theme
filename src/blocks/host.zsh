# --------------------------------------------- #
# | Block options
# --------------------------------------------- #

# User
BLOX_BLOCK__HOST_USER_SHOW_ALWAYS="${BLOX_BLOCK__HOST_USER_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_USER_COLOR="${BLOX_BLOCK__HOST_USER_COLOR:-yellow}"
BLOX_BLOCK__HOST_USER_ROOT_COLOR="${BLOX_BLOCK__HOST_USER_ROOT_COLOR:-red}"

# Machine
BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS="${BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_MACHINE_COLOR="${BLOX_BLOCK__HOST_MACHINE_COLOR:-cyan}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__host() {

  # The user's color
  USER_COLOR=$BLOX_BLOCK__HOST_USER_COLOR

  # Make the color red if the current user is root
  [[ $USER == "root" ]] && USER_COLOR=$BLOX_BLOCK__HOST_USER_ROOT_COLOR

  # The info
  info=""

  # Check if the user info is needed
  if [[ $BLOX_BLOCK__HOST_USER_SHOW_ALWAYS == true ]] || [[ $(who am i | awk '{print $1}') != $USER ]]; then
    info+="%{$fg[$USER_COLOR]%}%n%{$reset_color%}"
  fi

  # Check if the machine name is needed
  if [[ $BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS == true ]] || [[ -n $SSH_CONNECTION ]]; then
    [[ $info != "" ]] && info+="@"
    info+="%{$fg[${BLOX_BLOCK__HOST_MACHINE_COLOR}]%}%m%{$reset_color%}"
  fi

  # Echo the info in need
  if [[ $info != "" ]]; then
    echo "$info:"
  fi
}
