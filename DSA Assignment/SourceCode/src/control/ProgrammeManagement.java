package control;

import adt.*;
import dao.*;
import entity.*;
import boundary.ProgrammeManagementUI;
import utility.*;

/**
 *
 * @author Lee Weng Yi
 */
public class ProgrammeManagement {

    private SortedListInterface<Programme> programmeList = new SortedArrayList<>();
    private SortedListInterface<TutorialGroup> groupList = new SortedArrayList<>();
    private final ProgrammeDAO pd = new ProgrammeDAO();
    private ProgrammeManagementUI programmeUI = new ProgrammeManagementUI();
    private TutorialGroupCRUD tgm = new TutorialGroupCRUD();
    private final TutorialGroupDAO tgd = new TutorialGroupDAO();
    private ListInterface<Student> studentList = new ArrayList<>();
    private final StudentDAO sd = new StudentDAO();

    public ProgrammeManagement() {
        try {
            programmeList = pd.retrieveFromFile();
        } catch (ClassNotFoundException ex) {
            System.out.println("Something Wrong in File");
        }
    }

    public void runProgrammeManagement() {
        int choice = 0;
        do {
            choice = programmeUI.getProgrammeMenu();
            programmeUI.displayActionTitle(choice);
            switch (choice) {
                case 1:
                    addNewProgramme();
                    programmeUI.displayAllProgrammes(programmeList);
                    break;
                case 2:
                    deleteProgrammeByCode(programmeUI.inputProgrammeCode());
                    break;
                case 3:
                    searchProgrammeByCode(programmeUI.inputProgrammeCode());
                    break;
                case 4:
                    modifyProgrammeByCode(programmeUI.inputProgrammeCode());
                    break;
                case 5:
                    programmeUI.displayAllProgrammes(programmeList);
                    break;
                case 6:
                    addTutorialGroupToProgramme(programmeUI.inputProgrammeCode());
                    break;
                case 7:
                    removeTutorialGroupFromProgramme(programmeUI.inputProgrammeCode());
                    break;
                case 8:
                    listTutorialGroupsForProgramme(programmeUI.inputProgrammeCode());
                    break;
                case 9:
                    generateReport();
                    break;
                case 0:
                    MessageUI.displayExitSubsystemMessage();
                    UniversityManagement um = new UniversityManagement();
                    um.runMenu();
                    break;
                default:

                    MessageUI.displayInvalidChoiceMessage();
            }
        } while (choice != 0);
    }

    public void addNewProgramme() {
        Programme newProgramme = programmeUI.inputProgrammeDetails(programmeList);
        programmeUI.displayProgramme(newProgramme);

        if (!programmeUI.inputConfirmation("Confirm", "add").equals("Y")) {
            programmeUI.displayMessage("addCancel");
        } else {
            programmeList.add(newProgramme);
            pd.saveToFile(programmeList);
            programmeUI.displayMessage("addSuccess");
            if (programmeUI.inputConfirmation("Continue", "add").equals("Y")) {
                addNewProgramme();
            }
        }
        runProgrammeManagement();
    }

    public boolean searchProgrammeByCode(String programCode) {

        Programme searchKey = new Programme(programCode);
        int position = programmeList.getPosition(searchKey);

        if (position > 0) {
            Programme foundProgramme = programmeList.getEntry(position - 1);
            programmeUI.displayProgramme(foundProgramme);
            return true;
        } else {
            programmeUI.displayNotFound(programCode);
            return false;
        }
    }

    public void deleteProgrammeByCode(String programmeCode) {
        if (searchProgrammeByCode(programmeCode)) {
            Programme selectedProgram = programmeList.getEntry(programmeList.getPosition(new Programme(programmeCode)) - 1);
            if (!programmeUI.inputConfirmation("Confirm", "delete").equals("Y")) {
                programmeUI.displayMessage("deleteCancel");
            } else {
                if (!selectedProgram.getTutorialGroup().isEmpty()) {
                    programmeUI.displayMessage("unableDelete");
                    return;
                }
                Programme searchKey = new Programme(programmeCode);
                programmeList.remove(searchKey);
                pd.saveToFile(programmeList);
                programmeUI.displayMessage("deleteSuccess");
            }
        }
    }

    public void modifyProgrammeByCode(String programmeCode) {
        if (searchProgrammeByCode(programmeCode)) {
            Programme selectedProgram = programmeList.getEntry(programmeList.getPosition(new Programme(programmeCode)) - 1);
            //get Modify Selection
            int choice;
            String modifiedProgramName = selectedProgram.getProgrammeName();
            int modifiedDuration = selectedProgram.getDurationOfYear();
            // Display the modified details
            Programme modifiedProgramme = new Programme(selectedProgram.getProgrammeCode(), modifiedProgramName, modifiedDuration);
            do {
                choice = programmeUI.getModifySelection();
                switch (choice) {
                    case 1:
                        modifiedProgramName = programmeUI.inputProgrammeName(programmeList);
                        modifiedProgramme.setProgrammeName(modifiedProgramName);
                        programmeUI.displayProgramme(modifiedProgramme);
                        break;
                    case 2:
                        modifiedDuration = programmeUI.inputDurationOfYear();
                        modifiedProgramme.setDurationOfYear(modifiedDuration);
                        programmeUI.displayProgramme(modifiedProgramme);
                        break;
                    case 0:
                        break;
                }
            } while (choice != 0);
            // Display the modified details
            programmeUI.displayProgramme(modifiedProgramme);
            if (!programmeUI.inputConfirmation("Confirm", "modify").equals("Y")) {
                programmeUI.displayMessage("modifyCancel");
            } else {
                // Replace the existing program with the modified program
                selectedProgram.setProgrammeName(modifiedProgramName);
                selectedProgram.setDurationOfYear(modifiedDuration);
                pd.saveToFile(programmeList);
                programmeUI.displayMessage("modifySuccess");
            }
        }
    }

