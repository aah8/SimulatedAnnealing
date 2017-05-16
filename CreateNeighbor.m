function qnew=CreateNeighbor1(q)

    m=randi([1,3]);
    
    switch m
        case 1
            % Do Swap
            qnew=Swap(q);
            
        case 2
            % Do Reversion
            qnew=Reversion(q);
            
        case 3
            % Do Insertion
            qnew=Insertion(q);
    end
    
end

    function qnew=Swap(q);
        n=numel(q); %number of elements in q
        i=randsample(n,2); %without replacement
        i1=i(1);
        i2=i(2);
        
        qnew=q;
        qnew([i1 i2])=q([i2 i1]);
        
        %disp(['Swap '  num2str(i1) ', ' num2str(i2)]); 
    end

    function qnew=Reversion(q)
        n=numel(q); %number of elements in q
        i=randsample(n,2); %without replacement
        i1=min(i(1),i(2));
        i2=max(i(1),i(2));
        
        qnew=q;
        qnew(i1:i2)=q(i2:-1:i1);
        
        %disp(['Reversion '  num2str(i1) ', ' num2str(i2)]); 
    end

    function qnew=Insertion(q)
        n=numel(q); %number of elements in q
        i=randsample(n,2); %without replacement
        i1=i(1);
        i2=i(2);
        
        if i1<i2
            qnew=[q(1:i1-1) q(i1+1:i2) q(i1) q(i2+1:end)];
        else
            qnew=[q(1:i2) q(i1) q(i2+1:i1-1) q(i1+1:end)];
        end
        
        %disp(['Insertion '  num2str(i1) ', ' num2str(i2)]); 
    end
        
  
