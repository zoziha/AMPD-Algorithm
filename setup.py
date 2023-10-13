from setuptools import setup, find_packages

VERSION = "1.0.0"
DESCRIPTION = "Automatic multiscale-based peak detection (AMPD) algorithm"

setup(
    name="AMPD",
    version=VERSION,
    author="ZUO Zhihua",
    author_email="zuo.zhihua@qq.com",
    description=DESCRIPTION,
    packages=find_packages(),
    install_requires=["numpy"],
    keywords=["python", "peak detection", "multiscale", "time series"],
    classifiers=[
        "Intended Audience :: Education",
        "Programming Language :: Python :: 3",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: Microsoft :: Windows",
        "Operating System :: POSIX :: Linux",
        "License :: OSI Approved :: BSD-3 License",
        "Topic :: Scientific/Engineering :: Mathematics",
    ],
)
