extends Area2D
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal hit#signal that can emit
var speed=400 # How fast the player will move (pixels/sec).
var screensize # Size of the game window.

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
   screensize = get_viewport_rect().size   
   hide()#player will be hidden when the game starts

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
   #$ is shorthand for get_node(). So in the code above, $AnimatedSprite.play() is the same as get_node("AnimatedSprite").play().

   # Position control
   var velocity = Vector2()# The player's movement vector.
   if Input.is_action_pressed("ui_right"):
       print("ui_right")
       velocity.x += 1
   if Input.is_action_pressed("ui_left"):
       print("ui_left")
       velocity.x -= 1
   if Input.is_action_pressed("ui_down"):
       print("ui_down")
       velocity.y += 1
   if Input.is_action_pressed("ui_up"):
       print("ui_up")
       velocity.y -= 1
   if velocity.length() > 0:
       velocity = velocity.normalized() * speed
       $AnimatedSprite.play()
   else:
       $AnimatedSprite.stop()


   # Limit position control
   position += velocity * delta# Modify the player position
   position.x = clamp(position.x, 0, screensize.x)#limit horizontal axis
   position.y = clamp(position.y, 0, screensize.y)#limit vertical axis

   # Animation control
   if velocity.x != 0:#Sprit control for horizontal axis
    $AnimatedSprite.animation = "right"
    $AnimatedSprite.flip_v = false
    $AnimatedSprite.flip_h = velocity.x < 0
   elif velocity.y != 0:#Sprit control for vertical axis
    $AnimatedSprite.animation = "up"
    $AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
	hide() # Player disappears after being it
	emit_signal("hit")
	$CollisionShape2D.disabled = true

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func game_over():
	pass # replace with function body
