public class MyApp : Gtk.Application{
    public MyApp () {
        Object(
            application_id: "com.github.GoldenGladier.notifications-app",
            flags: ApplicationFlags.FLAGS_NONE            
        );
    }

protected override void activate () {
    var main_window = new Gtk.ApplicationWindow (this) {
        title = "Notification app",
        default_height = 500,
        default_width = 500
    };

    var title_label = new Gtk.Label ("Notifications");
    var show_button = new Gtk.Button.with_label ("Show");
    var replace_button = new Gtk.Button.with_label ("Replace");

    var grid = new Gtk.Grid ();
    grid.orientation = Gtk.Orientation.VERTICAL;
    grid.row_spacing = 6;
    grid.add (title_label);
    grid.add (show_button);
    grid.add (replace_button);

    //  This is a badge
    Granite.Services.Application.set_badge_visible.begin (true);
    Granite.Services.Application.set_badge.begin (4);
    //  This is a progress bar      
    Granite.Services.Application.set_progress_visible.begin (true);
    Granite.Services.Application.set_progress.begin (1f);

    main_window.add (grid);

    main_window.show_all ();

    show_button.clicked.connect (() => {
        var notification = new Notification ("Hello World");
        var icon = new GLib.ThemedIcon ("dialog-warning");
        notification.set_icon (icon);
        notification.set_body ("This is my first notification!");

        send_notification ("com.github.GoldenGladier.notifications-app", notification);
    });

    replace_button.clicked.connect (() => {
        var notification = new Notification ("CHANGE");
        var icon = new GLib.ThemedIcon ("dialog-warning");
        notification.set_icon (icon);
        notification.set_body ("This is my second Notification!");

        notification.set_priority (NotificationPriority.URGENT);
        send_notification ("com.github.GoldenGladier.notifications-app", notification);
    });    
    }

    public static int main (string[] args){
        return new MyApp ().run (args);
    }    
}

