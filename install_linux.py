import os
import shutil

# walk through present directories and install any
# sh files in bin
for dirpath, dirnames, filenames in os.walk('./'):
  if '.git' in dirnames:
    dirnames.remove('.git')

  for file in filenames:
    file_split = file.split('.')
    if file_split[-1] == 'sh':
      try:
        shutil.copy(dirpath + '/' + file, '/usr/local/bin/' + ''.join(file_split[:-1]))
      except Exception as e:
        pass

