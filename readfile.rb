# encoding: UTF-8
t = File.read("D:/result1.txt")
t1 = t.split("\n\n\nen")[0]
t2 = t1.force_encoding("utf-8").split("。")
t21 = t2[0]
t22 = t2[1]
puts t21
