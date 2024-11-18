/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.util.Objects;

/**
 *
 * @author Lee Weng Yi
 */
public class TutorialGroup implements Comparable<TutorialGroup>, Serializable {

    private String tgCode;
    private String tgName;

    public TutorialGroup() {

    }

    public TutorialGroup(String tgCode) {
        this.tgCode = tgCode;
    }

    public TutorialGroup(String tgCode, String tgName) {
        this.tgCode = tgCode;
        this.tgName = tgName;
    }

    public String getTgCode() {
        return tgCode;
    }

    public void setTgCode(String tgCode) {
        this.tgCode = tgCode;
    }

    public String getTgName() {
        return tgName;
    }

    public void setTgName(String tgName) {
        this.tgName = tgName;
    }

    public String toString() {
        return String.format("%-10s %-40s", tgCode, tgName);
    }
    
    @Override
    public int hashCode() {
        int hash = 3;
        return hash;
    }
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final TutorialGroup other = (TutorialGroup) obj;
        if (!Objects.equals(this.tgCode, other.tgCode)) {
            return false;
        }
        return true;
    }
    
    @Override
    public int compareTo(TutorialGroup o) {
        return getTgCode().compareTo(o.tgCode);
    }
}
