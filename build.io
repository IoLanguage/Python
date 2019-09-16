AddonBuilder clone do(

    pyConfigCall := System runCommand("python3-config --prefix")

    if(pyConfigCall succeeded,
        pythonPrefix := pyConfigCall stdout asMutable strip

        version := list("3.7", "3.6", "3.5", "3.4", "3.3", "3.2", "3.1", "3.0") detect(v, System system("python" .. v .. " -V 2> /dev/null") == 0)

        dependsOnHeader("Python.h")
        dependsOnLib("python" .. version)

        appendHeaderSearchPath("#{pythonPrefix}/include/" interpolate)
        appendLibSearchPath("#{pythonPrefix}/lib" interpolate)
        headerSearchPaths foreach(headerSearchPath, appendHeaderSearchPath(headerSearchPath .. "/python" .. version))
        headerSearchPaths foreach(headerSearchPath, appendHeaderSearchPath(headerSearchPath .. "/python" .. version .. "m"))

        ,
        Error withShow("Can't run python3-config")
        return
    )

)
