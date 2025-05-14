#!/usr/bin/env python3
import os
import subprocess

if __name__ == '__main__':
    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
    sinks = list_pipewire_sinks()
    
    if len(sinks) > 0:
        print(f'{{"text": "{sinks[0]}", "tooltip": "Click to cycle Pipewire sinks", "alt": "pipewire-sink"}}')
    else:
        print('{"text": "No Pipewire sinks available"}')

    mainloop = GLib.MainLoop()
    GLib.timeout_add_seconds(1, mainloop.quit)
    mainloop.run()
