#include "pch.h"

#include "Managed.h"

using namespace System::Runtime::InteropServices;
using namespace System;

namespace Managed {
	Executor::Executor() {
		nativeFunc = new NativeFunction();
	}

	Executor::~Executor() {

	}

	bool Executor::Execute() {
		return nativeFunc->Execute();
	}
}