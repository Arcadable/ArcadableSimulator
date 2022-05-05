#ifndef GameDataInputWindow_H
#define GameDataInputWindow_H
#include "../nfd/nfd.h"

class GameDataInputWindow {
    public:
        nfdchar_t *outPath = NULL;
        void Render();
};

#endif
