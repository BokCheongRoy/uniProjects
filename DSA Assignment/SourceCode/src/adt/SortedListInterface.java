package adt;

/** taken from sample code, except selectionSortAscending and selectionSortDescending
 * @author Frank M. Carrano
 * @version 2.0
 * @param <T>
 */
public interface SortedListInterface<T extends Comparable<T>> {

    public boolean add(T newEntry);

    public int getPosition(T anEntry);

    public T getEntry(int givenPosition);

    public T remove(int givenPosition);

    public boolean remove(T anEntry);

    public boolean contains(T anEntry);

    public void clear();

    public int getNumberOfEntries();

    public void selectionSortAscending();

    public void selectionSortDescending();

    public boolean isEmpty();

}
