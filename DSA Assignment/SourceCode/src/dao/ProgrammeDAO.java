/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import adt.*;
import entity.Programme;
import java.io.*;

/**
 *
 * @author Lee Weng Yi
 */
public class ProgrammeDAO {

    private final String fileName = "programmes.dat";

    public void saveToFile(SortedListInterface<Programme> programmeList) {
        File file = new File(fileName);
        try {
            ObjectOutputStream oo = new ObjectOutputStream(new FileOutputStream(file));
            oo.writeObject(programmeList);
            oo.close();
        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        }
    }

    public SortedListInterface<Programme> retrieveFromFile() throws ClassNotFoundException {
        File file = new File(fileName);

        SortedListInterface<Programme> programmeList = new SortedArrayList<>();
        try {
            ObjectInputStream oi = new ObjectInputStream(new FileInputStream(file));
            programmeList = (SortedArrayList<Programme>) (oi.readObject());
            oi.close();

        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        } catch (ClassNotFoundException ex) {
            System.out.println("\nClass not found.");
        }
        return programmeList;

    }
}
