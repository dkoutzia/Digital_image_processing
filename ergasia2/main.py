import cv2
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import confusion_matrix, accuracy_score
from create_dataset import createdataset
from find_Rotation_Angle import findRotationAngle
from rotate_image import rotateImage
from separate_lines import separate_lines
from separatecharacters import separate_characters
from countour_descriptor import contour_descriptor
from get_contour import getcontour

#image rotation
angle=findRotationAngle('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/text1_rot.png')
rotated_text_1=rotateImage('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/text1_rot.png',angle)
cv2.imshow(f"rotated text 1", rotated_text_1)
cv2.waitKey(0)
angle=findRotationAngle('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/text2_150dpi_rot.png')
rotated_text_2=rotateImage('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/text2_150dpi_rot.png',angle)
cv2.imshow("rotated text 2", rotated_text_2)
cv2.waitKey(0)

#contours for a,e,f,l

a=getcontour('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/aefl/a.png')
print("contours for a:",len(a))
e=getcontour('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/aefl/e.png')
print("contours for e:",len(e))
f=getcontour('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/aefl/f.png')
print("contours for f:",len(f))
l=getcontour('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/aefl/l.png')
print("contours for l:"
      "",len(l))

# Load and preprocess reference image and corresponding text file
reference_image = cv2.imread('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/text1_v3.png')
reference_text = open('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/text1_v3.txt').read()
angle=findRotationAngle('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/text1_v3.png')
rotated_image=rotateImage('C:/Users/Koutz/Desktop/sxoli/psee/ergasia/ergasia2/text1_v3.png',angle+1.4)
words=[]
character_images=[]
# Extract characters from reference image
# Display the image with contours
cv2.imshow('Image Rotated', rotated_image)
cv2.waitKey(0)

lines_separated=separate_lines(rotated_image)
print(lines_separated)
word_images = []

for i, line in enumerate(lines_separated):
    cv2.imshow(f"Line {i+1}", line)
    cv2.waitKey(0)

    cv2.destroyAllWindows()
# Separate words for each line
    character_images = separate_characters(line)


# Display the separated words
    for j,  character  in enumerate(character_images):
       cv2.imshow(f"Word {j+1}",  character)


       cv2.waitKey(0)
       cv2.destroyAllWindows()