    public void addTutorialGroupToProgramme(String programmeCode) {

        if (searchProgrammeByCode(programmeCode)) {
            Programme selectedProgramme = programmeList.getEntry(programmeList.getPosition(new Programme(programmeCode)) - 1);

            // Load all tutorial groups
            loadTutorialGroups();

            // Get the tutorial groups that haven't been associated with the selected program
            SortedListInterface<TutorialGroup> unassociatedGroups = getUnassociatedTutorialGroup();
            // Display unassociated tutorial groups
            if (!unassociatedGroups.isEmpty()) {
                int selectedGroupNumber = programmeUI.getSelectedGroup(unassociatedGroups);
                TutorialGroup selectedGroup = unassociatedGroups.getEntry(selectedGroupNumber - 1);
                if (!programmeUI.inputConfirmation("Confirm", "add").equals("Y")) {
                    programmeUI.displayMessage("addCancel");
                } else {
                    selectedProgramme.addTutorialGroup(selectedGroup);
                    pd.saveToFile(programmeList);
                    programmeUI.displayGroupMessage("add", selectedGroup.getTgName(), selectedProgramme.getProgrammeName());
                }
            } else {
                programmeUI.displayAllAssociated();
            }
        }
    }

    public void loadTutorialGroups() {
        try {
            // Retrieve tutorial groups from the file
            groupList = tgd.retrieveFromFile();
        } catch (ClassNotFoundException ex) {
            System.out.println("\nClass not found while loading tutorial groups.");
        }
    }

    public void loadStudent() {
        try {
            // Retrieve tutorial groups from the file
            studentList = sd.retrieveFromFile();
        } catch (ClassNotFoundException ex) {
            System.out.println("\nClass not found while loading tutorial groups.");
        }
    }

    public void removeTutorialGroupFromProgramme(String programmeCode) {
        if (searchProgrammeByCode(programmeCode)) {
            Programme selectedProgram = programmeList.getEntry(programmeList.getPosition(new Programme(programmeCode)) - 1);
            SortedListInterface<TutorialGroup> tgList = selectedProgram.getTutorialGroup();

            if (!tgList.isEmpty()) {
                int selectedGroupNumber = programmeUI.getSelectedGroup(tgList);
                TutorialGroup selectedGroup = tgList.getEntry(selectedGroupNumber - 1);

                if (programmeUI.inputConfirmation("Confirm", "delete").equals("Y")) {
                    tgList.remove(selectedGroup);
                    pd.saveToFile(programmeList);
                    programmeUI.displayGroupMessage("remove", selectedGroup.getTgName(), selectedProgram.getProgrammeName());
                }
            } else {
                programmeUI.displayGroup(tgList);
            }
        }
    }

    public void listTutorialGroupsForProgramme(String programmeCode) {
        if (searchProgrammeByCode(programmeCode)) {
            Programme selectedProgram = programmeList.getEntry(programmeList.getPosition(new Programme(programmeCode)) - 1);
            SortedListInterface<TutorialGroup> tgList = selectedProgram.getTutorialGroup();
            programmeUI.displayGroup(tgList);
        }
    }

    public SortedListInterface<TutorialGroup> getUnassociatedTutorialGroup() {
        SortedListInterface<TutorialGroup> associatedGroup = new SortedArrayList<>();
        SortedListInterface<TutorialGroup> unassociatedGroup = new SortedArrayList<>();
        // Get associated tutorial groups
        for (int i = 0; i < programmeList.getNumberOfEntries(); i++) {
            Programme selectedProgram = programmeList.getEntry(i);
            SortedListInterface<TutorialGroup> programGroups = selectedProgram.getTutorialGroup();
            if (!programGroups.isEmpty()) {
                for (int j = 0; j < programGroups.getNumberOfEntries(); j++) {
                    TutorialGroup group = programGroups.getEntry(j);
                    associatedGroup.add(group);
                }
            }
        }
        // Compare All groups and associated groups to get Unassociated
        for (int i = 0; i < groupList.getNumberOfEntries(); i++) {
            TutorialGroup currentTutorialGroup = groupList.getEntry(i);
            boolean isAssociated = false;
            for (int j = 0; j < associatedGroup.getNumberOfEntries(); j++) {
                TutorialGroup currentAssociatedGroup = associatedGroup.getEntry(j);
                if (currentTutorialGroup.getTgCode().equals(currentAssociatedGroup.getTgCode())) {
                    isAssociated = true;
                    break;
                }
            }
            if (!isAssociated) {
                unassociatedGroup.add(currentTutorialGroup);
            }
        }
        return unassociatedGroup;
    }

    public void generateReport() {
        loadStudent();
        programmeUI.displayReport(programmeList, studentList);
    }

}
