package control;

import adt.*;
import dao.TutorialGroupDAO;
import entity.*;
import boundary.TutorialGroupCRUD_UI;
import utility.*;

/**
 *
 * @author Lee Weng Yi
 */
public class TutorialGroupCRUD {

    private SortedListInterface<TutorialGroup> tgList = new SortedArrayList<>();
    private final TutorialGroupDAO tgd = new TutorialGroupDAO();
    private TutorialGroupCRUD_UI tgUI = new TutorialGroupCRUD_UI();

    public TutorialGroupCRUD() {
        try {
            tgList = tgd.retrieveFromFile();
        } catch (ClassNotFoundException ex) {
            System.out.println("Something Wrong in File");
        }
    }

    public void runTutorialGroupManagement() {
        int choice = 0;
        do {
            choice = tgUI.getTutorialGroupMenu();
            switch (choice) {
                case 1:
                    addNewTutorialGroup();
                    break;
                case 2:
                    deleteGroupByCode(tgUI.inputGroupCode());
                    break;
                case 3:
                    searchGroupByCode(tgUI.inputGroupCode());
                    break;
                case 4:
                    modifyGroupByCode(tgUI.inputGroupCode());
                    break;
                case 5:
                    tgUI.displayAllGroup(tgList);
                    break;
                case 0:
                    MessageUI.displayExitSubsystemMessage();
                    break;
                default:
                    MessageUI.displayInvalidChoiceMessage();
            }
        } while (choice != 0);
    }

    public void initialCourses() {
        tgList = new SortedArrayList<>();
        tgList.add(new TutorialGroup("TG1", "Group 1"));
        tgList.add(new TutorialGroup("TG2", "Group 2"));
        tgList.add(new TutorialGroup("TG3", "Group 3"));
    }

    public void addNewTutorialGroup() {
        System.out.println("======================"
                + "");
        System.out.println("Add New Tutorial Group");
        System.out.println("======================\n");

        TutorialGroup newGroup = tgUI.inputProgrammeDetails();
        tgUI.displayGroup(newGroup);

        if (!tgUI.inputConfirm().equals("Y")) {
            System.out.println("Add tutorial group cancelled");
        } else {
            tgList.add(newGroup);
            tgd.saveToFile(tgList);
            System.out.println("Tutorial group " + newGroup.getTgCode() + " added.");
        }
    }

    public boolean searchGroupByCode(String tgCode) {

        for (int i = 0; i < tgList.getNumberOfEntries(); i++) {
            TutorialGroup currentGroup = tgList.getEntry(i);
            if (currentGroup.getTgCode().equals(tgCode)) {
                tgUI.displayGroup(currentGroup);
                return true;
            }
        }
        System.out.println("Tutorial Group " + tgCode + " not found. ");
        return false;
    }

    public void deleteGroupByCode(String tgCode) {
        if (searchGroupByCode(tgCode)) {

            if (!tgUI.inputConfirm().equals("Y")) {
                System.out.println("Modification canceled.");
            } else {
                TutorialGroup searchKey = new TutorialGroup(tgCode);
                tgList.remove(searchKey);
                tgd.saveToFile(tgList);
                System.out.println("Tutorial Group" + tgCode + "deleted.");
            }
        }
    }

    public void modifyGroupByCode(String tgCode) {
        if (searchGroupByCode(tgCode)) {
            TutorialGroup selectedGroup = tgList.getEntry(tgList.getPosition(new TutorialGroup(tgCode)) - 1);
            String modifiedGroupName = tgUI.inputGroupName();
            TutorialGroup modifiedGroup = new TutorialGroup(selectedGroup.getTgCode(), modifiedGroupName);
            tgUI.displayGroup(modifiedGroup);
            if (!tgUI.inputConfirm().equals("Y")) {
                System.out.println("Modification canceled.");
            } else {
                // Replace the existing program with the modified program
                selectedGroup.setTgName(modifiedGroupName);
                tgd.saveToFile(tgList);
                System.out.println("Programme modified.");
            }
        }

    }

}
