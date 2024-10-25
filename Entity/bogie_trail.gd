extends PathFollow3D

var trail : bool = true # Чи це візок що слідує
var forward : bool = true # Чи їдемо ми вперед
@onready var path : Path3D = get_parent()
