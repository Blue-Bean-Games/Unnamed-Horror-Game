extends Control

func _ready():
	$VBoxContainer/EpisodesButton.grab_focus()

func _on_EpisodesButton_pressed():
	print("EpisodesButton Pressed!")
	get_tree().change_scene("res://Scenes/proto-world.tscn")

func _on_OptionsButton_pressed():
	print("OptionsButton Pressed!")

func _on_CreditsButton_pressed():
	print("CreditsButton Pressed!")

func _on_ExitButton_pressed():
	get_tree().quit()
