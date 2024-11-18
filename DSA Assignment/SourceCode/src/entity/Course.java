/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import adt.*;
import java.io.Serializable;
import java.util.*;

/**
 *
 * @author Pua Jia Qian
 */
public class Course implements Comparable<Course>, Serializable {

    private String courseCode;
    private String courseName;
    private int creditHours;
    private SortedListInterface<Programme> programmeList = new SortedArrayList<>();

    public Course(String courseCode, String courseName, int creditHours) {
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.creditHours = creditHours;
    }

    public Course() {

    }

    public Course(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getCreditHours() {
        return creditHours;
    }

    public void setCreditHours(int creditHours) {
        this.creditHours = creditHours;
    }

    public SortedListInterface<Programme> getProgramme() {
        return programmeList;
    }

    public void setProgramme(SortedListInterface<Programme> programme) {
        this.programmeList = programme;
    }

    public void addProgramme(Programme program) {
        programmeList.add(program);
    }

    @Override
    public int hashCode() {
        return Objects.hash(courseCode);

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
        final Course other = (Course) obj;
        if (this.creditHours != other.creditHours) {
            return false;
        }
        if (!Objects.equals(this.courseCode, other.courseCode)) {
            return false;
        }
        if (!Objects.equals(this.courseName, other.courseName)) {
            return false;
        }
        return Objects.equals(this.programmeList, other.programmeList);
    }

    @Override
    public String toString() {
        return String.format("%-13s %-40s %-10d", courseCode, courseName, creditHours);

    }

    @Override
    public int compareTo(Course o) {
        return getCourseCode().compareTo(o.getCourseCode());
    }

    public boolean matchKeyword(String searchKeyword) {
        String keyword
                = getCourseName().toLowerCase();

        return keyword.contains(searchKeyword);
    }

}
