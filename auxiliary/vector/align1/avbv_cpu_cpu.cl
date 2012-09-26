
// generic kernel for the vector operation v1 = alpha * v2 + beta * v3, where v1, v2, v3 are not necessarily distinct vectors
__kernel void avbv_cpu_cpu(
          __global float * vec1,
          unsigned int start1,
          unsigned int inc1,          
          unsigned int size1,
          
          float fac2,
          unsigned int options2,  // 0: no action, 1: flip sign, 2: take inverse, 3: flip sign and take inverse
          __global const float * vec2,
          unsigned int start2,
          unsigned int inc2,
          
          float fac3,
          unsigned int options3,  // 0: no action, 1: flip sign, 2: take inverse, 3: flip sign and take inverse
          __global float * vec3,
          unsigned int start3,
          unsigned int inc3
          )
{ 
  float alpha = fac2;
  if (options2 & (1 << 0))
    alpha = -alpha;
  if (options2 & (1 << 1))
    alpha = ((float)(1)) / alpha;

  float beta = fac3;
  if (options3 & (1 << 0))
    beta = -beta;
  if (options3 & (1 << 1))
    beta = ((float)(1)) / beta;

  for (unsigned int i = get_global_id(0); i < size1; i += get_global_size(0))
    vec1[i*inc1+start1] = vec2[i*inc2+start2] * alpha + vec3[i*inc3+start3] * beta;
}
