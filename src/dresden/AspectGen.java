/*
 * Copyright 2016 Alexandre Terrasa <alexandre@moz-code.org>.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package dresden;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import tudresden.ocl20.pivot.model.IModel;
import tudresden.ocl20.pivot.model.ModelAccessException;
import tudresden.ocl20.pivot.parser.ParseException;
import tudresden.ocl20.pivot.pivotmodel.Constraint;
import tudresden.ocl20.pivot.standalone.facade.StandaloneFacade;
import tudresden.ocl20.pivot.tools.codegen.exception.Ocl2CodeException;
import tudresden.ocl20.pivot.tools.codegen.ocl2java.IOcl2JavaSettings;
import tudresden.ocl20.pivot.tools.codegen.ocl2java.Ocl2JavaFactory;
import tudresden.ocl20.pivot.tools.template.exception.TemplateException;

public class AspectGen {

    public static void main(String[] args) {

        if (args.length != 2) {
            System.err.println("usage: AspectGen <modelFile> <constraintsFile>");
            System.exit(1);
        }

        String modelPath = args[0];
        String constraintsPath = args[1];

        // Initialize DresdenOCL standalone interface
        try {
            StandaloneFacade.INSTANCE.initialize(new URL("file:"
                    + new File("log4j.properties").getAbsolutePath()));
        } catch (MalformedURLException ex) {
            System.err.println("Malformed path to log4j.properties");
            System.err.println("Error: " + ex.getMessage());
            System.exit(1);
        } catch (TemplateException ex) {
            System.err.println("Malformed log4j.properties file");
            System.err.println("Error: " + ex.getMessage());
            System.exit(1);
        }

        try {
            // Load model
            File modelClass = new File(modelPath);
            IModel model = StandaloneFacade.INSTANCE.loadJavaModel(modelClass);

            // Load OCL contraints
            File contraintsFile = new File(constraintsPath);
            List<Constraint> constraintList = StandaloneFacade.INSTANCE
                    .parseOclConstraints(model, contraintsFile);

            // Generate AspectJ code
            IOcl2JavaSettings settings = Ocl2JavaFactory.getInstance()
                    .createJavaCodeGeneratorSettings();
            settings.setSourceDirectory("aspects");
            StandaloneFacade.INSTANCE.generateAspectJCode(constraintList, settings);

        } catch (ModelAccessException ex) {
            System.err.println("Unable to load model file `" + modelPath + "`");
            System.err.println("Error: " + ex.getMessage());
            System.exit(1);
        } catch (IOException | ParseException ex) {
            System.err.println("Unable to load constraints file `" + constraintsPath + "`");
            System.err.println("Error: " + ex.getMessage());
            System.exit(1);
        } catch (Ocl2CodeException ex) {
            System.err.println("Unable to generate aspect files");
            System.err.println("Error: " + ex.getMessage());
            System.exit(1);
        }
    }
}
