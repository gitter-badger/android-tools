AVD_NAME = "arm"
RESTART_ADB = true
EMULATOR_TIMEOUT = 300



task :emulator_start do

	stopped = "stopped"
	bootanim = ""

	#spawn emulator and save process id
	command = "$ANDROID_HOME/tools/emulator -avd #{AVD_NAME}"
	pid = spawn command
	Process.detach pid

	File.open(".emulator.pid", "w") do |pidFile|
		pidFile.write pid
	end

	`$ANDROID_HOME/platform-tools/adb kill-server` if RESTART_ADB

	#seconds elapsed while launching timeout
	counter = 1

	while bootanim != stopped do

		return "Emulator timeout" if counter >= EMULATOR_TIMEOUT

		sleep 1
		bootanim = `$ANDROID_HOME/platform-tools/adb shell getprop init.svc.bootanim`
		bootanim.strip!

		counter += 1
	end
end

task :emulator_kill do

	pid = File.read ".emulator.pid"

	pid.strip!

	if pid.length > 0

		`kill -9 #{pid}`

		File.open(".emulator.pid", "w") do |pidFile|
			pidFile.write ""
		end
		
	end
end


