import subprocess

# Sample text
sample_text = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""
cmd_out = subprocess.Popen(["echo", sample_text], stdout=subprocess.PIPE, text=True)

# Execute the FZF command with the sample text piped to it
try:
    result = subprocess.Popen(["fzf"], stdin=cmd_out.stdout, stdout=subprocess.PIPE, text=True)
    selected_entry, _ = result.communicate()  # Get the selected entry
    print("Selected entry:", selected_entry)
except subprocess.CalledProcessError:
    print("Error: FZF command failed.")
