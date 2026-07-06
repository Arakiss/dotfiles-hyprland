# greet.zsh — Night City daily greeting (2026-07-06)
# Fires ONCE per new interactive tab (guarded by env), never inside agent
# shells (CLAUDECODE). ANSI named colors only → re-skins with the active vibe.
# The "shader" here is typographic: a glitched header char + offset echo line,
# zero GPU. Run `greet` anytime for another quote.

night-city-greet() {
    emulate -L zsh
    local -a quotes
    quotes=(
        'Wake up, samurai. We have a city to burn.|Johnny Silverhand'
        'Preem. Ship it.|Rebecca'
        "I'd say the crew is only as good as its runner.|Lucy"
        'Nunca dejes que te calculen las probabilidades.|David Martínez'
        'Talk is cheap. Show me the code.|Linus Torvalds'
        'Hackea el planeta.|Hackers, 1995'
        'There is no place like 127.0.0.1.|proverbio netrunner'
        'sudo make me a sandwich.|xkcd 149'
        'Any sufficiently advanced technology is indistinguishable from magic.|Arthur C. Clarke'
        'Programs must be written for people to read, and only incidentally for machines to execute.|Harold Abelson'
        'First, solve the problem. Then, write the code.|John Johnson'
        'The quieter you become, the more you are able to hear.|motd de Kali'
        'El código legacy también fue el futuro una vez.|anónimo de Night City'
        'Compila a la primera. Sospecha.|proverbio netrunner'
        'La nube es solo el ordenador de otro corpo.|refrán de Kabuki'
        'Los TODO de hoy son los WTF de mañana.|ley de Arasaka Tower'
        'Chrome brillante, deuda técnica oscura.|proverbio ripperdoc'
        'Un gonk con root sigue siendo un gonk.|netrunner anónimo'
        'En Night City todos tienen un plan hasta que el linter opina.|V'
        'No es un bug: es una feature sin documentar.|clásico'
        'El mejor commit es el que borra más de lo que añade.|sabiduría de Afterlife'
        'Eres tu mejor firewall.|manual del netrunner, cap. 1'
        'Duerme. El deploy puede esperar a mañana.|nadie, nunca'
        'Si funciona, no lo toques. Primero haz backup; luego tampoco lo toques.|ley de Vik'
        'Move fast and fix things.|edición Night City'
        'La legibilidad es una feature. El cringe es un bug.|refrán de Night City'
    )
    local pick="${quotes[$((RANDOM % ${#quotes} + 1))]}"
    local text="${pick%%|*}" author="${pick##*|}"

    # Time-aware salute
    local hour=$(date +%H) salute="Buenas noches"
    (( hour >= 6 && hour < 14 )) && salute="Buenos días"
    (( hour >= 14 && hour < 21 )) && salute="Buenas tardes"
    local stamp="$(date '+%A · %H:%M')"

    # Glitched header: one random INNER char flips to a block in cyan.
    # Never the first/last letter — a glitched edge reads as breakage, not style.
    local title="NIGHT CITY" glitched="" i
    local gpos=$((RANDOM % (${#title} - 2) + 2))
    local -a blocks=('▓' '▒' '█' '░')
    for (( i = 1; i <= ${#title}; i++ )); do
        if (( i == gpos )) && [[ "${title[i]}" != " " ]]; then
            glitched+="%F{cyan}${blocks[$((RANDOM % ${#blocks} + 1))]}%F{yellow}"
        else
            glitched+="${title[i]}"
        fi
    done

    # Quote in default fg + italic (never a palette gray: some themes render
    # color 8 near-invisible on dark backgrounds — field-tested 2026-07-06)
    print -P ""
    # Timestamp in explicit mid-gray (256c 245): palette-8 grays vary by theme
    print -P "  %F{yellow}%B▌${glitched}%b%f  %F{cyan}${salute}, choom.%f  %{\e[38;5;245m%}${stamp}%{\e[0m%}"
    print    "  \e[3m\"${text}\"\e[23m \e[36m— ${author}\e[0m"
    print -P ""
}

alias greet=night-city-greet

# Auto-greet: once per tab, interactive only, never in agent tool shells
if [[ -o interactive && -z "${NIGHT_CITY_GREETED:-}" && -z "${CLAUDECODE:-}" && -z "${CODEX_SANDBOX:-}" ]]; then
    export NIGHT_CITY_GREETED=1
    night-city-greet
fi
