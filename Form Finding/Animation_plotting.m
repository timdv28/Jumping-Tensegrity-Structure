% PLotting of the animation

figure(1);
set(figure(1),'Position',[200,100,700,700]);
p = plot3(1,1,0,'o');
norm_plot1 = zeros(length(res.x1.data),1);
xs=[];ys=[];zs=[];
view(20, -10)

for i = 1:10:length(res.x1.data)
    axis(l_leg*[-1 2 -2 2 -1 2]);
    axis equal

    hold on;
    x_plot =  [res.x1.data(i,1),res.x2.data(i,1), res.x3.data(i,1), res.x4.data(i,1) , res.x5.data(i,1), res.x6.data(i,1), res.x7.data(i,1), res.x8.data(i,1), res.x9.data(i,1), res.x10.data(i,1), res.x11.data(i,1), res.x12.data(i,1)];
    y_plot =  [res.x1.data(i,2),res.x2.data(i,2), res.x3.data(i,2), res.x4.data(i,2) , res.x5.data(i,2), res.x6.data(i,2), res.x7.data(i,2), res.x8.data(i,2), res.x9.data(i,2), res.x10.data(i,2), res.x11.data(i,2), res.x12.data(i,2)];
    z_plot =  [res.x1.data(i,3),res.x2.data(i,3), res.x3.data(i,3), res.x4.data(i,3) , res.x5.data(i,3), res.x6.data(i,3), res.x7.data(i,3), res.x8.data(i,3), res.x9.data(i,3), res.x10.data(i,3), res.x11.data(i,3), res.x12.data(i,3)];
    set (p, 'XData', x_plot, 'YData', y_plot,'ZData', z_plot);
    xs=[xs;x_plot];ys=[ys;y_plot];zs=[zs;z_plot];
    
    norm_plot1(i) = norm([res.joint1.data(i,1) res.joint1.data(i,2) res.joint1.data(i,3)]);

    bar_17_1 = line([res.x1.data(i,1) res.joint1.data(i,1)],[res.x1.data(i,2) res.joint1.data(i,2)],[res.x1.data(i,3) res.joint1.data(i,3)],'linestyle','-','color','b','LineWidth',3);
    bar_17_2 = line([res.x7.data(i,1) res.joint1.data(i,1)],[res.x7.data(i,2) res.joint1.data(i,2)],[res.x7.data(i,3) res.joint1.data(i,3)],'linestyle','-','color','b','LineWidth',3);
    bar_28_1 = line([res.x2.data(i,1) res.joint2.data(i,1)],[res.x2.data(i,2) res.joint2.data(i,2)],[res.x2.data(i,3) res.joint2.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_28_2 = line([res.x8.data(i,1) res.joint2.data(i,1)],[res.x8.data(i,2) res.joint2.data(i,2)],[res.x8.data(i,3) res.joint2.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_39_1 = line([res.x3.data(i,1) res.joint3.data(i,1)],[res.x3.data(i,2) res.joint3.data(i,2)],[res.x3.data(i,3) res.joint3.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_39_2 = line([res.joint3.data(i,1) res.x9.data(i,1)],[res.joint3.data(i,2) res.x9.data(i,2)],[res.joint3.data(i,3) res.x9.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_410_1 = line([res.x4.data(i,1) res.joint4.data(i,1)],[res.x4.data(i,2) res.joint4.data(i,2)],[res.x4.data(i,3) res.joint4.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_410_2 = line([res.joint4.data(i,1) res.x10.data(i,1)],[res.joint4.data(i,2) res.x10.data(i,2)],[res.joint4.data(i,3) res.x10.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_511_1 = line([res.x5.data(i,1) res.joint5.data(i,1)],[res.x5.data(i,2) res.joint5.data(i,2)],[res.x5.data(i,3) res.joint5.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_511_2 = line([res.joint5.data(i,1) res.x11.data(i,1)],[res.joint5.data(i,2) res.x11.data(i,2)],[res.joint5.data(i,3) res.x11.data(i,3)],'linestyle','-','color','r','LineWidth',3);
    bar_612_1 = line([res.x6.data(i,1) res.joint6.data(i,1)],[res.x6.data(i,2) res.joint6.data(i,2)],[res.x6.data(i,3) res.joint6.data(i,3)],'linestyle','-','color','b','LineWidth',3);
    bar_612_2 = line([res.joint6.data(i,1) res.x12.data(i,1)],[res.joint6.data(i,2) res.x12.data(i,2)],[res.joint6.data(i,3) res.x12.data(i,3)],'linestyle','-','color','b','LineWidth',3);
    
    str_12 = line([res.x1.data(i,1) res.x2.data(i,1)],[res.x1.data(i,2) res.x2.data(i,2)],[res.x1.data(i,3) res.x2.data(i,3)]);
    str_13 = line([res.x1.data(i,1) res.x3.data(i,1)],[res.x1.data(i,2) res.x3.data(i,2)],[res.x1.data(i,3) res.x3.data(i,3)]);
    str_14 = line([res.x1.data(i,1) res.x4.data(i,1)],[res.x1.data(i,2) res.x4.data(i,2)],[res.x1.data(i,3) res.x4.data(i,3)]);
    str_19 = line([res.x1.data(i,1) res.x9.data(i,1)],[res.x1.data(i,2) res.x9.data(i,2)],[res.x1.data(i,3) res.x9.data(i,3)]);
    
    str_23 = line([res.x2.data(i,1) res.x3.data(i,1)],[res.x2.data(i,2) res.x3.data(i,2)],[res.x2.data(i,3) res.x3.data(i,3)]);
    str_25 = line([res.x2.data(i,1) res.x5.data(i,1)],[res.x2.data(i,2) res.x5.data(i,2)],[res.x2.data(i,3) res.x5.data(i,3)]);
    str_27 = line([res.x2.data(i,1) res.x7.data(i,1)],[res.x2.data(i,2) res.x7.data(i,2)],[res.x2.data(i,3) res.x7.data(i,3)]);
    
    str_36 = line([res.x3.data(i,1) res.x6.data(i,1)],[res.x3.data(i,2) res.x6.data(i,2)],[res.x3.data(i,3) res.x6.data(i,3)]);
    str_38 = line([res.x3.data(i,1) res.x8.data(i,1)],[res.x3.data(i,2) res.x8.data(i,2)],[res.x3.data(i,3) res.x8.data(i,3)]);
    
    str_47 = line([res.x4.data(i,1) res.x7.data(i,1)],[res.x4.data(i,2) res.x7.data(i,2)],[res.x4.data(i,3) res.x7.data(i,3)]);
    str_49 = line([res.x4.data(i,1) res.x9.data(i,1)],[res.x4.data(i,2) res.x9.data(i,2)],[res.x4.data(i,3) res.x9.data(i,3)]);
    str_411 = line([res.x4.data(i,1) res.x11.data(i,1)],[res.x4.data(i,2) res.x11.data(i,2)],[res.x4.data(i,3) res.x11.data(i,3)]);
    
    str_57 = line([res.x5.data(i,1) res.x7.data(i,1)],[res.x5.data(i,2) res.x7.data(i,2)],[res.x5.data(i,3) res.x7.data(i,3)]);
    str_58 = line([res.x5.data(i,1) res.x8.data(i,1)],[res.x5.data(i,2) res.x8.data(i,2)],[res.x5.data(i,3) res.x8.data(i,3)]);
    str_512 = line([res.x5.data(i,1) res.x12.data(i,1)],[res.x5.data(i,2) res.x12.data(i,2)],[res.x5.data(i,3) res.x12.data(i,3)]);
    
    str_68 = line([res.x6.data(i,1) res.x8.data(i,1)],[res.x6.data(i,2) res.x8.data(i,2)],[res.x6.data(i,3) res.x8.data(i,3)]);
    str_69 = line([res.x6.data(i,1) res.x9.data(i,1)],[res.x6.data(i,2) res.x9.data(i,2)],[res.x6.data(i,3) res.x9.data(i,3)]);
    str_610 = line([res.x6.data(i,1) res.x10.data(i,1)],[res.x6.data(i,2) res.x10.data(i,2)],[res.x6.data(i,3) res.x10.data(i,3)]);
    
    str_711 = line([res.x7.data(i,1) res.x11.data(i,1)],[res.x7.data(i,2) res.x11.data(i,2)],[res.x7.data(i,3) res.x11.data(i,3)]);
    
    str_812 = line([res.x8.data(i,1) res.x12.data(i,1)],[res.x8.data(i,2) res.x12.data(i,2)],[res.x8.data(i,3) res.x12.data(i,3)]);
    
    str_910 = line([res.x9.data(i,1) res.x10.data(i,1)],[res.x9.data(i,2) res.x10.data(i,2)],[res.x9.data(i,3) res.x10.data(i,3)]);
    
    str_1011 = line([res.x10.data(i,1) res.x11.data(i,1)],[res.x10.data(i,2) res.x11.data(i,2)],[res.x10.data(i,3) res.x11.data(i,3)]);
    str_1012 = line([res.x10.data(i,1) res.x12.data(i,1)],[res.x10.data(i,2) res.x12.data(i,2)],[res.x10.data(i,3) res.x12.data(i,3)]);
    
    str_1112 = line([res.x11.data(i,1) res.x12.data(i,1)],[res.x11.data(i,2) res.x12.data(i,2)],[res.x11.data(i,3) res.x12.data(i,3)]);
       
    drawnow;
    
    delete(bar_17_1);delete(bar_17_2);delete(bar_28_1);delete(bar_28_2);delete(bar_39_1);delete(bar_39_2);delete(bar_410_1);delete(bar_410_2);delete(bar_511_1);delete(bar_511_2);delete(bar_612_1);delete(bar_612_2);
    
    delete(str_12);delete(str_13);delete(str_14);delete(str_19);delete(str_23);delete(str_25);
    delete(str_27);delete(str_36);delete(str_38);delete(str_47);delete(str_49);delete(str_411);
    delete(str_57);delete(str_58);delete(str_512);delete(str_68);delete(str_69);delete(str_610);
    delete(str_711);delete(str_812);delete(str_910);delete(str_1011);delete(str_1012);delete(str_1112);
    
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    hold off;
end
