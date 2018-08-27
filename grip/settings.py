"""\
Default Configuration

Do NOT change the values here for risk of accidentally committing them.
Override them using command-line arguments or with a settings_local.py in
this directory or in ~/.grip/settings.py instead.
"""
import subprocess
import re


HOST = 'localhost'
PORT = 6419
DEBUG = False
DEBUG_GRIP = False
CACHE_DIRECTORY = 'cache-{version}'
AUTOREFRESH = True
QUIET = False


# Custom GitHub API
API_URL = None


# Custom styles
STYLE_URLS = []

# Grab password from macOS keychain
def grab_gh_password():
    invocation = ['security', 'find-internet-password', '-gs', 'github.com']
    block = subprocess.Popen(invocation, stdout = subprocess.PIPE, stderr = subprocess.PIPE)
    lastline = block.stderr.read().strip().decode("utf-8")
    parsed_password = re.sub('password: "(.*)"', '\\1', lastline)
    return parsed_password


PASSWORD = grab_gh_password()
USERNAME = 'dougpagani'
