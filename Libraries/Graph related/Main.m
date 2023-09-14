clc
clear

c=[1 1 1 1 1];      %cost vector 

A=[0 1 0 0 0;
   1 0 1 1 1;
   0 1 0 0 0;
   0 1 0 0 0;
   0 1 0 0 0];  %graph adjacency matrix
I=adj2inc(A);     %incidence matrix of the given adjacency matrix
%% Minimum Vertex cover optimization
[Xopt1]=MVC(A,c)
%% Minimum Vertex cover optimization - SDP
[Xopt2]=MVC_SDP(A,c)