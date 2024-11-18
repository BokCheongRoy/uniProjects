package control;

import adt.*;
import boundary.TutorialGroupManagementUI;
import dao.*;
import entity.*;
import utility.MessageUI;

/**
 *
 * @author Bok Cheong Roy
 */
public class TutorialGroupManagement {

    private ListInterface<Student> studentList = new ArrayList<>();
    private final StudentDAO studentDAO = new StudentDAO();
    private final TutorialGroupManagementUI tutorialUI = new TutorialGroupManagementUI();
    private SortedListInterface<Programme> programmeList = new SortedArrayList<>();
    private ProgrammeDAO programmeDAO = new ProgrammeDAO();

    public TutorialGroupManagement() {
        try {
            studentList = studentDAO.retrieveFromFile();
        } catch (ClassNotFoundException ex) {
            System.out.println("Something Wrong in File");
        }
        try {
            programmeList = programmeDAO.retrieveFromFile();
        } catch (ClassNotFoundException ex) {
            System.out.println("Something Wrong in File");
        }
    }

    public void runStudentMaintenance() {
        int choice = 0;
        do {
            choice = tutorialUI.getMenuChoice();
            switch (choice) {
                case 0:
                    MessageUI.displayExitSubsystemMessage();
                    break;
                case 1:
                    addNewStudent();
                    break;
                case 2:
                    displayStudents();
                    removeStudent();
                    break;
                case 3:
                    displayStudents();
                    changeTutorialGroup();
                    break;
                case 4:
                    findStudent();
                    break;
                case 5:
                    displayStudentsOfGroup();
                    break;
                case 6:
                    filterStudent();
                    break;
                case 7:
                    displayStudentReport();
                    break;
                default:
                    MessageUI.displayInvalid();
            }
        } while (choice != 0);
    }

    public void addNewStudent() {
        Student newStudent;
        boolean isUnique;

        do {
            newStudent = tutorialUI.inputStudentDetails();
            isUnique = isStudentIDUnique(newStudent.getStudentID());

            if (!isUnique) {
                System.out.println("Student ID already exists. Please enter a unique ID.");
            }
        } while (!isUnique);
        if (newStudent.getTutorialGroup() == null) {
            return;
        }
        boolean confirmation = tutorialUI.getConfirmation("Are you Confirm to Add?");
        if (confirmation == true) {
            studentList.add(newStudent);
            studentDAO.saveToFile(studentList);
            displayStudents();
            System.out.println("Succesful added Student:" + newStudent.getName());
            return;
        }
        System.out.println("Action Cancelled");
    }

    public boolean isStudentIDUnique(String studentIDToCheck) {
        for (int i = 1; i <= studentList.getNumberOfEntries(); i++) {
            Student student = studentList.getEntry(i);
            if (student != null && student.getStudentID().equalsIgnoreCase(studentIDToCheck)) {
                return false; // The studentID already exists in the list
            }
        }
        return true; // The studentID is unique
    }

    public void removeStudent() {
        int position;

        do {
            position = tutorialUI.inputPosition();
            if (position < 1 || position > studentList.getNumberOfEntries()) {
                System.out.println("Invalid Choice. Please Choose a valid position between 1 and " + studentList.getNumberOfEntries() + "\n");
            }
        } while (position < 1 || position > studentList.getNumberOfEntries());

        boolean confirmation = tutorialUI.getConfirmation("Are you Confirm to Remove?");
        if (confirmation == true) {
            System.out.println("Successful Removed Student:" + studentList.getEntry(position).getName());
            studentList.remove(position);
            studentDAO.saveToFile(studentList);
            return;
        }
        System.out.println("Action Cancelled");
    }

