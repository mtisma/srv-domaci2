package test;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;

import javax.swing.JPanel;

public class MyPanel extends JPanel{

	private Core core;
	
	public MyPanel(Core core)
	{
		this.core = core;
		addMouseListener(new MouseAdapter() {
			
			@Override
			public void mousePressed(MouseEvent e) {
				if (e.getButton() == 1)
				{
					Target t = new Target(e.getX() + 1, e.getY() + 1);
					core.realTargets.add(t);
					core.qReal.add(t);
					//System.out.println(core.qReal.size());
				}
				else 
				{
					Target t = new Target(e.getX() + 1, e.getY() + 1);
					core.fakeTargets.add(t);
					core.qFake.add(t);
				}
				repaint();
			}
		});
	}
	
	@Override
	protected void paintComponent(Graphics g) {
		super.paintComponent(g);
		
		g.setColor(Color.BLUE);
		for (Target p : core.realTargets)
			
			g.fillOval((int)p.x - Core.TARGET_SIZE / 2, (int)p.y - Core.TARGET_SIZE / 2,
					Core.TARGET_SIZE, Core.TARGET_SIZE);
		
		g.setColor(Color.GREEN);
		for (Target p : core.fakeTargets)
			g.fillOval((int)p.x - Core.TARGET_SIZE / 2, (int)p.y - Core.TARGET_SIZE / 2,
					Core.TARGET_SIZE, Core.TARGET_SIZE);
	}
	
}
