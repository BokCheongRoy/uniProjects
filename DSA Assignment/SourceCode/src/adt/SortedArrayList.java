package adt;
import java.io.Serializable;

/**taken from sample code, except selectionSortAscending and selectionSortDescending
 * @author Frank M. Carrano
 * @version 2.0
 * @param <T>
 */

public class SortedArrayList<T extends Comparable<T>> implements SortedListInterface<T>, Serializable {

    private T[] array;
    private int numberOfEntries;
    private static final int DEFAULT_CAPACITY = 25;

    public SortedArrayList() {
        this(DEFAULT_CAPACITY);
    }

    public SortedArrayList(int initialCapacity) {
        numberOfEntries = 0;
        array = (T[]) new Comparable[initialCapacity];
    }

    @Override
    public boolean add(T newEntry) {
        int i = 0;
        while (i < numberOfEntries && newEntry.compareTo(array[i]) > 0) {
            i++;
        }
        makeRoom(i + 1);
        array[i] = newEntry;
        numberOfEntries++;
        return true;
    }

    @Override
    public boolean remove(T anEntry) {
        boolean found = false;

        if (!isEmpty()) {
            int position = getPosition(anEntry);
            if (position >= 0) {
                removeGap(position);
                numberOfEntries--;
                found = true;
            } // end if
        } // end if

        return found;
    }

    @Override
    public int getPosition(T anEntry) {
        int position = 1;

        while ((position <= numberOfEntries) && (anEntry.compareTo(getEntry(position - 1)) > 0)) {
            position++;
        } // end while

        if ((position > numberOfEntries) || !anEntry.equals(getEntry(position - 1))) {
            position = -position;
        } // end if

        return position;
    } // end getPosition

    // list operations
    @Override
    public T remove(int givenPosition) {
        T result = null; // return value

        if ((givenPosition >= 1) && (givenPosition <= numberOfEntries)) { // test catches empty list

            result = array[givenPosition - 1]; // get entry to be removed

            // move subsequent entries towards entry to be removed, 
            // unless it is last in list
            if (givenPosition < numberOfEntries) {
                removeGap(givenPosition);
            }

            numberOfEntries--;
        } // end if

        return result; // return reference to removed entry,
        // or null if list is empty
    } // end remove

    @Override
    public void clear() {
        numberOfEntries = 0;
    }

    @Override
    public boolean contains(T anEntry) {
        boolean found = false;
        for (int index = 0; !found && (index < numberOfEntries); index++) {
            if (anEntry.equals(array[index])) {
                found = true;
            }
        }
        return found;
    }

    @Override
    public int getNumberOfEntries() {
        return numberOfEntries;
    }

    @Override
    public T getEntry(int givenPosition) {
        T result = null; // result to return

        if (givenPosition >= 0 && givenPosition < numberOfEntries) {
            result = array[givenPosition];
        } // end if

        return result;
    } // end getEntry

    @Override
    public boolean isEmpty() {
        return numberOfEntries == 0;
    }

    @Override
    public String toString() {
        String outputStr = "";
        for (int index = 0; index < numberOfEntries; ++index) {
            outputStr += array[index] + "\n";
        }

        return outputStr;
    }

    private void makeRoom(int newPosition) {
        int newIndex = newPosition - 1;
        int lastIndex = numberOfEntries - 1;

        for (int index = lastIndex; index >= newIndex; index--) {
            array[index + 1] = array[index];
        }
    }

    private void removeGap(int givenPosition) {
        int removedIndex = givenPosition - 1;
        int lastIndex = numberOfEntries - 1;

        for (int index = removedIndex; index < lastIndex; index++) {
            array[index] = array[index + 1];
        }
    }
    
    @Override
    public void selectionSortAscending() {
        int n = numberOfEntries;

        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (array[j].compareTo(array[minIndex]) < 0) {
                    minIndex = j;
                }
            }

            // Swap elements if needed
            if (minIndex != i) {
                T temp = array[i];
                array[i] = array[minIndex];
                array[minIndex] = temp;
            }
        }
    }

    @Override
    public void selectionSortDescending() {
        int n = numberOfEntries;

        for (int i = 0; i < n - 1; i++) {
            int maxIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (array[j].compareTo(array[maxIndex]) > 0) {
                    maxIndex = j;
                }
            }

            // Swap elements if needed (reversed comparison for descending order)
            if (maxIndex != i) {
                T temp = array[i];
                array[i] = array[maxIndex];
                array[maxIndex] = temp;
            }
        }
    }


   
}