    public void changeTutorialGroup() {
        int position;

        do {
            position = tutorialUI.inputPosition();
            if (position < 1 || position > studentList.getNumberOfEntries()) {
                System.out.println("Invalid Choice. Please Choose a valid position between 1 and " + studentList.getNumberOfEntries() + "\n");
            }
        } while (position < 1 || position > studentList.getNumberOfEntries());

        Student modifyStudent = studentList.getEntry(position);
        String newTutorialGroup = tutorialUI.inputTutorialGroup(studentList.getEntry(position).getProgramme());
        if (modifyStudent.getTutorialGroup() == null) {
            return;
        }
        boolean confirmation = tutorialUI.getConfirmation("Are you Confirm to Edit?");
        if (confirmation == true) {
            modifyStudent.setTutorialGroup(newTutorialGroup);
            studentList.replace(position, modifyStudent);
            studentDAO.saveToFile(studentList);
            System.out.println("Successful Edited Student:" + studentList.getEntry(position).getName());
            return;
        }
        System.out.println("Action Cancelled");

    }

    public void findStudent() {
        int choice = 0;
        do {
            choice = tutorialUI.findStudentMenu();
            switch (choice) {
                case 0:
                    System.out.println("Exit");
                    break;
                case 1:
                    findStudentByName();
                    break;
                case 2:
                    findStudentByID();
                    break;
                default:
                    System.out.println("Invalid Choice Please Choose Again");
            }

        } while (choice != 0);
    }

    public void findStudentByName() {
        String studentName = tutorialUI.inputStudentName().toLowerCase(); // Convert the input to lowercase
        Student foundStudent = null;

        for (int i = 1; i <= studentList.getNumberOfEntries(); i++) {
            String currentName = studentList.getEntry(i).getName().toLowerCase(); // Convert the current student's name to lowercase
            if (currentName.equals(studentName)) {
                foundStudent = studentList.getEntry(i);
                tutorialUI.printStudentDetails(foundStudent);
                System.out.println("");
            }
        }

        if (foundStudent == null) {
            System.out.println("Student not found");
        }
    }

    public void findStudentByID() {
        String studentID = tutorialUI.inputStudentID().toLowerCase(); // Convert the input to lowercase
        Student foundStudent = null;

        for (int i = 1; i <= studentList.getNumberOfEntries(); i++) {
            String currentID = studentList.getEntry(i).getStudentID().toLowerCase(); // Convert the current student's ID to lowercase
            if (currentID.equals(studentID)) {
                foundStudent = studentList.getEntry(i);
                tutorialUI.printStudentDetails(foundStudent);
                System.out.println("");
            }
        }

        if (foundStudent == null) {
            System.out.println("Student not found");
        }
    }

    public void filterStudent() {
        int choice = 0;
        do {
            choice = tutorialUI.filterMenu();
            switch (choice) {
                case 0:
                    System.out.println("Exit");
                    break;
                case 1:
                    tutorialUI.listAllStudents(filterStudentByName());
                    break;
                case 2:
                    tutorialUI.listAllStudents(filterStudentByID());

                    break;
                case 3:
                    tutorialUI.listAllStudents(filterStudentByProgramme());
                    break;
                default:
                    System.out.println("Invalid Choice Please Choose Again");
            }

        } while (choice != 0);
    }

    public String filterStudentByProgramme() {
        ListInterface<Student> filterStudent = new ArrayList<>();
        int numberOfEntries = studentList.getNumberOfEntries();

        for (int i = 1; i <= numberOfEntries; i++) {
            Student sortStudent = studentList.getEntry(i);

            // Check if sortStudent is not null
            if (sortStudent != null) {
                int j = 0;

                while (j < filterStudent.getNumberOfEntries()) {
                    Student existingStudent = filterStudent.getEntry(j + 1);

                    // Check if existingStudent is not null and has non-null Programme and TutorialGroup
                    if (existingStudent != null
                            && existingStudent.getProgramme() != null
                            && existingStudent.getTutorialGroup() != null
                            && sortStudent.getProgramme() != null
                            && sortStudent.getTutorialGroup() != null) {

                        int programmeComparison = sortStudent.compareToProgramme(existingStudent.getProgramme());
                        int tutorialGroupComparison = sortStudent.compareToTutorial(existingStudent.getTutorialGroup());

                        if (programmeComparison > 0 || (programmeComparison == 0 && tutorialGroupComparison > 0)) {
                            j++;
                        } else {
                            break; // Stop comparing once the correct position is found
                        }
                    } else {
                        // Handle null values or invalid data as needed
                        // You may choose to skip or log such entries
                        j++;
                    }
                }
                filterStudent.add(j + 1, sortStudent);
            }
        }

        String outputStr = String.format(" %4s %-20s %-10s %-30s %-12s\n", "No.", "Name", "ID", "Programme", "Group")
                + "----------------------------------------------------------------------------------\n";
        for (int i = 1; i <= filterStudent.getNumberOfEntries(); i++) {
            Student currentStudent = filterStudent.getEntry(i);
            outputStr = outputStr + String.format(" %3d. %-20s %-10s %-30s %-12s\n",
                    i, currentStudent.getName(),
                    currentStudent.getStudentID(),
                    currentStudent.getProgramme(),
                    currentStudent.getTutorialGroup());
        }
        return outputStr;
    }

