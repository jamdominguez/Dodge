extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (int) var min_speed # Minimum speed range
export (int) var max_speed # Maximum speed range
var mob_types = ["walk", "swim", "fly"]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] # Set a random animation


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
# The mobs delete themselves when they leave the screen
func _on_Visibility_screen_exited():
	queue_free()