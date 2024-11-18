/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import adt.*;
import entity.Course;
import java.io.*;

/**
 *
 * @author Pua Jia Qian
 */
public class CourseDAO {

    private final String fileName = "courses.dat";

    public void saveToFile(SortedListInterface<Course> courseList) {
        File file = new File(fileName);
        try {
            ObjectOutputStream oo = new ObjectOutputStream(new FileOutputStream(file));
            oo.writeObject(courseList);
            oo.close();
        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        }
    }

    public SortedListInterface<Course> retrieveFromFile() throws ClassNotFoundException {
        File file = new File(fileName);

        SortedListInterface<Course> courseList = new SortedArrayList<>();
        try {
            ObjectInputStream oi = new ObjectInputStream(new FileInputStream(file));
            courseList = (SortedArrayList<Course>) (oi.readObject());
            oi.close();

        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        } catch (ClassNotFoundException ex) {
            System.out.println("\nClass not found.");
        }
        return courseList;
    }
}
