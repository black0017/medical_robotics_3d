## Medical Robotics post-graduate assignment
Implementation is in pure Matlab. You can reproduce the reported results running the corresponing scripts.

#### T1) Compute in symbolic form the matrix A_8^12
The kinematic diagram in the inertial coordinate system of the base and the arm are illustrated below:
![Alt text](./figures/t1.png?raw=true "t1")
As we can see in the kinematic diagram, there are a 5-DOF manipulator. Using the kinematic configuration for each joint, we compute the Denavit – Hartenberg parameters.


#### T2) Given the bounds of q(described in the report), compute all the points of the 3D-working space.
The 3-D working space of the robot (sparse view - large step size) based on the initial conditions and the constraints.
![Alt text](./figures/t2.png?raw=true "t2")


#### T3) Solve the inverse kinematics problem, or given compatible values with the kinematic configuration of matrix T
In order to implement the IK problem we used:  
1) An analytical distance function that we try to minimize between the desired 
and current position. We used the sum of the absolute differences between 
coordinates with threshold 5(mm). 
2) A forward function that returns the position of the robot for the current 
parameters. (Forward.m file) 
3) A function that calculates the Jacobian matrix for the current 
parameters.(MyJacobian.m file) 
It is significant to mention that in order to compute the inverse of the Jacobian 
matrix, we calculated the pseudo-inverse so as the J is an orthonormal matrix. 
The result of the InverseKin.m function that we have made gives the following results 
as depicted.

![Alt text](./figures/t3.png?raw=true "t3")


#### T4) Select any spiral trajectory within your working space where the coordinates x y z are not expressed necessarily with respect to the coordinate system. Approximate two circular motions of this spiral with at least 36 2 ? points under the assumption that T =1. Solve for these 72 points the inverse kinematics problem by computing q.

The purpose of this question is to create a spiral trajectory that corresponds, with the best 
feasible way, to the already computed 3D working space of the robot, so we can solve the 
inverse kinematic problem.

The solution can be divided into three smaller steps that are summarized below: 
1. Determine the parameters of the spiral trajectory so as to be in the range of 3D 
working space. 
2. Prune the total 3D working space, in order to pick the best possible matching points 
of the spiral trajectory, based on the geometry of the spiral. 
3. Solve the inverse kinematic problem combining the inverse Jacobian approximation 
with the pruned search method. 

The results are presented below in different 2D planes:

![Alt text](./figures/t4a.png?raw=true "t4a")
![Alt text](./figures/t4b.png?raw=true "t4b")
![Alt text](./figures/t4c.png?raw=true "t4c")
![Alt text](./figures/t4d.png?raw=true "t4d")



#### T5) Under the assumption that two successive points are connected by a third order polynomial with a stop-and-go trajectory plot the joint trajectories and the resulting end-effector trajectory

We created a Matlab function (Third_order_solver.m) that calculated the values of the polynomial with velocities 
both at start and end point equal to zero. Change of th8 angle is depicted below:  
![Alt text](./figures/t5.png?raw=true "t5")


If you found this project usefull, let me know :)
