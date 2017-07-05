#include <Python.h>
#include <math.h>

const double e = 2.7182818284590452353602874713527;

double _sinh(double x) {
    return (1 - pow(e, -2 * x)) / (2 * pow(e, -x));
}

double _cosh(double x) {
    return (1 + pow(e, -2 * x)) / (2 * pow(e, -x));
}

PyObject *_tanh(PyObject *o) {
    double x = PyFloat_AsDouble(o);
    return PyFloat_FromDouble(_sinh(x) / _cosh(x));
}


PyDoc_STRVAR(fast_map_tanh_doc, "(sequence)\
\
Applies tanh to an entire sequence.");

PyObject *superfastcode_fast_map_tanh(PyObject *self, PyObject *args, PyObject *kwargs) {
    /* Shared references that do not need Py_DECREF before returning. */
    PyObject *obj = NULL;

    /* Parse positional and keyword arguments */
    static char* keywords[] = { "sequence",NULL };
    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O", keywords, &obj)) {
        return NULL;
    }

    PyObject *res = PyList_New(0);
    if (!res) {
        return NULL;
    }
    PyObject *iter = PyObject_GetIter(obj);
    if (!iter) {
        return NULL;
    }

    PyObject *o;
    while ((o = PyIter_Next(iter)) != NULL) {
        PyObject *th_o = _tanh(o);
        Py_DECREF(o);

        int r = PyList_Append(res, th_o);
        Py_DECREF(th_o);
        if (r < 0) {
            Py_DECREF(iter);
            Py_DECREF(res);
            return NULL;
        }
    }

    Py_DECREF(iter);

    return res;
}

/*
* List of functions to add to superfastcode in exec_superfastcode().
*/
static PyMethodDef superfastcode_functions[] = {
    { "fast_map_tanh", (PyCFunction)superfastcode_fast_map_tanh, METH_VARARGS | METH_KEYWORDS, fast_map_tanh_doc },
    { NULL, NULL, 0, NULL } /* marks end of array */
};

/*
* Initialize superfastcode. May be called multiple times, so avoid
* using static state.
*/
int exec_superfastcode(PyObject *module) {
    PyModule_AddFunctions(module, superfastcode_functions);

    PyModule_AddStringConstant(module, "__author__", "Steve Dower");
    PyModule_AddStringConstant(module, "__version__", "1.0.0");
    PyModule_AddIntConstant(module, "year", 2017);

    return 0; /* success */
}

/*
* Documentation for superfastcode.
*/
PyDoc_STRVAR(superfastcode_doc, "The superfastcode module");


static PyModuleDef_Slot superfastcode_slots[] = {
    { Py_mod_exec, exec_superfastcode },
    { 0, NULL }
};

static PyModuleDef superfastcode_def = {
    PyModuleDef_HEAD_INIT,
    "superfastcode",
    superfastcode_doc,
    0,              /* m_size */
    NULL,           /* m_methods */
    superfastcode_slots,
    NULL,           /* m_traverse */
    NULL,           /* m_clear */
    NULL,           /* m_free */
};

PyMODINIT_FUNC PyInit_superfastcode() {
    return PyModuleDef_Init(&superfastcode_def);
}
