/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import adt.*;
import java.util.Objects;

/**
 *
 * @author Lee Weng Yi
 */
public class Programme implements Comparable<Programme> {

    private String programmeCode;
    private String programmeName;
    private int durationOfYear;
    private SortedArrayList<TutorialGroup> tutorialGroupList = new SortedArrayList<>();

    public Programme() {

    }

    public Programme(String programmeCode) {
        this.programmeCode = programmeCode;
    }

    public Programme(String programmeCode, String programmeName, int durationOfYear) {
        this.programmeCode = programmeCode;
        this.programmeName = programmeName;
        this.durationOfYear = durationOfYear;
    }

    public String getProgrammeCode() {
        return programmeCode;
    }

    public void setProgrammeCode(String programmeCode) {
        this.programmeCode = programmeCode;
    }

    public String getProgrammeName() {
        return programmeName;
    }

    public void setProgrammeName(String programmeName) {
        this.programmeName = programmeName;
    }

    public int getDurationOfYear() {
        return durationOfYear;
    }

    public void setDurationOfYear(int durationOfYear) {
        this.durationOfYear = durationOfYear;
    }

    public SortedArrayList<TutorialGroup> getTutorialGroup() {
        return tutorialGroupList;
    }

    public void setTutorialGroup(SortedArrayList<TutorialGroup> tutorialGroupList) {
        this.tutorialGroupList = tutorialGroupList;
    }

    public void addTutorialGroup(TutorialGroup tutorialGroup) {
        tutorialGroupList.add(tutorialGroup);
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
        final Programme other = (Programme) obj;
        if (!Objects.equals(this.programmeCode, other.programmeCode)) {
            return false;
        }
        return true;
    }

    @Override
    public int compareTo(Programme otherProgramme) {
        return getProgrammeCode().compareTo(otherProgramme.programmeCode);
    }

    @Override
    public String toString() {
        return String.format("%-10s %-40s %10d", programmeCode, programmeName, durationOfYear);
    }

}
