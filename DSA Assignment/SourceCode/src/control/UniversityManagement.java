package control;

import boundary.*;
import utility.MessageUI;

/**
 *
 * @author All
 */
public class UniversityManagement {

    private MainMenu menu = new MainMenu();

    public void runMenu() {
        int choice = 0;
        do {
            choice = menu.option();
            switch (choice) {

                case 1:
                    MaintainCourse mc = new MaintainCourse();
                    mc.runCourseManagement();
                    break;
                case 2:
                    ProgrammeManagement pm = new ProgrammeManagement();
                    pm.runProgrammeManagement();
                    break;
                case 3:
                    TutorialGroupManagement tgsm = new TutorialGroupManagement();
                    tgsm.runStudentMaintenance();
                    break;
                case 4:
                    TutorMaintenance tm = new TutorMaintenance();
                    tm.runTutorMaintenance();
                    break;
                case 5:
                    TutorialGroupCRUD tgm = new TutorialGroupCRUD();
                    tgm.runTutorialGroupManagement();
                    break;
                case 0:
                    MessageUI.displayExitMessage();
                    
                    System.exit(0); 
                default:
                    MessageUI.displayInvalidChoiceMessage();
            }

        } while (choice != 0);
    }

    public static void main(String[] args) {
        UniversityManagement um = new UniversityManagement();
        um.runMenu();
    }
}
