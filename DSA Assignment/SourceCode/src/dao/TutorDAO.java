/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import adt.*;
import entity.Tutor;
import java.io.*;
/**
 *
 * @author Choo Shi Yi
 */
public class TutorDAO {

    private final String fileName = "Tutors.dat";

    public void saveToFile(SortedListInterface<Tutor> tutorList){
        File file = new File(fileName);
        try {
            ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file));
            oos.writeObject(tutorList);
            oos.close();
        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        }
    }
    
     public SortedListInterface<Tutor> retrieveFromFile(){
       File file = new File(fileName);
        SortedListInterface<Tutor> tutorList = new SortedArrayList<>();
        try {
            ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file));
            tutorList = (SortedArrayList<Tutor>) (ois.readObject());
            ois.close();
        } catch (FileNotFoundException ex) {
            System.out.println("\nNo such file.");
        } catch (IOException ex) {
            System.out.println("\nCannot read from file.");
        } catch (ClassNotFoundException ex) {
            System.out.println("\nClass not found.");
        } finally {
            return tutorList;
        }
    }
    
}
