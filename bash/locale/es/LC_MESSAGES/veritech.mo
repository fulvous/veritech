��    F      L  a   |                          .  
   E     P     b     s     �     �     �  	   �     �     �     �     �     �               &     9     R     i     x     �     �     �     �     �     �     �               4     E     [     r  	   {     �     �     �     �     �     �     �     �     �     		     	     0	     E	     V	     e	     u	  
   �	     �	     �	     �	     �	  
   �	     �	     �	     �	  	   
  
   
     
     .
     6
     D
     U
     m
     t
     z
     �
     �
  6   �
  }   �
     r     �  ,   �     �  *   �     �       "   !     D     J     j  o   ~     �  &   �     &     4     R  >   h     �  #   �  	   �  "   �  	   �  9   	  d   C     �     �     �     �     �       (     !   G     i  	   w  �   �  ^   #     �     �     �     �      �        %        @  �   U  
   &  7   1     i  (   {  >   �  =   �  N   !  :   p  g   �  Q     	   e     o     |     �     �     �      9   @   <   /             6          !               2   &   #      A   E          4      -                  0         7   5       .   :   "       3   8                                   =      ,            ?   (   B   ;             
      *      %   F   +                  	   $      1   )   C               '                  D   >                      choose_action city country create_client_cert debug_current_platform department dialog_back_title easy-rsa_content easy-rsa_title email erase_server_cert exit first_run get_city_content get_city_title get_country_content get_country_title get_email_content get_email_title get_key_size_content get_key_size_title get_organization_content get_organization_title get_ou_content get_ou_title get_port_content get_port_title get_protocol_content get_protocol_title get_province_content get_province_title get_server_content get_server_net_content get_server_net_title get_server_title getopts_debug_enabled getopts_unknown_option key_size main_menu need_to_install not_root organization province server_cert_content server_cert_successful server_cert_title server_name server_port server_protocol unsupported_os_version unsupported_platform validate_content validate_title welcome_content welcome_title wrong_city wrong_data_title wrong_email wrong_organization wrong_ou wrong_port wrong_province wrong_server_address wrong_server_net your_city your_email your_organization your_ou your_province your_server_name Seleccione una acción: Ciudad País Crear certificado de cliente Plataforma actual:  Departamento (OU) VERITECH: Administrador gráfico en consola de OpenVPN Creando el ambiente para easy-rsa:

 * Creando /etc/openvpn/easy-rsa
 * Copiando easy-rsa
 * Respaldando vars a ./data/backup Configurando easy-rsa Correo electrónico Borrar y recrear el certificado del servidor Salir Primera ejecución, arreglando el ambiente Ingrese el nombre de su ciudad: Ciudad Seleccione el código de su país: País Ingrese su correo electrónico: Correo electrónico Seleccione el tamaño de llave. Recuerde: Mientras más grande la llave, más segura, pero también más lento. Tamaño de llave Ingrese el nombre de su organización: Organización Ingresa tu departamento (OU): Unidad Organizacional Ingresa el puerto que tu servidor usará, el estándar es 1194 Puerto Selecciona el protocolo a utilizar: Protocolo Ingrese el nombre de su Provincia: Provincia Ingresa el nombre FQDN o al dirección IP de tu servidor: Ingresa la red vpn de tu servidor, usa la siguiente notación (red máscara): 10.1.0.0 255.255.255.0 Red del servidor Dirección del servidor Usuario habilitó debug Opción desconocida Tamaño de llave Menú principal Hacen falta dependencias, se instalarán No tiene permisos de superusuario Organización Provincia Creando el certificado del servidor:

 * Borrando otros certificados
 * Creando CA
 * Creando llave del servidor
 * Creando Delfie Hellman

Esto puede demorar... Certificado de servidor creado exitosamente, puedes encontrarlo en: /etc/openvpn/easy-rsa/keys Certificado del servidor Nombre del servidor (IP) Puerto del servidor Protocolo del servidor Versión de sistema no soportada Plataforma no soportada:  Por favor valide los datos ingresados Validación de datos Bienvenido a VERITECH, un administrador sencillo para servidores OpenVPN.
Con Veritech podrás:
 * Instalar
 * Configurar
 * Administrar
 un servidor OpenVPN desde la línea de comandos.

¿Quieres continuar? Bienvenido Nombre de ciudad muy corto o con caractéres especiales Datos incorrectos Correo electrónico inválido, verifique Nombre de organización muy corto o con caractéres especiales Nombre de departamento muy corto o con caractéres especiales Ingresaste un puerto incorrecto, recuerda que puedes usar desde el 1 al 65535. Nombre de provincia muy corto o con caractéres especiales El nombre o la dirección IP de tu servidor es incorrecto, recuerda usar un FQDN o una dirección IPv4. Notación de red de servidor equivocada, usa algo como: 172.16.32.0 255.255.255.0 Su Ciudad mi@email.com Su organización Sistemas Su provincia Nombre de tu servidor 