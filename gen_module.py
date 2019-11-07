import fileinput
import sys

repo_name = sys.argv[1]
module_name = sys.argv[2]

files = ["spec/PCModule.spec.js", "src/PCModule.js", "package.json", 
"package-lock.json"]

for file in files:
	filename = "../{}/".format(repo_name) + file
	
	file = open(filename, 'r')
	filedata = file.read()
	file.close()

	filedata = filedata.replace('MODULE_NAME', module_name)
	filedata = filedata.replace('REPO_NAME', repo_name)

	file = open(filename, 'w')
	file.write(filedata)
	file.close()
