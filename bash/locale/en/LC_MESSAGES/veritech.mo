��    E      D  a   l     �     �                 
   5     @     R     c     r     x     �  	   �     �     �     �     �     �     �               )     B     Y     h     u     �     �     �     �     �     �     �          $     5     K     b     k     {     �     �     �     �     �     �     �     �     �     	     +	     <	     K	     [	  
   i	     t	     �	     �	     �	  
   �	     �	     �	     �	  	   �	  
   �	     
     
     
     *
     ;
     M
     R
     Z
     v
     �
  #   �
  x   �
     6     G  +   N     z  /        �     �     �     �     �       N        \     e     �     �     �  <   �  
   �  $        -     6     P  *   Y  ^   �     �     �               ,     5  !   U     w     �  �   �  V        u     �     �     �     �     �      �       �        �  -   �     �  !     5   (  7   ^  6   �  1   �  N   �  S   N  	   �     �     �     �     �     �      8   ?   ;   .             5          !               1   &   #      @              3      ,                  /         6   4       -   9   "       2   7                                   <      +            >   '   A   :             
      )      %   E   *                  	   $      0   (   B               D                  C   =                      choose_action city country create_client_cert debug_current_platform department dialog_back_title easy-rsa_content easy-rsa_title email erase_server_cert exit first_run get_city_content get_city_title get_country_content get_country_title get_email_content get_email_title get_key_size_content get_key_size_title get_organization_content get_organization_title get_ou_content get_ou_title get_port_content get_port_title get_protocol_content get_protocol_title get_province_content get_province_title get_server_content get_server_net_content get_server_net_title get_server_title getopts_debug_enabled getopts_unknown_option key_size need_to_install not_root organization province server_cert_content server_cert_successful server_cert_title server_name server_port server_protocol unsupported_os_version unsupported_platform validate_content validate_title welcome_content welcome_title wrong_city wrong_data_title wrong_email wrong_organization wrong_ou wrong_port wrong_province wrong_server_address wrong_server_net your_city your_email your_organization your_ou your_province your_server_name Choose an action: City Country Create a client certificate Current platform:  Department (OU) VERITECH: OpenVPN TUI Administrator Setting easy-rsa environment:

 * Creating /etc/openvpn/easy-rsa
 * Copying easy-rsa
 * Backing up vars to ./data/backup Setting easy-rsa E-mail Erase and regenerate the server certificate Exit Executed for first time, setting up environment Enter your city name: City Select your country code: Select Country Enter your e-mail: e-mail Select your key size. Remember: The bigger, the stronger, but also the slowest Key size Enter your organization name: Organization Enter your Department (OU): Organizational Unit Enter a port number for your server to work, default is 1194 Enter Port Select the protocol you want to use: Protocol Enter your province name: Province Enter your FQDN server name or IP address: Enter your server vpn network in the following notation (network mask): 10.1.0.0 255.255.255.0 Server network Server address Debug enabled by user Unknown option given Key size Dependencies needed, installing Not running with root permissions Organization Province Building server certificate:

 * Clean old certificates
 * Build new CA
 * Build new key server
 * Build Delfie Helman

This may take a while... Server certificate succesfully created, you can find it in: /etc/openvpn/easy-rsa/keys Server Certificate Server name (IP) Server Port Server protocol Unsupported OS Version Unsupported platform:  Please validate your information Data validation Welcome to VERITECH a simple TUI OpenVPN administration tool.
This tool will:
 * Install
 * Configure
 * Manage
 an OpenVPN server from command line.

Do you want to continue? Welcome City name too short or special character used Wrong input Wrong email entered, please check Organization name too short or special character used Organizational Unit too short or special character used You entered a bad port, select a port from 1 to 65535. Pronvice name too short or special character used The server address you entered is wrong, please enter a FQDN or an IP address. Wrong server network notation, please use something like: 172.16.32.0 255.255.255.0 Your City your@email.com Your Organization IT Department Your Province Your server name 