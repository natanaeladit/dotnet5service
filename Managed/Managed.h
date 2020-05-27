#pragma once
#pragma unmanaged
#include "Native.h"
#pragma managed
using namespace System;

namespace Managed {
	public ref class Executor
	{
	public:
		Executor();
		~Executor();

		bool Execute();
	private:
		NativeFunction* nativeFunc;
	};
}
