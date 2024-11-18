
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utility;

/**
 *
 * @author Pua Jia Qian, Choo Shi Yi
 */
public class MessageUI {

    public static void displayInvalidChoiceMessage() {
        System.out.println("\n------ Invalid choice! ------");
    }

    public static void displayExitMessage() {
        System.out.println("\n------ Exiting system --------");
    }

    public static void displayExitSubsystemMessage() {
        System.out.println("\n------ Exiting Subsystem --------");
    }

    public static void displaySuccessfulMessage() {
        System.out.println("\n---- Successful! ------");
    }

    public static void displayExitProgram() {
        System.out.println("---Exit Tutor Maintenance---");
    }

    public static void displayInvalid() {
        System.out.println("Invalid input!\n");
    }

    public static void displaySuccessfulAdd() {
        System.out.println("Tutor Added Successful!\n");
    }

    public static void displaySuccessfulModify() {
        System.out.println("Tutor Modified Successful!\n");
    }

    public static void displaySuccessfulDelete() {
        System.out.println("Tutor Deleted Successful!\n");
    }

    public static void displayExitAdd() {
        System.out.println("Add tutor canceled!");
        System.out.println("----Exiting Add Tutor system-----\n");
    }

    public static void displayExitDelete() {
        System.out.println("----Exiting Delete Tutor system-----\n");
    }

    public static void displayExitEdit() {

        System.out.println("----Exiting Edit Tutor system-----\n");
    }

    public static void displayEmpty() {
        System.out.println("Cannot be empty!");
    }

    public static void displayNoTutors() {
        System.out.println("No tutors to display!");
    }

    public static void displayIdInvalid() {
        System.out.println("Invalid tutor ID format!(e.g., T1000).");
    }

    public static void displayCnInvalid() {
        System.out.println("Invalid tutor contact number format.(e.g., 123-12345678).");
    }

    public static void displayEmailInvalid() {
        System.out.println("Invalid email format. It must include '@'.");

    }

    public static void displayExpInvalid() {
        System.out.println("Experience year cannot contain a decimal point. Please enter a whole number.");

    }

    public static void displayPositiveInt() {
        System.out.println("Experience year must be a positive integer. Please try again.");

    }

    public static void displayExpFormat() {
        System.out.println("Invalid experience year format. Please enter a valid integer.");

    }

    public static void displayTypeInvalid() {
        System.out.println("Invalid tutor type. It must be 'FT' or 'PT'. Please try again.");

    }

}
