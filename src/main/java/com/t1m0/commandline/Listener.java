package com.t1m0.commandline;

/**
 * Created by timo.schoepflin on 08.05.2017.
 */
public class Listener implements Runnable {

    private static boolean shutdownInitiated = false;
    private static int runningListeners = 0;

    public static void InitiateShutdown(){
        shutdownInitiated = true;
    }

    public static int getRunningListeners(){
        return runningListeners;
    }

    private static synchronized void registerListener(){
        System.out.println(++runningListeners + " Listeners running!");
    }

    private static synchronized void unregisterListener(){
        System.out.println(--runningListeners + " Listeners running!");
    }


    @Override
    public void run() {
        int count = 0;
        registerListener();
        do{
            System.out.println("Cycle - "+ count++);
            try {
                Thread.sleep(5000);
            } catch (Exception e){
                System.err.println(e.getMessage());
            }
        }while(!shutdownInitiated);
        unregisterListener();
    }
}
