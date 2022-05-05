WIP

My plan is to rework a lot of the software implementation of the arcadable project.
 - Get rid of https://github.com/Arcadable/ArcadableVSCodeExtension and https://github.com/Arcadable/ArcadableSampleGames
 - make use of https://github.com/PaulStoffregen/LittleFS and https://tldp.org/HOWTO/html_single/C++-dlopen/
 - Instead of having custom arcadableScript executed by a custom interpeter, I want to load actual c++ code as a dynamic runtime library from littleFS or something similar. No more custom programming language for arcadable, games written in c++.
 - This Arcadable is the first step in this process. Make a project which can simulate/emulate the physical game table. A desktop application which can load and run the c++ game files to test during development