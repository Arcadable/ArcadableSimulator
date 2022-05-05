#include "../imgui/imgui.h"
#include "gameDataInputWindow.h"
#include "../nfd/nfd.h"

void GameDataInputWindow::Render() {
    ImGui::Begin("File Select");

    if (ImGui::Button("Select file to simulate", ImVec2(200, 0))) {
        NFD_OpenDialog( "png,jpg;pdf", NULL, &outPath );
    }
    if(outPath != NULL) {
        ImGui::Text("Selected file: %s", outPath);
    } else {
        ImGui::Text("No file selected.");
    }

    ImGui::End();
}
