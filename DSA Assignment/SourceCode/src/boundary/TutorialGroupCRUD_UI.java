package boundary;

import adt.SortedListInterface;
import entity.TutorialGroup;
import java.util.Scanner;

/**
 *
 * @author Lee Weng Yi
 */
public class TutorialGroupCRUD_UI {

    private Scanner scanner = new Scanner(System.in);

    public int getTutorialGroupMenu() {

        System.out.println("\nTutorial Group Management Menu\n");

        System.out.println("1. Add a new tutorial group");
        System.out.println("2. Remove a tutorial group");
        System.out.println("3. Find tutorial group");
        System.out.println("4. Amend tutorial group Details");
        System.out.println("5. List All tutorial group");
        System.out.println("0. Exit");
        int choice;
        while (true) {
            System.out.print("Enter choice (0-5): ");
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

    public void printGroupDetails(TutorialGroup group) {
        System.out.println("===================");
        System.out.println("Tutorial Group Details");
        System.out.println("===================\n");
        System.out.println("Tutorial Group Code:" + group.getTgCode());
        System.out.println("Tutorial Group Name:" + group.getTgName());
    }

    public String inputGroupCode() {
        System.out.print("Enter Tutorial Group Code: ");
        String code = scanner.nextLine();
        return code;
    }

    public String inputGroupName() {
        System.out.print("Enter Tutorial Group Name: ");
        String name = scanner.nextLine();
        return name;
    }

    public TutorialGroup inputProgrammeDetails() {
        String code = inputGroupCode();
        String name = inputGroupName();
        System.out.println();
        return new TutorialGroup(code, name);
    }

    public String inputConfirm() {
        String confirm;
        while (true) {
            System.out.print("Confirm? (Y/N): ");
            confirm = scanner.next().toUpperCase();
            scanner.nextLine(); // Consume the newline character

            if (confirm.equals("Y") || confirm.equals("N")) {
                return confirm;
            } else {
                System.out.println("Invalid input. Please enter 'Y' or 'N'.");
            }
        }
    }

    public void displayAllGroup(SortedListInterface<TutorialGroup> group) {
        System.out.println("+-----+------------+----------------------+");
        System.out.printf("| %3s | %-10s | %-20s |\n", "No.", "Code", "Tutorial Group");
        System.out.println("+-----+------------+----------------------+");
        for (int i = 0; i < group.getNumberOfEntries(); i++) {
            TutorialGroup currentGroup = group.getEntry(i);
            System.out.printf("| %2d. | %-10s | %-20s |\n", i + 1, currentGroup.getTgCode(),currentGroup.getTgName());
            System.out.println("+-----+------------+----------------------+");
        }
    }

    public void displayGroup(TutorialGroup group) {
        System.out.println("+------------+----------------------+");
        System.out.printf("| %-10s | %-20s |\n", "Code", "Tutorial Group");
        System.out.println("+------------+----------------------+");
        System.out.printf("| %-10s | %-20s |\n", group.getTgCode(),group.getTgName());
        System.out.println("+------------+----------------------+");
    }
}
