import control as ctrl
import matplotlib.pyplot as plt

zeros = []
poles = []
gain = 1
#poles = [complex(-1, 1), complex(-1, -1)]  (-1+1j, -1-1j)

sys = ctrl.zpk(zeros, poles, gain)

ctrl.rlocus(sys)
plt.title('Root Locus Plot')
plt.grid(True)
plt.show()