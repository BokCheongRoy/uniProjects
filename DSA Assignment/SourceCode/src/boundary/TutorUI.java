package boundary;

import adt.*;
import entity.Tutor;
import java.util.Scanner;
import utility.MessageUI;

/**
 *
 * @author Choo Shi Yi
 */
public class TutorUI {

    Scanner scanner = new Scanner(System.in);

    public int getMenuChoice() {
        System.out.println("▀█▀ █░█ ▀█▀ █▀█ █▀█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀\n"
                + "░█░ █▄█ ░█░ █▄█ █▀▄   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░");

        System.out.println("\n-----------------------------------------");
        System.out.println("𝐓𝐮𝐭𝐨𝐫 𝐌𝐞𝐧𝐮");
        System.out.println("-----------------------------------------");
        System.out.println("1. Add new tutor ");
        System.out.println("2. Remove a tutor");
        System.out.println("3. Find a tutor");
        System.out.println("4. Amend tutor details");
        System.out.println("5. List all tutors");
        System.out.println("6. Filter tutors based on criteria");
        System.out.println("7. Generate relevant reports");
        System.out.println("0. Exit\n");
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

    public void listAllTutor(String outputStr) {
        System.out.println("------------------------");
        System.out.println("𝗟𝗶𝘀𝘁 𝗢𝗳 𝗧𝘂𝘁𝗼𝗿");
        System.out.println("------------------------");

        if (outputStr.isEmpty()) {
            MessageUI.displayNoTutors();
        } else {
            System.out.println(
                    String.format("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+\n"
                            + "| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                            "Tutor ID", "Tutor Name", "Contact Number", "Email", "Specialization", "Experience Year", "Tutor type"));
            System.out.println("+=====================+===================+=====================+=====================+===================+=====================+=====================+");
            System.out.print(outputStr);
        }

        System.out.println("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+");
    }

    public void printTutorDetails(Tutor tutor) {

        System.out.println(
                String.format("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+\n"
                        + "| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                        "Tutor ID", "Tutor Name", "Contact Number", "Email", "Specialization", "Experience Year", "Tutor type"));
        System.out.println("+=====================+===================+=====================+=====================+===================+=====================+=====================+");
        System.out.println(
                String.format("| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                        tutor.getTutorId(), tutor.getTutorName(), tutor.getTutorContactNo(), tutor.getTutorEmail(),
                        tutor.getTutorSpecialization(), tutor.getTutorExpYear(), tutor.getTutorType()));

        System.out.println("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+");
    }

    public String inputTutorId() {
        System.out.print("Enter tutor ID: ");
        String tutorId = scanner.nextLine().toUpperCase();

        while (tutorId.isEmpty() || !tutorId.matches("^T\\d{4}$")) {
            if (tutorId.isEmpty()) {
                MessageUI.displayEmpty();
            } else {
                MessageUI.displayIdInvalid();
            }
            System.out.print("Enter tutor ID: ");
            tutorId = scanner.nextLine().toUpperCase();
        }
        return tutorId;
    }

    public String inputTutorName() {
        System.out.print("Enter tutor name: ");
        String tutorName = scanner.nextLine().toUpperCase();

        while (tutorName.isEmpty()) {
            MessageUI.displayEmpty();
            System.out.print("Enter tutor name: ");
            tutorName = scanner.nextLine();
        }
        return tutorName;
    }

    public String inputTutorContactNo() {
        System.out.print("Enter tutor contact no: ");
        String tutorContactNo = scanner.nextLine();

        while (tutorContactNo.isEmpty() || !tutorContactNo.matches("^\\d{3}-\\d{7,8}$")) {
            if (tutorContactNo.isEmpty()) {
                MessageUI.displayEmpty();
            } else {
                MessageUI.displayCnInvalid();
            }
            System.out.print("Enter tutor contact no: ");
            tutorContactNo = scanner.nextLine();
        }

        return tutorContactNo;
    }

    public String inputTutorEmail() {
        System.out.print("Enter tutor email: ");
        String tutorEmail = scanner.nextLine();

        while (tutorEmail.isEmpty() || !tutorEmail.contains("@")) {
            if (tutorEmail.isEmpty()) {
                MessageUI.displayEmpty();
            } else {
                MessageUI.displayEmailInvalid();
            }
            System.out.print("Enter tutor email: ");
            tutorEmail = scanner.nextLine();
        }
        return tutorEmail;
    }

    public String inputTutorSpecialization() {
        System.out.print("Enter tutor specialization: ");
        String tutorSubject = scanner.nextLine();

        while (tutorSubject.isEmpty()) {
            MessageUI.displayEmpty();
            System.out.print("Enter tutor subject: ");
            tutorSubject = scanner.nextLine();
        }
        return tutorSubject;
    }

    public int inputTutorExpYear() {
        int tutorExpYear = 0;

        do {
            System.out.print("Enter tutor experience year(Exp:1,2,5): ");
            String expYearInput = scanner.nextLine();
            if (expYearInput.isEmpty()) {
                MessageUI.displayEmpty();
            } else if (expYearInput.contains(".")) {
                MessageUI.displayExpInvalid();
            } else {
                try {
                    tutorExpYear = Integer.parseInt(expYearInput);
                    if (tutorExpYear <= 0) {
                        MessageUI.displayPositiveInt();
                    }
                } catch (NumberFormatException e) {
                    MessageUI.displayExpFormat();
                }
            }
        } while (tutorExpYear <= 0);
        return tutorExpYear;
    }

    public String inputTutorType() {
        System.out.print("Enter tutor type(FT/PT): ");
        String tutorType = scanner.nextLine().toUpperCase();

        while (tutorType.isEmpty() || (!tutorType.equals("FT") && !tutorType.equals("PT"))) {
            if (tutorType.isEmpty()) {
                MessageUI.displayEmpty();
            } else {
                MessageUI.displayTypeInvalid();
            }
            System.out.print("Enter tutor type(FT/PT): ");
            tutorType = scanner.nextLine().toUpperCase();
        }

        return tutorType;
    }

    public Tutor inputTutorDetails() {
        String tutorId;
        String tutorName;
        String tutorContactNo;
        String tutorEmail;
        String tutorSpecialization;
        int tutorExpYear = 0;
        String tutorType;

        boolean isValidTutorId = false;
        boolean isValidTutorName = false;
        boolean isValidTutorContactNo = false;
        boolean isValidTutorEmail = false;
        boolean isValidTutorSpecialization = false;
        boolean isValidTutorExpYear = false;
        boolean isValidTutorType = false;

        do {
            tutorId = inputTutorId().toUpperCase();

            if (tutorId.isEmpty()) {
                MessageUI.displayEmpty();
            } else if (!tutorId.matches("^T\\d{4}$")) {
                MessageUI.displayIdInvalid();
            } else {
                isValidTutorId = true;
            }
        } while (!isValidTutorId);

        do {
            tutorName = inputTutorName().toUpperCase();

            if (tutorName.isEmpty()) {
                MessageUI.displayEmpty();
            } else {
                isValidTutorName = true;
            }
        } while (!isValidTutorName);

        do {
            tutorContactNo = inputTutorContactNo();

            if (tutorContactNo.isEmpty()) {
                MessageUI.displayEmpty();
            } else if (!tutorContactNo.matches("^\\d{3}-\\d{7,8}$")) {
                MessageUI.displayCnInvalid();
            } else {
                isValidTutorContactNo = true;
            }
        } while (!isValidTutorContactNo);

        do {
            tutorEmail = inputTutorEmail();

            if (tutorEmail.isEmpty()) {
                MessageUI.displayEmpty();
            } else if (!tutorEmail.contains("@")) {
                MessageUI.displayEmailInvalid();
            } else {
                isValidTutorEmail = true;
            }
        } while (!isValidTutorEmail);

        do {
            tutorSpecialization = inputTutorSpecialization();

            if (tutorSpecialization.isEmpty()) {
                MessageUI.displayEmpty();
            } else {
                isValidTutorSpecialization = true;
            }
        } while (!isValidTutorSpecialization);

        do {

            tutorExpYear = inputTutorExpYear();
            if (tutorExpYear > 0) {
                isValidTutorExpYear = true;
            } else {
                MessageUI.displayTypeInvalid();
            }

        } while (!isValidTutorExpYear);

        do {
            tutorType = inputTutorType().toUpperCase();

            if (tutorType.isEmpty()) {
                MessageUI.displayEmpty();
            } else if (!tutorType.equalsIgnoreCase("pt") && !tutorType.equalsIgnoreCase("ft")) {
                MessageUI.displayTypeInvalid();
            } else {
                isValidTutorType = true;
            }
        } while (!isValidTutorType);

        System.out.println();

        return new Tutor(tutorId, tutorName, tutorContactNo, tutorEmail, tutorSpecialization, tutorExpYear, tutorType);
    }

    public int inputModifyOption() {
        System.out.println("Select which information you want to modify:");
        System.out.println("1. Tutor Name");
        System.out.println("2. Tutor Conatct No");
        System.out.println("3. Tutor Email");
        System.out.println("4. Tutor Specialization");
        System.out.println("5. Tutor Experience Year");
        System.out.println("6. Tutor Type(FT/PT)");
        System.out.println("7. Exit\n");
        int option;
        while (true) {
            System.out.print("Enter(1-7): ");
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

    public void printAdd() {
        System.out.println("-----------------------------------------");
        System.out.println("𝗔𝗱𝗱 𝗧𝘂𝘁𝗼𝗿");
        System.out.println("-----------------------------------------");
    }

    public void printModify() {
        System.out.println("-----------------------------------------");
        System.out.println("𝗠𝗼𝗱𝗶𝗳𝘆 𝗧𝘂𝘁𝗼𝗿");
        System.out.println("-----------------------------------------");
        System.out.println("Enter the tutor id that want to modify.");
    }

    public void printRemove() {
        System.out.println("-----------------------------------------");
        System.out.println("𝗗𝗲𝗹𝗲𝘁𝗲 𝗧𝘂𝘁𝗼𝗿");
        System.out.println("-----------------------------------------");
        System.out.println("Enter the tutor Id that want to delete.");

    }

    public int printFind() {
        System.out.println("-----------------------------------------");
        System.out.println("𝗙𝗶𝗻𝗱 𝗧𝘂𝘁𝗼𝗿");
        System.out.println("-----------------------------------------");
        System.out.println("Search tutor by id or name");
        System.out.println("1.ID");
        System.out.println("2.Name");
        int option;
        while (true) {
            System.out.print("Enter(1-2): ");
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

    public int printFilter() {
        System.out.println("-----------------------------------------");
        System.out.println("𝗦𝗼𝗿𝘁𝗶𝗻𝗴 𝗧𝘂𝘁𝗼𝗿");
        System.out.println("-----------------------------------------");
        System.out.println("Select the meyhod of sorting tutor");
        System.out.println("1.Ascending sorting tutor name");
        System.out.println("2.Descending sorting tutor name");
        System.out.println("3.Exit to tutor menu");
        int option;
        while (true) {
            System.out.print("Enter(1-3): ");
            if (scanner.hasNextInt()) {
                option = scanner.nextInt();
                return option;
            } else {
                scanner.nextLine();
                System.out.println("Invalid input. Please enter an integer.");
            }
        }
    }

    public static String printSortedList(SortedListInterface<Tutor> tutors, String sortingMethod) {
        StringBuilder outputStr = new StringBuilder();
        String sortType = sortingMethod.equals("ascending") ? "Ascending" : "Descending";

        outputStr.append(sortType).append(" Sorted List\n");
        outputStr.append(
                String.format("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+\n"
                        + "| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |\n",
                        "Tutor ID", "Tutor Name", "Contact Number", "Email", "Specialization", "Experience Year", "Tutor type"));
        outputStr.append("+=====================+===================+=====================+=====================+===================+=====================+=====================+\n");

        for (int i = 0; i < tutors.getNumberOfEntries(); i++) {
            Tutor tutor = tutors.getEntry(i);
            outputStr.append(
                    String.format("| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |\n",
                            tutor.getTutorId(), tutor.getTutorName(), tutor.getTutorContactNo(), tutor.getTutorEmail(),
                            tutor.getTutorSpecialization(), tutor.getTutorExpYear(), tutor.getTutorType()));
        }
        outputStr.append("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+\n");

        return outputStr.toString();
    }

    public int printReport() {
        System.out.println("-----------------------------------------");
        System.out.println("𝗧𝘂𝘁𝗼𝗿 𝗥𝗲𝗽𝗼𝗿𝘁");
        System.out.println("-----------------------------------------");
        System.out.println("Select the type of report");
        System.out.println("1.Part-Time/Full-Time Tutor Report");
        System.out.println("2.Experienced Tutor Report");
        System.out.println("3.Exit to tutor menu");
        int option;
        while (true) {
            System.out.print("Enter(1-3): ");
            if (scanner.hasNextInt()) {
                option = scanner.nextInt();
                return option;
            } else {
                scanner.nextLine();
                System.out.println("Invalid input. Please enter an integer.");
            }
        }

    }

    public void printFtTutors(ListInterface<Tutor> tutors) {
        int totalCount = tutors.getNumberOfEntries(); // Count the total number of full-time tutors

        System.out.println("-----------------------------------------");
        System.out.println("𝗙𝘂𝗹𝗹 𝗧𝗶𝗺𝗲 𝗧𝘂𝘁𝗼𝗿");
        System.out.println("-----------------------------------------");
        System.out.println(
                String.format("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+\n"
                        + "| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                        "Tutor ID", "Tutor Name", "Contact Number", "Email", "Specialization", "Experience Year", "Tutor type"));
        System.out.println("+=====================+===================+=====================+=====================+===================+=====================+=====================+");

        for (int i = 1; i <= tutors.getNumberOfEntries(); i++) {
            Tutor tutor = tutors.getEntry(i);
            System.out.println(
                    String.format("| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                            tutor.getTutorId(), tutor.getTutorName(), tutor.getTutorContactNo(), tutor.getTutorEmail(),
                            tutor.getTutorSpecialization(), tutor.getTutorExpYear(), tutor.getTutorType()));
        }

        // Display the total count at the bottom of the table
        System.out.println("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+");
        System.out.println(String.format("| Total Tutor: %-134d |", totalCount));
        System.out.println("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+");
    }

    public void printPtTutors(ListInterface<Tutor> tutors) {
        int totalCount = tutors.getNumberOfEntries();
        System.out.println("-----------------------------------------");
        System.out.println("𝗣𝗮𝗿𝘁-𝗧𝗶𝗺𝗲 𝗧𝘂𝘁𝗼𝗿");
        System.out.println("-----------------------------------------");
        System.out.println(
                String.format("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+\n"
                        + "| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                        "Tutor ID", "Tutor Name", "Contact Number", "Email", "Specialization", "Experience Year", "Tutor type"));
        System.out.println("+=====================+===================+=====================+=====================+===================+=====================+=====================+");

        //for (Tutor tutor : tutors) {
        for (int i = 1; i <= tutors.getNumberOfEntries(); i++) {
            Tutor tutor = tutors.getEntry(i);
            System.out.println(
                    String.format("| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                            tutor.getTutorId(), tutor.getTutorName(), tutor.getTutorContactNo(), tutor.getTutorEmail(),
                            tutor.getTutorSpecialization(), tutor.getTutorExpYear(), tutor.getTutorType()));
        }
        System.out.println("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+");

        System.out.println(String.format("| Total Tutor: %-134d |", totalCount));
        System.out.println("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+");
    }

    public void displayTutorCategory(String categoryHeader, ListInterface<Tutor> tutors) {
        int totalCount = tutors.getNumberOfEntries();

        System.out.println("-----------------------------------------");
        System.out.println(categoryHeader);
        System.out.println("-----------------------------------------");
        System.out.println(
                String.format("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+\n"
                        + "| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                        "Tutor ID", "Tutor Name", "Contact Number", "Email", "Specialization", "Experience Year", "Tutor type"));
        System.out.println("+=====================+===================+=====================+=====================+===================+=====================+=====================+");

        for (int i = 1; i <= tutors.getNumberOfEntries(); i++) {
            Tutor tutor = tutors.getEntry(i);
            System.out.println(
                    String.format("| %-19s | %-17s | %-19s | %-19s | %-17s | %-19s | %-19s |",
                            tutor.getTutorId(), tutor.getTutorName(), tutor.getTutorContactNo(), tutor.getTutorEmail(),
                            tutor.getTutorSpecialization(), tutor.getTutorExpYear(), tutor.getTutorType()));
        }

        // Display the total count at the bottom of the table
        System.out.println("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+");
        System.out.println(String.format("| Total Count: %-134d |", totalCount));
        System.out.println("+---------------------+-------------------+---------------------+---------------------+-------------------+---------------------+---------------------+");
    }

    public String inputContinue() {
        System.out.print("Do you want to continue to manage tutor?(Y/N): ");
        String inputContinue = scanner.nextLine().toUpperCase();
        return inputContinue;
    }

}
