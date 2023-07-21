extends Polygon2D


func _ready():
	$StaticBody/CollisionPolygon.polygon = polygon
