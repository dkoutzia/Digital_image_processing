function d = myLocalDescriptorUpgrade(I, p, rhom, rhoM, rhostep, N)
    b = size(I);
    d = [];
    for rho = rhom:rhostep:rhoM
        x_rho = [];
        for theta = 0:(2*pi/N):2*pi
            [x, y] = pol2cart(theta, rho);
            x = floor(x + p(1));
            y = floor(y + p(2));
            if y >= 1 && y <= b(1) && x >= 1 && x <= b(2)
                x_new = I(y, x);  % Access pixel intensity directly
                x_rho = [x_rho; x_new];
            end
        end
        x_mean = mean(x_rho);
        if ~isnan(x_mean)
            d = [d; x_rho];
        end
    end
end