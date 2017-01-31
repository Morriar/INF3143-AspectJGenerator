#  Copyright 2016 Alexandre Terrasa <alexandre@moz-code.org>.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

build:
	mkdir -p build/
	javac -cp `echo lib/*.jar | tr ' ' ':'` src/dresden/AspectGen.java -d build/

classes:
	mkdir -p classes/
	javac example/inf3143/banque/*.java -d classes

aspects: build classes
	java -cp `echo lib/*.jar | tr ' ' ':'`:build/ dresden.AspectGen classes/inf3143/banque/ModelProvider.class example/constraints.ocl

weaved: classes aspects
	ajc -inpath classes/ -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:classes/ aspects/inf3143/banque/constraints/*.aj -d weaved -1.7

run: weaved
	java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:weaved/ inf3143.banque.Test1
	java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:weaved/ inf3143.banque.Test2
	java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:weaved/ inf3143.banque.Test3
	java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:weaved/ inf3143.banque.Test4
	java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:weaved/ inf3143.banque.Test5
	java -cp ~/dev/tools/aspectj1.8/lib/aspectjrt.jar:weaved/ inf3143.banque.Test6

clean:
	rm -rf build/ classes/ weaved/ aspects/
