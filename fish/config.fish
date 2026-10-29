# ~/.config/fish/config.fish

# ---------- Environment (runs for every fish, including `fish -c`) ----------
set -gx EDITOR nvim
set -gx HELIX_RUNTIME ~/git/helix/runtime

# ---------- Interactive only ----------
if status is-interactive

    # Load extra files only if they exist
    for f in aliases.fish system.fish
        test -f $__fish_config_dir/$f; and source $__fish_config_dir/$f
    end

    # opam
    type -q opam; and eval (opam env)

    # cht.sh completion
    type -q cht.sh; and complete -c cht.sh -xa '(curl -s cht.sh/:list)'

    # Man pager: prefer nvim, fall back to bat
    if type -q nvim
        set -gx MANPAGER "nvim +Man!"
    else if type -q bat
        set -gx MANPAGER "bat -plman"
    end

    # ---------- Utilities ----------

    # yazi: cd into the directory you were in when you quit
    if type -q yazi
        function y
            set tmp (mktemp -t "yazi-cwd.XXXXXX")
            yazi $argv --cwd-file="$tmp"
            if set cwd (command cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
                builtin cd -- "$cwd"
            end
            rm -f -- "$tmp"
        end
        alias f=y
    end

    # Move $to's contents... swap: move $from to $to, then symlink $from -> $to
    function ln-swap -a from to
        if test -e "$to"
            echo "ln-swap: $to already exists, aborting" >&2
            return 1
        end
        mv $from $to; and ln -sf (realpath $to) $from
    end

    function dot -a what
        ln-swap ~/.config/$what ~/dotfiles/.config/$what
    end

    # ---------- Keybinds (fish 4.0+ syntax) ----------
    bind ctrl-z 'fg 2>/dev/null; commandline -f repaint'  # reopen with C-z
    bind alt-v fish_clipboard_paste
    bind ctrl-h backward-delete-char
    bind super-backspace backward-kill-word
    bind ctrl-x edit_command_buffer
    bind alt-z undo
    bind alt-shift-z redo

    # Zellij file picker
    set -q ZELLIJ_SESSION_NAME; and bind alt-e 'cd (zellij pipe -p filepicker)'

end
