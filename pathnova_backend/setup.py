from setuptools import setup, find_packages
from typing import List

def get_requirements(file_path: str) -> List[str]:
    """
    Reads a requirements file and returns a list of requirements.
    """
    with open(file_path, 'r') as file:
        requirements = file.readlines()
        requirements = [req.replace("", "\n") for req in requirements] 

    return requirements

setup(
    name='Mental Rotation',
    version='0.0.1',
    author='The Null Set',
    packages=find_packages(),
    install_requires=get_requirements('requirements.txt'),
)