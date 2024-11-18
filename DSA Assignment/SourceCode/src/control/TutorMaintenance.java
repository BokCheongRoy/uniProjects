package control;

import adt.*;
import dao.TutorDAO;
import boundary.TutorUI;
import entity.Tutor;
import java.util.Scanner;
import utility.MessageUI;

/**
 *
 * @author Choo Shi Yi
 */
public class TutorMaintenance {

    Scanner scanner = new Scanner(System.in);
    private SortedListInterface<Tutor> tutorList = new SortedArrayList<>();
    private final TutorDAO tutorDAO = new TutorDAO();
    private final TutorUI tutorUI = new TutorUI();
    UniversityManagement um = new UniversityManagement();

    public TutorMaintenance() {
        tutorList = tutorDAO.retrieveFromFile();
    }

    public void runTutorMaintenance() {
        int choice = 0;
        do {
            choice = tutorUI.getMenuChoice();
            switch (choice) {
                case 0:
                    MessageUI.displayExitProgram();
                    //System.exit(0);
                    break;
                case 1:
                    tutorUI.printAdd();
                    addNewTutor();
                    break;
                case 2:
                    tutorUI.listAllTutor(getAllTutor(tutorList));
                    tutorUI.printRemove();
                    removeTutor();
                    break;
                case 3:
                    findTutor();
                    break;
                case 4:
                    tutorUI.listAllTutor(getAllTutor(tutorList));
                    tutorUI.printModify();
                    amendTutor();
                    break;
                case 5:
                    tutorUI.listAllTutor(getAllTutor(tutorList));
                    break;
                case 6:
                    filterTutor(tutorList);
                    break;
                case 7:
                    tutorReport();
                    break;
                default:
                    MessageUI.displayInvalid();
            }
        } while (choice != 0);
    }

    public void addNewTutor() {
        // Input details for the new tutor
        Tutor newTutor = tutorUI.inputTutorDetails();
        String tutorId = newTutor.getTutorId(); // Get the tutor ID of the new tutor

        while (isTutorIdExists(tutorId)) {
            System.out.println("A tutor with the same ID already exists. Please choose a different tutor ID.");
            newTutor = tutorUI.inputTutorDetails();
            tutorId = newTutor.getTutorId();
        }

        tutorUI.printTutorDetails(newTutor);
        String addConfirm;
        String choice = "";

        do {
            System.out.print("Are you sure to add this tutor (Y/N)? ");
            addConfirm = scanner.nextLine().trim().toUpperCase();

            if (addConfirm.equals("Y")) {
                tutorList.add(newTutor);
                tutorDAO.saveToFile(tutorList);
                MessageUI.displaySuccessfulAdd();
                tutorUI.listAllTutor(getAllTutor(tutorList));
                choice = tutorUI.inputContinue();
                if (!choice.equals("Y")) {
                    MessageUI.displayExitProgram();
                    um.runMenu();
                }
            } else if (addConfirm.equals("N")) {
                MessageUI.displayExitAdd();
            } else if (addConfirm.isEmpty()) {
                MessageUI.displayEmpty();
            } else {
                MessageUI.displayInvalid();
            }
        } while (!addConfirm.equals("N") && !addConfirm.equals("Y") && addConfirm.isEmpty());
    }

    private boolean isTutorIdExists(String tutorId) {
        for (int i = 0; i < tutorList.getNumberOfEntries(); i++) {
            Tutor existingTutor = tutorList.getEntry(i);
            if (existingTutor.getTutorId().equalsIgnoreCase(tutorId)) {
                return true;
            }
        }
        return false;
    }

    public void removeTutor() {
        String removeTutorId = tutorUI.inputTutorId();
        boolean tutorFound = false;

        for (int i = 1; i <= tutorList.getNumberOfEntries(); i++) {
            if (removeTutorId.equals(tutorList.getEntry(i).getTutorId())) {
                Tutor removeTutor = tutorList.getEntry(i);
                tutorUI.printTutorDetails(removeTutor);
                tutorFound = true;
                break;
            }
        }

        if (!tutorFound) {
            System.out.println("Sorry, tutor could not be found or removed");
        } else {
            String deleteConfirm;

            do {
                System.out.print("\nAre you sure to remove this tutor (Y/N)? ");
                deleteConfirm = scanner.next().toUpperCase();

                if (deleteConfirm.isEmpty()) {
                    MessageUI.displayEmpty();
                } else if (!deleteConfirm.equals("Y") && !deleteConfirm.equals("N")) {
                    MessageUI.displayInvalid();
                }
            } while (deleteConfirm.isEmpty() || (!deleteConfirm.equals("Y") && !deleteConfirm.equals("N")));

            if (deleteConfirm.equals("Y")) {
                for (int i = 1; i <= tutorList.getNumberOfEntries(); i++) {
                    if (removeTutorId.equals(tutorList.getEntry(i).getTutorId())) {
                        Tutor tutorRemove = tutorList.getEntry(i);
                        tutorList.remove(tutorRemove);
                        tutorDAO.saveToFile(tutorList);
                        MessageUI.displaySuccessfulDelete();
                        String choice = " ";
                        choice = tutorUI.inputContinue();
                        if (!choice.equals("Y")) {
                            MessageUI.displayExitProgram();
                            um.runMenu();
                        }
                    }
                }
            } else {
                MessageUI.displayExitDelete();
            }
        }
    }

