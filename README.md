# A Simple HL Extension

This is mostly for my own benefit so I have a model to follow when creating Hashlink extensions because I will forget how.
See the references section below for the resources I referred to in doing this.

## Steps

   1. First create a project directory which will contain
      1. the C++ extension,
      2. its Haxe wrapper module
      3. the test code - in this code that is just a Main.hx to demo a simple function
   2. Open up Visual Studio (the big one not VSCode) 
        For reference I am using Microsoft Visual Studio Community 2022 (64-bit) Version 17.0.4
      1. Create a new project
         1. File -> New Project...
         2. Select the Empty Project template and click Next
         3. Project Name: The name of the extension - here hlextLib
         4. Location: the project directory you created in the very first step above
         5. Solution: Create new solution
         6. Leave solution name blank
         7. Check "Place solution and project in the same directory"
         8. Hit Create
      2. In the Solution Explorer you should see the project (the VS project that is) directory.
         1. Right click on that and select Properties at the bottom of the context menu
            1. Make sure the Configuration Platform: is Active(x64).
            2. Under Configuration Properties
               1. Select the General tab, and
                  1. Make the Configuration Type `Dynamic Library (.dll)`
               2. Select the VC++ Directories tab, and
                  1. Add to Include Directories your Hashlink include directory. For example `D:\Program Files\HashLink1.14\include`
                  2. Add to Library Directories your hashlink directory. For example `D:\Program Files\HashLink1.14`
               4. Select the Build Events tab, and
                  1. Add a Post-Build Event
                     1. Command Line `copy $(TargetDir)$(TargetFileName)  $(TargetDir)$(TargetName).hdll `
                     2. This will make the dll and hdll which is what HL will load.
            3. Under Linker
               3. Select the Input tab, and
               4. Add `libhl.lib` to Additional Dependencies
      3. In the Solution Explorer right click on the Source Files directory
         1. New Item...
         2. C++ File
         3. and name is whatever you like, here hlext.c
      4. Follow reference [1] in creating the code you need.
      5. And then build the solution
         1. if all goes well you will have an hdll undex `\x64\Debug` in your VS project
   3. Now in the hlextLib directory
      1. Create another directory to house the Haxe wrapper module for the hdll. Here this is `hlext`
      2. Create a Haxe module in it like `HLExt.hx`
   4. Now in the overall project directory create a
      1. build.hxml containg this, or similar
        ```
        -cp hlextLib
        -main Main
        -hl export/hl/main.hl
        ```
      2. Main.hx
         1. This will contain the test code.
   
You should now be able to build the test code. If all goes well you will have a `main.hl`  under `export\hl`.

At this point you can open another Powershell to run the program. This will require adding the `<FULL PATH>/hlextLib/x64/Debug` directory to the shell `PATH` variable so that HL can load the extension.

Run with something like `& 'D:\Program Files\HashLink1.14\hl.exe' .\export\hl\main.hl`


## References

First, my thanx those who created these.

[1] https://github.com/HaxeFoundation/hashlink/wiki/HashLink-native-extension-tutorial

   This got me most of what I needed though I found a few omissions that left me casting around for exactly how to get a full runnable program using the extension. This also contains good reference material on data types, how to pass parameters and how to handle returns.

[2] https://github.com/josuigoa/hl-extension/tree/master

   This is a good example but more complex for a first try than I wanted. What I took from this mostly was the directory layout and build file.