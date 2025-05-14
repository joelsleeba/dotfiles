#!/bin/env python

import csv
import subprocess as sp
import psutil
import colorama as c
from jinja2 import Template

# Initialize colorama
c.init()


def read_csv(file_path):
    data = []
    with open(file_path, 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)
    return data


def is_process_running(name):
    for process in psutil.process_iter(['name']):
        if process.info['name'] == name:
            return True
    return False


def fzf_station_select(file_path):
    data = read_csv(file_path)

    # Add color. This is currently not working with piping to fzf
    template_str = "{% for entry in data %}{{ c.Fore.MAGENTA }}{% if entry['station']|length > 40 %}{{ entry['station'][:37] + '...' }}{% else %}{{ entry['station'].ljust(40) }}{% endif %}{{ c.Style.RESET_ALL }} :: {{ c.Fore.CYAN }}{% if entry['radio']|length > 12 %}{{ entry['radio'][:9] + '...' }}{% else %}{{ entry['radio'].ljust(12) }}{% endif %}{{ c.Style.RESET_ALL }} :: {{ c.Fore.YELLOW }}{{ entry['link'] }}{{ c.Style.RESET_ALL }}\n{% endfor %}"
    # template = Template(template_str)
    # output = template.render(data=data, c={'Fore': Fore, 'Style': Fore})  # Render the output

    # template_str = "{% for entry in data %}{% if entry['station']|length > 40 %}{{ entry['station'][:37] + '...' }}{% else %}{{ entry['station'].ljust(40) }}{% endif %} :: {% if entry['radio']|length > 12 %}{{ entry['radio'][:9] + '...' }}{% else %}{{ entry['radio'].ljust(12) }}{% endif %} :: {{ entry['link'] }}\n{% endfor %}"
    template = Template(template_str)
    # output = template.render(data=data, c={'Fore': Fore})  # Render the output
    output = template.render(data=data, c=c)  # Render the output

    cmd_out = sp.Popen(["echo", output], stdout=sp.PIPE, text=True)
    fzf_command = ["fzf", "--ansi", "-i"]
    try:
        result = sp.Popen(fzf_command, stdin=cmd_out.stdout,
                          stdout=sp.PIPE, text=True)
        selected_entry, _ = result.communicate()
        return selected_entry.split(' ')[-1].strip()
    except sp.CalledProcessError:
        print("Error: FZF command failed.")
        return None


def main():
    # Update with your CSV file path
    file_path = '/home/joel/.config/userscripts/radio-stations.csv'
    stream_link = fzf_station_select(file_path)
    if stream_link:
        if is_process_running("mpv"):
            sp.run(["killall", "mpv"])
        sp.run(["mpv", stream_link])  # , "--title=Picture-in-Picture"])
    else:
        print("No entry selected.")


if __name__ == "__main__":
    main()
