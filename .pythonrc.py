import sys

sys.ps1 = "pass; "
sys.ps2 = ""

def catchex(fn, *args, **kwargs):
    try:
        result = fn(*args, **kwargs)
    except BaseException as e:
        return e
    else:
        return result
