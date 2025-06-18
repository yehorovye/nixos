let pri = ansi --escape '38;2;82;119;195m'
let sec = ansi --escape '38;2;127;183;255m'
let pri_bg = ansi --escape '48;2;82;119;195m'
let sec_bg = ansi --escape '48;2;127;183;255m'
let reset = ansi reset

let arts = [
{
  name: "NixOS",
  art: $"
($pri)       ██   ($sec)███  ██
($pri)       ███   ($sec)██████
($pri)        ███   ($sec)██████
($pri)    ████████████($sec_bg)($reset)($sec)████($pri)   
($pri)   ██████████████($sec_bg)($reset)($sec)███($pri)  ██
($sec)        ███      ███($pri)███
($sec)       ███        ██($pri_bg)($reset)($pri)███
($sec)█████████          ($pri_bg)($reset)($pri)████████
($sec)████████($pri_bg)($reset)($pri)          █████████
($sec)    ███($pri_bg)($reset)($pri)██        ███
($sec)   ███($pri)███      ███
($sec)   ██  ($pri)███($sec_bg)($reset)($sec)██████████████
($sec)       ($pri)████($sec_bg)($reset)($sec)████████████
($pri)        ██████   ($sec)███
($pri)       ██████   ($sec)███
($pri)       ██  ███   ($sec)██($reset)
"
}
]

def get_art [--fake: string] {
  if ($fake | is-not-empty) {
    return ($arts | where name == $fake | first | get art)
  }

  let host = sys host
  let target = $arts | where name == $host.name | first 
  if ($target | is-empty) {
    return ""
  } else {
    let ar = $target | get art
    return $ar
  }
}

def get_pc_model [] {
    if ($nu.os-info.name == "windows") {
      let info = wmic computersystem get model /format:csv | from csv | first
      return $info.Model
    } else if ($nu.os-info.name == "linux") {
      return (cat /sys/class/dmi/id/product_name)
    }
}

def get_shell [] {
    $env.SHELL | path split | last
}

def get_local_ip [] {
    ip -j route | from json | default gateway ""| default metric "" | first | get prefsrc
}

def calculate_packages [] {
  # TODO
    let nix_packages = ls /run/current-system/sw/bin | length
    return {
        nix: $nix_packages,
    }
}

def print_dots [] {
    let colors = {
        blue: "34m",
        cyan: "36m",
        green: "32m",
        yellow: "33m",
        red: "31m",
        magenta: "35m",
    }
    let dots = $colors | values | each {|k| $'(ansi --escape $k) '}

    return $"($dots | str join ' ') (ansi --escape '0m')"
}

def get_gpus [] {
    lspci | where description =~ "VGA" | each {|x| $'($x.description)'}
}

def nufetch [ --fake: string -l ] {
  if ($l) {
    return $arts
  }

  let art = get_art --fake $fake

  let hostinfo = sys host
  let pkgs = calculate_packages | transpose name count | each {|x| $"($x.name) - ($x.count)"} | str join ", "
  let cpus = sys cpu | get brand | uniq
  let disks = sys disks | each {$"(ansi yellow)Диск \(($in.mount)\)(ansi white): ($in.total) / ($in.free) \(((((($in.total - $in.free) / $in.total) * 100) | math floor))%\)"}

  let information = [
    $"(ansi blue)(whoami)(ansi white)@(ansi blue)($hostinfo.hostname)(ansi white)",
    "-------------------------------------",
    $"(ansi yellow)ОC(ansi white): ($hostinfo.long_os_version) ($hostinfo.kernel_version)",
    $"(ansi yellow)Модель(ansi white): (get_pc_model)",
    $"(ansi yellow)Ядро(ansi white): ($hostinfo.long_os_version)",
    $"(ansi yellow)Время(ansi white): ($hostinfo.uptime)",
    $"(ansi yellow)Oболочка(ansi white): (get_shell)",
    $"(ansi yellow)Пакеты(ansi white): ($pkgs)",
    $"(ansi yellow)Процессоры(ansi white): ($cpus | str join ', ')",
    $"(ansi yellow)Память(ansi white): ((sys mem | $'($in.total) / (ansi red)($in.used)(ansi white) / (ansi green)($in.free)(ansi white)'))",
    ...$disks,
    $"(ansi yellow)Локальный IP(ansi white): (get_local_ip)",
    $"(ansi yellow)Цвета(ansi white): (print_dots)",
  ]

  
  print ([[Арт, Информация]; [$art ($information | str join "\n")]] | table -i false)
}

