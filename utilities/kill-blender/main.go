package main

import (
	"fmt"
	"os"
	"strings"
	"time"

	"github.com/ChromeTemp/Popup"
	"github.com/shirou/gopsutil/process"
)

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
					res := Popup.Dialog("Dialog", "Want to kill blender?")
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
