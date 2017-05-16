function q=CreateRandomSolution1(model)

%model = CreateModel();

nVar=model.nVar;

q=randperm(model.nVar);

%mat2str(q)


end
