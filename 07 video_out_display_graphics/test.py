import cv2
path = "C:\\Users\\iris2\\Desktop\\Laboratory\\07 video_out_display_graphics\\google_pic.png"
pic = cv2.imread(path)
print(pic.shape)

# print(pic[60][60])  # BGR

# pic = cv2.cvtColor(pic, cv2.COLOR_BGR2GRAY)
l = list()
l2 = list()
for i in range(128):
    for j in range(128):
        s = ""
        for k in pic[i][j]:
            if k > 200:
                s += '1'
            else:
                s += '0'
        l.append(s)

# print(128*128*3)
print(len(l))
# print(len(l2))
# cv2.imshow('test',pic)
# cv2.waitKey(0)
