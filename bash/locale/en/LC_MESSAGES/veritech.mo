��    Z      �     �     �     �     �     �     �     �  
             ,     =     L     R     d  	   i     s     �     �     �     �     �     �     �     	     	     -	     ?	     O	     c	     u	     �	     �	     �	     �	     �	     �	     �	     	
     
     1
     F
     Y
     l
     �
     �
     �
     �
     �
     �
       	             .     >     G     T     ]     q     �     �     �  	   �     �     �     �     �     �               /     @     O     f     v  
   �     �     �     �     �     �  
   �     �     �     	  	        $  
   -     8     J     R     `     q     �     �     �     �     �     �  #   �  x        �     �  +   �     �  /   �  (         )     8     N     S     m  !   |     �     �  
   �     �     �  6   �     '  N   7     �     �     �     �     �  <   �  
   '  $   2     W     `     z  *   �  k   �          )  P   8     �     �     �     �  	   �  5   �       !   +     M     Z  �   c  V   �     K     ^     l  	   {     �     �     �     �     �     �     �      �          +  �   F     �  -   �     ,  )   8  !   b  5   �  7   �  6   �  1   )  N   [  S   �  	   �               #     5     C     Q  P             2      H       #   %       	   -       ;           W          C      O       G   =   A   R                    0   E          S       M   1   '   5   !   /   
   3   *       L   V      @            ,   9           T      .             <   6       (   F      $               Q   Y           N   D                  7   X   B   8              J         >   )       U                                 "                 K          ?       &   :      I         4   +   Z   add_static_routes choose_action city country create_client_cert debug_current_platform department dialog_back_title easy-rsa_content easy-rsa_title email erase_server_cert exit first_run get_another_route_content get_another_route_title get_city_content get_city_title get_country_content get_country_title get_device_content get_device_title get_dns_content get_dns_title get_email_content get_email_title get_gateway_content get_gateway_title get_key_size_content get_key_size_title get_organization_content get_organization_title get_ou_content get_ou_title get_port_content get_port_title get_protocol_content get_protocol_title get_province_content get_province_title get_server_content get_server_net_content get_server_net_title get_server_title get_static_route_content get_static_route_title getopts_debug_enabled getopts_unknown_option key_size main_menu modify_server_config need_to_install not_root organization province server_cert_content server_cert_successful server_cert_title server_device server_gateway server_ip server_name server_pool server_port server_protocol server_routes unsupported_os_version unsupported_platform validate_content validate_title vpn_as_default_gateway welcome_content welcome_title wrong_city wrong_data_title wrong_dns_address wrong_email wrong_organization wrong_ou wrong_port wrong_province wrong_server_address wrong_server_net your_city your_dns your_email your_organization your_ou your_province your_server_name No, add some static routes Choose an action: City Country Create a client certificate Current platform:  Department (OU) VERITECH: OpenVPN TUI Administrator Setting easy-rsa environment:

 * Creating /etc/openvpn/easy-rsa
 * Copying easy-rsa
 * Backing up vars to ./data/backup Setting easy-rsa E-mail Erase and regenerate the server certificate Exit Executed for first time, setting up environment Do you want to add another static route? Another route? Enter your city name: City Select your country code: Select Country Select the type of device to use: Type of device Enter your DNS IP for clients DNS option Enter your e-mail: e-mail Is the VPN tunnel will be used as the default gateway? Default gateway Select your key size. Remember: The bigger, the stronger, but also the slowest Key size Enter your organization name: Organization Enter your Department (OU): Organizational Unit Enter a port number for your server to work, default is 1194 Enter Port Select the protocol you want to use: Protocol Enter your province name: Province Enter your FQDN server name or IP address: Enter the dynamic pool in the following notation (first-ip last-ip mask): 10.1.0.2 10.1.0.100 255.255.255.0 Server network Server address Enter a network for accepting traffic through the tunnel: 10.1.0.0 255.255.255.0 Static routes Debug enabled by user Unknown option given Key size Main Menu Modify the server configuration (No changes to certs) Dependencies needed, installing Not running with root permissions Organization Province Building server certificate:

 * Clean old certificates
 * Build new CA
 * Build new key server
 * Build Delfie Helman

This may take a while... Server certificate succesfully created, you can find it in: /etc/openvpn/easy-rsa/keys Server Certificate Server device Server Gateway Server IP Server name (IP) Server Pool Server Port Server protocol Server routes Unsupported OS Version Unsupported platform:  Please validate your information Data validation VPN as the default gateway Welcome to VERITECH a simple TUI OpenVPN administration tool.
This tool will:
 * Install
 * Configure
 * Manage
 an OpenVPN server from command line.

Do you want to continue? Welcome City name too short or special character used Wrong input Wrong DNS address, only IPv4 is supported Wrong email entered, please check Organization name too short or special character used Organizational Unit too short or special character used You entered a bad port, select a port from 1 to 65535. Pronvice name too short or special character used The server address you entered is wrong, please enter a FQDN or an IP address. Wrong server network notation, please use something like: 172.16.32.0 255.255.255.0 Your City your dns ip your@email.com Your Organization IT Department Your Province Your server name 