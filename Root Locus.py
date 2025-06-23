import control as ctrl
import matplotlib.pyplot as plt

# Create transfer function: (2s^2 + 5s + 1) / (s^2 + 2s + 3)
# numerator = [2, 5, 1]
# denominator = [1, 2, 3]
numerator = []
denominator = []
sys = ctrl.tf(numerator, denominator)

ctrl.rlocus(sys)
plt.title('Root Locus Plot')
plt.grid(True)
plt.show()