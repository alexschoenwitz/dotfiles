if status is-interactive
	# List of terminals where tmux should auto-start
	set -l allowed_terminals ghostty

	if test -z "$TMUX"; and test -n "$TERM"; and not string match -q -- '*tmux*' "$TERM"
		if contains -- "$TERM_PROGRAM" $allowed_terminals
			if type -q tmux
				exec tmux
			end
		end
	end
end

if command -v bat > /dev/null
	abbr -a cat 'bat'
end

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -l'
	abbr -a lll 'eza -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

if command -v zoxide > /dev/null
    zoxide init fish --cmd cd | source
end

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

set -g fish_greeting
