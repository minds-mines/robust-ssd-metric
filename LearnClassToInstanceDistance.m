function [Uk, sk, obj] = LearnClassToInstanceDistance(Xk, Xnk, r, d_U)
% Distance Matrix for class k

d = size(Xk,1);
numk = size(Xk,2);
numnk = size(Xnk,2);

% initial sk, only for Xi in kth class
sk = ones(1,numk);
Uk = eye(d);

p_err = 1e-5;
options = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
for iter = 1:20
    % optimize Uk for fixed sk
    Ak = zeros(d);
    for i = 1:numk
        Ak = Ak + repmat(sk,d,1).*(Xk-repmat(Xk(:,i),1,numk))*(Xk-repmat(Xk(:,i),1,numk))';
    end
    Ak = Ak + r*sum(sk.^2)*eye(d)/d_U;

    Bk = zeros(d);
    for i = 1:numnk
        Bk = Bk + repmat(sk,d,1).*(Xk-repmat(Xnk(:,i),1,numk))*(Xk-repmat(Xnk(:,i),1,numk))';
    end

    lambda = trace(Uk'*Ak*Uk)/trace(Uk'*Bk*Uk);
          
    % Compute eigen vectors corresponding to d_U smallest eigen values
    % exclude negative eigen values    
    % lambdasm = eigs(Ak - lambda*Bk, 1, 'sr');
    % eigs may encounter error: dnaupd did not find any eigenvalues to sufficient accuracy
    e = eig(Ak-lambda*Bk);
    lambdasm = min(e(:));
    [evec eval] = eig(Ak - lambda*Bk - lambdasm*eye(size(Ak)));
    [eval,index] = sort(diag(eval));
    Uk = evec(:,index(1:d_U));


    % optimize sk for fixed Uk
    % dkw[i] is d_ik^w, dkw index corresponds to Xk
    dkw = zeros(numk,1);
    for i = 1:numk
        dkw = dkw + diag((Xk-repmat(Xk(:,i),1,numk))'*(Uk*Uk')*(Xk-repmat(Xk(:,i),1,numk)));
    end    
    dkb = zeros(numk,1);
    for i = 1:numnk
        dkb = dkb + diag((Xk-repmat(Xnk(:,i),1,numk))'*(Uk*Uk')*(Xk-repmat(Xnk(:,i),1,numk)));
    end
    sklambda = sum(sk'.*dkw+r*sk'.^2)/sum(sk'.*dkb); 
    
    dk = dkw - sklambda*dkb;
    for i = 1:numk
        sk(i) = quadprog(r*2,dk(i),[],[],[],[],0,[],[],options);
    end

    obj(iter) = sum(sk'.*dkw+r*sk'.^2)/sum(sk'.*dkb);    
%     if (iter > 1 && abs(obj(iter-1)-obj(iter)) < p_err)
%         break;
%     end
end

    