    public void amendTutor() {
        String modifyTutor = tutorUI.inputTutorId();

        Tutor modifyTutor1 = new Tutor();
        String newTutorName = "";
        String newTutorEmail = "";
        String newTutorContactNo = "";
        String newTutorType = "";
        int newTutorExpYear = 0;
        String newTutorSpecialization = "";

        for (int i = 0; i < tutorList.getNumberOfEntries(); i++) {
            if (modifyTutor.equals(tutorList.getEntry(i).getTutorId())) {
                modifyTutor1 = tutorList.getEntry(i);
                tutorUI.printTutorDetails(modifyTutor1);
                newTutorName = modifyTutor1.getTutorName();
                newTutorEmail = modifyTutor1.getTutorEmail();
                newTutorContactNo = modifyTutor1.getTutorContactNo();
                newTutorType = modifyTutor1.getTutorType();
                newTutorExpYear = modifyTutor1.getTutorExpYear();
                newTutorSpecialization = modifyTutor1.getTutorSpecialization();
            }
        }

        int choice = 8;
        do {
            choice = tutorUI.inputModifyOption();
            switch (choice) {
                case 0:
                    break;
                case 1:
                    newTutorName = tutorUI.inputTutorName();
                    break;
                case 2:
                    newTutorContactNo = tutorUI.inputTutorContactNo();
                    break;
                case 3:
                    newTutorEmail = tutorUI.inputTutorEmail();
                    break;
                case 4:
                    newTutorSpecialization = tutorUI.inputTutorSpecialization();
                    break;
                case 5:
                    newTutorExpYear = tutorUI.inputTutorExpYear();
                    break;
                case 6:
                    newTutorType = tutorUI.inputTutorType();
                    break;
                case 7:
                    MessageUI.displayExitEdit();
                    break;
                default:
                    MessageUI.displayInvalid();
            }
        } while (choice > 0 && choice < 7);

        String modifyConfirm;
        do {
            System.out.print("Are you sure to modify this tutor (Y/N)? ");
            modifyConfirm = scanner.next().toUpperCase();

            if (modifyConfirm.isEmpty()) {
                MessageUI.displayEmpty();
            } else if (!modifyConfirm.equals("Y") && !modifyConfirm.equals("N")) {
                MessageUI.displayInvalid();
            }
        } while (modifyConfirm.isEmpty() || (!modifyConfirm.equals("Y") && !modifyConfirm.equals("N")));

        String choice1 = "";
        if (modifyConfirm.equals("Y")) {
            modifyTutor1.setTutorName(newTutorName);
            modifyTutor1.setTutorContactNo(newTutorContactNo);
            modifyTutor1.setTutorEmail(newTutorEmail);
            modifyTutor1.setTutorSpecialization(newTutorSpecialization);
            modifyTutor1.setTutorExpYear(newTutorExpYear);
            modifyTutor1.setTutorType(newTutorType);

            tutorDAO.saveToFile(tutorList);
            MessageUI.displaySuccessfulModify();
            choice1 = tutorUI.inputContinue();
            if (!choice1.equals("Y")) {
                MessageUI.displayExitProgram();
                um.runMenu();
            }
        }
    }

    public String getAllTutor(SortedListInterface<Tutor> tutorList1) {
        String outputStr = "";

        for (int i = 0; i < tutorList.getNumberOfEntries(); i++) {
            outputStr += tutorList.getEntry(i) + "\n";
        }
        return outputStr;
    }

    public void displayTutor() {
        tutorUI.listAllTutor(getAllTutor(tutorList));

    }

    private int choice = 0;

    public void findTutor() {
        do {
            choice = tutorUI.printFind();

            if (choice == 0) {
                MessageUI.displayInvalid();
            } else if (choice == -1) {
                MessageUI.displayInvalid();
            } else {
                switch (choice) {
                    case 1:
                        findTutorById();
                        break;
                    case 2:
                        findTutorByName();
                        break;
                    default:
                        MessageUI.displayInvalid();
                        break;
                }
            }
        } while (choice != 1 && choice != 2);
    }

    public void findTutorById() {
        String findTutorId = tutorUI.inputTutorId();
        Tutor foundTutor = null;
        String choice = "";
        for (int i = 0; i < tutorList.getNumberOfEntries(); i++) {
            if (tutorList.getEntry(i).getTutorId().contentEquals(findTutorId)) {
                foundTutor = tutorList.getEntry(i);
                tutorUI.printTutorDetails(foundTutor);
                choice = tutorUI.inputContinue();
                if (!choice.equals("Y")) {
                    MessageUI.displayExitProgram();
                    um.runMenu();
                }
            }
        }
        if (foundTutor == null) {
            System.out.println("The tutor you found does not exist!");
        }
    }

