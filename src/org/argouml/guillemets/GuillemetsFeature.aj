// $Id: eclipse-argo-codetemplates.xml 11347 2006-10-26 22:37:44Z linus $
// Copyright (c) 2011 The Regents of the University of California. All
// Rights Reserved. Permission to use, copy, modify, and distribute this
// software and its documentation without fee, and without a written
// agreement is hereby granted, provided that the above copyright notice
// and this paragraph appear in all copies. This software program and
// documentation are copyrighted by The Regents of the University of
// California. The software program and documentation are supplied "AS
// IS", without any accompanying services from The Regents. The Regents
// does not warrant that the operation of the program will be
// uninterrupted or error-free. The end-user understands that the program
// was developed for research purposes and is advised not to rely
// exclusively on the program for any reason. IN NO EVENT SHALL THE
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

package org.argouml.guillemets;

import java.awt.GridBagConstraints;
import java.beans.PropertyChangeEvent;

import javax.swing.JCheckBox;
import javax.swing.JPanel;

import org.argouml.configuration.Configuration;
import org.argouml.configuration.ConfigurationKey;
import org.argouml.kernel.ProjectSettings;
import org.argouml.notation.Notation;
import org.argouml.notation.NotationSettings;
import org.argouml.notation.ui.SettingsTabNotation;
import org.argouml.persistence.ArgoParser;
import org.argouml.persistence.ArgoTokenTable;
import org.argouml.persistence.XMLElement;
import org.argouml.ui.explorer.ExplorerEventAdaptor;
import org.tigris.gef.undo.Memento;
import org.argouml.util.Driver;

