set $64BITS = 1
set debuginfod enabled on
set disassembly-flavor intel

# Options d'affichage
set print pretty on
set print static-members on
set print vtbl on
set print sevenbit-strings off
set print entry-values no
set print object on
set print raw-values off
set print finish off

# Historique
set history expansion on
set history save on
set history filename /home/stephane/.gdb_history

# === Layouts ===
# windows: src cmd stack memory regs locals(?) status asm

define stef_layout
    tui new-layout stef {-horizontal asm 1 regs 1} 2 {-horizontal cmd 1 src 1} 2 status 0
    layout stef
end

# Apply on launch
# define use_stef_layout
#     tui enable
#     tui set layout stef_layout
# end
# use_stef_layout

# === Display main arguments ===
define show_main_args
    if info functions main
        break main
        commands
            silent
            printf "Program started with arguments:\n"
            if argv != 0
                x/s *(char**)argv
                if argc > 1
                    set $i = 1
                    while $i < argc
                        printf "  arg[%d]: %s\n", $i, *(char**)(argv + $i)
                        set $i = $i + 1
                    end
                else
                    printf "  (No arguments)\n"
                end
            else
                printf "  (Cannot retrieve arguments - argv is null or not found)\n"
            end
            continue
        end
    else
        echo "Error: 'main' function not found. Please load a program with debug symbols.\n"
    end
end

# === Fonction : afficher le contexte courant (registre, assembleur, stack) ===
define show_context
    info registers
    x/10i $pc
    info locals
    bt
end
document show_context
    Affiche l'état courant : registres, instructions autour de $pc, variables locales, backtrace.
end

# Pretty printers (à adapter selon tes installations)
# python
# import sys
# sys.path.insert(0, '/usr/share/gdb/python')
# from libstdcxx.v6.printers import register_libstdcxx_printers
# register_libstdcxx_printers(None)
# end

# python
# import gdb.printing
# gdb.printing.register_pretty_printer(
#     gdb.current_objfile(),
#     gdb.printing.SubprinterCollection("python-objects"))
# end
