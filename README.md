# AspectJGenerator

Generates AspectJ code from OCL constraints using DresdenOCL.

## Usage

Generate AspectJ code

	java -jar AspectJGenerator.jar <ModelProvider.class> <constraints.ocl>

Weave aspects

	ajc aspect-j/*.aj -cp aspectjrt.jar -injars to_weave.jar -d classes
