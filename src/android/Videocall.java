package com.medleymed.VideoCall;

import androidx.appcompat.app.AppCompatActivity;
import io.ionic.starter.R;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;
import org.jitsi.meet.sdk.JitsiMeet;
import org.jitsi.meet.sdk.JitsiMeetActivity;
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions;
import java.net.MalformedURLException;
import java.net.URL;
public class Videocall extends AppCompatActivity {
    Bundle bundle;
    String meetingId;
    TextView tvMeetingId;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sample);
        tvMeetingId = findViewById(R.id.tvMeetingId);
        bundle = getIntent().getExtras();
        if(bundle != null)
        {
            meetingId = bundle.getString("meetingId");
            Toast.makeText(this, "Meeting ID"+meetingId, Toast.LENGTH_SHORT).show();
            tvMeetingId.setText(meetingId+"");
        }
        // Initialize default options for Jitsi Meet conferences.
        URL serverURL;
        try {
            serverURL = new URL("https://jitsimeet.tutoroot.com");
        } catch (MalformedURLException e) {
            e.printStackTrace();
            throw new RuntimeException("Invalid server URL!");
        }
        JitsiMeetConferenceOptions defaultOptions
                = new JitsiMeetConferenceOptions.Builder()
                .setServerURL(serverURL)
                .setWelcomePageEnabled(false)
                .build();
        JitsiMeet.setDefaultConferenceOptions(defaultOptions);
        // Build options object for joining the conference. The SDK will merge the default
        // one we set earlier and this one when joining.
        JitsiMeetConferenceOptions options
                = new JitsiMeetConferenceOptions.Builder()
                .setRoom(meetingId)
                .setWelcomePageEnabled(false)
                .setToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnt9fSwiYXVkIjoiaml0c2ltZWV0LnR1dG9yb290LmNvbSIsImlzcyI6Ik1lZERvY01hc3RlckFwcElEIiwic3ViIjoiaml0c2ltZWV0LnR1dG9yb290LmNvbSIsInJvb20iOiIqIn0.zKkYnDh99CdxVcVIZqYpvnLgGFiQj_r38HI4WQyK7Po")
//                .setFeatureFlag("recording.enabled", false)
//                .setFeatureFlag("invite.enabled", false)
//                .setFeatureFlag("chat.enabled", false)
                .build();
        // Launch the new activity with the given options. The launch() method takes care
        // of creating the required Intent and passing the options.
        JitsiMeetActivity.launch(this, options);
        finish();
    }
}