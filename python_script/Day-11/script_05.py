# Create a Python script that counts the number of files for each file extension in the files list. The counting should be dynamic, which means your program must work for any file extension without hardcoding .pdf, .doc, or .txt.

files = [
    "resume.pdf",
    "report.doc",
    "notes.txt",
    "invoice.pdf",
    "project.doc",
    "todo.txt",
    "manual.pdf",
    "meeting_notes.doc",
    "readme.txt",
    "design.pdf",
    "contract.doc",
    "backup.txt",
    "presentation.pdf",
    "summary.doc",
    "logs.txt"
]

extension_count = {}

for file_name in files:
  
  file_list = file_name.lower().split('.')
  
  extension = file_list[1]
  
  if extension not in extension_count:

    extension_count[extension] = 1
  
  else:

    extension_count[extension] += 1
  
print(f'extension_count = {extension_count}')