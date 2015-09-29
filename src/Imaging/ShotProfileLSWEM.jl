function ShotProfileLSWEM(m,m0,d,param=Dict())

	# least squares shot profile wave equation migration of isotropic 1C data. 
	cost = get(param,"cost","cost")   # cost function output text file
	precon = get(param,"precon",false)   # flag for preconditioning by smoothing the image
	wd = join(["tmp_LSM_wd_",string(int(rand()*100000))])
	CalculateSampling(d,wd,param)
	param["wd"] = wd
	if (precon == true)
		param["operators"] = [ApplyDataWeights ShotProfileWEM SmoothStructure SmoothGathers]
	else
		param["operators"] = [ApplyDataWeights ShotProfileWEM]
	end
	ConjugateGradients(m,m0,d,cost,param)
	SeisRemove(wd)

end
