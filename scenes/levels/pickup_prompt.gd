extends VBoxContainer
class_name PickupPropmt

@onready var pickup_prompts_timer = %PickupPromptsTimer
var picked_up_items := {
	"copper": {
		"timer": Timer.new(),
		"new_stuff": 0
	}
}

# TODO: implement this feature
func add_prompt(item: Item):
	if picked_up_items[item.name.to_lower()].new_stuff:
		picked_up_items[item.name.to_lower()].new_stuff += 1
		print(picked_up_items[item.name.to_lower()].new_stuff)
	var timer: Timer = picked_up_items[item.name.to_lower()].timer
	print("starting timer for item: %s" % timer.name)
	timer.start(2)

func on_timeout(item: Item):
	picked_up_items[item.name.to_lower()].new_stuff = 0
	print('timeout for item: %s' % item.name)
