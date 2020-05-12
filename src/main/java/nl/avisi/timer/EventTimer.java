package nl.avisi.timer;

import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;

public class EventTimer {

    public EventTimer(TimerTask task, Calendar dateTime, long interval) {
        Timer timer = new Timer();

        timer.scheduleAtFixedRate(
                task,
                dateTime.getTime(),
                interval
        );
    }
}
