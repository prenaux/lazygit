package oscommands

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func GetPlatform() *Platform {
	// If we're running inside Git Bash / MSYS2 / Cygwin, the SHELL env var
	// is set (e.g. "/usr/bin/bash"). In that case, use bash so that shell
	// scripts and commands available in the user's PATH work correctly
	// instead of being routed through cmd.exe which can't find them.
	if shell := os.Getenv("SHELL"); shell != "" {
		// Extract the base name (e.g. "bash" from "/usr/bin/bash") and
		// look for the corresponding .exe on the Windows PATH.
		base := filepath.Base(shell)
		base = strings.TrimSuffix(base, ".exe")
		if exePath, err := exec.LookPath(base + ".exe"); err == nil {
			prefixForShellFunctionsFile := ""
			if base == "bash" {
				prefixForShellFunctionsFile = "shopt -s expand_aliases\n"
			}
			return &Platform{
				OS:                          "windows",
				Shell:                       exePath,
				ShellArg:                    "-c",
				PrefixForShellFunctionsFile: prefixForShellFunctionsFile,
			}
		}
	}

	return &Platform{
		OS:       "windows",
		Shell:    "cmd",
		ShellArg: "/c",
	}
}

func (c *OSCommand) UpdateWindowTitle() error {
	path, getWdErr := os.Getwd()
	if getWdErr != nil {
		return getWdErr
	}
	title := filepath.Base(path) + " - Lazygit"

	if c.Cmd.isCmdShell() {
		// "title" is a cmd.exe built-in
		return c.Cmd.NewShell(fmt.Sprint("title ", title), c.UserConfig().OS.ShellFunctionsFile).Run()
	}

	// For bash/other shells, use the ANSI escape sequence to set the
	// terminal title.
	fmt.Printf("\033]0;%s\007", title)
	return nil
}

func TerminateProcessGracefully(cmd *exec.Cmd) error {
	// Signals other than SIGKILL are not supported on Windows
	return nil
}
