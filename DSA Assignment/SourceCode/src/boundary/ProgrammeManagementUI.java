package boundary;

import adt.*;
import entity.*;
import java.util.Scanner;

/**
 *
 * @author Lee Weng Yi
 */
public class ProgrammeManagementUI {

    private Scanner scanner = new Scanner(System.in);

    public int getProgrammeMenu() {
        System.out.println("\n\n\n\n\n+------------------------------------------+");
        System.out.println("|         Programme Management Menu        |");
        System.out.println("+------------------------------------------+\n");
        System.out.println("1. Add a new programmes");
        System.out.println("2. Remove a programme");
        System.out.println("3. Find programme");
        System.out.println("4. Amend programme details");
        System.out.println("5. List all programme");
        System.out.println("6. Add tutorial group to a programme");
        System.out.println("7. Remove tutorial group from a programme");
        System.out.println("8. List all tutorial groups for a programme");
        System.out.println("9. Generate relevant report");
        System.out.println("0. Exit programme management");
        int choice;
        while (true) {
            System.out.print("Enter choice (0-9): ");
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

    public String inputProgrammeCode(SortedListInterface<Programme> programmeList) {
        String code;
        while (true) {
            System.out.print("Enter Programme Code (3 letters): ");
            code = scanner.nextLine().toUpperCase();
            if (!code.isEmpty()) {
                if (code.length() == 3) {
                    boolean duplicate = false;
                    for (int i = 0; i < programmeList.getNumberOfEntries(); i++) {
                        Programme currentProgramme = programmeList.getEntry(i);
                        if (currentProgramme.getProgrammeCode().equals(code)) {
                            System.out.println("Programme code is duplicated in programme list.\n\n");
                            duplicate = true;
                            break;
                        }
                    }
                    if (!duplicate) {
                        return code;
                    }
                } else {
                    System.out.println("Programme code must be 3 letters");
                }
            } else {
                System.out.println("Programme code cannot be empty.");
            }
        }
    }

    public String inputProgrammeCode() {
        System.out.print("Enter Programme Code: ");
        String code = scanner.nextLine().toUpperCase();
        return code;
    }

    public String inputProgrammeName(SortedListInterface<Programme> programmeList) {
        String name;
        while (true) {
            System.out.print("Enter Programme Name (max 30 characters): ");
            name = scanner.nextLine().trim();
            if (!name.isEmpty()) {
                if (name.length() <= 30) {
                    boolean duplicate = false;
                    for (int i = 0; i < programmeList.getNumberOfEntries(); i++) {
                        Programme currentProgramme = programmeList.getEntry(i);
                        if (currentProgramme.getProgrammeName().equals(name)) {
                            System.out.println("Programme name is duplicated in programme list.\n\n");
                            duplicate = true;
                            break;
                        }
                    }
                    if (!duplicate) {
                        return name;
                    }
                } else {
                    System.out.println("Please enter a name with 30 characters or fewer.\n\n");
                }
            } else {
                System.out.println("Invalid name, Programme name cannot be empty.");
            }
        }
    }

    public int inputDurationOfYear() {
        int duration;
        while (true) {
            System.out.print("Enter Duration of Year: ");
            if (scanner.hasNextInt()) {
                duration = scanner.nextInt();
                if (duration == 0) {
                    System.out.println("Duration of year cannot be 0.");
                } else {
                    return duration;
                }
            } else {
                scanner.nextLine();
                System.out.println("Invalid duration. Please enter an integer.");
            }
        }
    }

    public Programme inputProgrammeDetails(SortedListInterface<Programme> programmeList) {
        String programmeCode = inputProgrammeCode(programmeList);
        String programmeName = inputProgrammeName(programmeList);
        int duration = inputDurationOfYear();
        return new Programme(programmeCode, programmeName, duration);
    }

    public int getModifySelection() {

        System.out.println("\nModify Programme Detail\n");

        System.out.println("1. Programme Name");
        System.out.println("2. Duration of Year");
        System.out.println("0. Done");
        int choice;
        while (true) {
            System.out.print("Enter choice (0-2): ");
            if (scanner.hasNextInt()) {
                choice = scanner.nextInt();
                scanner.nextLine();
                return choice;
            } else {
                scanner.nextLine();
                System.out.println("\nInvalid input. Please enter an integer.");
            }
        }
    }

    public String inputConfirmation(String question, String action) {
        String confirm;
        while (true) {
            System.out.print(question + " " + action + "? (Y/N): ");
            confirm = scanner.next().toUpperCase();
            scanner.nextLine();
            if (confirm.equals("Y") || confirm.equals("N")) {
                return confirm;
            } else {
                System.out.println("Invalid input. Please enter 'Y' or 'N'.");
            }
        }
    }

    public int getSelectedGroup(SortedListInterface<TutorialGroup> group) {
        int selectedGroupNumber = 0;
        displayGroup(group);

        while (true) {
            System.out.print("Enter the number of the tutorial group: ");

            if (scanner.hasNextInt()) {
                selectedGroupNumber = scanner.nextInt();
                scanner.nextLine(); 

                if (selectedGroupNumber >= 1 && selectedGroupNumber <= group.getNumberOfEntries()) {
                    break; 
                } else {
                    System.out.println("Invalid selection, please try again.");
                }
            } else {
                scanner.nextLine();  
                System.out.println("Invalid input. Please enter an integer.");
            }
        }

        return selectedGroupNumber;
    }

    public void displayActionTitle(int action) {
        if (action != 0) {
            System.out.println("\n\n+------------------------------------------+");
        }
        switch (action) {
            case 1:
                System.out.println("|            Add a new programme           |");
                break;
            case 2:
                System.out.println("|            Remove a programme            |");
                break;
            case 3:
                System.out.println("|              Find programme              |");
                break;
            case 4:
                System.out.println("|          Amend programme details         |");
                break;
            case 5:
                System.out.println("|             List all programme           |");
                break;
            case 6:
                System.out.println("|    Add tutorial group to a programme     |");
                break;
            case 7:
                System.out.println("|  Remove tutorial group from a programme  |");
                break;
            case 8:
                System.out.println("| List all tutorial groups for a programme |");
                break;
            case 9:
                System.out.println("|                   Report                 |");
                break;
        }
        if (action != 0) {
            System.out.println("+------------------------------------------+\n");
        }
    }

    public void displayProgramme(Programme programme) {
        System.out.println("\n\n\n+-----------------+--------------------------------+------------+");
        System.out.printf("| %-15s | %-30s | %-10s |\n", "Programme Code", "Programme Name", "Duration");
        System.out.println("+-----------------+--------------------------------+------------+");
        System.out.printf("| %-15s | %-30s | %6d     |\n", programme.getProgrammeCode(), programme.getProgrammeName(), programme.getDurationOfYear());
        System.out.println("+-----------------+--------------------------------+------------+");
    }

    public void displayAllProgrammes(SortedListInterface<Programme> programmeList) {
        System.out.println("+-----+-----------------+--------------------------------+------------+");
        System.out.printf("| %3s | %-15s | %-30s | %-10s |\n", "No.", "Programme Code", "Programme Name", "Duration");
        System.out.println("+-----+-----------------+--------------------------------+------------+");
        if (!programmeList.isEmpty()) {
            for (int i = 0; i < programmeList.getNumberOfEntries(); i++) {
                Programme currentProgramme = programmeList.getEntry(i);
                System.out.printf("| %2d. | %-15s | %-30s | %6d     |\n", i + 1, currentProgramme.getProgrammeCode(), currentProgramme.getProgrammeName(), currentProgramme.getDurationOfYear());
                System.out.println("+-----+-----------------+--------------------------------+------------+");
            }
        } else {
            System.out.printf("| %-67s |\n", "Programme list is empty");
            System.out.println("+-----+-----------------+--------------------------------+------------+");
        }

    }

    public void displayMessage(String message) {
        switch (message) {
            case "addSuccess":
                System.out.println("Programme successfully added.");
                break;
            case "addCancel":
                System.out.println("Addition cancelled.");
                break;
            case "modifySuccess":
                System.out.println("Programme successfully modified.");
                break;
            case "modifyCancel":
                System.out.println("Modification cancelled");
                break;
            case "deleteSuccess":
                System.out.println("Programme successfully deleted.");
                break;
            case "deleteCancel":
                System.out.println("Deletion cancelled.");
                break;
            case "unableDelete":
                System.out.println("Cannot delete the programme"
                        + " because it has associated tutorial groups. ");
                break;

        }
    }

    public void displayGroup(SortedListInterface<TutorialGroup> group) {
        if (!group.isEmpty()) {
            System.out.println("+-----+---------------------------------------------------------+");
            System.out.printf("| %3s | %-55s |\n", "No.", "Tutorial Group");
            System.out.println("+-----+---------------------------------------------------------+");
            for (int i = 0; i < group.getNumberOfEntries(); i++) {
                TutorialGroup currentGroup = group.getEntry(i);
                System.out.printf("| %2d. | %-55s |\n", i + 1, currentGroup.getTgName());
                System.out.println("+-----+---------------------------------------------------------+");
            }
        } else {
            System.out.println("+---------------------------------------------------------------+");
            System.out.println("|             No tutorial group in this programme               |");
            System.out.println("+---------------------------------------------------------------+");
        }
    }

    public void displayReport(SortedListInterface<Programme> programmeList, ListInterface<Student> studentList) {
        System.out.println("+-----+--------------------------------+-----------------+-----------------+");
        System.out.printf("| %3s | %-30s | %-15s |      %-10s |\n", "No.", "Programme", "Tutorial Group", "Student");
        System.out.println("+-----+--------------------------------+-----------------+-----------------+");
        for (int i = 0; i < programmeList.getNumberOfEntries(); i++) {
            Programme currentProgramme = programmeList.getEntry(i);
            SortedListInterface<TutorialGroup> programGroups = currentProgramme.getTutorialGroup();

            int numberStudent = 0;
            for (int j = 1; j <= studentList.getNumberOfEntries(); j++) {
                Student currentStudent = studentList.getEntry(j);
                if (currentStudent.getProgramme().equals(currentProgramme.getProgrammeName())) {
                    ++numberStudent;
                }
            }
            System.out.printf("| %2d. | %-30s |  %8d       |  %8d       |\n", i + 1, currentProgramme.getProgrammeName(), programGroups.getNumberOfEntries(), numberStudent);
            System.out.println("+-----+--------------------------------+-----------------+-----------------+");
        }
    }

    public void displayNotFound(String programmeCode) {
        System.out.println("Programmme " + programmeCode + " not found.");
    }

    public void displayGroupMessage(String action, String group, String programme) {
        switch (action) {
            case "add":
                System.out.println("Tutorial group " + group + " added to programme " + programme + ".");
                break;
            case "remove":
                System.out.println("Tutorial group " + group + " removed from programme " + programme + ".");
                break;
        }
    }

    public void displayAllAssociated() {
        System.out.println("All tutorial groups are already associated with programme.");
    }
}
