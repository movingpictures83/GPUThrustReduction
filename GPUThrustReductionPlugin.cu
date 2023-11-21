#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include "GPUThrustReductionPlugin.h"

void GPUThrustReductionPlugin::input(std::string inputfile) {
   readParameterFile(inputfile);
}

void GPUThrustReductionPlugin::run() {}

void GPUThrustReductionPlugin::output(std::string outputfile) {

  float *hostInput;
  float hostOutput;
  int numInputElements;

  numInputElements = atoi(myParameters["N"].c_str());

  hostInput = (float*) malloc (numInputElements*sizeof(float));
   std::ifstream myinput((std::string(PluginManager::prefix())+myParameters["data"]).c_str(), std::ios::in);
 int i;
 for (i = 0; i < numInputElements; ++i) {
        int k;
        myinput >> k;
        hostInput[i] = k;
 }


  //@@ Insert code here
  thrust::device_vector<float> deviceInput(numInputElements);
  //@@ Insert code here
  thrust::copy(hostInput, hostInput + numInputElements, deviceInput.begin());
  //@@ Insert Code here
  hostOutput = thrust::reduce(deviceInput.begin(), deviceInput.end());
  /////////////////////////////////////////////////////////


  std::cout << hostOutput << std::endl;


  free(hostInput);
}

PluginProxy<GPUThrustReductionPlugin> GPUThrustReductionPluginProxy = PluginProxy<GPUThrustReductionPlugin>("GPUThrustReduction", PluginManager::getInstance());
