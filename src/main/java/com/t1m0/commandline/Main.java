package com.t1m0.commandline;

/**
 * Created by timo.schoepflin on 08.05.2017.
 */
public class Main {

    public static void main(String[] args){
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.out.println("Shutdown !!!!!");
            Listener.InitiateShutdown();
            while (Listener.getRunningListeners() > 0){
                try {
                    Thread.sleep(500);
                } catch (Exception e){
                    System.err.println(e.getMessage());
                }
            }
        }));

        Thread t = new Thread(new Listener());
        t.start();
    }
}
