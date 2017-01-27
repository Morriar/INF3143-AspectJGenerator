#!/bin/bash

# Copyright 2016 Alexandre Terrasa <alexandre@moz-code.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Gen aspectj files
java -jar dist/AspectJGenerator.jar ../INF3143-DresdenOCL/build/classes/inf3143/banque/model/ModelProvider.class ../INF3143-DresdenOCL/build/classes/inf3143/banque/model/constraints.ocl

# Weave sources with aj files
ajc aspect-j/inf3143/banque/model/constraints/*.aj -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar -injars ../INF3143-DresdenOCL/dist/INF3143-DresdenOCL.jar -d classes -1.7

# Run test programs
java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:class/ inf3143.banque.tests.Test1
java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:class/ inf3143.banque.tests.Test2
java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:class/ inf3143.banque.tests.Test3
java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:class/ inf3143.banque.tests.Test4
java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:class/ inf3143.banque.tests.Test5
java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:class/ inf3143.banque.tests.Test6
