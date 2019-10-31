ffmpeg -i alterego.mp3 -af astats=metadata=1:reset=1,ametadata=print:key=lavfi.astats.Overall.RMS_level:file=log.txt -f null -

This produces an output like this:

frame:221  pts:226304  pts_time:4.71467
lavfi.astats.Overall.RMS_level=-67.437152
frame:222  pts:227328  pts_time:4.736
lavfi.astats.Overall.RMS_level=-67.159036
frame:223  pts:228352  pts_time:4.75733
lavfi.astats.Overall.RMS_level=-63.862748
frame:224  pts:229376  pts_time:4.77867
lavfi.astats.Overall.RMS_level=-63.666815

this is too fine-grained in terms of temporal resolution, increase the reset value which is the frame count for the filter's sampling frequency. For a 1-second slice, an integer approximating audio sampling rate/1000 should be used.

#############################
ffmpeg -i alterego.mp3 -filter_complex "showwavespic=s=640x120" -frames:v 5 output.png

ffmpeg -i alterego.mp3 -filter_complex \
"[0:a]aformat=channel_layouts=mono, \
 compand=gain=-6, \
 showwavespic=s=600x120:colors=#9cf42f[fg]; \
 color=s=600x120:color=#44582c, \
 drawgrid=width=iw/10:height=ih/5:color=#9cf42f@0.1[bg]; \
 [bg][fg]overlay=format=rgb,drawbox=x=(iw-w)/2:y=(ih-h)/2:w=iw:h=1:color=#9cf42f" \
-vframes 1 output.png

#########################
http://lukaprincic.si/development-log/ffmpeg-audio-visualization-tricks

######################
https://amiaopensource.github.io/ffmprovisr/#basics

##########################

https://github.com/t4nz/ffmpeg-peaks

const ffmpegPeaks = require('ffmpeg-peaks');

const ffpeaks = new ffmpegPeaks({
	width: 1640,
	precision: 1,
	numOfChannels: 2,
	sampleRate: 16000
});

ffpeaks.getPeaks('/my/input/audio.ogg', '/my/output/peaks.json', (err, peaks) => {
	if (err) return console.error(err);
	console.log(peaks);
});

ffpeaks.getPeaks('http:/my/url/audio.ogg', (err, peaks) => {
	if (err) return console.error(err);
	console.log(peaks);
});


##########################################
https://github.com/MonsieurV/py-findpeaks