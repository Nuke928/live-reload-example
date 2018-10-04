#include "shared.h"

struct GameState
{
    GameMemory memory;
    PlatformAPI api;

    float x;
    float y;
};

static GameState *state;

extern "C" GAME_INIT(GameInit)
{
    state = GameAllocateStruct(&memory, GameState);
    state->api = api;

    if(state->memory.ptr == 0) {
        state->memory = memory;
    }
}

extern "C" GAME_UPDATE(GameUpdate)
{
    state->x += dt * 50.0f;
    state->y += dt * 50.0f;
}

extern "C" GAME_RENDER(GameRender)
{
    state->api.PlatformDrawBox(state->x, state->y, 50.0f, 50.0f);
}
