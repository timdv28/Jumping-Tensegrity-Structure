% This function calculates the potential energy contained in the torsion springs
function E = torsion_energy(k_joint,a1,a2,a3,a4,a5,a6)
A1 = [a1(1) a2(1) a3(1) a4(1) a5(1) a6(1)];
A2 = [a1(2) a2(2) a3(2) a4(2) a5(2) a6(2)];
E_t = zeros(length(A1),1);

for i = 1:length(A1)
    E_t(i) = k_joint*(A2(i)^2 - A1(i)^2);
end
E = 0.5*sum(E_t);

end
