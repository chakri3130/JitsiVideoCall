
Jitsi Video call plugin ----

---->  Clone the plugin and install in your project

---->  open android studio and open this path Gradle scripts -> build.gradle(Module:app)

        add below dependencies 

        1) add below maven method in allprojects -> repositories -> under Jcenter() method
        maven {
            url "https://github.com/jitsi/jitsi-maven-repository/raw/master/releases"
        }
        2) add below dependencies in dependencies method

        implementation fileTree(dir: 'libs', include: '*.jar')
    // SUB-PROJECT DEPENDENCIES START
    implementation(project(path: ":CordovaLib"))
    implementation "com.android.support:support-annotations:27.+"
    implementation(project(path: ":CordovaLib"))
    implementation "com.android.support:support-annotations:27.+"
    implementation ('org.jitsi.react:jitsi-meet-sdk:2.+') { transitive = true }
    implementation 'androidx.appcompat:appcompat:1.2.0'
    implementation 'androidx.constraintlayout:constraintlayout:1.1.3'

        3) check minandroid sdk version(jitsi supports from version 21, if application below 21 please update and sync gradle)--- it is available in build.gradle(project:android) ---- defaultMinSdkVersion=21 

        4) add below lines in gradle.properties(project properties)-- android.useAndroidX=true
            android.enableJetifier=true
        5) replace theme in android.manifest.xml file(android:theme="@style/AppTheme") in application TAG.

        6) add activity in android.manifest.xml under application tag

        <activity
            android:name="com.medleymed.VideoCall.Videocall"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|smallestScreenSize|screenLayout|uiMode"
            android:launchMode="singleTop" />

