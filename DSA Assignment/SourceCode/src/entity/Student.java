/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import adt.*;
import java.io.Serializable;

/**
 *
 * @author Bok Cheong Roy
 */
public class Student implements Serializable {

    private String name;
    private String studentID;
    private String programme;
    private String tutorialGroup;

    public Student(String name, String studentID, String programme, String tutorialGroup) {
        this.name = name;
        this.studentID = studentID;
        this.programme = programme;
        this.tutorialGroup = tutorialGroup;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getProgramme() {
        return programme;
    }

    public void setProgramme(String programme) {
        this.programme = programme;
    }

    public String getTutorialGroup() {
        return tutorialGroup;
    }

    public void setTutorialGroup(String tutorialGroup) {
        this.tutorialGroup = tutorialGroup;
    }

    @Override
    public String toString() {
        return String.format("%20s %10s %18s %13s", name, studentID, programme, tutorialGroup);
    }

    public int compareTo(String anotherString) {
        return name.compareTo(anotherString);
    }

    public int compareToIgnoreCase(String str) {
        return studentID.compareToIgnoreCase(str);
    }
    
    public int compareToProgramme(String anotherString) {
        return programme.compareTo(anotherString);
    }
    
    public int compareToTutorial(String anotherString) {
        return tutorialGroup.compareTo(anotherString);
    }
    
}
