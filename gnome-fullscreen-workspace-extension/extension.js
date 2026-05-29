import Meta from 'gi://Meta';

let signals = [];
let createdSignal = null;

function moveToNewWorkspace(win) {

    if (win._moved)
        return;

    win._moved = true;

    const manager = global.workspace_manager;

    manager.append_new_workspace(
        false,
        global.get_current_time()
    );

    const newWorkspace =
        manager.get_workspace_by_index(
            manager.n_workspaces - 1
        );

    win.change_workspace(newWorkspace);

    newWorkspace.activate_with_focus(
        win,
        global.get_current_time()
    );
}

function handleWindow(win) {

    const signal = win.connect(
        'notify::fullscreen',
        () => {

            if (win.is_fullscreen()) {
                moveToNewWorkspace(win);
            } else {
                win._moved = false;
            }
        }
    );

    signals.push([win, signal]);
}

export default class Extension {

    enable() {

        global.get_window_actors().forEach(actor => {
            handleWindow(actor.meta_window);
        });

        createdSignal = global.display.connect(
            'window-created',
            (_, win) => {
                handleWindow(win);
            }
        );
    }

    disable() {

        if (createdSignal)
            global.display.disconnect(createdSignal);

        signals.forEach(([win, signal]) => {
            try {
                win.disconnect(signal);
            } catch {}
        });

        signals = [];
    }
}