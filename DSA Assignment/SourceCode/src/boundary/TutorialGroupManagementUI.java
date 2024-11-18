package boundary;

import adt.*;
import dao.ProgrammeDAO;
import entity.*;
import java.util.Scanner;

/**
 *
 * @author Bok Cheong Roy
 */
public class TutorialGroupManagementUI {

    private SortedListInterface<Programme> programmeList = new SortedArrayList<>();
    private final ProgrammeDAO programmeDAO = new ProgrammeDAO();

    public TutorialGroupManagementUI() {
        try {
            programmeList = programmeDAO.retrieveFromFile();
        } catch (ClassNotFoundException ex) {
            System.out.println("Something Wrong in File");
        }
    }

    Scanner scanner = new Scanner(System.in);

    public int getMenuChoice() {
        System.out.println("\nTUTORIAL GROUP MANAGEMENT MENU");
        System.out.println("1. Add a Student to a Tutorial Group");
        System.out.println("2. Remove Student from Tutorial Group");
        System.out.println("3. Change the Tutorial Group for a Student");
        System.out.println("4. Find a Student in a Tutorial Group");
        System.out.println("5. List all Students in a Tutorial Group");
        System.out.println("6. Filter tutorial groups based on criteria");
        System.out.println("7. Generate relevant reports");
        System.out.println("0. Quit");
        int choice;
        while (true) {
            System.out.print("Enter choice (0-7): ");
            if (scanner.hasNextInt()) {
                choice = scanner.nextInt();
                scanner.nextLine();
                return choice;
            } else {
                scanner.nextLine();
                System.out.println("Invalid input. Please enter an integer.");
            }
        }
    }

    public int findStudentMenu() {
        System.out.println("\nFind Student");
        System.out.println("1.By Name");
        System.out.println("2.By ID");
        System.out.println("0. Quit to TUTORIAL GROUP MANAGEMENT MENU");
        int option;
        while (true) {
            System.out.print("Enter choice: ");
            if (scanner.hasNextInt()) {
                option = scanner.nextInt();
                scanner.nextLine();
                return option;
            } else {
                scanner.nextLine();
                System.out.println("Invalid input. Please enter an integer.");
            }
        }
    }

    public int filterMenu() {
        System.out.println("\nFilter Student");
        System.out.println("1.By Name");
        System.out.println("2.By ID");
        System.out.println("3.By Programme");
        System.out.println("0. Quit to TUTORIAL GROUP MANAGEMENT MENU");
        int option;
        while (true) {
            System.out.print("Enter choice: ");
            if (scanner.hasNextInt()) {
                option = scanner.nextInt();
                scanner.nextLine();
                return option;
            } else {
                scanner.nextLine();
                System.out.println("Invalid input. Please enter an integer.");
            }
        }
    }

    public void listAllStudents(String outputStr) {
        System.out.println("\nList of Students:\n" + outputStr);
    }

    public void printStudentDetails(Student student) {
        System.out.println("Student Details");
        System.out.println("Student Name:" + student.getName());
        System.out.println("Student ID: " + student.getStudentID());
        System.out.println("Programme: " + student.getProgramme());
        System.out.println("TutorialGroup: " + student.getTutorialGroup());
    }

    public String inputStudentName() {
        String name;
        do {
            System.out.print("Enter Student Name: ");
            name = scanner.nextLine().trim();
            if (name.isEmpty()) {
                System.out.println("Name cannot be empty. Please try again.");
            }
        } while (name.isEmpty());
        return name;
    }

    public String inputStudentID() {
        String studentID;
        do {
            System.out.print("Enter Student ID (7-digit number): ");
            studentID = scanner.nextLine().trim();

            // Check if the input is empty
            if (studentID.isEmpty()) {
                System.out.println("Student ID cannot be empty. Please try again.");
                continue; // Skip the validation below and re-prompt for input
            }

            // Check if the input consists of exactly 7 digits
            if (!studentID.matches("\\d{7}")) {
                System.out.println("Student ID must be a 7-digit number. Please try again.");
                studentID = ""; // Reset studentID to trigger another iteration
            }
        } while (studentID.isEmpty());

        return studentID;
    }

