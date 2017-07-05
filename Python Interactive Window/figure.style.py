# Updates the default style of matplotlib figures

def _set_default_style(style):
    import matplotlib.style
    matplotlib.style.use(style)

_set_default_style('ggplot')
