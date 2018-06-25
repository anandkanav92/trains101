# Import the data
import sys

infile, outfile = '/Users/kanavanand/projects/PycharmProjects/trains/data/traindependenciesReal_Day_1.txt', '/Users/kanavanand/projects/PycharmProjects/trains/out/count_day1.txt'

with open(infile) as inf, open(outfile,"w") as outf:
    line_words = (line.split(' ') for line in inf)
    flag=0;
    row_to_write = []
    count=0;
    for i, x in enumerate(line_words):
        if x[0].__eq__("End") and x[1].__eq__("Related"):
            row_to_write.insert(len(row_to_write)-1,count)
            print(row_to_write)
            outf.writelines(str(words) + ' ' for words in row_to_write)
            count=0
            flag=0
            continue

        if x[0].__eq__("Begin") and x[1].__eq__("Related"):
            flag=1
            continue
        if x[0].__eq__("Activity:"):
            row_to_write=x[:]
            continue

        if flag==1:
            count+=1;
            continue
    #outf.writelines(words[1].strip() + '\n' for words in line_words if len(words)>1)