target("libco")
    set_kind("$(kind)")
    set_basename("co")
    add_files("**.cc")

    add_options("with_openssl")
    add_options("with_libcurl")

    if has_config("with_libcurl") then
        add_packages("libcurl")
        add_packages("openssl")
    elseif has_config("with_openssl") then
        add_packages("openssl")
    end 

    if is_plat("windows") then
        add_files("__/StackWalker.cpp")
        add_files("co/detours/creatwth.cpp")
        add_files("co/detours/detours.cpp")
        add_files("co/detours/image.cpp")
        add_files("co/detours/modules.cpp")
        add_files("co/detours/disasm.cpp")
        if is_arch("x64") then
            add_files("co/context/context_x64.asm")
        else
            add_files("co/context/context_x86.asm")
        end
    else
        includes("check_cincludes.lua")
        check_cincludes("HAS_EXECINFO_H", "execinfo.h")
        add_files("co/context/context.S")
    end