    public void findTutorByName() {
        String findTutorName = tutorUI.inputTutorName().toUpperCase(); // Convert input to uppercase
        ListInterface<Tutor> matchingTutors = new ArrayList<>();

        for (int i = 0; i < tutorList.getNumberOfEntries(); i++) {
            String tutorName = tutorList.getEntry(i).getTutorName().toUpperCase(); // Convert stored name to uppercase

            if (tutorName.contains(findTutorName)) { // Check if the stored name contains the input substring
                matchingTutors.add(tutorList.getEntry(i));
            }
        }
        if (!matchingTutors.isEmpty()) {
            for (int i = 1; i <= matchingTutors.getNumberOfEntries(); i++) {
                Tutor foundTutor = matchingTutors.getEntry(i);
                tutorUI.printTutorDetails(foundTutor);
                String choice = tutorUI.inputContinue();
                if (!choice.equals("Y")) {
                    MessageUI.displayExitProgram();
                    um.runMenu();
                }
            }
        } else {
            System.out.println("No matching tutor found!");
        }
    }

    public String filterTutor(SortedListInterface<Tutor> tutorList1) {
        String outputStr = "";
        int choice;

        do {
            choice = tutorUI.printFilter();

            if (choice == 0 || choice > 3) {
                System.out.println("Invalid choice. Please enter a valid option.");
            } else {
                switch (choice) {
                    case 1:
                        tutorList1.selectionSortAscending();
                        outputStr = tutorUI.printSortedList(tutorList1, "ascending");
                        System.out.println(outputStr);
                        break;
                    case 2:
                        tutorList1.selectionSortDescending();
                        outputStr = tutorUI.printSortedList(tutorList1, "descending");
                        System.out.println(outputStr);
                        break;
                    case 3:
                        // Exit
                        break;
                }
            }
        } while (choice != 3);

        return outputStr;
    }

    public void tutorReport() {
        int reportChoice;

        do {
            reportChoice = tutorUI.printReport();

            switch (reportChoice) {
                case 1:
                    fullTimeTutors();
                    partTimeTutors();
                    break;
                case 2:
                    experiencedTutorReport();
                    break;
                case 3:

                    break;
                default:
                    MessageUI.displayInvalid();
                    break;
            }
        } while (reportChoice != 1 && reportChoice != 2 && reportChoice != 3);
    }

    public void fullTimeTutors() {
        ListInterface<Tutor> fullTimeTutors = new ArrayList<>();

        for (int i = 0; i < tutorList.getNumberOfEntries(); i++) {
            Tutor tutor = tutorList.getEntry(i);

            if (tutor.getTutorType().equalsIgnoreCase("FT")) {
                fullTimeTutors.add(tutor);
            }
        }

        if (!fullTimeTutors.isEmpty()) {
            tutorUI.printFtTutors(fullTimeTutors);
        } else {
            System.out.println("No full-time tutors found!");
        }
    }

    public void partTimeTutors() {
        ListInterface<Tutor> partTimeTutors = new ArrayList<>();

        for (int i = 0; i < tutorList.getNumberOfEntries(); i++) {
            Tutor tutor = tutorList.getEntry(i);

            if (tutor.getTutorType().equalsIgnoreCase("PT")) {
                partTimeTutors.add(tutor);
            }
        }

        if (!partTimeTutors.isEmpty()) {
            tutorUI.printPtTutors(partTimeTutors);
        } else {
            System.out.println("No full-time tutors found!");
        }
    }

    public void experiencedTutorReport() {
        ListInterface<Tutor> lessThan2Years = new ArrayList<>();
        ListInterface<Tutor> between2And5Years = new ArrayList<>();
        ListInterface<Tutor> moreThan5Years = new ArrayList<>();
        String categoryHeader1 = "Tutor Experience Less Than 2 Years";
        String categoryHeader2 = "Tutor Experience Between 2 And 5 Years";
        String categoryHeader3 = "Tutor Experience More Than 5Years";

        for (int i = 0; i < tutorList.getNumberOfEntries(); i++) {
            Tutor tutor = tutorList.getEntry(i);

            int experience = tutor.getTutorExpYear();
            if (experience < 2) {
                lessThan2Years.add(tutor);
            } else if (experience >= 2 && experience < 5) {
                between2And5Years.add(tutor);
            } else if (experience > 5) {
                moreThan5Years.add(tutor);
            }
        }
        tutorUI.displayTutorCategory(categoryHeader1, lessThan2Years);
        tutorUI.displayTutorCategory(categoryHeader2, between2And5Years);
        tutorUI.displayTutorCategory(categoryHeader3, moreThan5Years);
    }

}
