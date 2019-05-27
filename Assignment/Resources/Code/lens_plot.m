function lens_plot(R,a,h,angle)
% Plot spherical lens
plot([R-a R*20],[-h/2 -h/2],'k-')    % Bottom
plot([R-a R*20],[h/2 h/2],'k-')      % Top
plot(R+R.*cos(angle),R.*sin(angle),'k-')  % Convex side
end