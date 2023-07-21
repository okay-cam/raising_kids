extends Polygon2D


func _ready():
	$StaticBody/CollisionShape.shape.segments = polygon
