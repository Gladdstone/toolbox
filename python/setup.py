from distutils.core import setup, Extension

def main():
    setup(name="fputs",
    version="1.0.0",
    description="Python interface for the fputs C library function",
    author="Joseph Farrell",
    author_email="your_email@gmail.com",
    ext_modules=[Extension("fputs", ["pythonext.c"])])

if __name__ == "__main__":
    main()

