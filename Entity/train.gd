extends PathFollow3D

var speed : float = 0.0 # Швидкість руху
var engaged = true # Чи керуємо ми цим вагоном
@export var power : float = 0.05 # Потужність розгону
@export var is_engine = false # Чи є вагон локомотивом
@export var is_coupled = false # Чи є вагон причепним вагоном
@export var my_progress = 0
@export var body : PackedScene # Експорт сцени кузова
@export var bogie : PackedScene # Експорт сцени візка
var id = 0
var bogie_trail : PathFollow3D # Другий візок це PathFollow3D
var path : Path3D # Колії це Path3D
var trail = false # Чи є візок причепним
var forward = true # Чи їдемо ми вперед
@onready var car_spawn : Marker3D # Місце спавну кузова
@onready var car_body # Кузов
@onready var world_rules = get_tree().root.get_child(0) # Шлях до скрипту світу 
@onready var my_collider : Area3D # Для зіткнення

func _ready():
	path = get_parent()
	id = world_rules.bogies.size() # Розмір масиву
	world_rules.bogies.append(self) # Додати себе до масиву
	setup_engine() # Додавання треіл візку та кузова
	lineup_train() # Простір між вагонами
	if is_engine: progress = my_progress
	else: progress = 0
	
func _process(delta):
	# Автоматичне з'єднання вагонів
	#if car_body.colliding and car_body.collider == world_rules:
		#couple_to_cars() # З'єднання з вігоном
	# Керування
	if is_engine: # Якщо вагон є локомотивом
		if world_rules.engine_engaged: # Якщо вагон є керованим
			if Input.is_action_pressed("1"):
				speed += power
			elif  Input.is_action_pressed("2"):
				speed -= power
			if speed < 0: # Якщо швидкість стає від'ємною ми їдемо назад
				forward = false
				bogie_trail.forward = false
			else: 
				forward = true
				bogie_trail.forward = true
		else: # Натиснути це раз щоб знову ввімкнути
			speed = 0 # Симуляція зіткнення 
			if Input.is_action_just_released("3"): # Запустити двигун
				print(speed)
				world_rules.engine_engaged = true
				print("Двигун запущено!")
		progress += speed * delta
	# Якщо вагон причепний то він слудує за тим до кого причеплений
	elif is_coupled: progress = world_rules.bogies[id - 1].progress - 3
	bogie_trail.progress += speed * delta
	# Реалізація опорно-повертального пристрою
	car_spawn.look_at(Vector3(bogie_trail.transform.origin.x,car_spawn.transform.origin.y,bogie_trail.transform.origin.z),Vector3.UP)
	
func setup_engine():
	# Створення кузова
	car_spawn = $Marker3D
	car_body = body.instantiate()
	car_spawn.add_child(car_body)
	# Створення причепного візка
	bogie_trail = bogie.instantiate()
	path.add_child.call_deferred(bogie_trail)
	
	world_rules.bogies.append(bogie_trail) 
	# Налаштування розміщення причепного візку і кузова
	bogie_trail.progress = progress - (car_body.scale.z * (2 * 4.267))
	car_body.transform.origin.z -= car_body.scale.z + 3.267
	
	#if is_engine: world_rules.engine_collider = car_body.collider
	#print(world_rules.engine_collider)
func lineup_train():
	#progress = game_mgr.bogies[id - 1].progress - 3
	pass

func couple_to_cars():
	world_rules.engine_engaged = false
	is_coupled = true
	# Симуліяця ваги
	power -= 0.001 * (world_rules.bogies.size()/2)
	car_body.colliding = false

#func get_offset(new_path : Path3D):
	#return new_path.curve.get_closest_offset(path.transform)
