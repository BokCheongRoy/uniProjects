/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import adt.*;
import entity.Student;
import java.io.*;

/**
 *
 * @author Bok Cheong Roy
 */
public class StudentDAO {

    private String fileName = "students.dat"; // For security and maintainability, should not have filename hardcoded here.

    public void saveToFile(ListInterface<Student> studentList) {
        File file = new File(fileName);
        try {
            ObjectOutputStream ooStream = new ObjectOutputStream(new FileOutputStream(file));
            ooStream.writeObject(studentList);
            ooStream.close();
        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        }
    }

    public ListInterface<Student> retrieveFromFile()throws ClassNotFoundException {
       File file = new File(fileName);

        ListInterface<Student> studentList = new ArrayList<>();
        try {
            ObjectInputStream oi = new ObjectInputStream(new FileInputStream(file));
            studentList = (ArrayList<Student>) (oi.readObject());
            oi.close();

        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        } catch (ClassNotFoundException ex) {
            System.out.println("\nClass not found.");
        }
        return studentList;
    }
}
