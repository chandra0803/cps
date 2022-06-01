
package com.delphi.gfad.coreframework.db;

import org.apache.commons.logging.*;
import java.util.*;


/** 
This class provides cache management for the generated data layer, or
for any ArrayList-based caching mechanism using the factory cache container.  
ArrayList cache objects are registered along with a "table key"
representing a table the cache depends on.  When a Business Object 
modifies a table through insert or delete, it should notify the cache manager class
so that all caches depending on that table can be cleared.
It is expected that Business Objects based on multi-table joins will register
once for each table in the join, so that each cache will be registered one
or more times with different keys.
We keep a second set of cache references that holds each cache at most once, this
is used by the Cache Monitor thread to periodically clear expired references.
*/

public class DBCacheManager 
{
  private static Log log = LogFactory.getLog(DBCacheManager.class);

  // every 15 minutes?
  // minutes * (millis * seconds)
  public static final long CACHE_TEST_INTERVAL_MILLIS = 15L * (1000L * 60L); 

  /*
  This HashMap contains an ArrayList of caches for each tableKey 
  it has been presented with.  Each ArrayList will contain zero or more
  caches (each a HashMap) that depend on the tableKey.
  So it's a HashMap of ArrayLists of HashMaps.
  */
  private static HashMap   _allTableCacheLists = new HashMap();

  /*
  This ArrayList has a reference to each cache object at most once.
  */
  private static ArrayList _allCaches = new ArrayList();

  /*
  This thread periodically removes expired elements from the cache
  */
  private static Timer        _timer;
  private static CacheMonitor _landShark;

  /*
  Land Shark: Candygram....
  Tina Fey: They don't make them anymore.
  Land Shark: Oh, they don't? It's Publisher's Clearing House...
  Tina Fey: Ooh, I finally won! Aaah!!!!!
  */
  static 
  {
    DBCacheManager dbc = new DBCacheManager();
    _landShark         = dbc.new CacheMonitor();
    _timer             = new Timer(true);  // timer is a daemon - do not prolong life of app

    _timer.schedule( _landShark, CACHE_TEST_INTERVAL_MILLIS, CACHE_TEST_INTERVAL_MILLIS );
  }


  private DBCacheManager()
  {
  }

  /*
  Register a cache object as being interested in a (potentially new)
  table key.
  */
  public static void registerCache(String tableKey, HashMap cache)
  {
    if ((tableKey != null) && (cache != null))
    {
      log.debug( "registering cache for table key: " + tableKey);
      // add the cache to the specified table list
      getOrCreateCacheListForTableKey(tableKey).add(cache);

      // unlike the allTableCacheLists data member, this
      // array list has each cache object at most once.
      // this is used for purge processing
      if (!(_allCaches.contains(cache)))
      {
        synchronized (DBCacheManager.class)
        {
          if (!(_allCaches.contains(cache)))
          {
            _allCaches.add(cache);
          }
        }
      }
    }
    else
      log.debug( "NOT registering cache (cache or key was null) for table key: " + tableKey);

  }

  /*
  Clear the cache objects registered to this particular tableKey,
  if any exist.
  Returns the count of caches cleared (cache object count, 
  not the sum of cache records).  Count returned may be an approximation 
  as the underlying list of caches is mutable, and indexing errors are trapped.
  */
  public static int clearCachesForTableKey(String tableKey)
  {
    int count;
    ArrayList table = getOrCreateCacheListForTableKey(tableKey);

    log.debug( "CLEARING "+table.size()+" caches for table key: " + tableKey);

    for (count=0; count<table.size(); count++)
    {
      try
      {
        HashMap cache = (HashMap)table.get(count);
        if (cache != null)
          cache.clear();
        else
          log.debug( "cache "+count+" for table " + tableKey + " was null (unexpectedly)");
      }
      catch (IndexOutOfBoundsException ioobe)
      {
        // the caches are mutable although in
        // practice this should not happen
        log.error( "cache for table "+tableKey+" mutated during cache clear, continuing", ioobe);
      }
    }

    return count;
  }

  /*
  Glide through all of the caches, and for each cache, remove
  any fcc's that have expired.
  */
  public static void purgeExpiredElements()
  {
    log.debug( "DBCacheManager Purge Expired Elements");

    for (int i=0;i < _allCaches.size(); i++)
    {
      Iterator cache = ((HashMap)_allCaches.get(i)).values().iterator();
      try
      {
        while (cache.hasNext())
        {
          FactoryCacheContainer fcc = (FactoryCacheContainer)cache.next();
          if (!(fcc.isValid()))
          {
            log.debug( "DBCacheManager Purge Process EXPIRING cache element");
            cache.remove();
          }
        }
      }
      catch (ConcurrentModificationException cme)
      {
        // this is actually exceedingly likely 
        // to happen as elements are cached
        // and caches are purged.  better to stop
        // than to try and remove element X when the 
        // hashmap changes underneath us, which
        // is why we use an iterator rather than an index here
      }
    }

    // suggest to the GC that this might be a good
    // time to clean house
    System.gc();
  }

  public static HashMap getAllTableCacheLists()
  {
    return _allTableCacheLists;
  }

  public static ArrayList getAllCaches()
  {
    return _allCaches;
  }

  public static ArrayList getOrCreateCacheListForTableKey(String tableKey)
  {
    ArrayList table = null;

    if ((table = (ArrayList)_allTableCacheLists.get(tableKey)) == null) 
    {
      synchronized (DBCacheManager.class)
      {
        if ((table = (ArrayList)_allTableCacheLists.get(tableKey)) == null) 
        {
          log.debug( "!!! Creating NEW cache list for table key: " + tableKey);

          table = new ArrayList();
          _allTableCacheLists.put(tableKey, table);
        }
      }
    }

    return table;
  }


  /**
   * A task for the instance that will fire at regular intervals to test each cached element
   * and remove expired cache elements
   */
  class CacheMonitor extends TimerTask
  {
    public CacheMonitor()
    {
    }

    public void run()
    {
      try
      {
        DBCacheManager.purgeExpiredElements();
      }
      catch (Exception e)
      {
        // don't allow any exceptions to kill this thread
        log.error( "Cache Monitor got exception, ignoring", e);
      }
    }
  }
}
