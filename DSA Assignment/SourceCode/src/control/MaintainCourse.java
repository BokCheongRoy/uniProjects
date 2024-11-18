package control;

import adt.*;
import dao.*;
import entity.*;
import boundary.*;
import java.util.Scanner;
import utility.*;

/**
 *
 * @author Pua Jia Qian
 */
public class MaintainCourse {

    Scanner scanner = new Scanner(System.in);

    private SortedListInterface<Course> courseList = new SortedArrayList<>();
    private SortedListInterface<Programme> programList = new SortedArrayList<>();
    private final CourseDAO cd = new CourseDAO();
    private final ProgrammeDAO pd = new ProgrammeDAO();
    private final CourseManagementUI courseUI = new CourseManagementUI();
    private ProgrammeManagement pm = new ProgrammeManagement();
    private ProgrammeManagementUI pmUI = new ProgrammeManagementUI();

    public MaintainCourse() {
        try {
            courseList = cd.retrieveFromFile();
            if (courseList == null) {
                System.out.println("The course list could not be loaded from the file or is empty.");
            }
        } catch (ClassNotFoundException ex) {
            System.out.println("Error: Something Wrong when reading file");
        }
    }

    public void runCourseManagement() {
        int choice;
        do {
            choice = courseUI.courseMenu();
            switch (choice) {

                case 1:
                    courseUI.addTitle();
                    addNewCourse();
                    break;
                case 2:
                    courseUI.removeTitle();
                    removeCourse(courseUI.inputCourseCode());
                    break;
                case 3:
                    courseUI.findTitle();
                    findCourseByCode(courseUI.inputCourseCode());
                    break;

                case 4:
                    courseUI.modifyTitle();
                    modifyCourse(courseUI.inputCourseCode());
                    break;
                case 5:
                    courseUI.displayTitle();
                    displayCourses();
                    break;
                case 6:
                    courseUI.assignProgramTitle();
                    assignProgrammeToCourse(courseUI.inputCourseCode());
                    break;
                case 7:
                    courseUI.removeProgramTitle();
                    removeProgrammeFromCourse(courseUI.inputCourseCode());
                    break;
                case 8:
                    courseUI.reportTitle();
                    generateReport();
                    break;
                case 0:
                    MessageUI.displayExitSubsystemMessage();
                    //System.exit(0); // Successful termination
                    break;
                default:
                    MessageUI.displayInvalidChoiceMessage();
            }
        } while (choice != 0);
    }

    public void initialCourses() {

        courseList = new SortedArrayList<>();
        courseList.add(new Course("BACS2234", "Human Computer Interaction", 3));
        courseList.add(new Course("ABCD1234", "Discrete Mathematics", 2));
        courseList.add(new Course("AACD3034", "Data Structure & Algorithms", 3));
    }

    public void addNewCourse() {

        String newCourseCode = courseUI.inputCourseCode();

        // Check for empty fields
        if (newCourseCode.isEmpty()) {
            System.out.println("Please fill in Course Code...");
            MessageUI.displayExitSubsystemMessage();
            return;

            //check course code format
        } else if (!newCourseCode.matches("^[A-Z]{4}\\d{4}$")) {
            System.out.println("Invalid Course Code format, Please follow correct format...");
            MessageUI.displayExitSubsystemMessage();
            return;

            // Check for duplicate course code
        } else if (checkCourseCodeDuplicate(newCourseCode)) {
            System.out.println("This course code " + newCourseCode + " already exists...");
            MessageUI.displayExitSubsystemMessage();
            return;
        }
        String newCourseName = courseUI.inputCourseName();
        if (newCourseName.isEmpty()) {
            System.out.println("Please fill in Course Name...");
            MessageUI.displayExitSubsystemMessage();
            return;

        } else if (newCourseName.length() > 40) {
            System.out.println("Course Name cannot exceeds 40 words...");
            MessageUI.displayExitSubsystemMessage();
            return;
        }

        int newCreditHours = courseUI.inputCreditHours();
        if (newCreditHours <= 0) {
            System.out.println("Please fill in Credit Hour...");
            MessageUI.displayExitSubsystemMessage();
            return;
        }

        Course newCourse = new Course(newCourseCode, newCourseName, newCreditHours);

        courseUI.printCourseDetails(newCourse);

        // confirmation
        if (courseUI.inputConfirmation().equals("y")) {
            courseList.add(newCourse);
            cd.saveToFile(courseList);
            MessageUI.displaySuccessfulMessage();

        } else {
            System.out.println("Cancel Add Course...");
            MessageUI.displayExitSubsystemMessage();
        }

    }

