AVD_NAME="arm"
RESTART_ADB=true
EMULATOR_TIMEOUT=300



task :emulator_start do

	stopped = "stopped"
	bootanim = ""

	#spawn emulator and save process id
	command = "$ANDROID_HOME/tools/emulator -avd #{AVD_NAME}"
	puts command
	pid = spawn command
	Process.detach(pid)

	pidFile = File.open(".emulator.pid", "w")
	pidFile.write(pid)
	pidFile.close
	puts RESTART_ADB

	if RESTART_ADB 
		`$ANDROID_HOME/platform-tools/adb kill-server`
	end

	#seconds elapsed while launching timeout
	counter = 1

	while bootanim != stopped do

		if counter >= EMULATOR_TIMEOUT
			return "Emulator timeout" 
		end

		sleep(1)
		bootanim = `$ANDROID_HOME/platform-tools/adb shell getprop init.svc.bootanim`
		bootanim.strip!

		counter += 1
	end
end

task :emulator_kill do

	pid = ""
	pidFile = File.open(".emulator.pid", "r")
	pidFile.each { |line|
		pid << line
	}
	pidFile.close

	pid.strip!

	if pid.length > 0

		`kill -9 #{pid}`

		pidFile = File.open(".emulator.pid", 'w')
		pidFile.write("")
		pidFile.close
		
	end
end


