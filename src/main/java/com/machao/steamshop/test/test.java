package com.machao.steamshop.test;

public class test {

	public static void main (String[] args) {
		// TODO Auto-generated method stub
		int i = 1;
		i = i++;
		int j = i++;
		System.out.println("i="+i);
		System.out.println("j="+j);
		int a = 1;
        //for (int b = 0; b < 99; b++) {
        a +=1;
        //}
        System.out.println(a);
        int x = 0;
        int y = 0;
        for (int z = 0; z < 99; z++) {
            x = x ++;
           y = x ++;
        }
        System.out.println(x);
        System.out.println(y);
	}

}
