package boundary;

import entity.Course;
import java.util.Scanner;

/**
 *
 * @author Pua Jia Qian
 */
public class CourseManagementUI {

    private Scanner scanner = new Scanner(System.in);

    public int courseMenu() {

        System.out.println("\n\n+---------------------------+");
        System.out.println("  ℂ𝕠𝕦𝕣𝕤𝕖 𝕄𝕒𝕟𝕒𝕘𝕖𝕞𝕖𝕟𝕥 𝕄𝕖𝕟𝕦");
        System.out.println("+---------------------------+\n");

        System.out.println("1. Add a new course");
        System.out.println("2. Remove a course");
        System.out.println("3. Find Course");
        System.out.println("4. Amend Course Details");
        System.out.println("5. List All Courses");
        System.out.println("6. Add programme to a course");
        System.out.println("7. Remove programme from a course");
        System.out.println("8. Generate relevant report");
        System.out.println("0. Exit the program");
        int choice;
        while (true) {
            System.out.print("Enter choice (0-8): ");
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

    public void printCourseDetails(Course course) {
        System.out.println("\n===================");
        System.out.println("  Course Details");
        System.out.println("===================");
        System.out.println("+-------------------------------------------------------------+");
        System.out.printf("| %-11s | %-30s | %-12s |\n", "Course Code", "Couse Name", "Credit Hours");
        System.out.println("+-------------------------------------------------------------+");
        System.out.printf("| %-11s | %-30s |     %-4d     |\n", course.getCourseCode(), course.getCourseName(), course.getCreditHours());
        System.out.println("+-------------------------------------------------------------+");
    }

    public String inputCourseCode() {
        System.out.print("Enter Course Code(eg.ABCD1234): ");
        String code = scanner.nextLine();
        return code;
    }

    public String inputCourseName() {
        System.out.print("Enter Course Name: ");
        String name = scanner.nextLine();
        return name;
    }

    public int inputCreditHours() {
        int creditHours;
        while (true) {
            System.out.print("Enter Credit Hours: ");
            if (scanner.hasNextInt()) {
                creditHours = scanner.nextInt();
                if (creditHours <= 0) {
                    System.out.println("Credit Hours must be a positive integer.");
                } else {
                    return creditHours;
                }
            } else {
                scanner.nextLine(); // Consume the invalid input
                System.out.println("Invalid input. Please enter a valid positive integer for Credit Hours.");
            }
        }
    }

    public String inputConfirmation() {
        System.out.print("Confirm (y/n)? ");
        String userConfirm = scanner.next().toLowerCase();
        return userConfirm;
    }

    public void addTitle() {
        System.out.println("===================");
        System.out.println("  Add New Course");
        System.out.println("===================\n");
    }

    public void removeTitle() {
        System.out.println("===================");
        System.out.println("  Remove a Course");
        System.out.println("===================\n");
    }

    public void findTitle() {
        System.out.println("===================");
        System.out.println("  Find a Course");
        System.out.println("===================\n");
    }

    public void modifyTitle() {
        System.out.println("===================");
        System.out.println("  Modify a Course");
        System.out.println("===================\n");
    }

    public void displayTitle() {
        System.out.println("========================");
        System.out.println("  Display Course List");
        System.out.println("========================\n");
    }

    public void assignProgramTitle() {
        System.out.println("==================================");
        System.out.println(" Assign a Programme to a Course");
        System.out.println("==================================\n");
    }

    public void removeProgramTitle() {
        System.out.println("===================================");
        System.out.println(" Remove a Programme from a Course");
        System.out.println("===================================\n");
    }

    public void reportTitle() {
        System.out.println("=====================");
        System.out.println("  Generate a Report");
        System.out.println("=====================\n");
    }

    public void courseDetailsReportTitle() {
        System.out.println("\t\t\t\t\t\t\t+-----------------------+");
        System.out.println("\t\t\t\t\t\t\t|Courses Details Report |");
        System.out.println("\t\t\t\t\t\t\t+-----------------------+");
    }

    public void courseNameReportTitle() {
        System.out.println("\t\t\t\t\t\t\t+-----------------------------+");
        System.out.println("\t\t\t\t\t\t\t| Search Course's Name Report |");
        System.out.println("\t\t\t\t\t\t\t+-----------------------------+");
    }

    public void courseSubTitle() {
        System.out.println("+-------------------------------------------------------------------+");
        System.out.printf("| %3s | %-11s | %-30s | %-12s |\n", "No.", "Course Code", "Couse Name", "Credit Hours");
        System.out.println("+-------------------------------------------------------------------+");
    }

    public void reportsubTitle() {
        System.out.println("\n+-----------------------------------------------------------------------------------------------------------------------------------+");
        System.out.printf("| %-11s | %-30s | %-12s | %-14s | %-30s | %-17s |\n", "Course Code", "Course Name", "Credit Hours", "Programme Code", "Programme Name", "Duration of Years");
        System.out.println("+-----------------------------------------------------------------------------------------------------------------------------------+");

    }

    public void programmeTitle() {
        System.out.println("+-----------------------------------------------------------+");
        System.out.printf("| %4s | %-30s | %-17s |\n", "Code", "Programme Name", "Duration of Years");
        System.out.println("+-----------------------------------------------------------+");
    }

    public void separateLine() {
        System.out.println("+-----------------------------------------------------------------------------------------------------------------------------------+");

    }

    public int inputModifyOption() {
        System.out.println("\nSelect which part you want to modify: ");
        System.out.println("1. Course Name");
        System.out.println("2. Credit Hours");
        int option;
        while (true) {
            System.out.print("Choose (1/2): ");
            if (scanner.hasNextInt()) {
                option = scanner.nextInt();
                return option;
            } else {
                scanner.nextLine();
                System.out.println("\nInvalid input. Please enter an integer.");
            }
        }
    }

    public int inputReportOption() {
        System.out.println("Select which report you want to view: ");
        System.out.println("1. All Courses Details Report");
        System.out.println("2. Search Course Name Report");
        int option;
        while (true) {
            System.out.print("Choose (1/2): ");
            if (scanner.hasNextInt()) {
                option = scanner.nextInt();
                return option;
            } else {
                scanner.nextLine();
                System.out.println("\nInvalid input. Please enter an integer.");
            }
        }
    }

    public String inputCourseKeyword() {
        System.out.print("Enter Course Keyword: ");
        scanner.nextLine();
        String keyword = scanner.nextLine();
        return keyword;

    }
}