    public String inputProgramme() {
        int programCount = programmeList.getNumberOfEntries();
        if (programCount == 0) {
            System.out.println("No programme available.");
            return null; // Handle the case when there are no programs
        }

        String programme = null;
        int choice;

        do {
            System.out.println("\nProgramme\n" + "---------");
            for (int i = 0; i < programCount; i++) {
                System.out.println((i + 1) + ". " + programmeList.getEntry(i).getProgrammeName());
            }
            System.out.print("Enter Programme: ");
            String input = scanner.nextLine().trim(); // Read a line and trim leading/trailing spaces

            if (input.isEmpty()) {
                System.out.println("Please enter a valid programme.");
            } else {
                try {
                    choice = Integer.parseInt(input);
                    if (choice >= 1 && choice <= programCount) {
                        programme = programmeList.getEntry(choice - 1).getProgrammeName();
                    } else {
                        System.out.println("Invalid choice. Please select a valid programme.");
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid input. Please enter a valid programme number.");
                }
            }
        } while (programme == null);

        return programme;
    }

    public String inputTutorialGroup(String programme) {
        String tutorialGroup;
        int programmeNum = -1;

        for (int i = 0; i < programmeList.getNumberOfEntries(); i++) {
            if (programmeList.getEntry(i).getProgrammeName().equals(programme)) {
                programmeNum = i;
                int tutorialCount = programmeList.getEntry(i).getTutorialGroup().getNumberOfEntries();

                if (tutorialCount == 0) {
                    System.out.println("No tutorial groups available for this program.\n");
                    return null; // Handle the case when there are no tutorial groups for the selected program
                }

                String input;
                int choice;

                do {
                    System.out.println("Tutorial Groups for " + programme + "\n" + "-------------------");
                    for (int j = 0; j < tutorialCount; j++) {
                        int num = j + 1;
                        System.out.println(num + ". " + programmeList.getEntry(i).getTutorialGroup().getEntry(j).getTgName());
                    }
                    System.out.print("Enter Tutorial Group: ");
                    input = scanner.nextLine().trim(); // Read a line and trim leading/trailing spaces

                    if (input.isEmpty()) {
                        System.out.println("Please enter a valid tutorial group.\n");
                    } else {
                        try {
                            choice = Integer.parseInt(input);
                            if (choice >= 1 && choice <= tutorialCount) {
                                tutorialGroup = programmeList.getEntry(programmeNum).getTutorialGroup().getEntry(choice - 1).getTgName();
                                return tutorialGroup;
                            } else {
                                System.out.println("Invalid choice. Please select a valid tutorial group.\n");
                            }
                        } catch (NumberFormatException e) {
                            System.out.println("Invalid input. Please enter a valid tutorial group number.\n");
                        }
                    }
                } while (true);
            }
        }

        System.out.println("Invalid program name.");
        return null; // Handle the case when the program name is not found
    }

    public Student inputStudentDetails() {
        String studentName = inputStudentName();
        String studentID = inputStudentID();
        String programme = inputProgramme();
        String tutorialGroup = inputTutorialGroup(programme);
        System.out.println();
        return new Student(studentName, studentID, programme, tutorialGroup);
    }

    public int inputPosition() {
        int position = 0;
        boolean isValid = false;

        do {
            System.out.print("Enter Position by using number: ");
            String input = scanner.nextLine().trim(); // Read a line and trim leading/trailing spaces

            if (input.isEmpty()) {
                System.out.println("Please enter a valid integer.\n");
            } else {
                try {
                    position = Integer.parseInt(input);
                    isValid = true;
                } catch (NumberFormatException e) {
                    System.out.println("Invalid input. Please enter a valid integer.\n");
                }
            }
        } while (!isValid);

        return position;
    }

    public boolean getConfirmation(String message) {
        String userInput = "";
        boolean valid = false;
        do {
            System.out.print(message + " (y/n): ");
            userInput = scanner.nextLine().toLowerCase().trim();
            if (userInput.isEmpty()) {
                System.out.println("Cannot be empty. Please try again.");
            }else if (!userInput.equals("y") && !userInput.equals("n")) {
                System.out.println("Cannot be empty. Please try again.");
            }
        } while (!userInput.equals("y") && !userInput.equals("n"));

        if (userInput.equals("y")) {
            valid = true;
        }
        return valid;
    }
    
    public String inputProgrammeForListStudentInGroup() {
        int programCount = programmeList.getNumberOfEntries();
        if (programCount == 0) {
            System.out.println("No programme available.");
            return null; // Handle the case when there are no programs
        }

        String programme = null;
        int choice;

        do {
            System.out.println("\nProgramme\n" + "---------");
            for (int i = 0; i < programCount; i++) {
                System.out.println((i + 1) + ". " + programmeList.getEntry(i).getProgrammeName());
            }
            System.out.println("0. Quit to Tutorial Group Management");
            System.out.print("Enter Programme: ");
            String input = scanner.nextLine().trim(); // Read a line and trim leading/trailing spaces

            if (input.isEmpty()) {
                System.out.println("Please enter a valid programme.");
            } else {
                try {
                    choice = Integer.parseInt(input);
                    if (choice == 0) {
                        programme = "0";
                        return programme;
                    }
                    if (choice >= 1 && choice <= programCount) {
                        programme = programmeList.getEntry(choice - 1).getProgrammeName();
                    } else {
                        System.out.println("Invalid choice. Please select a valid programme.");
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid input. Please enter a valid programme number.");
                }
            }
        } while (programme == null);

        return programme;
    }
    
    public String inputTutorialGroupForListStudentInGroup(String programme) {
        String tutorialGroup;
        int programmeNum = -1;

        for (int i = 0; i < programmeList.getNumberOfEntries(); i++) {
            if (programmeList.getEntry(i).getProgrammeName().equals(programme)) {
                programmeNum = i;
                int tutorialCount = programmeList.getEntry(i).getTutorialGroup().getNumberOfEntries();

                if (tutorialCount == 0) {
                    System.out.println("No tutorial groups available for this program.\n");
                    return null; // Handle the case when there are no tutorial groups for the selected program
                }

                String input;
                int choice;

                do {
                    System.out.println("Tutorial Groups for " + programme + "\n" + "-------------------");
                    for (int j = 0; j < tutorialCount; j++) {
                        int num = j + 1;
                        System.out.println(num + ". " + programmeList.getEntry(i).getTutorialGroup().getEntry(j).getTgName());
                    }
                    System.out.println("0. Quit to Programme.");
                    System.out.print("Enter Tutorial Group: ");
                    input = scanner.nextLine().trim(); // Read a line and trim leading/trailing spaces

                    if (input.isEmpty()) {
                        System.out.println("Please enter a valid tutorial group.\n");
                    } else {
                        try {
                            choice = Integer.parseInt(input);
                            if (choice == 0) {
                                tutorialGroup = "0";
                                return tutorialGroup;
                            }
                            if (choice >= 1 && choice <= tutorialCount) {
                                tutorialGroup = programmeList.getEntry(programmeNum).getTutorialGroup().getEntry(choice - 1).getTgName();
                                return tutorialGroup;
                            } else {
                                System.out.println("Invalid choice. Please select a valid tutorial group.\n");
                            }
                        } catch (NumberFormatException e) {
                            System.out.println("Invalid input. Please enter a valid tutorial group number.\n");
                        }
                    }
                } while (true);
            }
        }

        System.out.println("Invalid program name.");
        return null; // Handle the case when the program name is not found
    }
}
