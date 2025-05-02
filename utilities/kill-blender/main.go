package main

import (
	"fmt"
	"math/rand"
	"os"
	"strings"
	"time"

	"github.com/ChromeTemp/Popup"
	"github.com/shirou/gopsutil/process"
)

var prompts = []string{
	"Kill Blender?",
	"Send it to the shadow realm?",
	"Slaughter the RAM demon?",
	"Execute Order 66 on Blender?",
	"Blender's CPU crimes: punishable by death?",
	"Cut its power like it’s anime filler?",
	"End Blender’s OnlyFans of thermal output?",
	"Yeet the hentai renderer?",
	"Time to Ctrl+K this thotware?",
	"Bury this memory-leaking gremlin?",
	"Terminate Blender’s GPU chokehold?",
	"Throw Blender into the abyss?",
	"Is it lagging or summoning Satan?",
	"Blender sus—vent it?",
	"Put the hentai engine to rest?",
	"Send it back to the underworld?",
	"Make it commit Sudoku?",
	"Torch it like bad fanfic?",
	"Drain its chakra permanently?",
	"Ban this RAM-devouring waifu?",
	"Thanos-snap Blender's ass?",
	"Cancel Blender harder than Twitter?",
	"Make Blender pay for its sins?",
	"End this anime arc early?",
	"Kick Blender off the mortal coil?",
	"Defrag Blender’s soul?",
	"It’s over 9000—end it?",
	"Give Blender the 404 treatment?",
	"No simp for Blender—nuke it?",
	"This ain't a render farm, it's a warzone—terminate?",
}
var titles = []string{
	"Render Reaper",
	"Task Manager's Revenge",
	"CPU's Last Stand",
	"RAM's Cry for Help",
	"Blender Judgment Day",
	"System Purge Incoming",
	"Too Spicy for This PC",
	"Thermal Meltdown Imminent",
	"Waifu Execution Protocol",
	"Exorcise This Software",
	"Maximum Edge Reached",
	"Dark Mode Engaged",
	"Final Destination: Blender",
	"Anime Plot Twist Detected",
	"No Chill Zone",
	"Blender.exe is Guilty",
	"Heater 9000 Detected",
	"RAM Goblin Tribunal",
	"Smite the Pixel Lord?",
	"GPU Crimes Tribunal",
	"Mission: Kill Process",
	"Thirsty for Cores",
	"Welcome to Lag Hell",
	"Memory Leak Detected",
	"Sussy Process Alert",
	"Initiate Kill Sequence",
	"Crunch Time, Literally",
	"Goodbye, GPU Bandit",
	"Edge Mode: ON",
	"Operation: Blender Snuff",
}

func main() {
	for {
		procs, err := process.Processes()
		if err != nil {
			fmt.Println("Could not get processes")
			os.Exit(1)
		}
		for _, proc := range procs {
			name, _ := proc.Name()
			exe, _ := proc.Exe()

			if strings.Contains(strings.ToLower(name), "blender") ||
				strings.Contains(strings.ToLower(exe), "blender") {
				memory, err := proc.MemoryPercent()
				if err != nil {
					continue
				}
				if memory > 10 {
					title_i, prompt_i := rand.Int()%len(titles), rand.Int()%len(prompts)
					res := Popup.Dialog(titles[title_i], prompts[prompt_i])
					if res {
						proc.Kill()
					}
					time.Sleep(time.Second * 5)
				}
			}

		}
		time.Sleep(time.Millisecond * 500)
	}
}
