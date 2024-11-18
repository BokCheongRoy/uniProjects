/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.util.Objects;

/**
 *
 * @author Choo Shi Yi
 */
public class Tutor implements Comparable<Tutor>, Serializable {

    private String tutorId;
    private String tutorName;
    private String tutorContactNo;
    private String tutorEmail;
    private String tutorSpecialization;
    private int tutorExpYear;
    private String tutorType;

    public Tutor() {
    }

    public Tutor(String tutorId, String tutorName, String tutorContactNo, String tutorEmail, String tutorSubject, int tutorExpYear, String tutorType) {
        this.tutorId = tutorId;
        this.tutorName = tutorName;
        this.tutorContactNo = tutorContactNo;
        this.tutorEmail = tutorEmail;
        this.tutorSpecialization = tutorSubject;
        this.tutorExpYear = tutorExpYear;
        this.tutorType = tutorType;
    }

    public String getTutorId() {
        return tutorId;
    }

    public String getTutorName() {
        return tutorName;
    }

    public String getTutorContactNo() {
        return tutorContactNo;
    }

    public String getTutorEmail() {
        return tutorEmail;
    }

    public String getTutorSpecialization() {
        return tutorSpecialization;
    }

    public int getTutorExpYear() {
        return tutorExpYear;
    }

    public String getTutorType() {
        return tutorType;
    }

    public void setTutorId(String tutorId) {
        this.tutorId = tutorId;
    }

    public void setTutorName(String tutorName) {
        this.tutorName = tutorName;
    }

    public void setTutorContactNo(String tutorContactNo) {
        this.tutorContactNo = tutorContactNo;
    }

    public void setTutorEmail(String tutorEmail) {
        this.tutorEmail = tutorEmail;
    }

    public void setTutorSpecialization(String tutorSubject) {
        this.tutorSpecialization = tutorSubject;
    }

    public void setTutorExpYear(int tutorExpYear) {
        this.tutorExpYear = tutorExpYear;
    }

    public void setTutorType(String tutorType) {
        this.tutorType = tutorType;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 29 * hash + Objects.hashCode(this.tutorId);
        hash = 29 * hash + Objects.hashCode(this.tutorName);
        hash = 29 * hash + Objects.hashCode(this.tutorContactNo);
        hash = 29 * hash + Objects.hashCode(this.tutorEmail);
        hash = 29 * hash + Objects.hashCode(this.tutorSpecialization);
        hash = 29 * hash + Objects.hashCode(this.tutorExpYear);
        hash = 29 * hash + Objects.hashCode(this.tutorType);
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
        final Tutor other = (Tutor) obj;
        if (!Objects.equals(this.tutorId, other.tutorId)) {
            return false;
        }
        if (!Objects.equals(this.tutorName, other.tutorName)) {
            return false;
        }
        if (!Objects.equals(this.tutorContactNo, other.tutorContactNo)) {
            return false;
        }
        if (!Objects.equals(this.tutorEmail, other.tutorEmail)) {
            return false;
        }
        if (!Objects.equals(this.tutorSpecialization, other.tutorSpecialization)) {
            return false;
        }
        if (!Objects.equals(this.tutorExpYear, other.tutorExpYear)) {
            return false;
        }
        return Objects.equals(this.tutorType, other.tutorType);
    }

    @Override
    public String toString() {
        return String.format("| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |", tutorId, tutorName, tutorContactNo, tutorEmail, tutorSpecialization, tutorExpYear, tutorType);
    }

    @Override
    public int compareTo(Tutor o) {
    return this.tutorId.compareTo(o.tutorId);
    }

//    public boolean isEmpty() {
//        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
//    }

//   public boolean tutorAlreadyExists(String tutorIdToCheck) {
//    for (Tutor tutor : tutorList) {
//        if (tutor.getTutorId().equals(tutorIdToCheck)) {
//            return true; // Tutor with the same ID already exists
//        }
//    }
//    return false; // Tutor with the given ID does not exist
//}


}
