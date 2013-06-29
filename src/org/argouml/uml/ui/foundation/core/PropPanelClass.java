// $Id: PropPanelClass.java 16261 2008-12-06 19:37:46Z tfmorris $
// Copyright (c) 1996-2007 The Regents of the University of California. All
// Rights Reserved. Permission to use, copy, modify, and distribute this
// software and its documentation without fee, and without a written
// agreement is hereby granted, provided that the above copyright notice
// and this paragraph appear in all copies.  This software program and
// documentation are copyrighted by The Regents of the University of
// California. The software program and documentation are supplied "AS
// IS", without any accompanying services from The Regents. The Regents
// does not warrant that the operation of the program will be
// uninterrupted or error-free. The end-user understands that the program
// was developed for research purposes and is advised not to rely
// exclusively on the program for any reason.  IN NO EVENT SHALL THE
// UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
// SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
// ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
// THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF
// SUCH DAMAGE. THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE
// PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY OF
// CALIFORNIA HAS NO OBLIGATIONS TO PROVIDE MAINTENANCE, SUPPORT,
// UPDATES, ENHANCEMENTS, OR MODIFICATIONS.

package org.argouml.uml.ui.foundation.core;

import org.argouml.uml.ui.ActionNavigateNamespace;
import org.argouml.uml.ui.foundation.extension_mechanisms.ActionNewStereotype;

/**
 * The properties panel for a Class.
 */
public class PropPanelClass extends PropPanelClassifier {

    /**
     * The serial version.
     */
    private static final long serialVersionUID = -8288739384387629966L;

    /**
     * Construct a property panel for UML Class elements.
     */
    public PropPanelClass() {
        super("label.class", lookupIcon("Class"));

        addField("label.name", getNameTextField());
        addField("label.namespace", getNamespaceSelector());
        getModifiersPanel().add(new UMLClassActiveCheckBox());
        add(getModifiersPanel());
        add(getVisibilityPanel());

        addSeparator();
        addField("label.client-dependencies", getClientDependencyScroll());
        addField("label.supplier-dependencies", getSupplierDependencyScroll());
        addField("label.generalizations", getGeneralizationScroll());
        addField("label.specializations", getSpecializationScroll());

        addSeparator();
        addField("label.attributes", getAttributeScroll());
        addField("label.association-ends", getAssociationEndScroll());
        addField("label.operations", getOperationScroll());
        addField("label.owned-elements", getOwnedElementsScroll());
//        addField("label.template-parameters", getTemplateParameterScroll());
        
        addAction(new ActionNavigateNamespace());
        addAction(new ActionAddAttribute());
        addAction(new ActionAddOperation());
        addAction(getActionNewReception());
        addAction(new ActionNewInnerClass());
        addAction(new ActionNewClass());
        addAction(new ActionNewStereotype());
//        addAction(new ActionAddTemplateParameter());
        addAction(getDeleteAction());
        
    }

}
