import torch

print("torch.cuda.is_available():", torch.cuda.is_available())

print("torch.cuda.current_device():", torch.cuda.current_device())

print("torch.cuda.device_count():", torch.cuda.device_count())

print("torch.cuda.get_device_name(0):", torch.cuda.get_device_name(0))

#print("Suported architectures (compute capabiliies):", torch.cuda.get_arch_list())

print(torch.rand(2,3).cuda())