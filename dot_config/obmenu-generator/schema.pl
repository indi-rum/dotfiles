#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    file:      include the content of an XML file        {file => "/path/to/file.xml"},
    raw:       any XML data supported by Openbox          {raw => q(xml data)},
    begin_cat: beginning of a category              {begin_cat => ["name", "icon"]},
    end_cat:   end of a category                      {end_cat => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

## Text editor
my $editor = $CONFIG->{editor};

our $SCHEMA = [
	{sep => "Menu"},

    #          COMMAND          LABEL               ICON
    {item => ['alacritty',    'Terminal',          'terminal']},
    {item => ['thunar',       'File Manager',      'file-manager']},
    {item => ['firefox',      'Web Browser',       'firefox']},
    {sep => undef},

    {sep => "»--•--«"},
    
    {begin_cat => ['Applications', 'menulibre']},
        #          NAME            LABEL                ICON
    {cat => ['utility',     'Accessories', 'applications-utilities']},
    {sep => undef},
    {cat => ['development', 'Development', 'applications-development']},
    {sep => undef},
    {cat => ['education',   'Education',   'applications-science']},
    {sep => undef},
    {cat => ['game',        'Games',       'applications-games']},
    {sep => undef},
    {cat => ['graphics',    'Graphics',    'applications-graphics']},
    {sep => undef},
    {cat => ['audiovideo',  'Multimedia',  'applications-multimedia']},
    {sep => undef},
    {cat => ['network',     'Network',     'applications-internet']},
    {sep => undef},
    {cat => ['office',      'Office',      'applications-office']},
    {sep => undef},
    {cat => ['other',       'Other',       'applications-other']},
    {sep => undef},
    {cat => ['settings',    'Settings',    'gnome-settings']},
    {sep => undef},
    {cat => ['system',      'System',      'applications-system']},
    {end_cat => undef},

    {sep => undef},

    {begin_cat => ['Preferences', 'albert']},
        {item => ['lxappearance',     'Appearance Settings',       'applications-accessories']},
        {item => ['tint2conf',        'Tint2RC',                   'tint2']},
    {end_cat => undef},
    
    {sep => undef},

    {begin_cat => ['Apps as Root', 'emblem-warning']},
    {item => ["gksudo thunar",          'File Manager As Root',                 'file-manager']},
    {item => ["gksudo alacritty",       'Terminal As Root',                     'terminal']},
    {item => ["pamac-manager",          'Software Center As Root',              'pamac']},

    {end_cat => undef},

    {sep => "»--•--«"},

    {begin_cat => ['Obmenu-Generator', 'menu-editor']},
    {item => ["$editor ~/.config/obmenu-generator/schema.pl", 'Menu Schema', 'text-x-source']},
        	{item => ["$editor ~/.config/obmenu-generator/config.pl", 'Menu Config', 'text-x-source']},
        	{sep  => undef},
        	{item => ['obmenu-generator -p',       'Generate a pipe menu',              'menu-editor']},
        	{item => ['obmenu-generator -s -c',    'Generate a static menu',            'menu-editor']},
       	 	{item => ['obmenu-generator -p -i',    'Generate a pipe menu with icons',   'menu-editor']},
        	{item => ['obmenu-generator -s -i -c', 'Generate a static menu with icons', 'menu-editor']},
       	 	{sep  => undef},
        	{item => ['obmenu-generator -d',       'Refresh Icon Set',                  'gtk-refresh']},
    {end_cat => undef},

    {sep => undef},

    {begin_cat => ['Openbox', 'openbox']},
            {item => ['obconf',                                 'GUI Config Tool',               'menu-editor']},
            {item => ['openbox --restart',                      'Restart Openbox',               'openbox']},
            {item => ['openbox --reconfigure',                  'Reconfigure Openbox',           'openbox']},
    {end_cat => undef},

    {sep => "»--•--«"},

    {item => ['/home/gin/.bin/set_wallpaper',       'Change Wallpaper',              'image-viewer']},

    {sep => "»--•--«"},

    {item => ['archlinux-logout',                      'Lock Screen',                       'lock']},
    {item => ['archlinux-logout',                      'Exit Openbox',                      'exit']},

    {sep => "»--•--«"},

    {pipe => ['/home/gin/.config/openbox/scripts/ac-places',                      'Places',                  'folder']},
    {pipe => ['/home/gin/.config/openbox/scripts/ac-recent-files',                'Recent Files',            'file-library-symbolic']},
]