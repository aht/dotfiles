import atexit
import readline
import rlcompleter
import os
import sys

from pprint import pprint as pp
from pprint import pformat as pf

try:
    history = os.path.expanduser('~/.python_history')
    open(history, 'a').close()
    readline.read_history_file(history)
    readline.parse_and_bind('tab: complete')
    atexit.register(readline.write_history_file, history)
except ImportError:
    pass

sys.ps1 = "pass; "
sys.ps2 = ""

def catchex(fn, *args, **kwargs):
    try:
        result = fn(*args, **kwargs)
    except BaseException as e:
        return e
    else:
        return result
