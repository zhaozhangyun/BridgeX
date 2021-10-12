package zizzy.zhao.bridgex.base.utils;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;

import java.lang.ref.WeakReference;

public class WeakHandler extends Handler {

    private WeakReference weakHandler;

    public WeakHandler(OnHandleMessageListener listener) {
        super(Looper.getMainLooper());
        weakHandler = new WeakReference(listener);
    }

    @Override
    public void handleMessage(Message message) {
        if (weakHandler != null && weakHandler.get() != null) {
            OnHandleMessageListener listener = (OnHandleMessageListener) weakHandler.get();
            listener.onHandleMessage(message);
        }
    }

    public interface OnHandleMessageListener {
        void onHandleMessage(Message message);
    }
}
