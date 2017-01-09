package test;

public class Target {
	
	public int x;
	public int y;
	public long lifeMs = 2000;
	
	public Target(int x, int y)
	{
		this.x = x;
		this.y = y;
	}
	
	public boolean dec(long time)
	{
		lifeMs -= time;
		return lifeMs < 0;
	}

}
