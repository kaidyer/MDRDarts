import paho.mqtt.publish as publish
import time

MQTT_SERVER = "broker.emqx.io"
#MQTT_SERVER = "broker.hivemq.com"
MQTT_PATH = "1"
authentications = {'username': "kdyer", 'password': "Green82"}

# A function to publish the data to the MQTT server
# this fnciton asks the user what channel they want, ranging from 0 to 3
# the function asks the user what score they want to throw, ranging from 0 to 50
# the function then publishes the data to the MQTT server
shouldContinue = True
for i in range(100):
    # print("Run: ", i)
    print(time.time(), ", ")
    publish.single("11", "1", hostname=MQTT_SERVER, auth=authentications)
    #shouldContinue = input("Continue? (y/n): ")
    #if shouldContinue == "n":
     #   shouldContinue = False
    time.sleep(0.5)

# publish.single(MQTT_PATH, "30", hostname=MQTT_SERVER, auth={'username':"kdyer",'password':"Green"})
