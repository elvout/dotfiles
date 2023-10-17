# Localhost defaults. Do not comment these out -- subsequent exports will
# overwrite them automatically.
export ROS_MASTER_URI="http://localhost:11311"
export ROS_IP="127.0.0.1"

DEFAULT_IP="$(hostname -I | cut -f 1 -d ' ')"

# Uncomment to set this computer as a ROS master on the default network
export ROS_MASTER_URI="http://$DEFAULT_IP:11311"

# Uncomment to set this computer as a ROS node on the default network
export ROS_IP="$DEFAULT_IP"
