#include <Python.h>

/* #include <stdio.h> */
/* #include <stdlib.h> */
/* #include <unistd.h> */

/* int main() { */
/*     FILE *fp = fopen("write.txt", "w"); */
/*     fputs("Python ext", fp); */
/*     fclose(fp); */
/*     return 1; */
/* } */

static PyObject *method_fputs(PyObject *self, PyObject *args) {
    char *str, *filename = NULL;
    int bytes_copied = -1;

    /* Parse Arguments */
    if(!PyArg_ParseTuple(args, "ss", &str, &filename)) {
        return NULL;
    }

    FILE *fp = fopen(filename, "w");
    bytes_copied = fputs(str, fp);
    fclose(fp);

    return PyLong_FromLong(bytes_copied);
}

static PyMethodDef FputsMethods[] = {
    {"fputs", method_fputs, METH_VARARGS, "fputs function"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef fputsmodule = {
    PyModuleDef_HEAD_INIT,
    "fputs",
    "fputs function",
    -1,
    FputsMethods
};

PyMODINIT_FUNC PyInit_fputs(void) {
    return PyModule_Create(&fputsmodule);
}


