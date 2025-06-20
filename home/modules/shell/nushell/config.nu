use std repeat

$env.EDITOR = "nvim"

const config_path = $nu.default-config-dir | path join "nu_scripts";
const scripts_path = $nu.default-config-dir | path join "scripts";
const themes_path = $config_path | path join "themes" | path join "nu-themes";
const completions_path = $config_path | path join "custom-completions";
const aliases_path = $config_path | path join "aliases";
const hooks_path = $config_path | path join "nu-hooks/nu-hooks";

# current theme
source ($themes_path | path join "tokyo-moon.nu")

# hooks
source ($hooks_path | path join "rusty-paths/rusty-paths.nu")
source ($hooks_path | path join "command_not_found/did_you_mean.nu")

# completions
source ($completions_path | path join "cargo/cargo-completions.nu")
source ($completions_path | path join "git/git-completions.nu")
source ($completions_path | path join "nix/nix-completions.nu")
source ($completions_path | path join "nix/nix-completions.nu")
source ($completions_path | path join "rustup/rustup-completions.nu")
source ($completions_path | path join "ssh/ssh-completions.nu")

# aliases
source ($aliases_path | path join "git/git-aliases.nu")

# custom scripts
source ($scripts_path | path join "nufetch.nu")

$env.PATH = ($env.PATH |
  split row (char esep) |
  prepend /home/ye/bin |
  append /home/ye/go/bin
)

$env.config = {
    buffer_editor: "nvim"
    edit_mode: "vi"
    show_banner: false
    menus: [
        {
            name: commands_with_description_menu
            only_buffer_difference: true
            marker: "# "
            type: {
                layout: description
                columns: 4
                col_width: 20
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
            source: { |buffer, position|
                scope commands
                | where name =~ $buffer
                | each { |it| {value: $it.name description: $it.description} }
            }
        }
    ]
}

def create_left_prompt [] {
    # Time segment (yellow)
    let time_segment = (date now | format date '%H:%M:%S' | $"(ansi yellow_bold)($in)(ansi reset)")

    # Path segment (green)
    let path_segment = (
        $env.PWD
        | str replace $env.HOME "~"
        | split row "/"
        | each {|it| $it }
        | str join "/"
        | $"(ansi green_bold)($in)(ansi reset)"
    )

    # Git segment (blue with red modification indicator)
    let git_segment = (
        if (do -i { git rev-parse --is-inside-work-tree } | complete | get exit_code) == 0 {
            let branch = (do -i { git branch --show-current } | complete | get stdout | str trim)
            let changes = (do -i { git status --porcelain } | complete | get stdout | str trim)
            let status = if ($changes | is-empty) { "" } else { " *" }
            $"(ansi blue_bold) ($branch)(ansi red)($status)(ansi reset)"
        } else {
            ""
        }
    )

    let nix_segment = (
        if ($env | columns | any {|c| $c == "IN_NIX_SHELL" }) and ($env.IN_NIX_SHELL | default "" | str trim | is-not-empty) {
            $"(ansi magenta_bold) (ansi reset)"
        } else {
            ""
        }
    )

    # Combine all segments
    [$time_segment $path_segment $git_segment $nix_segment]
    | filter {|x| not ($x | is-empty) }
    | str join " "
}


# Prompt setup
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { || "" }

# VI mode indicators
$env.PROMPT_INDICATOR_VI_INSERT = { || ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = { || "> " }

# Multiline indicator
$env.PROMPT_MULTILINE_INDICATOR = { || "::: " }

# Main prompt indicator with exit code awareness
$env.PROMPT_INDICATOR = { ||
    let last_exit_code = $env.LAST_EXIT_CODE
    let indicator = if ($last_exit_code == 0) {
        $"(ansi cyan)❯(ansi reset)"
    } else {
        $"(ansi red)❯(ansi reset)"
    }
    $"\n($indicator) "
}

novofetch
