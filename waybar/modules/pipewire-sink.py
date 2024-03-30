#!/usr/bin/env python3
import sys
import gi
import dbus
import dbus.mainloop.glib
from gi.repository import GLib

def list_pipewire_sinks():
    bus = dbus.SessionBus()
    pipewire_obj = bus.get_object('org.freedesktop.DBus', '/org/freedesktop/DBus')
    pipewire_iface = dbus.Interface(pipewire_obj, 'org.freedesktop.DBus')

    # Get a list of all Pipewire sinks
    sinks = pipewire_iface.ListNames()
    return [name for name in sinks if name.startswith('org.pipewire.MediaStream')]

def switch_sink(sink_name):
    bus = dbus.SessionBus()
    pipewire_obj = bus.get_object(sink_name, '/org/freedesktop/portal/desktop')
    pipewire_iface = dbus.Interface(pipewire_obj, 'org.freedesktop.portal.Device')
    pipewire_iface.SetActive(True)

def cycle_sinks(widget, event, data):
    if event.get('button') == 1:  # Check for left mouse click
        sinks = list_pipewire_sinks()
        if len(sinks) > 1:
            current_sink = sinks.index(data['instance'])
            next_sink = (current_sink + 1) % len(sinks)
            switch_sink(sinks[next_sink])

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
