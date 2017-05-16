function sol=ParseSolution1(q,model)

I=model.I;
J=model.J;
s=model.s;
p=model.p;
nVar=model.nVar;

%determine the delimiter positions
DelPos=find(q>I);
From=[0 DelPos]+1;
To=[DelPos I+J]-1;

sol.DelPos=DelPos;
sol.From=From;
sol.To=To;

%create job list
L=cell(J,1);

for j=1:J
   L[j]=q(From(j):To(j));
end

%starting time
ST=zeros(1,1);
%finishing time
FT=zeros(1,1);
%processing time
PT=zeros(1,1);
%mct time
MCT=zeros(1,1);


for j=1:J
   for i=L[j]
       %find position of the job on this machine
       k=find(L[j]==i);
       %find the index of the job that has the first position on L - make
       %starting time 0
       if k==1
           ST(i)=0;
       else
           PreviousJob=find(L[j](k-1));
           ST(i)=FT(PreviousJob)+s(PreviousJob,i,j);
       end
       PT(i)=p(i,j);
       FT(i)=ST(i)+PT(i);
   end
    
end


end
