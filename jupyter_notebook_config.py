import os

# Jupyter Notebook config to start inside the notebooks folder.
c.FileContentsManager.root_dir = "notebooks"  # noqa F821

print("relative os.curdir: " + os.curdir)
print("absolute os.curdir: " + os.path.abspath(os.curdir))
