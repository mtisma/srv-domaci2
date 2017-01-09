package test;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.Queue;

import javax.swing.JFrame;
import javax.swing.JPanel;

import com.codeminders.hidapi.HIDDevice;
import com.codeminders.hidapi.HIDDeviceInfo;
import com.codeminders.hidapi.HIDManager;

public class Core {

	static {
		System.loadLibrary("hidapi-jni");
	}
	
	private static final int BUF_SIZE = 128;
	public static int TARGET_SIZE = 40;
	
	private MyPanel panel;

	ArrayList<Target> realTargets = new ArrayList<>();
	ArrayList<Target> fakeTargets = new ArrayList<>();
	Queue<Target> qReal = new LinkedList<>();
	Queue<Target> qFake = new LinkedList<>();
	
	int score = 0;
	
	private void initGui()
	{
		JFrame frame = new JFrame(" ");
		frame.setSize(320, 240);
		frame.setLocationRelativeTo(null);
		panel = new MyPanel(this);
		//panel.setMaximumSize(new Dimension(320, 240));
		panel.setBackground(Color.white);
		frame.setContentPane(panel);
		frame.setVisible(true);
	}
	
	private HIDDevice findBoard(HIDManager hidMgr) throws IOException
	{
		HIDDevice device = null;
		
		while (true) 
		{
			HIDDeviceInfo[] infos = hidMgr.listDevices();
			
			for (HIDDeviceInfo info : infos)
			{
				if (info.getProduct_string().compareTo("USB HID Library") == 0) 
					device = info.open();
				if (device != null) 
				{
					System.out.println("nasao");
					return device;
				}
			}
		}
	}
		
	public static void main(String[] args) throws IOException {
		
		Core core = new Core();
				
		HIDManager hidMgr;		
		hidMgr = HIDManager.getInstance();
		
		HIDDevice device = core.findBoard(hidMgr);
		core.initGui();
		
		
		
		try {
			device.enableBlocking();
		
			ArrayList<Target> lista = new ArrayList<>();
			byte[] readBuf = new byte[BUF_SIZE];
			byte[] writeBuf = new byte[BUF_SIZE];
			
			Queue<Target> qr = core.qReal;
			long lastTime = System.nanoTime() / 1000000;
			while(true)
			{				
				
				long currTime = System.nanoTime() / 1000000;
				long diff = currTime - lastTime;
				lastTime = System.nanoTime() / 1000000;
				
					
				for (int j = 0; j < writeBuf.length; j++)
					writeBuf[j] = 0;
				int i = 1;
				if (!core.qReal.isEmpty())
				{
					Target t = core.qReal.remove();
					if ((t.x & 0xFF00) > 0)
					{
						writeBuf[1] = (byte) 0xFF;
						writeBuf[2] = (byte) (t.x & 0x00FF);
					}
					else writeBuf[2] = (byte) t.x;
					
					writeBuf[3] = (byte) t.y;
				}
				
				if (!core.qFake.isEmpty())
				{
					Target t = core.qFake.remove();
					if ((t.x & 0xFF00) > 0)
					{
						writeBuf[4] = (byte) 0xFF;
						writeBuf[5] = (byte) (t.x & 0x00FF);
					}
					else writeBuf[5] = (byte) t.x;
					
					writeBuf[6] = (byte) t.y;
					//System.out.println((writeBuf[4] & 0xFF) + " " + (writeBuf[5] & 0xFF) + " " + (writeBuf[6] & 0xFF));
				}
				
				i = 7;
				for (Target p : lista)
				{
					if ((p.x & 0xFF00) > 0)
					{
						writeBuf[i++] = (byte) 0xFF;
						writeBuf[i++] = (byte) (p.x & 0x00FF);
					}
					else 
					{
						writeBuf[i++] = 0;
						writeBuf[i++] = (byte) p.x;
					}
					writeBuf[i++] = (byte) p.y;
				}
				lista.clear();
				
				for (int j = 0; j < core.fakeTargets.size(); j++)
				{
					if (core.fakeTargets.get(j).dec(diff))
					{
						Target t = core.fakeTargets.get(j);
						core.fakeTargets.remove(j);
						if ((t.x & 0xFF00) > 0)
						{
							writeBuf[7] = (byte) 0xFF;
							writeBuf[8] = (byte) (t.x & 0x00FF);
						}
						else 
						{
							writeBuf[7] = 0;
							writeBuf[8] = (byte) t.x;
						}
						writeBuf[9] = (byte) t.y;
					}
					
				}
				
				for (int j = 0; j < core.realTargets.size(); j++)
				{
					if (core.realTargets.get(j).dec(diff))
					{
						Target t = core.realTargets.get(j);
						core.realTargets.remove(j);
						if ((t.x & 0xFF00) > 0)
						{
							writeBuf[7] = (byte) 0xFF;
							writeBuf[8] = (byte) (t.x & 0x00FF);
						}
						else 
						{
							writeBuf[7] = 0;
							writeBuf[8] = (byte) t.x;
						}
						writeBuf[9] = (byte) t.y;
					}
				}
				
				device.write(writeBuf); 
				device.read(readBuf);
				
				for (int j = 0; j < readBuf.length - 5 ; j += 3)
				{
					int x = (readBuf[j] & 0xFF) + (readBuf[j + 1] & 0xFF) ;
					int y = readBuf[j + 2] & 0xFF;
					
					if (x == 0 && y == 0)
						break;
					for (int k = 0; k < core.fakeTargets.size(); k++)
					{
						Target target = core.fakeTargets.get(k);
						Rectangle rect = new Rectangle((int)target.x - TARGET_SIZE / 2, (int)target.y - TARGET_SIZE / 2,
								TARGET_SIZE, TARGET_SIZE);
						
						if (rect.contains(x, y))
						{
							core.fakeTargets.remove(k);
							lista.add(target);
							
							core.score = core.score - 3;
							if(core.score < 0){
								core.score = 0;
							}
							System.out.println("SCORE: " + core.score);
						}
					}
					
					for (int k = 0; k < core.realTargets.size(); k++)
					{
						Target target = core.realTargets.get(k);
						Rectangle rect = new Rectangle((int)target.x - TARGET_SIZE / 2, (int)target.y - TARGET_SIZE / 2,
								TARGET_SIZE, TARGET_SIZE);
						
						if (rect.contains(x, y))
						{
							core.realTargets.remove(k);
							lista.add(target);
							core.score = core.score + 1;
							System.out.println("SCORE: " + core.score);
						}
					}
				}
				
				core.panel.repaint();
				
/*				try {
					Thread.sleep(40);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}*/
			
			}
			
			
		} finally {
			device.close();
			hidMgr.release();   
		}
		
	}
	


}