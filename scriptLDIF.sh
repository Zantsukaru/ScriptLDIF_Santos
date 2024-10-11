#!/bin/bash

# VARIABLE DE CONTROL PARA EL BUCLE
opcion=0

# FUNCIÓN PARA GENERAR UN ARCHIVO LDIF DE UNIDADES ORGANIZATIVAS
generar_ou_ldif() {
    echo "Ingrese el nombre del archivo .ldif (sin la extensión):"
    read archivo_ou
    archivo_ou="${archivo_ou}.ldif"

    echo "Ingrese el nombre del Dominio Base (ej: dc=ejemplo,dc=com):"
    read dominio_base

    echo "¿Cuántas Unidades Organizativas desea crear?"
    read cantidad_ou

    echo "Creando archivo $archivo_ou para Unidades Organizativas..."
    echo "" > "$archivo_ou"  # Crear archivo vacío

    for ((i=1; i<=cantidad_ou; i++)); do
        echo "Ingrese el nombre de la Unidad Organizativa $i:"
        read ou_nombre

        echo "dn: ou=$ou_nombre,$dominio_base" >> "$archivo_ou"
        echo "objectClass: organizationalUnit" >> "$archivo_ou"
        echo "ou: $ou_nombre" >> "$archivo_ou"
        echo "" >> "$archivo_ou"
    done

    echo "Archivo $archivo_ou generado exitosamente."
}

# FUNCIÓN PARA GENERAR UN ARCHIVO LDIF DE GRUPOS
generar_grupos_ldif() {
    echo "Ingrese el nombre del archivo .ldif (sin la extensión):"
    read archivo_grupo
    archivo_grupo="${archivo_grupo}.ldif"

    echo "Ingrese el nombre del Dominio Base (ej: dc=ejemplo,dc=com):"
    read dominio_base

    echo "¿Cuántos Grupos desea crear?"
    read cantidad_grupos

    echo "Creando archivo $archivo_grupo para Grupos..."
    echo "" > "$archivo_grupo"  # Crear archivo vacío

    for ((i=1; i<=cantidad_grupos; i++)); do
        echo "Ingrese el nombre del Grupo $i:"
        read grupo_nombre

        echo "dn: cn=$grupo_nombre,$dominio_base" >> "$archivo_grupo"
        echo "objectClass: posixGroup" >> "$archivo_grupo"
        echo "cn: $grupo_nombre" >> "$archivo_grupo"
        echo "gidNumber: $((10000 + i))" >> "$archivo_grupo"
        echo "" >> "$archivo_grupo"
    done

    echo "Archivo $archivo_grupo generado exitosamente."
}

# FUNCIÓN PARA GENERAR UN ARCHIVO LDIF DE USUARIOS
generar_usuarios_ldif() {
    echo "Ingrese el nombre del archivo .ldif (sin la extensión):"
    read archivo_usuario
    archivo_usuario="${archivo_usuario}.ldif"

    echo "Ingrese el nombre del Dominio Base (ej: dc=ejemplo,dc=com):"
    read dominio_base

    echo "¿Cuántos Usuarios desea crear?"
    read cantidad_usuarios

    echo "Creando archivo $archivo_usuario para Usuarios..."
    echo "" > "$archivo_usuario"  # Crear archivo vacío

    for ((i=1; i<=cantidad_usuarios; i++)); do
        echo "Ingrese el nombre del Usuario $i (uid):"
        read usuario_uid

        echo "Ingrese el nombre común (cn) del Usuario $i:"
        read usuario_cn

        echo "Ingrese el apellido (sn) del Usuario $i:"
        read usuario_sn

        echo "dn: uid=$usuario_uid,$dominio_base" >> "$archivo_usuario"
        echo "objectClass: inetOrgPerson" >> "$archivo_usuario"
        echo "objectClass: top" >> "$archivo_usuario"
        echo "uid: $usuario_uid" >> "$archivo_usuario"
        echo "cn: $usuario_cn" >> "$archivo_usuario"
        echo "sn: $usuario_sn" >> "$archivo_usuario"
        echo "" >> "$archivo_usuario"
    done

    echo "Archivo $archivo_usuario generado exitosamente."
}

# Menú principal
while [ "$opcion" -ne 4]; do
    echo "----- MENÚ PRINCIPAL GENERADOR DE FICHEROS LDIF-----"
    echo "1. Crear Unidades Organizativas"
    echo "2. Crear Grupos"
    echo "3. Crear Usuarios"
    echo "4. Salir"
    echo "Seleccione una opción (1-4):"
    read opcion

    case $opcion in
        1)
            generar_ou_ldif
            ;;
        2)
            generar_grupos_ldif
            ;;
        3)
            generar_usuarios_ldif
            ;;
        4)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, seleccione una opción entre 1 y 4."
            ;;
    esac
done