    public String filterStudentByName() {
        ListInterface<Student> filterStudent = new ArrayList<>();
        for (int i = 1; i <= studentList.getNumberOfEntries(); i++) {
            Student sortStudent = studentList.getEntry(i);
            if (filterStudent.isEmpty()) {
                filterStudent.add(sortStudent);
            } else {
                int j = 0;
                while (j < filterStudent.getNumberOfEntries() && sortStudent.compareTo(filterStudent.getEntry(j + 1).getName()) > 0) {
                    j++;
                }
                filterStudent.add(j + 1, sortStudent);
            }
        }

        String outputStr = String.format(" %4s %-20s %-10s %-30s %-12s\n", "No.", "Name", "ID", "Programme", "Group")
                + "----------------------------------------------------------------------------------\n";
        for (int i = 1; i <= filterStudent.getNumberOfEntries(); i++) {
            Student currentStudent = filterStudent.getEntry(i);
            outputStr = outputStr + String.format(" %3d. %-20s %-10s %-30s %-12s\n",
                    i, currentStudent.getName(),
                    currentStudent.getStudentID(),
                    currentStudent.getProgramme(),
                    currentStudent.getTutorialGroup());
        }

        return outputStr;
    }

    public String filterStudentByID() {
        ListInterface<Student> filterStudent = new ArrayList<>();
        for (int i = 1; i <= studentList.getNumberOfEntries(); i++) {
            Student sortStudent = studentList.getEntry(i);
            if (filterStudent.isEmpty()) {
                filterStudent.add(sortStudent);
            } else {
                int j = 0;
                while (j < filterStudent.getNumberOfEntries() && sortStudent.compareToIgnoreCase(filterStudent.getEntry(j + 1).getStudentID()) > 0) {
                    j++;
                }
                filterStudent.add(j + 1, sortStudent);
            }
        }
        String outputStr = String.format(" %4s %-20s %-10s %-30s %-12s\n", "No.", "Name", "ID", "Programme", "Group")
                + "----------------------------------------------------------------------------------\n";
        for (int i = 1; i <= filterStudent.getNumberOfEntries(); i++) {
            Student currentStudent = filterStudent.getEntry(i);
            outputStr = outputStr + String.format(" %3d. %-20s %-10s %-30s %-12s\n",
                    i, currentStudent.getName(),
                    currentStudent.getStudentID(),
                    currentStudent.getProgramme(),
                    currentStudent.getTutorialGroup());
        }

        return outputStr;
    }

    public String getAllStudents() {
        String outputStr = String.format(" %4s %-20s %-10s %-30s %-12s\n", "No.", "Name", "ID", "Programme", "Group")
                + "----------------------------------------------------------------------------------\n";
        for (int i = 1; i <= studentList.getNumberOfEntries(); i++) {
            Student currentStudent = studentList.getEntry(i);
            outputStr = outputStr + String.format(" %3d. %-20s %-10s %-30s %-12s\n",
                    i, currentStudent.getName(),
                    currentStudent.getStudentID(),
                    currentStudent.getProgramme(),
                    currentStudent.getTutorialGroup());
        }
        return outputStr;
    }

    public void displayStudents() {
        tutorialUI.listAllStudents(getAllStudents());
    }

