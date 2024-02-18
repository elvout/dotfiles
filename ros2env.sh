# Shell completions for zsh are broken on Humble, requiring this
# workaround.
# https://github.com/ros2/ros2cli/issues/534#issuecomment-958010930
#
# The fix might be present in a future release.
# https://github.com/ros2/ros2cli/pull/750.
complete -o nospace -o default -F _python_argcomplete "ros2"
complete -o nospace -o default -F _python_argcomplete "colcon"

export ROS_LOCALHOST_ONLY=1
