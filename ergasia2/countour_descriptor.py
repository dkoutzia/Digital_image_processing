import numpy as np
from get_contour import getcontour


def contour_descriptor(c):
    # iterate over all contours
    descriptors = []
    for i in range(len(c)):
        contour = c[i]

        # construct the complex sequence
        r = contour[:, 0] + 1j * contour[:, 1]

        # compute the DFT
        R = np.fft.fft(r)

        # calculate the descriptor
        descriptor = np.abs(R[1:])

        descriptors.append(descriptor)

    return descriptors



def compute_distance(desc1, desc2):
    n = min(len(R1), len(R2)
    distance= np.sum(np.square(desc1[:n] - desc2[:n]))
    return distance






