function [ mse] = mse_loc( Psi, loc)
% compute an mse of certain allocation

        Psi=Psi(loc,:);
        mse=sum(eig(Psi'*Psi).^(-1));
        
        
end

