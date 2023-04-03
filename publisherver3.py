import paho.mqtt.publish as publish

MQTT_SERVER = "broker.emqx.io"  # Address for the server that hosts the broker
#MQTT_SERVER = "broker.hivemq.com"
authentications = {'username': "kdyer", 'password': "Green82"}  # Username and password for sending the data

# Variable definitions
# channel is the multiplier of the score. It must be a string
# 11 - single, outer-ring
# 12 - single, inner-ring
# 2 - double
# 3 - triple

# score is the slice of the dartboard that was hit. It must also be a string
# It can be from 0-20, 25, or 50

# here is an example of hitting a single 20, on the outer-ring

channel = "11"
score = "20"
publish.single(channel, score, hostname=MQTT_SERVER, auth=authentications)
