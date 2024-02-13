extends AudioStreamPlayer2D

@export var bpm: int = 100
@export var measures: int = 4

#signals to report song position, beat and measure
signal report_beat(beat_position)
signal report_measure(measure_position)

# Tracking the beat and song position
var song_position = 0.0
var song_position_in_beats = 1
var sec_per_beat = 60.0 / bpm
var last_reported_beat = 0
var beats_before_start = 0
var measure = 1

# Determining how close to the beat an event is
var closest = 0
var time_off_beat = 0.0


func _ready():
	sec_per_beat = 60.0 / bpm


func _physics_process(_delta):
	if playing:
		#sound hardware clock to sync with position by adding the time since last report
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		#subtract latency for more accuracy
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
		_report_beat()


#responsible for emitting our signals and report song position based on beat and measure
func _report_beat():
	#to repeat every beat rather than constant
	if last_reported_beat < song_position_in_beats:
		#to track measure and reset
		if measure > measures:
			measure = 1
		print("beats: " + str(song_position_in_beats))
		print("beat in measure: " + str(measure))
		report_beat.emit(song_position_in_beats)
		report_measure.emit(measure)
		last_reported_beat = song_position_in_beats
		measure += 1


func closest_beat(nth):
	closest = int(round((song_position / sec_per_beat) / nth) * nth) 
	time_off_beat = abs(closest * sec_per_beat - song_position)
	return Vector2(closest, time_off_beat)


#debug helper to allow us to play from a specific section of a song based on beat
func play_from_beat(beat, offset):
	play()
	seek(beat * sec_per_beat)
	beats_before_start = offset
	measure = (beat % measures) + 1


#helper to allow us to spawn beats offset before song start
func play_with_beat_offset(num):
	beats_before_start = num
	$StartTimer.wait_time = sec_per_beat
	$StartTimer.start()


#helper continued on StartTimer timeout signal
func _on_StartTimer_timeout():
	song_position_in_beats += 1
	if song_position_in_beats < beats_before_start - 1:
		$StartTimer.start()
	#last beat before starting song, we calibrate: account for delay on audiostreamplayer to play
	elif song_position_in_beats == beats_before_start - 1:
		$StartTimer.wait_time = $StartTimer.wait_time - (AudioServer.get_time_to_next_mix() + 
		AudioServer.get_output_latency())
		$StartTimer.start()
	else:
		play()
		$StartTimer.stop()
	_report_beat()
