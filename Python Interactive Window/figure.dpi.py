# Updates the default resolution of matplotlib figures.

def _set_default_dpi(dpi):
    import matplotlib.pyplot
    matplotlib.pyplot.rcParams['figure.dpi'] = float(dpi)

_set_default_dpi(300)