    private boolean checkCourseCodeDuplicate(String courseCode) {
        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course course = courseList.getEntry(i);
            if (course.getCourseCode().equals(courseCode)) {
                return true;
            }
        }
        return false;
    }

    public void removeCourse(String cCode) {

        // check empty course code
        if (cCode.isEmpty()) {
            System.out.println("Invalid course code. Please provide a valid course code...");
            MessageUI.displayExitSubsystemMessage();
            return;
        }

        boolean courseFound = false; // Flag to check if the course is found

        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course currentCourse = courseList.getEntry(i); // get course details

            if (currentCourse.getCourseCode().equals(cCode)) { // compare course code
                courseUI.printCourseDetails(currentCourse);

                if (courseUI.inputConfirmation().equals("y")) {
                    boolean removed = courseList.remove(currentCourse);
                    if (removed) {
                        cd.saveToFile(courseList);
                        MessageUI.displaySuccessfulMessage();
                    } else {
                        System.out.println("-- Course could not be removed. --");
                    }
                } else {
                    System.out.println("Cancel Remove Course...");
                }
                courseFound = true;
                break; // Exit the loop when the course is found and modified

            }
        }

        if (!courseFound) {
            System.out.println("This '" + cCode + "' Course not found... ");
        }
    }

    public boolean findCourseByCode(String courseCode) {

        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course currentCourse = courseList.getEntry(i);
            if (currentCourse.getCourseCode().equals(courseCode)) {
                courseUI.printCourseDetails(currentCourse);
                return true;
            }
        }

        System.out.println("This '" + courseCode + "' Course not found... ");
        return false;
    }

    public void modifyCourse(String cCode) {

        // check empty course code
        if (cCode.isEmpty()) {
            System.out.println("Invalid course code. Please provide a valid course code...");
            MessageUI.displayExitSubsystemMessage();
            return;
        }

        boolean courseFound = false; // Flag to check if the course is found

        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course currentCourse = courseList.getEntry(i);
            if (currentCourse.getCourseCode().equals(cCode)) {
                courseUI.printCourseDetails(currentCourse);

                String newCourseName = currentCourse.getCourseName();
                int newCreditHours = currentCourse.getCreditHours();

                switch (courseUI.inputModifyOption()) {
                    case 1:
                        System.out.print("Enter new Course Name: ");
                        newCourseName = scanner.nextLine();
                        if (newCourseName.isEmpty()) {
                            System.out.println("Please fill in Course Name...");
                            MessageUI.displayExitSubsystemMessage();
                            return;

                        } else if (newCourseName.length() > 40) {
                            System.out.println("Course Name cannot exceeds 40 words...");
                            MessageUI.displayExitSubsystemMessage();
                            return;
                        }
                        break;
                    case 2:
                        while (true) {
                            System.out.print("Enter Credit Hours: ");
                            if (scanner.hasNextInt()) {
                                newCreditHours = scanner.nextInt();
                                if (newCreditHours <= 0) {
                                    System.out.println("Credit Hours must be a positive integer.");
                                } else {
                                    break;
                                }
                            } else {
                                scanner.nextLine(); // Consume the invalid input
                                System.out.println("Invalid input. Please enter a valid positive integer for Credit Hours.");
                            }
                        }
                        break;

                    default:
                        MessageUI.displayInvalidChoiceMessage();

                }

                if (courseUI.inputConfirmation().equals("y")) {
                    currentCourse.setCourseName(newCourseName);
                    currentCourse.setCreditHours(newCreditHours);

                    cd.saveToFile(courseList);
                    MessageUI.displaySuccessfulMessage();
                } else {
                    return;
                }
                courseFound = true; // Set the flag to true
                break; // Exit the loop when the course is found and modified
            }
        }
        if (!courseFound) {
            System.out.println("This '" + cCode + "' Course not found... ");
        }
    }
    public void assignProgrammeToCourse(String cCode) {
        boolean courseFound = false; // Flag to check if the course is found

        retrieveProgramme();

        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course currentCourse = courseList.getEntry(i);
            if (currentCourse.getCourseCode().equals(cCode)) {
                courseUI.printCourseDetails(currentCourse);

                //pmUI.displayAllProgrammes(programList);
                pmUI.displayAllProgrammes(programList);
                System.out.print("\nChoose Number of Programme to assign:");
                int currentProgramNo;

                try {
                    currentProgramNo = Integer.parseInt(scanner.nextLine());
                } catch (NumberFormatException e) {
                    System.out.println("Invalid input. Please enter a valid number.");
                    return;
                }

                if (currentProgramNo < 1 || currentProgramNo > programList.getNumberOfEntries()) {
                    MessageUI.displayInvalidChoiceMessage();
                    return;
                }

                Programme currentProgramme = programList.getEntry(currentProgramNo - 1);
                if (courseUI.inputConfirmation().equals("y")) {
                    currentCourse.addProgramme(currentProgramme);
                    cd.saveToFile(courseList);
                    System.out.println(" '" + currentProgramme.getProgrammeName() + "' Programme is added to '" + currentCourse.getCourseName() + "' Course !");
                } else {
                    System.out.println("Assign programme canceled...");
                }
                courseFound = true; // Set the flag to true
                break; // Exit the loop when the course is found and modified
            }

        }
        if (!courseFound) {
            System.out.println("This '" + cCode + "' Course not found... ");
        }

    }

    public void removeProgrammeFromCourse(String cCode) {
        boolean courseFound = false; // Flag to check if the course is found

        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course currentCourse = courseList.getEntry(i);
            if (currentCourse.getCourseCode().equals(cCode)) {
                courseUI.printCourseDetails(currentCourse);

                programList = currentCourse.getProgramme();

                if (!programList.isEmpty()) {
                    // display programme list 
                    pmUI.displayAllProgrammes(programList);

                    System.out.print("\nChoose Number of Programme to remove:");
                    int currentProgramNo;
                    try {
                        currentProgramNo = Integer.parseInt(scanner.nextLine());
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid input. Please enter a valid number.");
                        return;
                    }
                    if (currentProgramNo < 1 || currentProgramNo > programList.getNumberOfEntries()) {
                        MessageUI.displayInvalidChoiceMessage();
                        return;
                    }

                    Programme currentProgramme = programList.getEntry(currentProgramNo - 1);

                    if (courseUI.inputConfirmation().equals("y")) {

                        // Remove the selected programme
                        programList.remove(currentProgramme);
                        cd.saveToFile(courseList);
                        System.out.println("\n '" + currentProgramme.getProgrammeName() + "' Programme removed successfully!");

                    } else {
                        System.out.println("\nCancel Remove Programme...");
                    }

                } else {
                    System.out.println("\nNo programme found for this course...");
                }
                courseFound = true;
                break; // Exit the loop when the course is found and modified

            }
        }

        if (!courseFound) {
            System.out.println("This '" + cCode + "' Course not found... ");
        }

    }

    //retrieve programme from the file
    public void retrieveProgramme() {

        try {
            programList = pd.retrieveFromFile();
        } catch (ClassNotFoundException ex) {
            System.out.println("Something Wrong in File");
        }
    }

    // choose 1 type of report
    public void generateReport() {
        switch (courseUI.inputReportOption()) {
            case 1:
                courseUI.courseDetailsReportTitle();
                allCoursesReport();
                break;
            case 2:
                courseUI.courseNameReportTitle();
                courseNameReport(courseUI.inputCourseKeyword());
                break;
            default:
                MessageUI.displayInvalidChoiceMessage();
                break;

        }
    }

    public void allCoursesReport() {

        courseUI.reportsubTitle();
        int totalCreditHours = 0;

        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course currentCourse = courseList.getEntry(i);

            programList = currentCourse.getProgramme();

            if (!programList.isEmpty()) {
                for (int j = 0; j < programList.getNumberOfEntries(); j++) {
                    Programme programme = programList.getEntry(j);
                    System.out.printf("| %-11s | %-30s |     %-4d     | %-14s | %-30s |      %-7d      |\n",
                            currentCourse.getCourseCode(),
                            currentCourse.getCourseName(),
                            currentCourse.getCreditHours(),
                            programme.getProgrammeCode(),
                            programme.getProgrammeName(),
                            programme.getDurationOfYear()
                    );
                    totalCreditHours += currentCourse.getCreditHours();

                }
                courseUI.separateLine();

            } else {
                System.out.printf("| %-11s | %-30s |     %-4d     | %-67s |\n",
                        currentCourse.getCourseCode(),
                        currentCourse.getCourseName(),
                        currentCourse.getCreditHours(),
                        "No associated Programme");
                courseUI.separateLine();

            }

        }
        System.out.printf("\n\t\t\tTotal Credit Hours(s):   %-12d", totalCreditHours);
        System.out.printf("\tTotal Programme(s):   %-12d\n", getTotalProgramme((SortedArrayList<Course>) courseList));

    }

    public static int getTotalProgramme(SortedArrayList<Course> courseList) {
        int totalProgramme = 0;

        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course currentCourse = courseList.getEntry(i);
            totalProgramme += currentCourse.getProgramme().getNumberOfEntries();
        }

        return totalProgramme;
    }

    public void courseNameReport(String keyword) {

        boolean courseFound = false; // Flag to check if any course matches the keyword
        int totalCreditHours = 0;

        for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
            Course currentCourse = courseList.getEntry(i);
            String courseName = currentCourse.getCourseName();

            if (courseName.toLowerCase().contains(keyword.toLowerCase())) {
                if (!courseFound) {
                    courseUI.reportsubTitle();

                    programList = currentCourse.getProgramme();

                    if (!programList.isEmpty()) {
                        for (int j = 0; j < programList.getNumberOfEntries(); j++) {
                            Programme programme = programList.getEntry(j);
                            System.out.printf("| %-11s | %-30s |     %-4d     | %-14s | %-30s |      %-7d      |\n",
                                    currentCourse.getCourseCode(),
                                    courseName,
                                    currentCourse.getCreditHours(),
                                    programme.getProgrammeCode(),
                                    programme.getProgrammeName(),
                                    programme.getDurationOfYear()
                            );

                            totalCreditHours += currentCourse.getCreditHours();
                        }
                        courseUI.separateLine();

                    } else {
                        System.out.printf("| %-11s | %-30s |     %-4d     | %-67s |\n",
                                currentCourse.getCourseCode(),
                                currentCourse.getCourseName(),
                                currentCourse.getCreditHours(),
                                "No associated Programme");
                        courseUI.separateLine();
                    }
                    courseFound = true;
                    break;
                }
            }
        }

        System.out.printf("\n\t\t\tTotal Credit Hours(s):   %-12d", totalCreditHours);
        System.out.printf("\tTotal Programme(s):   %-12d\n", programList.getNumberOfEntries());
        if (!courseFound) {
            System.out.println("No courses matching the keyword were found...");
        }

    }

    public void displayCourses() {

        //check empty list
        if (courseList.isEmpty()) {
            System.out.println("No courses found.");
        } else {
            courseUI.courseSubTitle();
            for (int i = 0; i < courseList.getNumberOfEntries(); i++) {
                Course course = courseList.getEntry(i);
                System.out.printf("| %2d. | %-11s | %-30s |     %-4d     |\n", i + 1, course.getCourseCode(), course.getCourseName(), course.getCreditHours());
                System.out.println("+-------------------------------------------------------------------+");
            }
        }

    }

}
