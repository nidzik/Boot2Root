#!/bin/python3

import os

def main():
	seq = os.listdir("./ft_fun")
#	print(seq)
	i = 0
	while (i < 750):
		fd = open("./ft_fun/" + seq[i], 'r')
		file = fd.read()
#		print(file)
		fd.close()
		string = ""
		if (file[len(file) - 3] >= '0' and file[len(file) - 3] <= '9'):
			string += file[len(file) - 3]
		if (file[len(file) - 2] >= '0' and file[len(file) - 2] <= '9'):
			string += file[len(file) - 2]
		if (file[len(file) - 1] >= '0' and file[len(file) - 1] <= '9'):
			string += file[len(file) - 1]
		if (len(string) == 3):
			fd3 = open("./fun/file" + string + ".c", 'w')
			print("create: " + "./fun/file" + string + ".c")
			j = 0
			writer = ""
			while (j < len(file)):
				if (j < len(file) - 9):
					writer += file[j]
				j += 1
			fd3.write(writer)
			fd3.close()
		if (len(string) == 2):
			fd2 = open("./fun/file0" + string + ".c", 'w')
			print("create: " + "./fun/file0" + string + ".c")
			j = 0
			writer = ""
			while (j < len(file)):
				if (j < len(file) - 8):
					writer += file[j]
				j += 1
			fd2.write(writer)
			fd2.close()
		if (len(string) == 1):
			fd1 = open("./fun/file00" + string + ".c", 'w')
			print("create: " + "./fun/file00" + string + ".c")
			j = 0
			writer = ""
			while (j < len(file)):
				if (j < len(file) - 7):
					writer += file[j]
				j += 1
			fd1.write(writer)
			fd1.close()
		i += 1

if __name__ == '__main__':
	main()

