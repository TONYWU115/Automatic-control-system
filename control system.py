import time
import matplotlib.pyplot as plt

class PIDController:
    """
    A simple implementation of a PID controller.
    """
    def __init__(self, Kp, Ki, Kd, setpoint):
        """
        Initialize the PID controller.

        Parameters:
            Kp (float): Proportional gain
            Ki (float): Integral gain
            Kd (float): Derivative gain
            setpoint (float): Target setpoint
        """
        self.Kp = Kp
        self.Ki = Ki
        self.Kd = Kd
        self.setpoint = setpoint

        self.prev_error = 0.0
        self.integral = 0.0
        self.last_time = time.time()

    def update(self, current_value):
        """
        Calculate the control output based on the current value.

        Parameters:
            current_value (float): The current measured value of the system

        Returns:
            float: The output of the controller
        """
        current_time = time.time()
        dt = current_time - self.last_time  # Calculate time interval

        # Avoid division by zero or instability if the time interval is too small
        if dt <= 0:
            dt = 1e-16  # Use a very small value

        error = self.setpoint - current_value

        # Proportional term
        P_out = self.Kp * error

        # Integral term
        self.integral += error * dt
        I_out = self.Ki * self.integral

        # Derivative term
        derivative = (error - self.prev_error) / dt
        D_out = self.Kd * derivative

        # Calculate total output
        output = P_out + I_out + D_out

        # Update state
        self.prev_error = error
        self.last_time = current_time

        return output

class SimpleSystem:
    """
    A simple first-order system model.
    For example, a heater where the rate of temperature change depends on input power and current temperature.
    """
    def __init__(self, initial_value=0.0, time_constant=5.0, gain=1.0):
        """
        Initialize the system.

        Parameters:
            initial_value (float): Initial value of the system (e.g., initial temperature)
            time_constant (float): Time constant of the system (a measure of response speed)
            gain (float): Gain of the system
        """
        self.value = initial_value
        self.time_constant = time_constant
        self.gain = gain
        self.last_time = time.time()

    def update(self, control_input):
        """
        Update the system state based on the control input.

        Parameters:
            control_input (float): Input from the controller (e.g., heating power)

        Returns:
            float: The current value of the system
        """
        current_time = time.time()
        dt = current_time - self.last_time

        if dt <= 0:
            dt = 1e-16

        # First-order system differential equation: dV/dt = (gain * control_input - V) / time_constant
        # Discretized: V_new = V_old + dt * (gain * control_input - V_old) / time_constant
        self.value += dt * (self.gain * control_input - self.value) / self.time_constant

        self.last_time = current_time
        return self.value

# --- Main Program ---
if __name__ == "__main__":
    # Set PID controller parameters
    Kp = 1.2
    Ki = 0.3
    Kd = 0.05
    setpoint = 50.0  # Target value (e.g., target temperature of 50°C)

    # Initialize the PID controller and system
    pid = PIDController(Kp, Ki, Kd, setpoint)
    system = SimpleSystem(initial_value=20.0, time_constant=10.0, gain=0.5)  # Initial temperature of 20°C

    # Simulation parameters
    simulation_time = 60  # Total simulation time (seconds)
    time_step = 0.1       # Simulation time step (seconds) - Note: Actual time is controlled by time.sleep for pacing

    # Lists for plotting
    time_points = []
    setpoint_points = []
    system_value_points = []
    control_output_points = []

    current_simulation_time = 0.0
    start_sim_time = time.time()

    print(f"Starting simulation: Setpoint = {setpoint}, Kp={Kp}, Ki={Ki}, Kd={Kd}")
    print("Time (s) | Current Value | Control Output | Error")
    print("-----------------------------------------------")

    try:
        while current_simulation_time < simulation_time:
            # 1. Get the current value of the system
            current_value = system.value

            # 2. PID controller calculates the control output
            control_output = pid.update(current_value)

            # Limit the control output (optional, simulating actuator limits)
            control_output = max(min(control_output, 100.0), 0.0)  # For example, power limited between 0 and 100

            # 3. Apply the control output to the system
            system.update(control_output)

            # Record data for plotting
            time_points.append(current_simulation_time)
            setpoint_points.append(setpoint)
            system_value_points.append(current_value)
            control_output_points.append(control_output)

            # Print the current state
            error = setpoint - current_value
            if int(current_simulation_time * 10) % 10 == 0:  # Print once per second
                 print(f"{current_simulation_time:8.1f} | {current_value:8.2f} | {control_output:8.2f} | {error:8.2f}")

            # Simulate time passing
            # Note: time.sleep here is used to pace the simulation closer to real-time.
            # The dt in the PID and system model is calculated based on actual elapsed time.
            # For pure mathematical simulation, time.sleep can be omitted, and a fixed dt can be used.
            time.sleep(time_step)
            current_simulation_time = time.time() - start_sim_time

    except KeyboardInterrupt:
        print("\nSimulation interrupted by user.")

    print("-----------------------------------------------")
    print("Simulation ended.")

    # --- Plot the results ---
    plt.figure(figsize=(12, 8))

    plt.subplot(2, 1, 1)
    plt.plot(time_points, system_value_points, label='System Actual Value (e.g., Temperature)')
    plt.plot(time_points, setpoint_points, 'r--', label='Target Setpoint')
    plt.xlabel('Time (s)')
    plt.ylabel('Value')
    plt.title('PID Control Simulation - System Response')
    plt.legend()
    plt.grid(True)

    plt.subplot(2, 1, 2)
    plt.plot(time_points, control_output_points, label='Controller Output (e.g., Power)', color='green')
    plt.xlabel('Time (s)')
    plt.ylabel('Control Output')
    plt.title('PID Control Simulation - Controller Output')
    plt.legend()
    plt.grid(True)

    plt.tight_layout()  # Adjust spacing between subplots
    plt.show()