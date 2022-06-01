
package com.delphi.gfad.coreframework.db;


public class FactoryCacheContainer
{
  private long   expires;
  private Object payload;
  private Object reference;

  public FactoryCacheContainer (Object payload, long expiresInterval)
  {
    this.expires = System.currentTimeMillis() + expiresInterval;
    this.payload = payload;
  }

  public FactoryCacheContainer (Object payload, Object reference, long expiresInterval)
  {
    this.expires = System.currentTimeMillis() + expiresInterval;
    this.payload = payload;
    this.reference = reference;
  }
  
  public Object getPayload()
  {
    return payload;
  }
  public Object getReference()
  {
    return reference;
  }
  public boolean isValid()
  {
    return (expires > System.currentTimeMillis());
  }
}
