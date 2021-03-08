package com.medleymed.VideoCall;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.apache.cordova.CordovaWebView;
import org.jitsi.meet.sdk.JitsiMeet;
import org.jitsi.meet.sdk.JitsiMeetActivity;
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.net.MalformedURLException;
import java.net.URL;



import static android.content.Intent.FLAG_ACTIVITY_NEW_TASK;

/**
 * This class echoes a string called from JavaScript.
 */
/**
 * This class echoes a string called from JavaScript.
 */
public class JitsiVCall extends CordovaPlugin {

     private CordovaInterface cordova;


    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        this.cordova = cordova;
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Context context = cordova.getActivity().getApplicationContext();

        if (action.equals("startconfig")) {
            String meetingId = args.getString(0);
            openVideoChatRoom(context, meetingId);           
            return true;
        }
        return false;
    }


    private void openVideoChatRoom(Context context, String meetingId){

        cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {

                Intent intent = new Intent(context.getApplicationContext(), cordova.plugin.videocall.SampleActivity.class);
                intent.putExtra("meetingId", meetingId);
                intent.addFlags(FLAG_ACTIVITY_NEW_TASK);
                cordova.getContext().getApplicationContext().startActivity(intent);
            }
        });
    }
}
