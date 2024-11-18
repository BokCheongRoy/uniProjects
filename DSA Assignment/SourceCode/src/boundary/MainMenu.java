package boundary;

import java.util.Scanner;

/**
 *
 * @author All
 */
public class MainMenu {

    private Scanner scanner = new Scanner(System.in);

    public int option() {
        System.out.println(" _   _       _                    _ _          ___  ___                                                  _     _____           _  \n"
                + "| | | |     (_)                  (_) |         |  \\/  |                                                 | |   /  ___|         | |      \n"
                + "| | | |_ __  ___   _____ _ __ ___ _| |_ _   _  | .  . | __ _ _ __   __ _  __ _  ___ _ __ ___   ___ _ __ | |_  \\ `--. _   _ ___| |_ ___ _ __ ___  \n"
                + "| | | | '_ \\| \\ \\ / / _ \\ '__/ __| | __| | | | | |\\/| |/ _` | '_ \\ / _` |/ _` |/ _ \\ '_ ` _ \\ / _ \\ '_ \\| __|  `--. \\ | | / __| __/ _ \\ '_ ` _ \\ \n"
                + "| |_| | | | | |\\ V /  __/ |  \\__ \\ | |_| |_| | | |  | | (_| | | | | (_| | (_| |  __/ | | | | |  __/ | | | |_  /\\__/ / |_| \\__ \\ ||  __/ | | | | |\n"
                + " \\___/|_| |_|_| \\_/ \\___|_|  |___/_|\\__|\\__, | \\_|  |_/\\__,_|_| |_|\\__,_|\\__, |\\___|_| |_| |_|\\___|_| |_|\\__| \\____/ \\__, |___/\\__\\___|_| |_| |_|\n"
                + "                                         __/ |                            __/ |                                       __/ |     \n"
                + "                                        |___/                            |___/                                       |___/      \n");
        System.out.println("1. Course Management Menu");
        System.out.println("2. Programme Management Menu");
        System.out.println("3. Tutorial Group Management Menu");
        System.out.println("4. Tutor Management Menu");
        System.out.println("5. Tutorial Group - CRUD");
        System.out.println("0. Exit the program");
        int choice;
        while (true) {
            System.out.print("Enter choice (0-5): ");
            if (scanner.hasNextInt()) {
                choice = scanner.nextInt();
                return choice;
            } else {
                scanner.nextLine();
                System.out.println("Invalid input. Please enter an integer.");
            }
        }
    }

}