    public String getAllStudentsOfGroup(String TutorialGroup) {
        String outputStr = String.format(" %4s %-20s %-10s %-30s %-12s\n", "No.", "Name", "ID", "Programme", "Group")
                + "----------------------------------------------------------------------------------\n";
        int j = 1;
        for (int i = 1; i <= studentList.getNumberOfEntries(); i++) {
            if (TutorialGroup.equals(studentList.getEntry(i).getTutorialGroup())) {
                Student currentStudent = studentList.getEntry(i);
                outputStr = outputStr + String.format(" %3d. %-20s %-10s %-30s %-12s\n",
                        j, currentStudent.getName(),
                        currentStudent.getStudentID(),
                        currentStudent.getProgramme(),
                        currentStudent.getTutorialGroup());
                j++;
            }
        }
        return outputStr;
    }

    public void displayStudentsOfGroup() {
    String repeat="";
    do {
        String programme = tutorialUI.inputProgrammeForListStudentInGroup();
        if (programme.equals("0")) {
            return;
        }
        String tutorialGroup = tutorialUI.inputTutorialGroupForListStudentInGroup(programme);
        if (tutorialGroup == null) {
            System.out.println("No Tutorial Group Found");
        } else if (tutorialGroup.equals("0")) {
            repeat = "repeat";
        } else {
            String output = getAllStudentsOfGroup(tutorialGroup);
            tutorialUI.listAllStudents(output);
        }
    } while (repeat.equals("repeat"));
}

    public void displayStudentReport() {
        int totalPrograms = programmeList.getNumberOfEntries();
        int totalTutorialGroups = 0;
        int totalStudents = studentList.getNumberOfEntries();

        System.out.println("Report:");
        System.out.println(String.format("%-20s%-30s%-30s%-30s", "", "Programme", "Tutorial Group", "Students"));
        System.out.println("----------------------------------------------------------------------------------------\n");

        for (int i = 0; i < totalPrograms; i++) {
            Programme program = programmeList.getEntry(i);
            String programName = program.getProgrammeName();
            int subtotalTutorialGroups = 0;
            int subtotalStudents = 0;
            
            System.out.println(String.format("%20s%-30s%-30s%-30s", "", programName, "", ""));
            System.out.println("----------------------------------------------------------------------------------------");
            // Iterate through each tutorial group
            for (int j = 0; j < program.getTutorialGroup().getNumberOfEntries(); j++) {
                String tutorialGroupName = "";
                if (program.getTutorialGroup().getEntry(j) != null) {
                    tutorialGroupName = program.getTutorialGroup().getEntry(j).getTgName();
                }
                int tutorialGroupStudents = countStudentsInTutorialGroup(programName, tutorialGroupName);

                System.out.println(String.format("%-20s%-30s%-30s%-30s", "", programName, tutorialGroupName, tutorialGroupStudents));
                subtotalTutorialGroups = j+1;
                subtotalStudents += tutorialGroupStudents;
            }
            if (program.getTutorialGroup().getNumberOfEntries() == 0) {
                System.out.println(String.format("%-20s%-30s%-30s%-30s", "", "", "No Tutorial Group", ""));
            }
            // Subtotal for each program
            System.out.println("----------------------------------------------------------------------------------------");
            System.out.println(String.format("%-20s%-30s%-30s%-30s", "Subtotal:", "", subtotalTutorialGroups, subtotalStudents));
            System.out.println("\n");
            totalTutorialGroups += subtotalTutorialGroups;
            subtotalTutorialGroups = 0;
            subtotalStudents = 0;
        }

        // Total number of students in all programs
        System.out.println("----------------------------------------------------------------------------------------");
        System.out.println(String.format("%-20s%-30s%-30s%-30s", "   Total:", totalPrograms, totalTutorialGroups, totalStudents));
        System.out.println("----------------------------------------------------------------------------------------");
    }

// Helper method to count students in a specific tutorial group of a program
    private int countStudentsInTutorialGroup(String programName, String tutorialGroupName) {
        int count = 0;
        for (int i = 1; i <= studentList.getNumberOfEntries(); i++) {
            Student student = studentList.getEntry(i);
            if (programName.equals(student.getProgramme()) && tutorialGroupName.equals(student.getTutorialGroup())) {
                count++;
            }
        }
        return count;
    }

}