public privileged aspect GuillemetsFeature {

    pointcut handleUseGuillemots(ArgoParser cthis, XMLElement e) 
    : execution(* ArgoParser.handleUseGuillemots(..)) 
    && this(cthis) && args(e);

    pointcut addTokenGuillemetsHook(ArgoTokenTable cthis) 
    : execution(* ArgoTokenTable.addTokenGuillemetsHook(..)) 
    && this(cthis);

    pointcut addListenerGuillemotsHook(ExplorerEventAdaptor cthis) 
    : execution(* ExplorerEventAdaptor.addListenerGuillemotsHook(..)) 
     && this(cthis);

    pointcut isChangePropertyGuillemetsHook(final PropertyChangeEvent pce) 
    : execution(* ExplorerEventAdaptor.isChangePropertyGuillemetsHook(..)) 
     && args(pce);

    pointcut createCheckBoxGuillemotsHook(JPanel settings,
            GridBagConstraints constraints, SettingsTabNotation cthis) 
        : execution(* SettingsTabNotation.createCheckBoxGuillemotsHook(..)) 
         && args(settings, constraints) && this(cthis);

    pointcut setSelectedGuillemotsHook(SettingsTabNotation cthis) 
    : execution(* SettingsTabNotation.setSelectedGuillemotsHook(..)) 
    && this(cthis);

    pointcut setBooleanGuillemotsHook(SettingsTabNotation cthis) 
    : execution(* SettingsTabNotation.setBooleanGuillemotsHook(..)) 
    && this(cthis);

    pointcut setUseGuillemotsHook(SettingsTabNotation cthis, ProjectSettings ps) 
    : execution(* SettingsTabNotation.setUseGuillemotsHook(..)) 
    && this(cthis) && args(ps);

    pointcut setSelectedPsGuillemotsHook(SettingsTabNotation cthis,
            ProjectSettings ps) 
        : execution(* SettingsTabNotation.setSelectedPsGuillemotsHook(..)) 
        && this(cthis) && args(ps);

    pointcut addListenerGuillemetsHook(Notation cthis) 
    : execution(* Notation.addListenerGuillemetsHook(..)) 
    && this(cthis);

    pointcut setUseGuillemetsHook(NotationSettings settings) 
    : execution(* NotationSettings.setUseGuillemetsHook(..)) 
    && args(settings);

    pointcut isUseGuillemets(NotationSettings cthis) 
    : execution(* NotationSettings.isUseGuillemets(..)) 
    && this(cthis);

    pointcut setUseGuillemets(final NotationSettings cthis, final boolean showem) 
    : execution(* NotationSettings.setUseGuillemets(..)) 
    && this(cthis) && args(showem);

    pointcut setUseGuillemetsHook2(ProjectSettings cthis) 
    : execution(* ProjectSettings.setUseGuillemetsHook(..)) 
    && this(cthis);

    pointcut getUseGuillemotsValue(ProjectSettings cthis) 
    : execution(* ProjectSettings.getUseGuillemotsValue(..)) 
    && this(cthis);

    pointcut setUseGuillemots(final ProjectSettings cthis, final boolean showem) 
    : execution(* ProjectSettings.setUseGuillemots(..)) 
    && this(cthis) && args(showem);
    
    before(ArgoParser cthis, XMLElement e) 
    : handleUseGuillemots(cthis, e) {
        String ug = e.getText().trim();
        cthis.ps.setUseGuillemots(ug);
    }

    before(ArgoTokenTable cthis) : addTokenGuillemetsHook(cthis) {
        cthis.addToken(ArgoTokenTable.STRING_USEGUILLEMOTS,
                Integer.valueOf(ArgoTokenTable.TOKEN_USEGUILLEMOTS));
    }

    before(ExplorerEventAdaptor cthis) : addListenerGuillemotsHook(cthis) {
        Configuration.addListener(Notation.KEY_USE_GUILLEMOTS, cthis);
    }

    boolean around(final PropertyChangeEvent pce) : isChangePropertyGuillemetsHook(pce) {
        return Notation.KEY_USE_GUILLEMOTS.isChangedProperty(pce);
    }

    before(JPanel settings, GridBagConstraints constraints,
            SettingsTabNotation cthis) 
        : createCheckBoxGuillemotsHook(settings, constraints, cthis) {
        cthis.useGuillemots = cthis.createCheckBox("label.use-guillemots");
        settings.add(cthis.useGuillemots, constraints);
    }

    before(SettingsTabNotation cthis) 
        : setSelectedGuillemotsHook(cthis) {
        cthis.useGuillemots.setSelected(SettingsTabNotation
                .getBoolean(Notation.KEY_USE_GUILLEMOTS));
    }

    before(SettingsTabNotation cthis) 
    : setBooleanGuillemotsHook(cthis) {
        Configuration.setBoolean(Notation.KEY_USE_GUILLEMOTS,
                cthis.useGuillemots.isSelected());
    }

    before(SettingsTabNotation cthis, ProjectSettings ps) 
    : setUseGuillemotsHook(cthis, ps) {
        ps.setUseGuillemots(cthis.useGuillemots.isSelected());
    }

    before(SettingsTabNotation cthis, ProjectSettings ps) 
    : setSelectedPsGuillemotsHook(cthis, ps) {
        cthis.useGuillemots.setSelected(ps.getUseGuillemotsValue());
    }

    before(Notation cthis) : addListenerGuillemetsHook(cthis) {
        Configuration.addListener(Notation.KEY_USE_GUILLEMOTS, cthis);
    }

    before(NotationSettings settings) : setUseGuillemetsHook(settings) {
        settings.setUseGuillemets(false);
    }

    boolean around(NotationSettings cthis) : isUseGuillemets(cthis) {
        if (cthis.useGuillemetsSet) {
            return cthis.useGuillemets;
        } else if (cthis.parent != null) {
            return cthis.parent.isUseGuillemets();
        }
        return NotationSettings.getDefaultSettings().isUseGuillemets();
    }

    before(final NotationSettings cthis, final boolean showem) : setUseGuillemets(cthis, showem) {
        if (cthis.useGuillemets == showem && cthis.useGuillemetsSet) {
            return;
        }
        final boolean oldValid = cthis.useGuillemetsSet;
        Memento memento = new Memento() {
            public void redo() {
                cthis.useGuillemets = showem;
                cthis.useGuillemetsSet = true;
            }

            public void undo() {
                cthis.useGuillemets = !showem;
                cthis.useGuillemetsSet = oldValid;
            }
        };
        cthis.doUndoable(memento);
    }

    before(ProjectSettings cthis) : setUseGuillemetsHook2(cthis) {
        cthis.npSettings.setUseGuillemets(Configuration.getBoolean(
                Notation.KEY_USE_GUILLEMOTS, false));
    }

    boolean around(ProjectSettings cthis) : getUseGuillemotsValue(cthis) {
        return cthis.npSettings.isUseGuillemets();
    }

    before(final ProjectSettings cthis, final boolean showem) : setUseGuillemots(cthis, showem) {
        if (cthis.getUseGuillemotsValue() == showem) {
            return;
        }
        Memento memento = new Memento() {
            private final ConfigurationKey key = Notation.KEY_USE_GUILLEMOTS;

            public void redo() {
                cthis.npSettings.setUseGuillemets(showem);
                cthis.fireNotationEvent(key, !showem, showem);
            }

            public void undo() {
                cthis.npSettings.setUseGuillemets(!showem);
                cthis.fireNotationEvent(key, showem, !showem);
            }
        };
        cthis.doUndoable(memento);
    }

    /**
     * 
     * @param showem
     */
    public void ProjectSettings.setUseGuillemots(String showem) {
        this.setUseGuillemots(Boolean.valueOf(showem).booleanValue());
    }

    // ArgoTokenTable
    private static final String ArgoTokenTable.STRING_USEGUILLEMOTS = "useguillemots";

    /**
     * 
     * @return
     */
    public static final int ArgoTokenTable.TOKEN_USEGUILLEMOTS = 12;

    private JCheckBox SettingsTabNotation.useGuillemots;

    public static final ConfigurationKey Notation.KEY_USE_GUILLEMOTS = Driver
            .getDriver("argo.notation.guillemots").equals("true") ? Configuration
            .makeKey("notation", "guillemots") : null;

    private boolean NotationSettings.useGuillemets;

    private boolean NotationSettings.useGuillemetsSet = false;
}
