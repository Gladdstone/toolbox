import fputs

fputs.fputs('python', 'write.txt')

with open('write.txt', 'r') as file:
  print(file.read())
