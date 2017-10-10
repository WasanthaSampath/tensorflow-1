# Macros for building ROCm code.
def if_rocm(if_true, if_false = []):
    """Shorthand for select()'ing on whether we're building with ROCm.

    Returns a select statement which evaluates to if_true if we're building
    with ROCm enabled.  Otherwise, the select statement evaluates to if_false.

    """
    return select({
        "//conditions:default": if_true
    })


def rocm_default_copts():
    """Default options for all CUDA compilations."""
    return if_rocm(["-DGOOGLE_CUDA=1"])


def rocm_is_configured():
    """Returns true if ROCm was enabled during the configure process."""
    return %{rocm_is_configured}

def if_rocm_is_configured(x):
    """Tests if the ROCm was enabled during the configure process.

    Unlike if_rocm(), this does not require that we are building with
    --config=rocm. Used to allow non-ROCm code to depend on ROCm libraries.
    """
    if rocm_is_configured():
      return x
    return []