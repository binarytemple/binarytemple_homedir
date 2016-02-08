.PHONY: all help backup install
 
READLINK_OS:=$(shell readlink -f /usr/bin/java | sed -e 's|/jre/bin/java||' 2> /dev/null)
JAVA_HOME_HELPER:=$(shell /usr/libexec/java_home -v 1.8 2> /dev/null)

ifdef READLINK_OS
		JAVA_HOME=${READLINK_OS}
else
		JAVA_HOME=${JAVA_HOME_HELPER}
endif


IS_MD5_OSX:=$(shell echo test | md5 -q 2> /dev/null)


EXECUTION_START:=$(shell date +"%d-%m-%Y-%H-%M-%S")
SECURITY_DIR:="${JAVA_HOME}/jre/lib/security"
LOCAL_PATH:="UnlimitedJCEPolicyJDK8"
LOCAL_POLICY:="local_policy.jar"
US_EXPORT_POLICY:="US_export_policy.jar"

all: help

help:
		@echo "This makefile installs the JCE Policy files to your local Java 8 install."
		@echo "It backs up the existing files to the same directory, suffixed with the"
		@echo "MD5 checksum and timestamp."
		@echo "As the files are owned by root, your password will be required"
		@echo "run 'make install' in order to perform the backup and install"

backup:
		printf "\033[1;33;41mBacking up existing files,,, \033[0m\n"
ifdef IS_MD5_OSX
		for file in "${SECURITY_DIR}/${LOCAL_POLICY}" "${SECURITY_DIR}/${US_EXPORT_POLICY}" ; \
				do MD5=$$(md5 -q $${file}); sudo cp -v $${file} "$${file}-$${MD5}-${EXECUTION_START}" \
		; done
else
		for file in "${SECURITY_DIR}/${LOCAL_POLICY}" "${SECURITY_DIR}/${US_EXPORT_POLICY}" ; \
				do MD5=$$(md5sum --text $${file} | awk '{print $$1}' | tr -d '\n'); sudo cp -v $${file} "$${file}-$${MD5}-${EXECUTION_START}" \
		; done
endif

install: backup
		printf "\033[1;33;41mInstalling export strength JCE policy files... \033[0m\n"
		for file in "./${LOCAL_PATH}/${LOCAL_POLICY}" "./${LOCAL_PATH}/${US_EXPORT_POLICY}" ; \
        do sudo cp -v $${file} ${SECURITY_DIR} \
        ; done
