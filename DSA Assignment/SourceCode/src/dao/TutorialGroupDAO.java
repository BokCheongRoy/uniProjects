/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import adt.*;
import entity.TutorialGroup;
import java.io.*;

/**
 *
 * @author Lee Weng Yi
 */
public class TutorialGroupDAO {

    private final String fileName = "tutorialGroups.dat";

    public void saveToFile(SortedListInterface<TutorialGroup> tgList) {
        File file = new File(fileName);
        try {
            ObjectOutputStream oo = new ObjectOutputStream(new FileOutputStream(file));
            oo.writeObject(tgList);
            oo.close();
        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        }
    }

    public SortedListInterface<TutorialGroup> retrieveFromFile() throws ClassNotFoundException {
        File file = new File(fileName);

        SortedListInterface<TutorialGroup> tgList = new SortedArrayList<>();
        try {
            ObjectInputStream oi = new ObjectInputStream(new FileInputStream(file));
            tgList = (SortedArrayList<TutorialGroup>) (oi.readObject());
            oi.close();

        } catch (FileNotFoundException ex) {
            System.out.println("\nFile not found");
        } catch (IOException ex) {
            System.out.println("\nCannot save to file");
        } catch (ClassNotFoundException ex) {
            System.out.println("\nClass not found.");
        }
        return tgList;

    }
}
