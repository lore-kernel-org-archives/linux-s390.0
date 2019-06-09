Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 26/33] docs: s390: convert docs to ReST and rename to *.rst
Date: Sat,  8 Jun 2019 23:27:16 -0300
Message-Id: <b210921b088cd4ae898c102e08663d50f1206267.1560045490.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

Convert all text files with s390 documentation to ReST format.

Tried to preserve as much as possible the original document
format. Still, some of the files required some work in order
for it to be visible on both plain text and after converted
to html.

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |    4 +-
 Documentation/driver-api/s390-drivers.rst     |    4 +-
 Documentation/s390/{3270.txt => 3270.rst}     |   85 +-
 Documentation/s390/{cds.txt => cds.rst}       |  354 ++-
 .../s390/{CommonIO => common_io.rst}          |   49 +-
 Documentation/s390/{DASD => dasd.rst}         |   33 +-
 .../{Debugging390.txt => debugging390.rst}    | 2389 ++++++++++-------
 .../{driver-model.txt => driver-model.rst}    |  179 +-
 Documentation/s390/index.rst                  |   30 +
 .../s390/{monreader.txt => monreader.rst}     |   85 +-
 Documentation/s390/{qeth.txt => qeth.rst}     |   36 +-
 .../s390/{s390dbf.txt => s390dbf.rst}         |  798 +++---
 Documentation/s390/text_files.rst             |   11 +
 .../s390/{vfio-ap.txt => vfio-ap.rst}         |  487 ++--
 .../s390/{vfio-ccw.txt => vfio-ccw.rst}       |   90 +-
 .../s390/{zfcpdump.txt => zfcpdump.rst}       |    2 +
 MAINTAINERS                                   |    4 +-
 arch/s390/Kconfig                             |    4 +-
 arch/s390/include/asm/debug.h                 |    4 +-
 drivers/s390/char/zcore.c                     |    2 +-
 20 files changed, 2753 insertions(+), 1897 deletions(-)
 rename Documentation/s390/{3270.txt => 3270.rst} (90%)
 rename Documentation/s390/{cds.txt => cds.rst} (64%)
 rename Documentation/s390/{CommonIO => common_io.rst} (87%)
 rename Documentation/s390/{DASD => dasd.rst} (92%)
 rename Documentation/s390/{Debugging390.txt => debugging390.rst} (53%)
 rename Documentation/s390/{driver-model.txt => driver-model.rst} (73%)
 create mode 100644 Documentation/s390/index.rst
 rename Documentation/s390/{monreader.txt => monreader.rst} (81%)
 rename Documentation/s390/{qeth.txt => qeth.rst} (62%)
 rename Documentation/s390/{s390dbf.txt => s390dbf.rst} (43%)
 create mode 100644 Documentation/s390/text_files.rst
 rename Documentation/s390/{vfio-ap.txt => vfio-ap.rst} (72%)
 rename Documentation/s390/{vfio-ccw.txt => vfio-ccw.rst} (89%)
 rename Documentation/s390/{zfcpdump.txt => zfcpdump.rst} (97%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index df96a896fafa..0092a453f7dc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -478,7 +478,7 @@
 			others).
 
 	ccw_timeout_log	[S390]
-			See Documentation/s390/CommonIO for details.
+			See Documentation/s390/common_io.rst for details.
 
 	cgroup_disable=	[KNL] Disable a particular controller
 			Format: {name of the controller(s) to disable}
@@ -516,7 +516,7 @@
 				/selinux/checkreqprot.
 
 	cio_ignore=	[S390]
-			See Documentation/s390/CommonIO for details.
+			See Documentation/s390/common_io.rst for details.
 	clk_ignore_unused
 			[CLK]
 			Prevents the clock framework from automatically gating
diff --git a/Documentation/driver-api/s390-drivers.rst b/Documentation/driver-api/s390-drivers.rst
index 30e6aa7e160b..5158577bc29b 100644
--- a/Documentation/driver-api/s390-drivers.rst
+++ b/Documentation/driver-api/s390-drivers.rst
@@ -27,7 +27,7 @@ not strictly considered I/O devices. They are considered here as well,
 although they are not the focus of this document.
 
 Some additional information can also be found in the kernel source under
-Documentation/s390/driver-model.txt.
+Documentation/s390/driver-model.rst.
 
 The css bus
 ===========
@@ -38,7 +38,7 @@ into several categories:
 * Standard I/O subchannels, for use by the system. They have a child
   device on the ccw bus and are described below.
 * I/O subchannels bound to the vfio-ccw driver. See
-  Documentation/s390/vfio-ccw.txt.
+  Documentation/s390/vfio-ccw.rst.
 * Message subchannels. No Linux driver currently exists.
 * CHSC subchannels (at most one). The chsc subchannel driver can be used
   to send asynchronous chsc commands.
diff --git a/Documentation/s390/3270.txt b/Documentation/s390/3270.rst
similarity index 90%
rename from Documentation/s390/3270.txt
rename to Documentation/s390/3270.rst
index 7c715de99774..e09e77954238 100644
--- a/Documentation/s390/3270.txt
+++ b/Documentation/s390/3270.rst
@@ -1,13 +1,17 @@
+===============================
 IBM 3270 Display System support
+===============================
 
 This file describes the driver that supports local channel attachment
 of IBM 3270 devices.  It consists of three sections:
+
 	* Introduction
 	* Installation
 	* Operation
 
 
-INTRODUCTION.
+Introduction
+============
 
 This paper describes installing and operating 3270 devices under
 Linux/390.  A 3270 device is a block-mode rows-and-columns terminal of
@@ -17,12 +21,12 @@ twenty and thirty years ago.
 You may have 3270s in-house and not know it.  If you're using the
 VM-ESA operating system, define a 3270 to your virtual machine by using
 the command "DEF GRAF <hex-address>"  This paper presumes you will be
-defining four 3270s with the CP/CMS commands
+defining four 3270s with the CP/CMS commands:
 
-	DEF GRAF 620
-	DEF GRAF 621
-	DEF GRAF 622
-	DEF GRAF 623
+	- DEF GRAF 620
+	- DEF GRAF 621
+	- DEF GRAF 622
+	- DEF GRAF 623
 
 Your network connection from VM-ESA allows you to use x3270, tn3270, or
 another 3270 emulator, started from an xterm window on your PC or
@@ -34,7 +38,8 @@ This paper covers installation of the driver and operation of a
 dialed-in x3270.
 
 
-INSTALLATION.
+Installation
+============
 
 You install the driver by installing a patch, doing a kernel build, and
 running the configuration script (config3270.sh, in this directory).
@@ -59,13 +64,15 @@ Use #CP TERM CONMODE 3270 to change it to 3270.  If you generate only
 at boot time to a 3270 if it is a 3215.
 
 In brief, these are the steps:
+
 	1. Install the tub3270 patch
-	2. (If a module) add a line to a file in /etc/modprobe.d/*.conf
+	2. (If a module) add a line to a file in `/etc/modprobe.d/*.conf`
 	3. (If VM) define devices with DEF GRAF
 	4. Reboot
 	5. Configure
 
 To test that everything works, assuming VM and x3270,
+
 	1. Bring up an x3270 window.
 	2. Use the DIAL command in that window.
 	3. You should immediately see a Linux login screen.
@@ -74,7 +81,8 @@ Here are the installation steps in detail:
 
 	1.  The 3270 driver is a part of the official Linux kernel
 	source.  Build a tree with the kernel source and any necessary
-	patches.  Then do
+	patches.  Then do::
+
 		make oldconfig
 		(If you wish to disable 3215 console support, edit
 		.config; change CONFIG_TN3215's value to "n";
@@ -84,20 +92,22 @@ Here are the installation steps in detail:
 		make modules_install
 
 	2. (Perform this step only if you have configured tub3270 as a
-	module.)  Add a line to a file /etc/modprobe.d/*.conf to automatically
+	module.)  Add a line to a file `/etc/modprobe.d/*.conf` to automatically
 	load the driver when it's needed.  With this line added, you will see
 	login prompts appear on your 3270s as soon as boot is complete (or
 	with emulated 3270s, as soon as you dial into your vm guest using the
 	command "DIAL <vmguestname>").  Since the line-mode major number is
-	227, the line to add should be:
+	227, the line to add should be::
+
 		alias char-major-227 tub3270
 
 	3. Define graphic devices to your vm guest machine, if you
 	haven't already.  Define them before you reboot (reipl):
-		DEFINE GRAF 620
-		DEFINE GRAF 621
-		DEFINE GRAF 622
-		DEFINE GRAF 623
+
+		- DEFINE GRAF 620
+		- DEFINE GRAF 621
+		- DEFINE GRAF 622
+		- DEFINE GRAF 623
 
 	4. Reboot.  The reboot process scans hardware devices, including
 	3270s, and this enables the tub3270 driver once loaded to respond
@@ -107,21 +117,23 @@ Here are the installation steps in detail:
 
 	5. Run the 3270 configuration script config3270.  It is
 	distributed in this same directory, Documentation/s390, as
-	config3270.sh.	Inspect the output script it produces,
+	config3270.sh.  Inspect the output script it produces,
 	/tmp/mkdev3270, and then run that script.  This will create the
 	necessary character special device files and make the necessary
 	changes to /etc/inittab.
 
 	Then notify /sbin/init that /etc/inittab has changed, by issuing
-	the telinit command with the q operand:
+	the telinit command with the q operand::
+
 		cd Documentation/s390
 		sh config3270.sh
 		sh /tmp/mkdev3270
 		telinit q
 
-	This should be sufficient for your first time.	If your 3270
+	This should be sufficient for your first time.  If your 3270
 	configuration has changed and you're reusing config3270, you
-	should follow these steps:
+	should follow these steps::
+
 		Change 3270 configuration
 		Reboot
 		Run config3270 and /tmp/mkdev3270
@@ -132,8 +144,10 @@ Here are the testing steps in detail:
 	1. Bring up an x3270 window, or use an actual hardware 3278 or
 	3279, or use the 3270 emulator of your choice.  You would be
 	running the emulator on your PC or workstation.  You would use
-	the command, for example,
+	the command, for example::
+
 		x3270 vm-esa-domain-name &
+
 	if you wanted a 3278 Model 4 with 43 rows of 80 columns, the
 	default model number.  The driver does not take advantage of
 	extended attributes.
@@ -144,7 +158,8 @@ Here are the testing steps in detail:
 
 	2. Use the DIAL command instead of the LOGIN command to connect
 	to one of the virtual 3270s you defined with the DEF GRAF
-	commands:
+	commands::
+
 		dial my-vm-guest-name
 
 	3. You should immediately see a login prompt from your
@@ -171,14 +186,17 @@ Here are the testing steps in detail:
 	Wrong major number?  Wrong minor number?  There's your
 	problem!
 
-	D. Do you get the message
+	D. Do you get the message::
+
 		 "HCPDIA047E my-vm-guest-name 0620 does not exist"?
+
 	If so, you must issue the command "DEF GRAF 620" from your VM
 	3215 console and then reboot the system.
 
 
 
 OPERATION.
+==========
 
 The driver defines three areas on the 3270 screen:  the log area, the
 input area, and the status area.
@@ -203,8 +221,10 @@ which indicates no scrolling will occur.  (If you hit ENTER with "Linux
 Running" and nothing typed, the application receives a newline.)
 
 You may change the scrolling timeout value.  For example, the following
-command line:
+command line::
+
 	echo scrolltime=60 > /proc/tty/driver/tty3270
+
 changes the scrolling timeout value to 60 sec.  Set scrolltime to 0 if
 you wish to prevent scrolling entirely.
 
@@ -228,7 +248,8 @@ cause an EOF also by typing "^D" and hitting ENTER.
 No PF key is preassigned to cause a job suspension, but you may cause a
 job suspension by typing "^Z" and hitting ENTER.  You may wish to
 assign this function to a PF key.  To make PF7 cause job suspension,
-execute the command:
+execute the command::
+
 	echo pf7=^z > /proc/tty/driver/tty3270
 
 If the input you type does not end with the two characters "^n", the
@@ -243,8 +264,10 @@ command is entered into the stack only when the input area is not made
 invisible (such as for password entry) and it is not identical to the
 current top entry.  PF10 rotates backward through the command stack;
 PF11 rotates forward.  You may assign the backward function to any PF
-key (or PA key, for that matter), say, PA3, with the command:
+key (or PA key, for that matter), say, PA3, with the command::
+
 	echo -e pa3=\\033k > /proc/tty/driver/tty3270
+
 This assigns the string ESC-k to PA3.  Similarly, the string ESC-j
 performs the forward function.  (Rationale:  In bash with vi-mode line
 editing, ESC-k and ESC-j retrieve backward and forward history.
@@ -252,15 +275,19 @@ Suggestions welcome.)
 
 Is a stack size of twenty commands not to your liking?  Change it on
 the fly.  To change to saving the last 100 commands, execute the
-command:
+command::
+
 	echo recallsize=100 > /proc/tty/driver/tty3270
 
 Have a command you issue frequently?  Assign it to a PF or PA key!  Use
-the command
-	echo pf24="mkdir foobar; cd foobar" > /proc/tty/driver/tty3270 
+the command::
+
+	echo pf24="mkdir foobar; cd foobar" > /proc/tty/driver/tty3270
+
 to execute the commands mkdir foobar and cd foobar immediately when you
 hit PF24.  Want to see the command line first, before you execute it?
-Use the -n option of the echo command:
+Use the -n option of the echo command::
+
 	echo -n pf24="mkdir foo; cd foo" > /proc/tty/driver/tty3270
 
 
diff --git a/Documentation/s390/cds.txt b/Documentation/s390/cds.rst
similarity index 64%
rename from Documentation/s390/cds.txt
rename to Documentation/s390/cds.rst
index 480a78ef5a1e..7006d8209d2e 100644
--- a/Documentation/s390/cds.txt
+++ b/Documentation/s390/cds.rst
@@ -1,14 +1,18 @@
+===========================
 Linux for S/390 and zSeries
+===========================
 
 Common Device Support (CDS)
 Device Driver I/O Support Routines
 
-Authors : Ingo Adlung
-	  Cornelia Huck
+Authors:
+	- Ingo Adlung
+	- Cornelia Huck
 
 Copyright, IBM Corp. 1999-2002
 
 Introduction
+============
 
 This document describes the common device support routines for Linux/390.
 Different than other hardware architectures, ESA/390 has defined a unified
@@ -27,18 +31,20 @@ Operation manual (IBM Form. No. SA22-7201).
 
 In order to build common device support for ESA/390 I/O interfaces, a
 functional layer was introduced that provides generic I/O access methods to
-the hardware. 
+the hardware.
 
-The common device support layer comprises the I/O support routines defined 
-below. Some of them implement common Linux device driver interfaces, while 
+The common device support layer comprises the I/O support routines defined
+below. Some of them implement common Linux device driver interfaces, while
 some of them are ESA/390 platform specific.
 
 Note:
-In order to write a driver for S/390, you also need to look into the interface
-described in Documentation/s390/driver-model.txt.
+  In order to write a driver for S/390, you also need to look into the interface
+  described in Documentation/s390/driver-model.rst.
 
 Note for porting drivers from 2.4:
+
 The major changes are:
+
 * The functions use a ccw_device instead of an irq (subchannel).
 * All drivers must define a ccw_driver (see driver-model.txt) and the associated
   functions.
@@ -57,19 +63,16 @@ The major changes are:
 ccw_device_get_ciw()
    get commands from extended sense data.
 
-ccw_device_start()	
-ccw_device_start_timeout()
-ccw_device_start_key()
-ccw_device_start_key_timeout()
+ccw_device_start(), ccw_device_start_timeout(), ccw_device_start_key(), ccw_device_start_key_timeout()
    initiate an I/O request.
 
 ccw_device_resume()
    resume channel program execution.
 
-ccw_device_halt()	
+ccw_device_halt()
    terminate the current I/O request processed on the device.
 
-do_IRQ()	
+do_IRQ()
    generic interrupt routine. This function is called by the interrupt entry
    routine whenever an I/O interrupt is presented to the system. The do_IRQ()
    routine determines the interrupt status and calls the device specific
@@ -82,12 +85,15 @@ first level interrupt handler only and does not comprise a device driver
 callable interface. Instead, the functional description of do_IO() also
 describes the input to the device specific interrupt handler.
 
-Note: All explanations apply also to the 64 bit architecture s390x.
+Note:
+	All explanations apply also to the 64 bit architecture s390x.
 
 
 Common Device Support (CDS) for Linux/390 Device Drivers
+========================================================
 
 General Information
+-------------------
 
 The following chapters describe the I/O related interface routines the
 Linux/390 common device support (CDS) provides to allow for device specific
@@ -101,6 +107,7 @@ can be found in the architecture specific C header file
 linux/arch/s390/include/asm/irq.h.
 
 Overview of CDS interface concepts
+----------------------------------
 
 Different to other hardware platforms, the ESA/390 architecture doesn't define
 interrupt lines managed by a specific interrupt controller and bus systems
@@ -126,7 +133,7 @@ has to call every single device driver registered on this IRQ in order to
 determine the device driver owning the device that raised the interrupt.
 
 Up to kernel 2.4, Linux/390 used to provide interfaces via the IRQ (subchannel).
-For internal use of the common I/O layer, these are still there. However, 
+For internal use of the common I/O layer, these are still there. However,
 device drivers should use the new calling interface via the ccw_device only.
 
 During its startup the Linux/390 system checks for peripheral devices. Each
@@ -134,7 +141,7 @@ of those devices is uniquely defined by a so called subchannel by the ESA/390
 channel subsystem. While the subchannel numbers are system generated, each
 subchannel also takes a user defined attribute, the so called device number.
 Both subchannel number and device number cannot exceed 65535. During sysfs
-initialisation, the information about control unit type and device types that 
+initialisation, the information about control unit type and device types that
 imply specific I/O commands (channel command words - CCWs) in order to operate
 the device are gathered. Device drivers can retrieve this set of hardware
 information during their initialization step to recognize the devices they
@@ -164,18 +171,26 @@ get_ciw() - get command information word
 This call enables a device driver to get information about supported commands
 from the extended SenseID data.
 
-struct ciw *
-ccw_device_get_ciw(struct ccw_device *cdev, __u32 cmd);
+::
 
-cdev - The ccw_device for which the command is to be retrieved.
-cmd  - The command type to be retrieved.
+  struct ciw *
+  ccw_device_get_ciw(struct ccw_device *cdev, __u32 cmd);
+
+====  ========================================================
+cdev  The ccw_device for which the command is to be retrieved.
+cmd   The command type to be retrieved.
+====  ========================================================
 
 ccw_device_get_ciw() returns:
-NULL    - No extended data available, invalid device or command not found.
-!NULL   - The command requested.
 
+=====  ================================================================
+ NULL  No extended data available, invalid device or command not found.
+!NULL  The command requested.
+=====  ================================================================
 
-ccw_device_start() - Initiate I/O Request
+::
+
+  ccw_device_start() - Initiate I/O Request
 
 The ccw_device_start() routines is the I/O request front-end processor. All
 device driver I/O requests must be issued using this routine. A device driver
@@ -186,93 +201,105 @@ This description also covers the status information passed to the device
 driver's interrupt handler as this is related to the rules (flags) defined
 with the associated I/O request when calling ccw_device_start().
 
-int ccw_device_start(struct ccw_device *cdev,
-		     struct ccw1 *cpa,
-		     unsigned long intparm,
-		     __u8 lpm,
-		     unsigned long flags);
-int ccw_device_start_timeout(struct ccw_device *cdev,
-			     struct ccw1 *cpa,
-			     unsigned long intparm,
-			     __u8 lpm,
-			     unsigned long flags,
-			     int expires);
-int ccw_device_start_key(struct ccw_device *cdev,
-			 struct ccw1 *cpa,
-			 unsigned long intparm,
-			 __u8 lpm,
-			 __u8 key,
-			 unsigned long flags);
-int ccw_device_start_key_timeout(struct ccw_device *cdev,
-				 struct ccw1 *cpa,
-				 unsigned long intparm,
-				 __u8 lpm,
-				 __u8 key,
-				 unsigned long flags,
-				 int expires);
+::
 
-cdev         : ccw_device the I/O is destined for
-cpa          : logical start address of channel program
-user_intparm : user specific interrupt information; will be presented
-	       back to the device driver's interrupt handler. Allows a
-               device driver to associate the interrupt with a
-               particular I/O request.
-lpm          : defines the channel path to be used for a specific I/O
-               request. A value of 0 will make cio use the opm.
-key	     : the storage key to use for the I/O (useful for operating on a
-	       storage with a storage key != default key)
-flag         : defines the action to be performed for I/O processing
-expires      : timeout value in jiffies. The common I/O layer will terminate
-	       the running program after this and call the interrupt handler
-	       with ERR_PTR(-ETIMEDOUT) as irb.
+  int ccw_device_start(struct ccw_device *cdev,
+		       struct ccw1 *cpa,
+		       unsigned long intparm,
+		       __u8 lpm,
+		       unsigned long flags);
+  int ccw_device_start_timeout(struct ccw_device *cdev,
+			       struct ccw1 *cpa,
+			       unsigned long intparm,
+			       __u8 lpm,
+			       unsigned long flags,
+			       int expires);
+  int ccw_device_start_key(struct ccw_device *cdev,
+			   struct ccw1 *cpa,
+			   unsigned long intparm,
+			   __u8 lpm,
+			   __u8 key,
+			   unsigned long flags);
+  int ccw_device_start_key_timeout(struct ccw_device *cdev,
+				   struct ccw1 *cpa,
+				   unsigned long intparm,
+				   __u8 lpm,
+				   __u8 key,
+				   unsigned long flags,
+				   int expires);
 
-Possible flag values are :
+============= =============================================================
+cdev          ccw_device the I/O is destined for
+cpa           logical start address of channel program
+user_intparm  user specific interrupt information; will be presented
+	      back to the device driver's interrupt handler. Allows a
+	      device driver to associate the interrupt with a
+	      particular I/O request.
+lpm           defines the channel path to be used for a specific I/O
+	      request. A value of 0 will make cio use the opm.
+key           the storage key to use for the I/O (useful for operating on a
+	      storage with a storage key != default key)
+flag          defines the action to be performed for I/O processing
+expires       timeout value in jiffies. The common I/O layer will terminate
+	      the running program after this and call the interrupt handler
+	      with ERR_PTR(-ETIMEDOUT) as irb.
+============= =============================================================
 
-DOIO_ALLOW_SUSPEND       - channel program may become suspended
-DOIO_DENY_PREFETCH       - don't allow for CCW prefetch; usually
-                           this implies the channel program might
-                           become modified
-DOIO_SUPPRESS_INTER     - don't call the handler on intermediate status
+Possible flag values are:
 
-The cpa parameter points to the first format 1 CCW of a channel program :
+========================= =============================================
+DOIO_ALLOW_SUSPEND        channel program may become suspended
+DOIO_DENY_PREFETCH        don't allow for CCW prefetch; usually
+			  this implies the channel program might
+			  become modified
+DOIO_SUPPRESS_INTER       don't call the handler on intermediate status
+========================= =============================================
 
-struct ccw1 {
-      __u8  cmd_code;/* command code */
-      __u8  flags;   /* flags, like IDA addressing, etc. */
-      __u16 count;   /* byte count */
-      __u32 cda;     /* data address */
-} __attribute__ ((packed,aligned(8)));
+The cpa parameter points to the first format 1 CCW of a channel program::
 
-with the following CCW flags values defined :
+  struct ccw1 {
+	__u8  cmd_code;/* command code */
+	__u8  flags;   /* flags, like IDA addressing, etc. */
+	__u16 count;   /* byte count */
+	__u32 cda;     /* data address */
+  } __attribute__ ((packed,aligned(8)));
 
-CCW_FLAG_DC        - data chaining
-CCW_FLAG_CC        - command chaining
-CCW_FLAG_SLI       - suppress incorrect length
-CCW_FLAG_SKIP      - skip
-CCW_FLAG_PCI       - PCI
-CCW_FLAG_IDA       - indirect addressing
-CCW_FLAG_SUSPEND   - suspend
+with the following CCW flags values defined:
+
+=================== =========================
+CCW_FLAG_DC         data chaining
+CCW_FLAG_CC         command chaining
+CCW_FLAG_SLI        suppress incorrect length
+CCW_FLAG_SKIP       skip
+CCW_FLAG_PCI        PCI
+CCW_FLAG_IDA        indirect addressing
+CCW_FLAG_SUSPEND    suspend
+=================== =========================
 
 
 Via ccw_device_set_options(), the device driver may specify the following
 options for the device:
 
-DOIO_EARLY_NOTIFICATION  - allow for early interrupt notification
-DOIO_REPORT_ALL          - report all interrupt conditions
+========================= ======================================
+DOIO_EARLY_NOTIFICATION   allow for early interrupt notification
+DOIO_REPORT_ALL           report all interrupt conditions
+========================= ======================================
 
 
-The ccw_device_start() function returns :
+The ccw_device_start() function returns:
 
-      0 - successful completion or request successfully initiated
--EBUSY	- The device is currently processing a previous I/O request, or there is
-          a status pending at the device.
--ENODEV - cdev is invalid, the device is not operational or the ccw_device is
-          not online.
+======== ======================================================================
+      0  successful completion or request successfully initiated
+ -EBUSY  The device is currently processing a previous I/O request, or there is
+	 a status pending at the device.
+-ENODEV  cdev is invalid, the device is not operational or the ccw_device is
+	 not online.
+======== ======================================================================
 
 When the I/O request completes, the CDS first level interrupt handler will
 accumulate the status in a struct irb and then call the device interrupt handler.
-The intparm field will contain the value the device driver has associated with a 
-particular I/O request. If a pending device status was recognized, 
+The intparm field will contain the value the device driver has associated with a
+particular I/O request. If a pending device status was recognized,
 intparm will be set to 0 (zero). This may happen during I/O initiation or delayed
 by an alert status notification. In any case this status is not related to the
 current (last) I/O request. In case of a delayed status notification no special
@@ -282,9 +309,11 @@ never started, even though ccw_device_start() returned with successful completio
 The irb may contain an error value, and the device driver should check for this
 first:
 
--ETIMEDOUT: the common I/O layer terminated the request after the specified
-            timeout value
--EIO:       the common I/O layer terminated the request due to an error state
+========== =================================================================
+-ETIMEDOUT the common I/O layer terminated the request after the specified
+	   timeout value
+-EIO       the common I/O layer terminated the request due to an error state
+========== =================================================================
 
 If the concurrent sense flag in the extended status word (esw) in the irb is
 set, the field erw.scnt in the esw describes the number of device specific
@@ -294,6 +323,7 @@ sensing by the device driver itself is required.
 The device interrupt handler can use the following definitions to investigate
 the primary unit check source coded in sense byte 0 :
 
+======================= ====
 SNS0_CMD_REJECT         0x80
 SNS0_INTERVENTION_REQ   0x40
 SNS0_BUS_OUT_CHECK      0x20
@@ -301,36 +331,41 @@ SNS0_EQUIPMENT_CHECK    0x10
 SNS0_DATA_CHECK         0x08
 SNS0_OVERRUN            0x04
 SNS0_INCOMPL_DOMAIN     0x01
+======================= ====
 
 Depending on the device status, multiple of those values may be set together.
 Please refer to the device specific documentation for details.
 
 The irb->scsw.cstat field provides the (accumulated) subchannel status :
 
-SCHN_STAT_PCI            - program controlled interrupt
-SCHN_STAT_INCORR_LEN     - incorrect length
-SCHN_STAT_PROG_CHECK     - program check
-SCHN_STAT_PROT_CHECK     - protection check
-SCHN_STAT_CHN_DATA_CHK   - channel data check
-SCHN_STAT_CHN_CTRL_CHK   - channel control check
-SCHN_STAT_INTF_CTRL_CHK  - interface control check
-SCHN_STAT_CHAIN_CHECK    - chaining check
+========================= ============================
+SCHN_STAT_PCI             program controlled interrupt
+SCHN_STAT_INCORR_LEN      incorrect length
+SCHN_STAT_PROG_CHECK      program check
+SCHN_STAT_PROT_CHECK      protection check
+SCHN_STAT_CHN_DATA_CHK    channel data check
+SCHN_STAT_CHN_CTRL_CHK    channel control check
+SCHN_STAT_INTF_CTRL_CHK   interface control check
+SCHN_STAT_CHAIN_CHECK     chaining check
+========================= ============================
 
 The irb->scsw.dstat field provides the (accumulated) device status :
 
-DEV_STAT_ATTENTION   - attention
-DEV_STAT_STAT_MOD    - status modifier
-DEV_STAT_CU_END      - control unit end
-DEV_STAT_BUSY        - busy
-DEV_STAT_CHN_END     - channel end
-DEV_STAT_DEV_END     - device end
-DEV_STAT_UNIT_CHECK  - unit check
-DEV_STAT_UNIT_EXCEP  - unit exception
+===================== =================
+DEV_STAT_ATTENTION    attention
+DEV_STAT_STAT_MOD     status modifier
+DEV_STAT_CU_END       control unit end
+DEV_STAT_BUSY         busy
+DEV_STAT_CHN_END      channel end
+DEV_STAT_DEV_END      device end
+DEV_STAT_UNIT_CHECK   unit check
+DEV_STAT_UNIT_EXCEP   unit exception
+===================== =================
 
 Please see the ESA/390 Principles of Operation manual for details on the
 individual flag meanings.
 
-Usage Notes :
+Usage Notes:
 
 ccw_device_start() must be called disabled and with the ccw device lock held.
 
@@ -374,32 +409,39 @@ secondary status without error (alert status) is presented, this indicates
 successful completion for all overlapping ccw_device_start() requests that have
 been issued since the last secondary (final) status.
 
-Channel programs that intend to set the suspend flag on a channel command word 
-(CCW)  must start the I/O operation with the DOIO_ALLOW_SUSPEND option or the 
-suspend flag will cause a channel program check. At the time the channel program 
-becomes suspended an intermediate interrupt will be generated by the channel 
+Channel programs that intend to set the suspend flag on a channel command word
+(CCW)  must start the I/O operation with the DOIO_ALLOW_SUSPEND option or the
+suspend flag will cause a channel program check. At the time the channel program
+becomes suspended an intermediate interrupt will be generated by the channel
 subsystem.
 
-ccw_device_resume() - Resume Channel Program Execution 
+ccw_device_resume() - Resume Channel Program Execution
 
-If a device driver chooses to suspend the current channel program execution by 
-setting the CCW suspend flag on a particular CCW, the channel program execution 
-is suspended. In order to resume channel program execution the CIO layer 
-provides the ccw_device_resume() routine. 
+If a device driver chooses to suspend the current channel program execution by
+setting the CCW suspend flag on a particular CCW, the channel program execution
+is suspended. In order to resume channel program execution the CIO layer
+provides the ccw_device_resume() routine.
 
-int ccw_device_resume(struct ccw_device *cdev);
+::
 
-cdev - ccw_device the resume operation is requested for
+  int ccw_device_resume(struct ccw_device *cdev);
+
+====  ================================================
+cdev  ccw_device the resume operation is requested for
+====  ================================================
 
 The ccw_device_resume() function returns:
 
-        0  - suspended channel program is resumed
--EBUSY     - status pending
--ENODEV    - cdev invalid or not-operational subchannel 
--EINVAL    - resume function not applicable  
--ENOTCONN  - there is no I/O request pending for completion 
+=========   ==============================================
+	0   suspended channel program is resumed
+   -EBUSY   status pending
+  -ENODEV   cdev invalid or not-operational subchannel
+  -EINVAL   resume function not applicable
+-ENOTCONN   there is no I/O request pending for completion
+=========   ==============================================
 
 Usage Notes:
+
 Please have a look at the ccw_device_start() usage notes for more details on
 suspended channel programs.
 
@@ -412,22 +454,28 @@ command is provided.
 
 ccw_device_halt() must be called disabled and with the ccw device lock held.
 
-int ccw_device_halt(struct ccw_device *cdev,
-                    unsigned long intparm);
+::
 
-cdev    : ccw_device the halt operation is requested for
-intparm : interruption parameter; value is only used if no I/O
-          is outstanding, otherwise the intparm associated with
-          the I/O request is returned
+  int ccw_device_halt(struct ccw_device *cdev,
+		      unsigned long intparm);
 
-The ccw_device_halt() function returns :
+=======  =====================================================
+cdev     ccw_device the halt operation is requested for
+intparm  interruption parameter; value is only used if no I/O
+	 is outstanding, otherwise the intparm associated with
+	 the I/O request is returned
+=======  =====================================================
 
-      0 - request successfully initiated
--EBUSY  - the device is currently busy, or status pending.
--ENODEV - cdev invalid.
--EINVAL - The device is not operational or the ccw device is not online.
+The ccw_device_halt() function returns:
 
-Usage Notes :
+=======  ==============================================================
+      0  request successfully initiated
+-EBUSY   the device is currently busy, or status pending.
+-ENODEV  cdev invalid.
+-EINVAL  The device is not operational or the ccw device is not online.
+=======  ==============================================================
+
+Usage Notes:
 
 A device driver may write a never-ending channel program by writing a channel
 program that at its end loops back to its beginning by means of a transfer in
@@ -438,25 +486,34 @@ can then perform an appropriate action. Prior to interrupt of an outstanding
 read to a network device (with or without PCI flag) a ccw_device_halt()
 is required to end the pending operation.
 
-ccw_device_clear() - Terminage I/O Request Processing
+::
+
+  ccw_device_clear() - Terminage I/O Request Processing
 
 In order to terminate all I/O processing at the subchannel, the clear subchannel
 (CSCH) command is used. It can be issued via ccw_device_clear().
 
 ccw_device_clear() must be called disabled and with the ccw device lock held.
 
-int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm);
+::
 
-cdev:	 ccw_device the clear operation is requested for
-intparm: interruption parameter (see ccw_device_halt())
+  int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm);
+
+======= ===============================================
+cdev    ccw_device the clear operation is requested for
+intparm interruption parameter (see ccw_device_halt())
+======= ===============================================
 
 The ccw_device_clear() function returns:
 
-      0 - request successfully initiated
--ENODEV - cdev invalid
--EINVAL - The device is not operational or the ccw device is not online.
+=======  ==============================================================
+      0  request successfully initiated
+-ENODEV  cdev invalid
+-EINVAL  The device is not operational or the ccw device is not online.
+=======  ==============================================================
 
 Miscellaneous Support Routines
+------------------------------
 
 This chapter describes various routines to be used in a Linux/390 device
 driver programming environment.
@@ -466,7 +523,8 @@ get_ccwdev_lock()
 Get the address of the device specific lock. This is then used in
 spin_lock() / spin_unlock() calls.
 
+::
 
-__u8 ccw_device_get_path_mask(struct ccw_device *cdev);
+  __u8 ccw_device_get_path_mask(struct ccw_device *cdev);
 
 Get the mask of the path currently available for cdev.
diff --git a/Documentation/s390/CommonIO b/Documentation/s390/common_io.rst
similarity index 87%
rename from Documentation/s390/CommonIO
rename to Documentation/s390/common_io.rst
index 6e0f63f343b4..846485681ce7 100644
--- a/Documentation/s390/CommonIO
+++ b/Documentation/s390/common_io.rst
@@ -1,5 +1,9 @@
-S/390 common I/O-Layer - command line parameters, procfs and debugfs entries
-============================================================================
+======================
+S/390 common I/O-Layer
+======================
+
+command line parameters, procfs and debugfs entries
+===================================================
 
 Command line parameters
 -----------------------
@@ -13,7 +17,7 @@ Command line parameters
 	device := {all | [!]ipldev | [!]condev | [!]<devno> | [!]<devno>-<devno>}
 
   The given devices will be ignored by the common I/O-layer; no detection
-  and device sensing will be done on any of those devices. The subchannel to 
+  and device sensing will be done on any of those devices. The subchannel to
   which the device in question is attached will be treated as if no device was
   attached.
 
@@ -28,14 +32,20 @@ Command line parameters
   keywords can be used to refer to the CCW based boot device and CCW console
   device respectively (these are probably useful only when combined with the '!'
   operator). The '!' operator will cause the I/O-layer to _not_ ignore a device.
-  The command line is parsed from left to right.
+  The command line
+  is parsed from left to right.
+
+  For example::
 
-  For example, 
 	cio_ignore=0.0.0023-0.0.0042,0.0.4711
+
   will ignore all devices ranging from 0.0.0023 to 0.0.0042 and the device
   0.0.4711, if detected.
-  As another example,
+
+  As another example::
+
 	cio_ignore=all,!0.0.4711,!0.0.fd00-0.0.fd02
+
   will ignore all devices but 0.0.4711, 0.0.fd00, 0.0.fd01, 0.0.fd02.
 
   By default, no devices are ignored.
@@ -48,40 +58,45 @@ Command line parameters
 
   Lists the ranges of devices (by bus id) which are ignored by common I/O.
 
-  You can un-ignore certain or all devices by piping to /proc/cio_ignore. 
-  "free all" will un-ignore all ignored devices, 
+  You can un-ignore certain or all devices by piping to /proc/cio_ignore.
+  "free all" will un-ignore all ignored devices,
   "free <device range>, <device range>, ..." will un-ignore the specified
   devices.
 
   For example, if devices 0.0.0023 to 0.0.0042 and 0.0.4711 are ignored,
+
   - echo free 0.0.0030-0.0.0032 > /proc/cio_ignore
     will un-ignore devices 0.0.0030 to 0.0.0032 and will leave devices 0.0.0023
     to 0.0.002f, 0.0.0033 to 0.0.0042 and 0.0.4711 ignored;
   - echo free 0.0.0041 > /proc/cio_ignore will furthermore un-ignore device
     0.0.0041;
-  - echo free all > /proc/cio_ignore will un-ignore all remaining ignored 
+  - echo free all > /proc/cio_ignore will un-ignore all remaining ignored
     devices.
 
-  When a device is un-ignored, device recognition and sensing is performed and 
+  When a device is un-ignored, device recognition and sensing is performed and
   the device driver will be notified if possible, so the device will become
   available to the system. Note that un-ignoring is performed asynchronously.
 
-  You can also add ranges of devices to be ignored by piping to 
+  You can also add ranges of devices to be ignored by piping to
   /proc/cio_ignore; "add <device range>, <device range>, ..." will ignore the
   specified devices.
 
   Note: While already known devices can be added to the list of devices to be
-        ignored, there will be no effect on then. However, if such a device
+	ignored, there will be no effect on then. However, if such a device
 	disappears and then reappears, it will then be ignored. To make
 	known devices go away, you need the "purge" command (see below).
 
-  For example,
+  For example::
+
 	"echo add 0.0.a000-0.0.accc, 0.0.af00-0.0.afff > /proc/cio_ignore"
+
   will add 0.0.a000-0.0.accc and 0.0.af00-0.0.afff to the list of ignored
   devices.
 
-  You can remove already known but now ignored devices via
+  You can remove already known but now ignored devices via::
+
 	"echo purge > /proc/cio_ignore"
+
   All devices ignored but still registered and not online (= not in use)
   will be deregistered and thus removed from the system.
 
@@ -115,11 +130,11 @@ debugfs entries
     Various debug messages from the common I/O-layer.
 
   - /sys/kernel/debug/s390dbf/cio_trace/hex_ascii
-    Logs the calling of functions in the common I/O-layer and, if applicable, 
+    Logs the calling of functions in the common I/O-layer and, if applicable,
     which subchannel they were called for, as well as dumps of some data
     structures (like irb in an error case).
 
-  The level of logging can be changed to be more or less verbose by piping to 
+  The level of logging can be changed to be more or less verbose by piping to
   /sys/kernel/debug/s390dbf/cio_*/level a number between 0 and 6; see the
-  documentation on the S/390 debug feature (Documentation/s390/s390dbf.txt)
+  documentation on the S/390 debug feature (Documentation/s390/s390dbf.rst)
   for details.
diff --git a/Documentation/s390/DASD b/Documentation/s390/dasd.rst
similarity index 92%
rename from Documentation/s390/DASD
rename to Documentation/s390/dasd.rst
index 9963f1e9c98a..9e22247285c8 100644
--- a/Documentation/s390/DASD
+++ b/Documentation/s390/dasd.rst
@@ -1,4 +1,6 @@
+==================
 DASD device driver
+==================
 
 S/390's disk devices (DASDs) are managed by Linux via the DASD device
 driver. It is valid for all types of DASDs and represents them to
@@ -14,14 +16,14 @@ parameters are to be given in hexadecimal notation without a leading
 If you supply kernel parameters the different instances are processed
 in order of appearance and a minor number is reserved for any device
 covered by the supplied range up to 64 volumes. Additional DASDs are
-ignored. If you do not supply the 'dasd=' kernel parameter at all, the 
+ignored. If you do not supply the 'dasd=' kernel parameter at all, the
 DASD driver registers all supported DASDs of your system to a minor
 number in ascending order of the subchannel number.
 
 The driver currently supports ECKD-devices and there are stubs for
 support of the FBA and CKD architectures. For the FBA architecture
 only some smart data structures are missing to make the support
-complete. 
+complete.
 We performed our testing on 3380 and 3390 type disks of different
 sizes, under VM and on the bare hardware (LPAR), using internal disks
 of the multiprise as well as a RAMAC virtual array. Disks exported by
@@ -34,19 +36,22 @@ accessibility of the DASD from other OSs. In a later stage we will
 provide support of partitions, maybe VTOC oriented or using a kind of
 partition table in the label record.
 
-USAGE
+Usage
+=====
 
 -Low-level format (?CKD only)
 For using an ECKD-DASD as a Linux harddisk you have to low-level
 format the tracks by issuing the BLKDASDFORMAT-ioctl on that
 device. This will erase any data on that volume including IBM volume
-labels, VTOCs etc. The ioctl may take a 'struct format_data *' or
-'NULL' as an argument.  
-typedef struct {
+labels, VTOCs etc. The ioctl may take a `struct format_data *` or
+'NULL' as an argument::
+
+  typedef struct {
 	int start_unit;
 	int stop_unit;
 	int blksize;
-} format_data_t;
+  } format_data_t;
+
 When a NULL argument is passed to the BLKDASDFORMAT ioctl the whole
 disk is formatted to a blocksize of 1024 bytes. Otherwise start_unit
 and stop_unit are the first and last track to be formatted. If
@@ -56,17 +61,23 @@ up to the last track. blksize can be any power of two between 512 and
 1kB blocks anyway and you gain approx. 50% of capacity increasing your
 blksize from 512 byte to 1kB.
 
--Make a filesystem
+Make a filesystem
+=================
+
 Then you can mk??fs the filesystem of your choice on that volume or
 partition. For reasons of sanity you should build your filesystem on
-the partition /dev/dd?1 instead of the whole volume. You only lose 3kB	
+the partition /dev/dd?1 instead of the whole volume. You only lose 3kB
 but may be sure that you can reuse your data after introduction of a
 real partition table.
 
-BUGS:
+Bugs
+====
+
 - Performance sometimes is rather low because we don't fully exploit clustering
 
-TODO-List:
+TODO-List
+=========
+
 - Add IBM'S Disk layout to genhd
 - Enhance driver to use more than one major number
 - Enable usage as a module
diff --git a/Documentation/s390/Debugging390.txt b/Documentation/s390/debugging390.rst
similarity index 53%
rename from Documentation/s390/Debugging390.txt
rename to Documentation/s390/debugging390.rst
index c35804c238ad..d49305fd5e1a 100644
--- a/Documentation/s390/Debugging390.txt
+++ b/Documentation/s390/debugging390.rst
@@ -1,9 +1,12 @@
+=============================================
+Debugging on Linux for s/390 & z/Architecture
+=============================================
 
-		  Debugging on Linux for s/390 & z/Architecture
-				       by
-	  Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
-    Copyright (C) 2000-2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
-			Best viewed with fixed width fonts
+Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
+
+Copyright (C) 2000-2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
+
+.. Best viewed with fixed width fonts
 
 Overview of Document:
 =====================
@@ -17,32 +20,32 @@ It is intended like the Enterprise Systems Architecture/390 Reference Summary
 to be printed out & used as a quick cheat sheet self help style reference when
 problems occur.
 
-Contents
-========
-Register Set
-Address Spaces on Intel Linux
-Address Spaces on Linux for s/390 & z/Architecture
-The Linux for s/390 & z/Architecture Kernel Task Structure
-Register Usage & Stackframes on Linux for s/390 & z/Architecture
-A sample program with comments
-Compiling programs for debugging on Linux for s/390 & z/Architecture
-Debugging under VM
-s/390 & z/Architecture IO Overview
-Debugging IO on s/390 & z/Architecture under VM
-GDB on s/390 & z/Architecture
-Stack chaining in gdb by hand
-Examining core dumps
-ldd
-Debugging modules
-The proc file system
-SysRq
-References
-Special Thanks
+.. Contents
+   ========
+   Register Set
+   Address Spaces on Intel Linux
+   Address Spaces on Linux for s/390 & z/Architecture
+   The Linux for s/390 & z/Architecture Kernel Task Structure
+   Register Usage & Stackframes on Linux for s/390 & z/Architecture
+   A sample program with comments
+   Compiling programs for debugging on Linux for s/390 & z/Architecture
+   Debugging under VM
+   s/390 & z/Architecture IO Overview
+   Debugging IO on s/390 & z/Architecture under VM
+   GDB on s/390 & z/Architecture
+   Stack chaining in gdb by hand
+   Examining core dumps
+   ldd
+   Debugging modules
+   The proc file system
+   SysRq
+   References
+   Special Thanks
 
 Register Set
 ============
 The current architectures have the following registers.
- 
+
 16 General propose registers, 32 bit on s/390 and 64 bit on z/Architecture,
 r0-r15 (or gpr0-gpr15), used for arithmetic and addressing.
 
@@ -59,20 +62,22 @@ Access register 0 (and access register 1 on z/Architecture, which needs a
 64 bit pointer) is currently used by the pthread library as a pointer to
 the current running threads private area.
 
-16 64 bit floating point registers (fp0-fp15 ) IEEE & HFP floating 
-point format compliant on G5 upwards & a Floating point control reg (FPC) 
-4  64 bit registers (fp0,fp2,fp4 & fp6) HFP only on older machines.
+16 64-bit floating point registers (fp0-fp15 ) IEEE & HFP floating
+point format compliant on G5 upwards & a Floating point control reg (FPC)
+
+4  64-bit registers (fp0,fp2,fp4 & fp6) HFP only on older machines.
+
 Note:
-Linux (currently) always uses IEEE & emulates G5 IEEE format on older machines,
-( provided the kernel is configured for this ).
+   Linux (currently) always uses IEEE & emulates G5 IEEE format on older
+   machines, ( provided the kernel is configured for this ).
 
 
 The PSW is the most important register on the machine it
-is 64 bit on s/390 & 128 bit on z/Architecture & serves the roles of 
+is 64 bit on s/390 & 128 bit on z/Architecture & serves the roles of
 a program counter (pc), condition code register,memory space designator.
 In IBM standard notation I am counting bit 0 as the MSB.
 It has several advantages over a normal program counter
-in that you can change address translation & program counter 
+in that you can change address translation & program counter
 in a single instruction. To change address translation,
 e.g. switching address translation off requires that you
 have a logical=physical mapping for the address you are
@@ -206,14 +211,18 @@ It exists between the real addresses 0-4096 on s/390 and between 0-8192 on
 z/Architecture and is exchanged with one page on s/390 or two pages on
 z/Architecture in absolute storage by the set prefix instruction during Linux
 startup.
+
 This page is mapped to a different prefix for each processor in an SMP
 configuration (assuming the OS designer is sane of course).
+
 Bytes 0-512 (200 hex) on s/390 and 0-512, 4096-4544, 4604-5119 currently on
 z/Architecture are used by the processor itself for holding such information
 as exception indications and entry points for exceptions.
+
 Bytes after 0xc00 hex are used by linux for per processor globals on s/390 and
 z/Architecture (there is a gap on z/Architecture currently between 0xc00 and
 0x1000, too, which is used by Linux).
+
 The closest thing to this on traditional architectures is the interrupt
 vector table. This is a good thing & does simplify some of the kernel coding
 however it means that we now cannot catch stray NULL pointers in the
@@ -225,27 +234,29 @@ Address Spaces on Intel Linux
 =============================
 
 The traditional Intel Linux is approximately mapped as follows forgive
-the ascii art.
-0xFFFFFFFF 4GB Himem		*****************
-				*		*
-				* Kernel Space	*
-				*		*
-				*****************	  ****************
-User Space Himem		*  User Stack	*	  *		 *
-(typically 0xC0000000 3GB )	*****************	  *		 *
-				*  Shared Libs	*	  * Next Process *
-				*****************	  *	to	 *
-				*		*   <==   *	Run	 *  <==
-				*  User Program *	  *		 *
-				*   Data BSS	*	  *		 *
-				*    Text	*	  *		 *
-				*   Sections	*	  *		 *
-0x00000000			*****************	  ****************
+the ascii art::
+
+  0xFFFFFFFF 4GB Himem          *****************
+				*               *
+				* Kernel Space  *
+				*               *
+				*****************         ****************
+  User Space Himem              *  User Stack   *         *              *
+  (typically 0xC0000000 3GB )   *****************         *              *
+				*  Shared Libs  *         * Next Process *
+				*****************         *     to       *
+				*               *   <==   *     Run      *  <==
+				*  User Program *         *              *
+				*   Data BSS    *         *              *
+				*    Text       *         *              *
+				*   Sections    *         *              *
+  0x00000000                    *****************         ****************
 
 Now it is easy to see that on Intel it is quite easy to recognise a kernel
 address as being one greater than user space himem (in this case 0xC0000000),
 and addresses of less than this are the ones in the current running program on
 this processor (if an smp box).
+
 If using the virtual machine ( VM ) as a debugger it is quite difficult to
 know which user process is running as the address space you are looking at
 could be from any process in the run queue.
@@ -256,6 +267,7 @@ of Real Address=Virtual Address-User Space Himem.
 This means that on Intel the kernel linux can typically only address
 Himem=0xFFFFFFFF-0xC0000000=1GB & this is all the RAM these machines
 can typically use.
+
 They can lower User Himem to 2GB or lower & thus be
 able to use 2GB of RAM however this shrinks the maximum size
 of User Space from 3GB to 2GB they have a no win limit of 4GB unless
@@ -264,31 +276,31 @@ they go to 64 Bit.
 
 On 390 our limitations & strengths make us slightly different.
 For backward compatibility we are only allowed use 31 bits (2GB)
-of our 32 bit addresses, however, we use entirely separate address 
+of our 32 bit addresses, however, we use entirely separate address
 spaces for the user & kernel.
 
 This means we can support 2GB of non Extended RAM on s/390, & more
-with the Extended memory management swap device & 
+with the Extended memory management swap device &
 currently 4TB of physical memory currently on z/Architecture.
 
 
 Address Spaces on Linux for s/390 & z/Architecture
 ==================================================
 
-Our addressing scheme is basically as follows:
+Our addressing scheme is basically as follows::
 
-				   Primary Space	       Home Space
-Himem 0x7fffffff 2GB on s/390    *****************          ****************
-currently 0x3ffffffffff (2^42)-1 *  User Stack   *          *              *
-on z/Architecture.		 *****************          *              *
-				 *  Shared Libs  *	    *		   *
-				 *****************	    *		   *
-			         *               *          *    Kernel    *  
-		                 *  User Program *          *              *
-		                 *   Data BSS    *          *              *
-                                 *    Text       *          *              *
-            			 *   Sections    *          *              *
-0x00000000                       *****************          ****************
+				   Primary Space               Home Space
+  Himem 0x7fffffff 2GB on s/390    *****************          ****************
+  currently 0x3ffffffffff (2^42)-1 *  User Stack   *          *              *
+  on z/Architecture.               *****************          *              *
+				   *  Shared Libs  *          *              *
+				   *****************          *              *
+				   *               *          *    Kernel    *
+				   *  User Program *          *              *
+				   *   Data BSS    *          *              *
+				   *    Text       *          *              *
+				   *   Sections    *          *              *
+  0x00000000                       *****************          ****************
 
 This also means that we need to look at the PSW problem state bit and the
 addressing mode to decide whether we are looking at user or kernel space.
@@ -304,20 +316,25 @@ instruction on a user space address is performed.
 When also looking at the ASCE control registers, this means:
 
 User space:
+
 - runs in primary or access register mode
 - cr1 contains the user asce
 - cr7 contains the user asce
 - cr13 contains the kernel asce
 
 Kernel space:
+
 - runs in home space mode
 - cr1 contains the user or kernel asce
-  -> the kernel asce is loaded when a uaccess requires primary or
-     secondary address mode
+
+  - the kernel asce is loaded when a uaccess requires primary or
+    secondary address mode
+
 - cr7 contains the user or kernel asce, (changed with set_fs())
 - cr13 contains the kernel asce
 
 In case of uaccess the kernel changes to:
+
 - primary space mode in case of a uaccess (copy_to_user) and uses
   e.g. the mvcp instruction to access user space. However the kernel
   will stay in home space mode if the mvcos instruction is available
@@ -337,41 +354,44 @@ Virtual Addresses on s/390 & z/Architecture
 A virtual address on s/390 is made up of 3 parts
 The SX (segment index, roughly corresponding to the PGD & PMD in Linux
 terminology) being bits 1-11.
+
 The PX (page index, corresponding to the page table entry (pte) in Linux
 terminology) being bits 12-19.
+
 The remaining bits BX (the byte index are the offset in the page )
 i.e. bits 20 to 31.
 
 On z/Architecture in linux we currently make up an address from 4 parts.
-The region index bits (RX) 0-32 we currently use bits 22-32
-The segment index (SX) being bits 33-43
-The page index (PX) being bits  44-51
-The byte index (BX) being bits  52-63
+
+- The region index bits (RX) 0-32 we currently use bits 22-32
+- The segment index (SX) being bits 33-43
+- The page index (PX) being bits  44-51
+- The byte index (BX) being bits  52-63
 
 Notes:
-1) s/390 has no PMD so the PMD is really the PGD also.
-A lot of this stuff is defined in pgtable.h.
+  1) s/390 has no PMD so the PMD is really the PGD also.
+     A lot of this stuff is defined in pgtable.h.
 
-2) Also seeing as s/390's page indexes are only 1k  in size 
-(bits 12-19 x 4 bytes per pte ) we use 1 ( page 4k )
-to make the best use of memory by updating 4 segment indices 
-entries each time we mess with a PMD & use offsets 
-0,1024,2048 & 3072 in this page as for our segment indexes.
-On z/Architecture our page indexes are now 2k in size
-( bits 12-19 x 8 bytes per pte ) we do a similar trick
-but only mess with 2 segment indices each time we mess with
-a PMD.
+  2) Also seeing as s/390's page indexes are only 1k  in size
+     (bits 12-19 x 4 bytes per pte ) we use 1 ( page 4k )
+     to make the best use of memory by updating 4 segment indices
+     entries each time we mess with a PMD & use offsets
+     0,1024,2048 & 3072 in this page as for our segment indexes.
+     On z/Architecture our page indexes are now 2k in size
+     ( bits 12-19 x 8 bytes per pte ) we do a similar trick
+     but only mess with 2 segment indices each time we mess with
+     a PMD.
+
+  3) As z/Architecture supports up to a massive 5-level page table lookup we
+     can only use 3 currently on Linux ( as this is all the generic kernel
+     currently supports ) however this may change in future
+     this allows us to access ( according to my sums )
+     4TB of virtual storage per process i.e.
+     4096*512(PTES)*1024(PMDS)*2048(PGD) = 4398046511104 bytes,
+     enough for another 2 or 3 of years I think :-).
+     to do this we use a region-third-table designation type in
+     our address space control registers.
 
-3) As z/Architecture supports up to a massive 5-level page table lookup we
-can only use 3 currently on Linux ( as this is all the generic kernel
-currently supports ) however this may change in future
-this allows us to access ( according to my sums )
-4TB of virtual storage per process i.e.
-4096*512(PTES)*1024(PMDS)*2048(PGD) = 4398046511104 bytes,
-enough for another 2 or 3 of years I think :-).
-to do this we use a region-third-table designation type in
-our address space control registers.
- 
 
 The Linux for s/390 & z/Architecture Kernel Task Structure
 ==========================================================
@@ -382,42 +402,43 @@ the __LC_KERNEL_STACK variable in the spare prefix area for this cpu
 (which we use for per-processor globals).
 
 The kernel stack pointer is intimately tied with the task structure for
-each processor as follows.
+each processor as follows::
 
-                      s/390
-            ************************
-            *  1 page kernel stack *
-	    *        ( 4K )        *
-            ************************
-            *   1 page task_struct *        
-            *        ( 4K )        *
-8K aligned  ************************ 
+			s/390
+	      ************************
+	      *  1 page kernel stack *
+	      *        ( 4K )        *
+	      ************************
+	      *   1 page task_struct *
+	      *        ( 4K )        *
+  8K aligned  ************************
 
-                 z/Architecture
-            ************************
-            *  2 page kernel stack *
-	    *        ( 8K )        *
-            ************************
-            *  2 page task_struct  *        
-            *        ( 8K )        *
-16K aligned ************************ 
+		   z/Architecture
+	      ************************
+	      *  2 page kernel stack *
+	      *        ( 8K )        *
+	      ************************
+	      *  2 page task_struct  *
+	      *        ( 8K )        *
+  16K aligned ************************
 
 What this means is that we don't need to dedicate any register or global
 variable to point to the current running process & can retrieve it with the
-following very simple construct for s/390 & one very similar for z/Architecture.
+following very simple construct for s/390 & one very similar for
+z/Architecture::
 
-static inline struct task_struct * get_current(void)
-{
-        struct task_struct *current;
-        __asm__("lhi   %0,-8192\n\t"
-                "nr    %0,15"
-                : "=r" (current) );
-        return current;
-}
+  static inline struct task_struct * get_current(void)
+  {
+	struct task_struct *current;
+	__asm__("lhi   %0,-8192\n\t"
+		"nr    %0,15"
+		: "=r" (current) );
+	return current;
+  }
 
 i.e. just anding the current kernel stack pointer with the mask -8192.
 Thankfully because Linux doesn't have support for nested IO interrupts
-& our devices have large buffers can survive interrupts being shut for 
+& our devices have large buffers can survive interrupts being shut for
 short amounts of time we don't need a separate stack for interrupts.
 
 
@@ -428,7 +449,7 @@ Register Usage & Stackframes on Linux for s/390 & z/Architecture
 Overview:
 ---------
 This is the code that gcc produces at the top & the bottom of
-each function. It usually is fairly consistent & similar from 
+each function. It usually is fairly consistent & similar from
 function to function & if you know its layout you can probably
 make some headway in finding the ultimate cause of a problem
 after a crash without a source level debugger.
@@ -443,87 +464,95 @@ didn't have to maintain compatibility with older linkage formats.
 Glossary:
 ---------
 alloca:
-This is a built in compiler function for runtime allocation
-of extra space on the callers stack which is obviously freed
-up on function exit ( e.g. the caller may choose to allocate nothing
-of a buffer of 4k if required for temporary purposes ), it generates 
-very efficient code ( a few cycles  ) when compared to alternatives 
-like malloc.
+  This is a built in compiler function for runtime allocation
+  of extra space on the callers stack which is obviously freed
+  up on function exit ( e.g. the caller may choose to allocate nothing
+  of a buffer of 4k if required for temporary purposes ), it generates
+  very efficient code ( a few cycles  ) when compared to alternatives
+  like malloc.
 
-automatics: These are local variables on the stack,
-i.e they aren't in registers & they aren't static.
+automatics:
+  These are local variables on the stack, i.e they aren't in registers &
+  they aren't static.
 
 back-chain:
-This is a pointer to the stack pointer before entering a
-framed functions ( see frameless function ) prologue got by 
-dereferencing the address of the current stack pointer,
- i.e. got by accessing the 32 bit value at the stack pointers
-current location.
+  This is a pointer to the stack pointer before entering a
+  framed functions ( see frameless function ) prologue got by
+  dereferencing the address of the current stack pointer,
+  i.e. got by accessing the 32 bit value at the stack pointers
+  current location.
 
 base-pointer:
-This is a pointer to the back of the literal pool which
-is an area just behind each procedure used to store constants
-in each function.
+  This is a pointer to the back of the literal pool which
+  is an area just behind each procedure used to store constants
+  in each function.
 
-call-clobbered: The caller probably needs to save these registers if there 
-is something of value in them, on the stack or elsewhere before making a 
-call to another procedure so that it can restore it later.
+call-clobbered:
+  The caller probably needs to save these registers if there
+  is something of value in them, on the stack or elsewhere before making a
+  call to another procedure so that it can restore it later.
 
 epilogue:
-The code generated by the compiler to return to the caller.
+  The code generated by the compiler to return to the caller.
 
-frameless-function
-A frameless function in Linux for s390 & z/Architecture is one which doesn't 
-need more than the register save area (96 bytes on s/390, 160 on z/Architecture)
-given to it by the caller.
-A frameless function never:
-1) Sets up a back chain.
-2) Calls alloca.
-3) Calls other normal functions
-4) Has automatics.
+frameless-function:
+  A frameless function in Linux for s390 & z/Architecture is one which doesn't
+  need more than the register save area (96 bytes on s/390, 160 on z/Architecture)
+  given to it by the caller.
+
+  A frameless function never:
+
+  1) Sets up a back chain.
+  2) Calls alloca.
+  3) Calls other normal functions
+  4) Has automatics.
 
 GOT-pointer:
-This is a pointer to the global-offset-table in ELF
-( Executable Linkable Format, Linux'es most common executable format ),
-all globals & shared library objects are found using this pointer.
+  This is a pointer to the global-offset-table in ELF
+  ( Executable Linkable Format, Linux'es most common executable format ),
+  all globals & shared library objects are found using this pointer.
 
 lazy-binding
-ELF shared libraries are typically only loaded when routines in the shared
-library are actually first called at runtime. This is lazy binding.
+  ELF shared libraries are typically only loaded when routines in the shared
+  library are actually first called at runtime. This is lazy binding.
 
 procedure-linkage-table
-This is a table found from the GOT which contains pointers to routines
-in other shared libraries which can't be called to by easier means.
+  This is a table found from the GOT which contains pointers to routines
+  in other shared libraries which can't be called to by easier means.
 
 prologue:
-The code generated by the compiler to set up the stack frame.
+  The code generated by the compiler to set up the stack frame.
 
 outgoing-args:
-This is extra area allocated on the stack of the calling function if the
-parameters for the callee's cannot all be put in registers, the same
-area can be reused by each function the caller calls.
+  This is extra area allocated on the stack of the calling function if the
+  parameters for the callee's cannot all be put in registers, the same
+  area can be reused by each function the caller calls.
 
 routine-descriptor:
-A COFF  executable format based concept of a procedure reference 
-actually being 8 bytes or more as opposed to a simple pointer to the routine.
-This is typically defined as follows
-Routine Descriptor offset 0=Pointer to Function
-Routine Descriptor offset 4=Pointer to Table of Contents
-The table of contents/TOC is roughly equivalent to a GOT pointer.
-& it means that shared libraries etc. can be shared between several
-environments each with their own TOC.
+  A COFF  executable format based concept of a procedure reference
+  actually being 8 bytes or more as opposed to a simple pointer to the routine.
+  This is typically defined as follows:
 
- 
-static-chain: This is used in nested functions a concept adopted from pascal 
-by gcc not used in ansi C or C++ ( although quite useful ), basically it
-is a pointer used to reference local variables of enclosing functions.
-You might come across this stuff once or twice in your lifetime.
+  - Routine Descriptor offset 0=Pointer to Function
+  - Routine Descriptor offset 4=Pointer to Table of Contents
 
-e.g.
-The function below should return 11 though gcc may get upset & toss warnings 
-about unused variables.
-int FunctionA(int a)
-{
+  The table of contents/TOC is roughly equivalent to a GOT pointer.
+  & it means that shared libraries etc. can be shared between several
+  environments each with their own TOC.
+
+static-chain:
+  This is used in nested functions a concept adopted from pascal
+  by gcc not used in ansi C or C++ ( although quite useful ), basically it
+  is a pointer used to reference local variables of enclosing functions.
+  You might come across this stuff once or twice in your lifetime.
+
+  e.g.
+
+  The function below should return 11 though gcc may get upset & toss warnings
+  about unused variables::
+
+    int FunctionA(int a)
+    {
 	int b;
 	FunctionC(int c)
 	{
@@ -531,19 +560,21 @@ int FunctionA(int a)
 	}
 	FunctionC(10);
 	return(b);
-}
+    }
 
 
 s/390 & z/Architecture Register usage
 =====================================
+
+======== ========================================== ===============
 r0       used by syscalls/assembly                  call-clobbered
-r1	 used by syscalls/assembly                  call-clobbered
+r1       used by syscalls/assembly                  call-clobbered
 r2       argument 0 / return value 0                call-clobbered
 r3       argument 1 / return value 1 (if long long) call-clobbered
 r4       argument 2                                 call-clobbered
 r5       argument 3                                 call-clobbered
-r6	 argument 4				    saved
-r7       pointer-to arguments 5 to ...              saved      
+r6       argument 4                                 saved
+r7       pointer-to arguments 5 to ...              saved
 r8       this & that                                saved
 r9       this & that                                saved
 r10      static-chain ( if nested function )        saved
@@ -557,65 +588,74 @@ f0       argument 0 / return value ( float/double ) call-clobbered
 f2       argument 1                                 call-clobbered
 f4       z/Architecture argument 2                  saved
 f6       z/Architecture argument 3                  saved
+======== ========================================== ===============
+
 The remaining floating points
 f1,f3,f5 f7-f15 are call-clobbered.
 
 Notes:
 ------
 1) The only requirement is that registers which are used
-by the callee are saved, e.g. the compiler is perfectly
-capable of using r11 for purposes other than a frame a
-frame pointer if a frame pointer is not needed.
-2) In functions with variable arguments e.g. printf the calling procedure 
-is identical to one without variable arguments & the same number of 
-parameters. However, the prologue of this function is somewhat more
-hairy owing to it having to move these parameters to the stack to
-get va_start, va_arg & va_end to work.
+   by the callee are saved, e.g. the compiler is perfectly
+   capable of using r11 for purposes other than a frame a
+   frame pointer if a frame pointer is not needed.
+2) In functions with variable arguments e.g. printf the calling procedure
+   is identical to one without variable arguments & the same number of
+   parameters. However, the prologue of this function is somewhat more
+   hairy owing to it having to move these parameters to the stack to
+   get va_start, va_arg & va_end to work.
 3) Access registers are currently unused by gcc but are used in
-the kernel. Possibilities exist to use them at the moment for
-temporary storage but it isn't recommended.
+   the kernel. Possibilities exist to use them at the moment for
+   temporary storage but it isn't recommended.
 4) Only 4 of the floating point registers are used for
-parameter passing as older machines such as G3 only have only 4
-& it keeps the stack frame compatible with other compilers.
-However with IEEE floating point emulation under linux on the
-older machines you are free to use the other 12.
-5) A long long or double parameter cannot be have the 
-first 4 bytes in a register & the second four bytes in the 
-outgoing args area. It must be purely in the outgoing args
-area if crossing this boundary.
+   parameter passing as older machines such as G3 only have only 4
+   & it keeps the stack frame compatible with other compilers.
+   However with IEEE floating point emulation under linux on the
+   older machines you are free to use the other 12.
+5) A long long or double parameter cannot be have the
+   first 4 bytes in a register & the second four bytes in the
+   outgoing args area. It must be purely in the outgoing args
+   area if crossing this boundary.
 6) Floating point parameters are mixed with outgoing args
-on the outgoing args area in the order the are passed in as parameters.
-7) Floating point arguments 2 & 3 are saved in the outgoing args area for 
-z/Architecture
+   on the outgoing args area in the order the are passed in as parameters.
+7) Floating point arguments 2 & 3 are saved in the outgoing args area for
+   z/Architecture
 
 
 Stack Frame Layout
 ------------------
+
+========= ============== ======================================================
 s/390     z/Architecture
-0         0             back chain ( a 0 here signifies end of back chain )
-4         8             eos ( end of stack, not used on Linux for S390 used in other linkage formats )
-8         16            glue used in other s/390 linkage formats for saved routine descriptors etc.
-12        24            glue used in other s/390 linkage formats for saved routine descriptors etc.
-16        32            scratch area
-20        40            scratch area
-24        48            saved r6 of caller function
-28        56            saved r7 of caller function
-32        64            saved r8 of caller function
-36        72            saved r9 of caller function
-40        80            saved r10 of caller function
-44        88            saved r11 of caller function
-48        96            saved r12 of caller function
-52        104           saved r13 of caller function
-56        112           saved r14 of caller function
-60        120           saved r15 of caller function
-64        128           saved f4 of caller function
-72        132           saved f6 of caller function
-80                      undefined
-96        160           outgoing args passed from caller to callee
-96+x      160+x         possible stack alignment ( 8 bytes desirable )
-96+x+y    160+x+y       alloca space of caller ( if used )
-96+x+y+z  160+x+y+z     automatics of caller ( if used )
-0                       back-chain
+========= ============== ======================================================
+0         0              back chain ( a 0 here signifies end of back chain )
+4         8              eos ( end of stack, not used on Linux for S390 used
+			 in other linkage formats )
+8         16             glue used in other s/390 linkage formats for saved
+			 routine descriptors etc.
+12        24             glue used in other s/390 linkage formats for saved
+			 routine descriptors etc.
+16        32             scratch area
+20        40             scratch area
+24        48             saved r6 of caller function
+28        56             saved r7 of caller function
+32        64             saved r8 of caller function
+36        72             saved r9 of caller function
+40        80             saved r10 of caller function
+44        88             saved r11 of caller function
+48        96             saved r12 of caller function
+52        104            saved r13 of caller function
+56        112            saved r14 of caller function
+60        120            saved r15 of caller function
+64        128            saved f4 of caller function
+72        132            saved f6 of caller function
+80                       undefined
+96        160            outgoing args passed from caller to callee
+96+x      160+x          possible stack alignment ( 8 bytes desirable )
+96+x+y    160+x+y        alloca space of caller ( if used )
+96+x+y+z  160+x+y+z      automatics of caller ( if used )
+0                        back-chain
+========= ============== ======================================================
 
 A sample program with comments.
 ===============================
@@ -623,82 +663,86 @@ A sample program with comments.
 Comments on the function test
 -----------------------------
 1) It didn't need to set up a pointer to the constant pool gpr13 as it is not
-used ( :-( ).
+   used ( :-( ).
 2) This is a frameless function & no stack is bought.
 3) The compiler was clever enough to recognise that it could return the
-value in r2 as well as use it for the passed in parameter ( :-) ).
-4) The basr ( branch relative & save ) trick works as follows the instruction 
-has a special case with r0,r0 with some instruction operands is understood as 
-the literal value 0, some risc architectures also do this ). So now
-we are branching to the next address & the address new program counter is
-in r13,so now we subtract the size of the function prologue we have executed
-+ the size of the literal pool to get to the top of the literal pool
-0040037c int test(int b)
-{                                                          # Function prologue below
-  40037c:	90 de f0 34 	stm	%r13,%r14,52(%r15) # Save registers r13 & r14
-  400380:	0d d0       	basr	%r13,%r0           # Set up pointer to constant pool using
-  400382:	a7 da ff fa 	ahi	%r13,-6            # basr trick
+   value in r2 as well as use it for the passed in parameter ( :-) ).
+4) The basr ( branch relative & save ) trick works as follows the instruction
+   has a special case with r0,r0 with some instruction operands is understood as
+   the literal value 0, some risc architectures also do this ). So now
+   we are branching to the next address & the address new program counter is
+   in r13,so now we subtract the size of the function prologue we have executed
+   the size of the literal pool to get to the top of the literal pool::
+
+
+     0040037c int test(int b)
+     {                                                     # Function prologue below
+       40037c:  90 de f0 34     stm     %r13,%r14,52(%r15) # Save registers r13 & r14
+       400380:  0d d0           basr    %r13,%r0           # Set up pointer to constant pool using
+       400382:  a7 da ff fa     ahi     %r13,-6            # basr trick
 	return(5+b);
-	                                                   # Huge main program
-  400386:	a7 2a 00 05 	ahi	%r2,5              # add 5 to r2
+							   # Huge main program
+       400386:  a7 2a 00 05     ahi     %r2,5              # add 5 to r2
 
-                                                           # Function epilogue below 
-  40038a:	98 de f0 34 	lm	%r13,%r14,52(%r15) # restore registers r13 & 14
-  40038e:	07 fe       	br	%r14               # return
-}
+							   # Function epilogue below
+       40038a:  98 de f0 34     lm      %r13,%r14,52(%r15) # restore registers r13 & 14
+       40038e:  07 fe           br      %r14               # return
+     }
 
 Comments on the function main
 -----------------------------
-1) The compiler did this function optimally ( 8-) )
+1) The compiler did this function optimally ( 8-) )::
 
-Literal pool for main.
-400390:	ff ff ff ec 	.long 0xffffffec
-main(int argc,char *argv[])
-{                                                          # Function prologue below
-  400394:	90 bf f0 2c 	stm	%r11,%r15,44(%r15) # Save necessary registers
-  400398:	18 0f       	lr	%r0,%r15           # copy stack pointer to r0
-  40039a:	a7 fa ff a0 	ahi	%r15,-96           # Make area for callee saving 
-  40039e:	0d d0       	basr	%r13,%r0           # Set up r13 to point to
-  4003a0:	a7 da ff f0 	ahi	%r13,-16           # literal pool
-  4003a4:	50 00 f0 00 	st	%r0,0(%r15)        # Save backchain
+     Literal pool for main.
+     400390:    ff ff ff ec     .long 0xffffffec
+     main(int argc,char *argv[])
+     {                                                     # Function prologue below
+       400394:  90 bf f0 2c     stm     %r11,%r15,44(%r15) # Save necessary registers
+       400398:  18 0f           lr      %r0,%r15           # copy stack pointer to r0
+       40039a:  a7 fa ff a0     ahi     %r15,-96           # Make area for callee saving
+       40039e:  0d d0           basr    %r13,%r0           # Set up r13 to point to
+       4003a0:  a7 da ff f0     ahi     %r13,-16           # literal pool
+       4003a4:  50 00 f0 00     st      %r0,0(%r15)        # Save backchain
 
 	return(test(5));                                   # Main Program Below
-  4003a8:	58 e0 d0 00 	l	%r14,0(%r13)       # load relative address of test from
-						           # literal pool
-  4003ac:	a7 28 00 05 	lhi	%r2,5              # Set first parameter to 5
-  4003b0:	4d ee d0 00 	bas	%r14,0(%r14,%r13)  # jump to test setting r14 as return
+       4003a8:  58 e0 d0 00     l       %r14,0(%r13)       # load relative address of test from
+							   # literal pool
+       4003ac:  a7 28 00 05     lhi     %r2,5              # Set first parameter to 5
+       4003b0:  4d ee d0 00     bas     %r14,0(%r14,%r13)  # jump to test setting r14 as return
 							   # address using branch & save instruction.
 
 							   # Function Epilogue below
-  4003b4:	98 bf f0 8c 	lm	%r11,%r15,140(%r15)# Restore necessary registers.
-  4003b8:	07 fe       	br	%r14               # return to do program exit 
-}
+       4003b4:  98 bf f0 8c     lm      %r11,%r15,140(%r15)# Restore necessary registers.
+       4003b8:  07 fe           br      %r14               # return to do program exit
+     }
 
 
 Compiler updates
 ----------------
 
-main(int argc,char *argv[])
-{
-  4004fc:	90 7f f0 1c       	stm	%r7,%r15,28(%r15)
-  400500:	a7 d5 00 04       	bras	%r13,400508 <main+0xc>
-  400504:	00 40 04 f4       	.long	0x004004f4 
-  # compiler now puts constant pool in code to so it saves an instruction 
-  400508:	18 0f             	lr	%r0,%r15
-  40050a:	a7 fa ff a0       	ahi	%r15,-96
-  40050e:	50 00 f0 00       	st	%r0,0(%r15)
+::
+
+  main(int argc,char *argv[])
+  {
+    4004fc:     90 7f f0 1c             stm     %r7,%r15,28(%r15)
+    400500:     a7 d5 00 04             bras    %r13,400508 <main+0xc>
+    400504:     00 40 04 f4             .long   0x004004f4
+    # compiler now puts constant pool in code to so it saves an instruction
+    400508:     18 0f                   lr      %r0,%r15
+    40050a:     a7 fa ff a0             ahi     %r15,-96
+    40050e:     50 00 f0 00             st      %r0,0(%r15)
 	return(test(5));
-  400512:	58 10 d0 00       	l	%r1,0(%r13)
-  400516:	a7 28 00 05       	lhi	%r2,5
-  40051a:	0d e1             	basr	%r14,%r1
-  # compiler adds 1 extra instruction to epilogue this is done to
-  # avoid processor pipeline stalls owing to data dependencies on g5 &
-  # above as register 14 in the old code was needed directly after being loaded 
-  # by the lm	%r11,%r15,140(%r15) for the br %14.
-  40051c:	58 40 f0 98       	l	%r4,152(%r15)
-  400520:	98 7f f0 7c       	lm	%r7,%r15,124(%r15)
-  400524:	07 f4             	br	%r4
-}
+    400512:     58 10 d0 00             l       %r1,0(%r13)
+    400516:     a7 28 00 05             lhi     %r2,5
+    40051a:     0d e1                   basr    %r14,%r1
+    # compiler adds 1 extra instruction to epilogue this is done to
+    # avoid processor pipeline stalls owing to data dependencies on g5 &
+    # above as register 14 in the old code was needed directly after being loaded
+    # by the lm %r11,%r15,140(%r15) for the br %14.
+    40051c:     58 40 f0 98             l       %r4,152(%r15)
+    400520:     98 7f f0 7c             lm      %r7,%r15,124(%r15)
+    400524:     07 f4                   br      %r4
+  }
 
 
 Hartmut ( our compiler developer ) also has been threatening to take out the
@@ -709,38 +753,39 @@ have been warned.
 --------------------------------------
 
 If you understand the stuff above you'll understand the stuff
-below too so I'll avoid repeating myself & just say that 
+below too so I'll avoid repeating myself & just say that
 some of the instructions have g's on the end of them to indicate
-they are 64 bit & the stack offsets are a bigger, 
+they are 64 bit & the stack offsets are a bigger,
 the only other difference you'll find between 32 & 64 bit is that
-we now use f4 & f6 for floating point arguments on 64 bit.
-00000000800005b0 <test>:
-int test(int b)
-{
+we now use f4 & f6 for floating point arguments on 64 bit::
+
+  00000000800005b0 <test>:
+  int test(int b)
+  {
 	return(5+b);
-    800005b0:	a7 2a 00 05       	ahi	%r2,5
-    800005b4:	b9 14 00 22       	lgfr	%r2,%r2 # downcast to integer
-    800005b8:	07 fe             	br	%r14
-    800005ba:	07 07             	bcr	0,%r7
+      800005b0: a7 2a 00 05             ahi     %r2,5
+      800005b4: b9 14 00 22             lgfr    %r2,%r2 # downcast to integer
+      800005b8: 07 fe                   br      %r14
+      800005ba: 07 07                   bcr     0,%r7
 
 
-}
+  }
 
-00000000800005bc <main>:
-main(int argc,char *argv[])
-{ 
-    800005bc:	eb bf f0 58 00 24 	stmg	%r11,%r15,88(%r15)
-    800005c2:	b9 04 00 1f       	lgr	%r1,%r15
-    800005c6:	a7 fb ff 60       	aghi	%r15,-160
-    800005ca:	e3 10 f0 00 00 24 	stg	%r1,0(%r15)
+  00000000800005bc <main>:
+  main(int argc,char *argv[])
+  {
+      800005bc: eb bf f0 58 00 24       stmg    %r11,%r15,88(%r15)
+      800005c2: b9 04 00 1f             lgr     %r1,%r15
+      800005c6: a7 fb ff 60             aghi    %r15,-160
+      800005ca: e3 10 f0 00 00 24       stg     %r1,0(%r15)
 	return(test(5));
-    800005d0:	a7 29 00 05       	lghi	%r2,5
-    # brasl allows jumps > 64k & is overkill here bras would do fune
-    800005d4:	c0 e5 ff ff ff ee 	brasl	%r14,800005b0 <test> 
-    800005da:	e3 40 f1 10 00 04 	lg	%r4,272(%r15)
-    800005e0:	eb bf f0 f8 00 04 	lmg	%r11,%r15,248(%r15)
-    800005e6:	07 f4             	br	%r4
-}
+      800005d0: a7 29 00 05             lghi    %r2,5
+      # brasl allows jumps > 64k & is overkill here bras would do fune
+      800005d4: c0 e5 ff ff ff ee       brasl   %r14,800005b0 <test>
+      800005da: e3 40 f1 10 00 04       lg      %r4,272(%r15)
+      800005e0: eb bf f0 f8 00 04       lmg     %r11,%r15,248(%r15)
+      800005e6: 07 f4                   br      %r4
+  }
 
 
 
@@ -749,15 +794,15 @@ Compiling programs for debugging on Linux for s/390 & z/Architecture
 -gdwarf-2 now works it should be considered the default debugging
 format for s/390 & z/Architecture as it is more reliable for debugging
 shared libraries,  normal -g debugging works much better now
-Thanks to the IBM java compiler developers bug reports. 
+Thanks to the IBM java compiler developers bug reports.
 
-This is typically done adding/appending the flags -g or -gdwarf-2 to the 
+This is typically done adding/appending the flags -g or -gdwarf-2 to the
 CFLAGS & LDFLAGS variables Makefile of the program concerned.
 
 If using gdb & you would like accurate displays of registers &
- stack traces compile without optimisation i.e make sure
+stack traces compile without optimisation i.e make sure
 that there is no -O2 or similar on the CFLAGS line of the Makefile &
-the emitted gcc commands, obviously this will produce worse code 
+the emitted gcc commands, obviously this will produce worse code
 ( not advisable for shipment ) but it is an  aid to the debugging process.
 
 This aids debugging because the compiler will copy parameters passed in
@@ -766,7 +811,7 @@ parameters will work, however some larger programs which use inline functions
 will not compile without optimisation.
 
 Debugging with optimisation has since much improved after fixing
-some bugs, please make sure you are using gdb-5.0 or later developed 
+some bugs, please make sure you are using gdb-5.0 or later developed
 after Nov'2000.
 
 
@@ -779,7 +824,7 @@ Notes
 Addresses & values in the VM debugger are always hex never decimal
 Address ranges are of the format <HexValue1>-<HexValue2> or
 <HexValue1>.<HexValue2>
-For example, the address range	0x2000 to 0x3000 can be described as 2000-3000
+For example, the address range  0x2000 to 0x3000 can be described as 2000-3000
 or 2000.1000
 
 The VM Debugger is case insensitive.
@@ -798,27 +843,31 @@ operands are nibble (half byte aligned).
 So if you have an objdump listing by hand, it is quite easy to follow, and if
 you don't have an objdump listing keep a copy of the s/390 Reference Summary
 or alternatively the s/390 principles of operation next to you.
-e.g. even I can guess that 
+e.g. even I can guess that
 0001AFF8' LR    180F        CC 0
-is a ( load register ) lr r0,r15 
+is a ( load register ) lr r0,r15
 
 Also it is very easy to tell the length of a 390 instruction from the 2 most
 significant bits in the instruction (not that this info is really useful except
 if you are trying to make sense of a hexdump of code).
 Here is a table
+
+======================= ==================
 Bits                    Instruction Length
-------------------------------------------
+======================= ==================
 00                          2 Bytes
 01                          4 Bytes
 10                          4 Bytes
 11                          6 Bytes
+======================= ==================
 
 The debugger also displays other useful info on the same line such as the
 addresses being operated on destination addresses of branches & condition codes.
-e.g.  
-00019736' AHI   A7DAFF0E    CC 1
-000198BA' BRC   A7840004 -> 000198C2'   CC 0
-000198CE' STM   900EF068 >> 0FA95E78    CC 2
+e.g.::
+
+  00019736' AHI   A7DAFF0E    CC 1
+  000198BA' BRC   A7840004 -> 000198C2'   CC 0
+  000198CE' STM   900EF068 >> 0FA95E78    CC 2
 
 
 
@@ -826,54 +875,79 @@ Useful VM debugger commands
 ---------------------------
 
 I suppose I'd better mention this before I start
-to list the current active traces do 
-Q TR
+to list the current active traces do::
+
+	Q TR
+
 there can be a maximum of 255 of these per set
 ( more about trace sets later ).
-To stop traces issue a
-TR END.
-To delete a particular breakpoint issue
-TR DEL <breakpoint number>
+
+To stop traces issue a::
+
+	TR END.
+
+To delete a particular breakpoint issue::
+
+	TR DEL <breakpoint number>
 
 The PA1 key drops to CP mode so you can issue debugger commands,
-Doing alt c (on my 3270 console at least ) clears the screen. 
+Doing alt c (on my 3270 console at least ) clears the screen.
+
 hitting b <enter> comes back to the running operating system
 from cp mode ( in our case linux ).
+
 It is typically useful to add shortcuts to your profile.exec file
 if you have one ( this is roughly equivalent to autoexec.bat in DOS ).
-file here are a few from mine.
-/* this gives me command history on issuing f12 */
-set pf12 retrieve 
-/* this continues */
-set pf8 imm b
-/* goes to trace set a */
-set pf1 imm tr goto a
-/* goes to trace set b */
-set pf2 imm tr goto b
-/* goes to trace set c */
-set pf3 imm tr goto c
+file here are a few from mine::
+
+  /* this gives me command history on issuing f12 */
+  set pf12 retrieve
+  /* this continues */
+  set pf8 imm b
+  /* goes to trace set a */
+  set pf1 imm tr goto a
+  /* goes to trace set b */
+  set pf2 imm tr goto b
+  /* goes to trace set c */
+  set pf3 imm tr goto c
 
 
 
 Instruction Tracing
 -------------------
-Setting a simple breakpoint
-TR I PSWA <address>
-To debug a particular function try
-TR I R <function address range>
-TR I on its own will single step.
-TR I DATA <MNEMONIC> <OPTIONAL RANGE> will trace for particular mnemonics
-e.g.
-TR I DATA 4D R 0197BC.4000
+Setting a simple breakpoint::
+
+	TR I PSWA <address>
+
+To debug a particular function try::
+
+  TR I R <function address range>
+  TR I on its own will single step.
+  TR I DATA <MNEMONIC> <OPTIONAL RANGE> will trace for particular mnemonics
+
+e.g.::
+
+  TR I DATA 4D R 0197BC.4000
+
 will trace for BAS'es ( opcode 4D ) in the range 0197BC.4000
+
 if you were inclined you could add traces for all branch instructions &
-suffix them with the run prefix so you would have a backtrace on screen 
-when a program crashes.
-TR BR <INTO OR FROM> will trace branches into or out of an address.
-e.g.
-TR BR INTO 0 is often quite useful if a program is getting awkward & deciding
+suffix them with the run prefix so you would have a backtrace on screen
+when a program crashes::
+
+	TR BR <INTO OR FROM> will trace branches into or out of an address.
+
+e.g.::
+
+	TR BR INTO 0
+
+is often quite useful if a program is getting awkward & deciding
 to branch to 0 & crashing as this will stop at the address before in jumps to 0.
-TR I R <address range> RUN cmd d g
+
+::
+
+	TR I R <address range> RUN cmd d g
+
 single steps a range of addresses but stays running &
 displays the gprs on each step.
 
@@ -881,93 +955,129 @@ displays the gprs on each step.
 
 Displaying & modifying Registers
 --------------------------------
-D G will display all the gprs
-Adding a extra G to all the commands is necessary to access the full 64 bit 
+D G
+	will display all the gprs
+
+Adding a extra G to all the commands is necessary to access the full 64 bit
 content in VM on z/Architecture. Obviously this isn't required for access
 registers as these are still 32 bit.
-e.g. DGG instead of DG 
-D X will display all the control registers
-D AR will display all the access registers
-D AR4-7 will display access registers 4 to 7
-CPU ALL D G will display the GRPS of all CPUS in the configuration
-D PSW will display the current PSW
-st PSW 2000 will put the value 2000 into the PSW &
-cause crash your machine.
-D PREFIX displays the prefix offset
+
+e.g.
+
+DGG
+	instead of DG
+
+D X
+	will display all the control registers
+D AR
+	will display all the access registers
+D AR4-7
+	will display access registers 4 to 7
+CPU ALL D G
+	will display the GRPS of all CPUS in the configuration
+D PSW
+	will display the current PSW
+st PSW 2000
+	will put the value 2000 into the PSW & cause crash your machine.
+D PREFIX
+	displays the prefix offset
 
 
 Displaying Memory
 -----------------
-To display memory mapped using the current PSW's mapping try
-D <range>
+To display memory mapped using the current PSW's mapping try::
+
+   D <range>
+
 To make VM display a message each time it hits a particular address and
-continue try
-D I<range> will disassemble/display a range of instructions.
-ST addr 32 bit word will store a 32 bit aligned address
-D T<range> will display the EBCDIC in an address (if you are that way inclined)
-D R<range> will display real addresses ( without DAT ) but with prefixing.
+continue try:
+
+D I<range>
+	will disassemble/display a range of instructions.
+
+ST addr 32 bit word
+	will store a 32 bit aligned address
+D T<range>
+	will display the EBCDIC in an address (if you are that way inclined)
+D R<range>
+	will display real addresses ( without DAT ) but with prefixing.
+
 There are other complex options to display if you need to get at say home space
 but are in primary space the easiest thing to do is to temporarily
 modify the PSW to the other addressing mode, display the stuff & then
 restore it.
 
 
- 
+
 Hints
 -----
 If you want to issue a debugger command without halting your virtual machine
-with the PA1 key try prefixing the command with #CP e.g.
-#cp tr i pswa 2000
+with the PA1 key try prefixing the command with #CP e.g.::
+
+	#cp tr i pswa 2000
+
 also suffixing most debugger commands with RUN will cause them not
 to stop just display the mnemonic at the current instruction on the console.
+
 If you have several breakpoints you want to put into your program &
 you get fed up of cross referencing with System.map
 you can do the following trick for several symbols.
-grep do_signal System.map 
-which emits the following among other things
-0001f4e0 T do_signal 
-now you can do
 
-TR I PSWA 0001f4e0 cmd msg * do_signal
+::
+
+	grep do_signal System.map
+
+which emits the following among other things::
+
+	0001f4e0 T do_signal
+
+now you can do::
+
+	TR I PSWA 0001f4e0 cmd msg * do_signal
+
 This sends a message to your own console each time do_signal is entered.
 ( As an aside I wrote a perl script once which automatically generated a REXX
 script with breakpoints on every kernel procedure, this isn't a good idea
 because there are thousands of these routines & VM can only set 255 breakpoints
-at a time so you nearly had to spend as long pruning the file down as you would 
+at a time so you nearly had to spend as long pruning the file down as you would
 entering the msgs by hand), however, the trick might be useful for a single
 object file. In the 3270 terminal emulator x3270 there is a very useful option
 in the file menu called "Save Screen In File" - this is very good for keeping a
 copy of traces.
 
-From CMS help <command name> will give you online help on a particular command. 
-e.g. 
-HELP DISPLAY
+From CMS help <command name> will give you online help on a particular command.
+e.g.::
+
+	HELP DISPLAY
 
 Also CP has a file called profile.exec which automatically gets called
 on startup of CMS ( like autoexec.bat ), keeping on a DOS analogy session
 CP has a feature similar to doskey, it may be useful for you to
-use profile.exec to define some keystrokes. 
-e.g.
+use profile.exec to define some keystrokes.
+
 SET PF9 IMM B
-This does a single step in VM on pressing F8. 
+	This does a single step in VM on pressing F8.
+
 SET PF10  ^
-This sets up the ^ key.
-which can be used for ^c (ctrl-c),^z (ctrl-z) which can't be typed directly
-into some 3270 consoles.
+	This sets up the ^ key.
+	which can be used for ^c (ctrl-c),^z (ctrl-z) which can't be typed
+	directly into some 3270 consoles.
+
 SET PF11 ^-
-This types the starting keystrokes for a sysrq see SysRq below.
+	This types the starting keystrokes for a sysrq see SysRq below.
 SET PF12 RETRIEVE
-This retrieves command history on pressing F12.
+	This retrieves command history on pressing F12.
 
 
 Sometimes in VM the display is set up to scroll automatically this
 can be very annoying if there are messages you wish to look at
 to stop this do
+
 TERM MORE 255 255
-This will nearly stop automatic screen updates, however it will
-cause a denial of service if lots of messages go to the 3270 console,
-so it would be foolish to use this as the default on a production machine.
- 
+  This will nearly stop automatic screen updates, however it will
+  cause a denial of service if lots of messages go to the 3270 console,
+  so it would be foolish to use this as the default on a production machine.
+
 
 Tracing particular processes
 ----------------------------
@@ -976,69 +1086,116 @@ very seldom collide with text segments of user programs ( thanks Martin ),
 this simplifies debugging the kernel.
 However it is quite common for user processes to have addresses which collide
 this can make debugging a particular process under VM painful under normal
-circumstances as the process may change when doing a 
-TR I R <address range>.
+circumstances as the process may change when doing a::
+
+	TR I R <address range>.
+
 Thankfully after reading VM's online help I figured out how to debug
 I particular process.
 
 Your first problem is to find the STD ( segment table designation )
 of the program you wish to debug.
 There are several ways you can do this here are a few
-1) objdump --syms <program to be debugged> | grep main
-To get the address of main in the program.
-tr i pswa <address of main>
+
+Run::
+
+	objdump --syms <program to be debugged> | grep main
+
+To get the address of main in the program. Then::
+
+	tr i pswa <address of main>
+
 Start the program, if VM drops to CP on what looks like the entry
 point of the main function this is most likely the process you wish to debug.
 Now do a D X13 or D XG13 on z/Architecture.
-On 31 bit the STD is bits 1-19 ( the STO segment table origin ) 
+
+On 31 bit the STD is bits 1-19 ( the STO segment table origin )
 & 25-31 ( the STL segment table length ) of CR13.
-now type
-TR I R STD <CR13's value> 0.7fffffff
-e.g.
-TR I R STD 8F32E1FF 0.7fffffff
-Another very useful variation is
-TR STORE INTO STD <CR13's value> <address range>
+
+now type::
+
+	TR I R STD <CR13's value> 0.7fffffff
+
+e.g.::
+
+	TR I R STD 8F32E1FF 0.7fffffff
+
+Another very useful variation is::
+
+	TR STORE INTO STD <CR13's value> <address range>
+
 for finding out when a particular variable changes.
 
-An alternative way of finding the STD of a currently running process 
+An alternative way of finding the STD of a currently running process
 is to do the following, ( this method is more complex but
 could be quite convenient if you aren't updating the kernel much &
 so your kernel structures will stay constant for a reasonable period of
 time ).
 
-grep task /proc/<pid>/status
-from this you should see something like
-task: 0f160000 ksp: 0f161de8 pt_regs: 0f161f68
+::
+
+	grep task /proc/<pid>/status
+
+from this you should see something like::
+
+	task: 0f160000 ksp: 0f161de8 pt_regs: 0f161f68
+
 This now gives you a pointer to the task structure.
-Now make CC:="s390-gcc -g" kernel/sched.s
+
+Now make::
+
+	CC:="s390-gcc -g" kernel/sched.s
+
 To get the task_struct stabinfo.
+
 ( task_struct is defined in include/linux/sched.h ).
+
 Now we want to look at
 task->active_mm->pgd
+
 on my machine the active_mm in the task structure stab is
 active_mm:(4,12),672,32
+
 its offset is 672/8=84=0x54
+
 the pgd member in the mm_struct stab is
 pgd:(4,6)=*(29,5),96,32
 so its offset is 96/8=12=0xc
 
-so we'll
-hexdump -s 0xf160054 /dev/mem | more
+so we'll::
+
+	hexdump -s 0xf160054 /dev/mem | more
+
 i.e. task_struct+active_mm offset
-to look at the active_mm member
-f160054 0fee cc60 0019 e334 0000 0000 0000 0011
-hexdump -s 0x0feecc6c /dev/mem | more
-i.e. active_mm+pgd offset
-feecc6c 0f2c 0000 0000 0001 0000 0001 0000 0010
+to look at the active_mm member::
+
+	f160054 0fee cc60 0019 e334 0000 0000 0000 0011
+
+::
+
+	hexdump -s 0x0feecc6c /dev/mem | more
+
+i.e. active_mm+pgd offset::
+
+	feecc6c 0f2c 0000 0000 0001 0000 0001 0000 0010
+
 we get something like
-now do 
-TR I R STD <pgd|0x7f> 0.7fffffff
+now do::
+
+	TR I R STD <pgd|0x7f> 0.7fffffff
+
 i.e. the 0x7f is added because the pgd only
 gives the page table origin & we need to set the low bits
 to the maximum possible segment table length.
-TR I R STD 0f2c007f 0.7fffffff
-on z/Architecture you'll probably need to do
-TR I R STD <pgd|0x7> 0.ffffffffffffffff
+
+::
+
+	TR I R STD 0f2c007f 0.7fffffff
+
+on z/Architecture you'll probably need to do::
+
+	TR I R STD <pgd|0x7> 0.ffffffffffffffff
+
 to set the TableType to 0x1 & the Table length to 3.
 
 
@@ -1051,40 +1208,51 @@ You can restart linux & trace these using the tr prog <range or value> trace
 option.
 
 
-The most common ones you will normally be tracing for is
-1=operation exception
-2=privileged operation exception
-4=protection exception
-5=addressing exception
-6=specification exception
-10=segment translation exception
-11=page translation exception
+The most common ones you will normally be tracing for is:
+
+- 1=operation exception
+- 2=privileged operation exception
+- 4=protection exception
+- 5=addressing exception
+- 6=specification exception
+- 10=segment translation exception
+- 11=page translation exception
 
 The full list of these is on page 22 of the current s/390 Reference Summary.
 e.g.
+
 tr prog 10 will trace segment translation exceptions.
+
 tr prog on its own will trace all program interruption codes.
 
 Trace Sets
 ----------
 On starting VM you are initially in the INITIAL trace set.
 You can do a Q TR to verify this.
-If you have a complex tracing situation where you wish to wait for instance 
+If you have a complex tracing situation where you wish to wait for instance
 till a driver is open before you start tracing IO, but know in your
 heart that you are going to have to make several runs through the code till you
-have a clue whats going on. 
+have a clue whats going on.
+
+What you can do is::
+
+	TR I PSWA <Driver open address>
 
-What you can do is
-TR I PSWA <Driver open address>
 hit b to continue till breakpoint
+
 reach the breakpoint
-now do your
-TR GOTO B 
-TR IO 7c08-7c09 inst int run 
+
+now do your::
+
+	TR GOTO B
+	TR IO 7c08-7c09 inst int run
+
 or whatever the IO channels you wish to trace are & hit b
 
-To got back to the initial trace set do
-TR GOTO INITIAL
+To got back to the initial trace set do::
+
+	TR GOTO INITIAL
+
 & the TR I PSWA <Driver open address> will be the only active breakpoint again.
 
 
@@ -1093,11 +1261,14 @@ Tracing linux syscalls under VM
 Syscalls are implemented on Linux for S390 by the Supervisor call instruction
 (SVC). There 256 possibilities of these as the instruction is made up of a 0xA
 opcode and the second byte being the syscall number. They are traced using the
-simple command:
-TR SVC  <Optional value or range>
+simple command::
+
+	TR SVC  <Optional value or range>
+
 the syscalls are defined in linux/arch/s390/include/asm/unistd.h
-e.g. to trace all file opens just do
-TR SVC 5 ( as this is the syscall number of open )
+e.g. to trace all file opens just do::
+
+	TR SVC 5 ( as this is the syscall number of open )
 
 
 SMP Specific commands
@@ -1105,33 +1276,51 @@ SMP Specific commands
 To find out how many cpus you have
 Q CPUS displays all the CPU's available to your virtual machine
 To find the cpu that the current cpu VM debugger commands are being directed at
-do Q CPU to change the current cpu VM debugger commands are being directed at do
-CPU <desired cpu no>
+do Q CPU to change the current cpu VM debugger commands are being directed at
+do::
+
+	CPU <desired cpu no>
 
 On a SMP guest issue a command to all CPUs try prefixing the command with cpu
-all. To issue a command to a particular cpu try cpu <cpu number> e.g.
-CPU 01 TR I R 2000.3000
+all. To issue a command to a particular cpu try cpu <cpu number> e.g.::
+
+	CPU 01 TR I R 2000.3000
+
 If you are running on a guest with several cpus & you have a IO related problem
 & cannot follow the flow of code but you know it isn't smp related.
-from the bash prompt issue
-shutdown -h now or halt.
-do a Q CPUS to find out how many cpus you have
-detach each one of them from cp except cpu 0 
-by issuing a 
-DETACH CPU 01-(number of cpus in configuration)
+
+from the bash prompt issue::
+
+	shutdown -h now or halt.
+
+do a::
+
+	Q CPUS
+
+to find out how many cpus you have detach each one of them from cp except
+cpu 0 by issuing a::
+
+	DETACH CPU 01-(number of cpus in configuration)
+
 & boot linux again.
-TR SIGP will trace inter processor signal processor instructions.
-DEFINE CPU 01-(number in configuration) 
-will get your guests cpus back.
+
+TR SIGP
+	will trace inter processor signal processor instructions.
+
+DEFINE CPU 01-(number in configuration)
+	will get your guests cpus back.
 
 
 Help for displaying ascii textstrings
 -------------------------------------
 On the very latest VM Nucleus'es VM can now display ascii
-( thanks Neale for the hint ) by doing
-D TX<lowaddr>.<len>
-e.g.
-D TX0.100
+( thanks Neale for the hint ) by doing::
+
+	D TX<lowaddr>.<len>
+
+e.g.::
+
+	D TX0.100
 
 Alternatively
 =============
@@ -1143,66 +1332,85 @@ to your xterm if you are debugging from a linuxbox.
 This is quite useful when looking at a parameter passed in as a text string
 under VM ( unless you are good at decoding ASCII in your head ).
 
-e.g. consider tracing an open syscall
-TR SVC 5
-We have stopped at a breakpoint
-000151B0' SVC   0A05     -> 0001909A'   CC 0
+e.g. consider tracing an open syscall::
+
+	TR SVC 5
+
+We have stopped at a breakpoint::
+
+	000151B0' SVC   0A05     -> 0001909A'   CC 0
 
 D 20.8 to check the SVC old psw in the prefix area and see was it from userspace
 (for the layout of the prefix area consult the "Fixed Storage Locations"
 chapter of the s/390 Reference Summary if you have it available).
-V00000020  070C2000 800151B2
+
+::
+
+  V00000020  070C2000 800151B2
+
 The problem state bit wasn't set &  it's also too early in the boot sequence
-for it to be a userspace SVC if it was we would have to temporarily switch the 
+for it to be a userspace SVC if it was we would have to temporarily switch the
 psw to user space addressing so we could get at the first parameter of the open
 in gpr2.
-Next do a 
-D G2
-GPR  2 =  00014CB4
-Now display what gpr2 is pointing to
-D 00014CB4.20
-V00014CB4  2F646576 2F636F6E 736F6C65 00001BF5
-V00014CC4  FC00014C B4001001 E0001000 B8070707
+
+Next do a::
+
+	D G2
+	GPR  2 =  00014CB4
+
+Now display what gpr2 is pointing to::
+
+	D 00014CB4.20
+	V00014CB4  2F646576 2F636F6E 736F6C65 00001BF5
+	V00014CC4  FC00014C B4001001 E0001000 B8070707
+
 Now copy the text till the first 00 hex ( which is the end of the string
-to an xterm & do hex2ascii on it.
-hex2ascii 2F646576 2F636F6E 736F6C65 00 
-outputs
-Decoded Hex:=/ d e v / c o n s o l e 0x00 
+to an xterm & do hex2ascii on it::
+
+	hex2ascii 2F646576 2F636F6E 736F6C65 00
+
+outputs::
+
+	Decoded Hex:=/ d e v / c o n s o l e 0x00
+
 We were opening the console device,
 
 You can compile the code below yourself for practice :-),
-/*
- *    hex2ascii.c
- *    a useful little tool for converting a hexadecimal command line to ascii
- *
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
- *    (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation.
- */   
-#include <stdio.h>
 
-int main(int argc,char *argv[])
-{
-  int cnt1,cnt2,len,toggle=0;
-  int startcnt=1;
-  unsigned char c,hex;
-  
-  if(argc>1&&(strcmp(argv[1],"-a")==0))
-     startcnt=2;
-  printf("Decoded Hex:=");
-  for(cnt1=startcnt;cnt1<argc;cnt1++)
+::
+
+  /*
+   *    hex2ascii.c
+   *    a useful little tool for converting a hexadecimal command line to ascii
+   *
+   *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
+   *    (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation.
+   */
+  #include <stdio.h>
+
+  int main(int argc,char *argv[])
   {
-    len=strlen(argv[cnt1]);
-    for(cnt2=0;cnt2<len;cnt2++)
+    int cnt1,cnt2,len,toggle=0;
+    int startcnt=1;
+    unsigned char c,hex;
+
+    if(argc>1&&(strcmp(argv[1],"-a")==0))
+       startcnt=2;
+    printf("Decoded Hex:=");
+    for(cnt1=startcnt;cnt1<argc;cnt1++)
     {
-       c=argv[cnt1][cnt2];
-       if(c>='0'&&c<='9')
+      len=strlen(argv[cnt1]);
+      for(cnt2=0;cnt2<len;cnt2++)
+      {
+	 c=argv[cnt1][cnt2];
+	 if(c>='0'&&c<='9')
 	  c=c-'0';
-       if(c>='A'&&c<='F')
+	 if(c>='A'&&c<='F')
 	  c=c-'A'+10;
-       if(c>='a'&&c<='f')
+	 if(c>='a'&&c<='f')
 	  c=c-'a'+10;
-       switch(toggle)
-       {
+	 switch(toggle)
+	 {
 	  case 0:
 	     hex=c<<4;
 	     toggle=1;
@@ -1224,11 +1432,11 @@ int main(int argc,char *argv[])
 	     }
 	     toggle=0;
 	  break;
-       }
+	 }
+      }
     }
+    printf("\n");
   }
-  printf("\n");
-}
 
 
 
@@ -1248,48 +1456,58 @@ should be able to sniff further back if you follow the following tricks.
 1) A kernel address should be easy to recognise since it is in
 primary space & the problem state bit isn't set & also
 The Hi bit of the address is set.
-2) Another backchain should also be easy to recognise since it is an 
+2) Another backchain should also be easy to recognise since it is an
 address pointing to another address approximately 100 bytes or 0x70 hex
 behind the current stackpointer.
 
 
 Here is some practice.
+
 boot the kernel & hit PA1 at some random time
-d g to display the gprs, this should display something like
-GPR  0 =  00000001  00156018  0014359C  00000000
-GPR  4 =  00000001  001B8888  000003E0  00000000
-GPR  8 =  00100080  00100084  00000000  000FE000
-GPR 12 =  00010400  8001B2DC  8001B36A  000FFED8
+
+d g to display the gprs, this should display something like::
+
+  GPR  0 =  00000001  00156018  0014359C  00000000
+  GPR  4 =  00000001  001B8888  000003E0  00000000
+  GPR  8 =  00100080  00100084  00000000  000FE000
+  GPR 12 =  00010400  8001B2DC  8001B36A  000FFED8
+
 Note that GPR14 is a return address but as we are real men we are going to
 trace the stack.
-display 0x40 bytes after the stack pointer.
+display 0x40 bytes after the stack pointer::
 
-V000FFED8  000FFF38 8001B838 80014C8E 000FFF38
-V000FFEE8  00000000 00000000 000003E0 00000000
-V000FFEF8  00100080 00100084 00000000 000FE000
-V000FFF08  00010400 8001B2DC 8001B36A 000FFED8
+  V000FFED8  000FFF38 8001B838 80014C8E 000FFF38
+  V000FFEE8  00000000 00000000 000003E0 00000000
+  V000FFEF8  00100080 00100084 00000000 000FE000
+  V000FFF08  00010400 8001B2DC 8001B36A 000FFED8
 
 
 Ah now look at whats in sp+56 (sp+0x38) this is 8001B36A our saved r14 if
 you look above at our stackframe & also agrees with GPR14.
 
-now backchain 
-d 000FFF38.40
-we now are taking the contents of SP to get our first backchain.
+now backchain::
 
-V000FFF38  000FFFA0 00000000 00014995 00147094
-V000FFF48  00147090 001470A0 000003E0 00000000
-V000FFF58  00100080 00100084 00000000 001BF1D0
-V000FFF68  00010400 800149BA 80014CA6 000FFF38
+	d 000FFF38.40
+
+we now are taking the contents of SP to get our first backchain::
+
+  V000FFF38  000FFFA0 00000000 00014995 00147094
+  V000FFF48  00147090 001470A0 000003E0 00000000
+  V000FFF58  00100080 00100084 00000000 001BF1D0
+  V000FFF68  00010400 800149BA 80014CA6 000FFF38
 
 This displays a 2nd return address of 80014CA6
 
-now do d 000FFFA0.40 for our 3rd backchain
+now do::
 
-V000FFFA0  04B52002 0001107F 00000000 00000000
-V000FFFB0  00000000 00000000 FF000000 0001107F
-V000FFFC0  00000000 00000000 00000000 00000000
-V000FFFD0  00010400 80010802 8001085A 000FFFA0
+	d 000FFFA0.40
+
+for our 3rd backchain::
+
+  V000FFFA0  04B52002 0001107F 00000000 00000000
+  V000FFFB0  00000000 00000000 FF000000 0001107F
+  V000FFFC0  00000000 00000000 00000000 00000000
+  V000FFFD0  00010400 80010802 8001085A 000FFFA0
 
 
 our 3rd return address is 8001085A
@@ -1297,23 +1515,35 @@ our 3rd return address is 8001085A
 as the 04B52002 looks suspiciously like rubbish it is fair to assume that the
 kernel entry routines for the sake of optimisation don't set up a backchain.
 
-now look at System.map to see if the addresses make any sense.
+now look at System.map to see if the addresses make any sense::
+
+	grep -i 0001b3 System.map
+
+outputs among other things::
+
+	0001b304 T cpu_idle
 
-grep -i 0001b3 System.map
-outputs among other things
-0001b304 T cpu_idle 
 so 8001B36A
 is cpu_idle+0x66 ( quiet the cpu is asleep, don't wake it )
 
+::
+
+	grep -i 00014 System.map
+
+produces among other things::
+
+	00014a78 T start_kernel
 
-grep -i 00014 System.map 
-produces among other things
-00014a78 T start_kernel  
 so 0014CA6 is start_kernel+some hex number I can't add in my head.
 
-grep -i 00108 System.map 
-this produces
-00010800 T _stext
+::
+
+	grep -i 00108 System.map
+
+this produces::
+
+	00010800 T _stext
+
 so   8001085A is _stext+0x5a
 
 Congrats you've done your first backchain.
@@ -1337,47 +1567,49 @@ system might be choking with around 64.
 Here is some of the common IO terminology:
 
 Subchannel:
-This is the logical number most IO commands use to talk to an IO device. There
-can be up to 0x10000 (65536) of these in a configuration, typically there are a
-few hundred. Under VM for simplicity they are allocated contiguously, however
-on the native hardware they are not. They typically stay consistent between
-boots provided no new hardware is inserted or removed.
-Under Linux for s390 we use these as IRQ's and also when issuing an IO command
-(CLEAR SUBCHANNEL, HALT SUBCHANNEL, MODIFY SUBCHANNEL, RESUME SUBCHANNEL,
-START SUBCHANNEL, STORE SUBCHANNEL and TEST SUBCHANNEL). We use this as the ID
-of the device we wish to talk to. The most important of these instructions are
-START SUBCHANNEL (to start IO), TEST SUBCHANNEL (to check whether the IO
-completed successfully) and HALT SUBCHANNEL (to kill IO). A subchannel can have
-up to 8 channel paths to a device, this offers redundancy if one is not
-available.
+  This is the logical number most IO commands use to talk to an IO device. There
+  can be up to 0x10000 (65536) of these in a configuration, typically there are a
+  few hundred. Under VM for simplicity they are allocated contiguously, however
+  on the native hardware they are not. They typically stay consistent between
+  boots provided no new hardware is inserted or removed.
+
+  Under Linux for s390 we use these as IRQ's and also when issuing an IO command
+  (CLEAR SUBCHANNEL, HALT SUBCHANNEL, MODIFY SUBCHANNEL, RESUME SUBCHANNEL,
+  START SUBCHANNEL, STORE SUBCHANNEL and TEST SUBCHANNEL). We use this as the ID
+  of the device we wish to talk to. The most important of these instructions are
+  START SUBCHANNEL (to start IO), TEST SUBCHANNEL (to check whether the IO
+  completed successfully) and HALT SUBCHANNEL (to kill IO). A subchannel can have
+  up to 8 channel paths to a device, this offers redundancy if one is not
+  available.
 
 Device Number:
-This number remains static and is closely tied to the hardware. There are 65536
-of these, made up of a CHPID (Channel Path ID, the most significant 8 bits) and
-another lsb 8 bits. These remain static even if more devices are inserted or
-removed from the hardware. There is a 1 to 1 mapping between subchannels and
-device numbers, provided devices aren't inserted or removed.
+  This number remains static and is closely tied to the hardware. There are 65536
+  of these, made up of a CHPID (Channel Path ID, the most significant 8 bits) and
+  another lsb 8 bits. These remain static even if more devices are inserted or
+  removed from the hardware. There is a 1 to 1 mapping between subchannels and
+  device numbers, provided devices aren't inserted or removed.
 
 Channel Control Words:
-CCWs are linked lists of instructions initially pointed to by an operation
-request block (ORB), which is initially given to Start Subchannel (SSCH)
-command along with the subchannel number for the IO subsystem to process
-while the CPU continues executing normal code.
-CCWs come in two flavours, Format 0 (24 bit for backward compatibility) and
-Format 1 (31 bit). These are typically used to issue read and write (and many
-other) instructions. They consist of a length field and an absolute address
-field.
-Each IO typically gets 1 or 2 interrupts, one for channel end (primary status)
-when the channel is idle, and the second for device end (secondary status).
-Sometimes you get both concurrently. You check how the IO went on by issuing a
-TEST SUBCHANNEL at each interrupt, from which you receive an Interruption
-response block (IRB). If you get channel and device end status in the IRB
-without channel checks etc. your IO probably went okay. If you didn't you
-probably need to examine the IRB, extended status word etc.
-If an error occurs, more sophisticated control units have a facility known as
-concurrent sense. This means that if an error occurs Extended sense information
-will be presented in the Extended status word in the IRB. If not you have to
-issue a subsequent SENSE CCW command after the test subchannel.
+  CCWs are linked lists of instructions initially pointed to by an operation
+  request block (ORB), which is initially given to Start Subchannel (SSCH)
+  command along with the subchannel number for the IO subsystem to process
+  while the CPU continues executing normal code.
+  CCWs come in two flavours, Format 0 (24 bit for backward compatibility) and
+  Format 1 (31 bit). These are typically used to issue read and write (and many
+  other) instructions. They consist of a length field and an absolute address
+  field.
+
+  Each IO typically gets 1 or 2 interrupts, one for channel end (primary status)
+  when the channel is idle, and the second for device end (secondary status).
+  Sometimes you get both concurrently. You check how the IO went on by issuing a
+  TEST SUBCHANNEL at each interrupt, from which you receive an Interruption
+  response block (IRB). If you get channel and device end status in the IRB
+  without channel checks etc. your IO probably went okay. If you didn't you
+  probably need to examine the IRB, extended status word etc.
+  If an error occurs, more sophisticated control units have a facility known as
+  concurrent sense. This means that if an error occurs Extended sense information
+  will be presented in the Extended status word in the IRB. If not you have to
+  issue a subsequent SENSE CCW command after the test subchannel.
 
 
 TPI (Test pending interrupt) can also be used for polled IO, but in
@@ -1388,58 +1620,62 @@ Store Subchannel and Modify Subchannel can be used to examine and modify
 operating characteristics of a subchannel (e.g. channel paths).
 
 Other IO related Terms:
-Sysplex: S390's Clustering Technology
-QDIO: S390's new high speed IO architecture to support devices such as gigabit
-ethernet, this architecture is also designed to be forward compatible with
-upcoming 64 bit machines.
 
+Sysplex:
+  S390's Clustering Technology
+QDIO:
+  S390's new high speed IO architecture to support devices such as gigabit
+  ethernet, this architecture is also designed to be forward compatible with
+  upcoming 64 bit machines.
 
-General Concepts 
+
+General Concepts
+----------------
 
 Input Output Processors (IOP's) are responsible for communicating between
 the mainframe CPU's & the channel & relieve the mainframe CPU's from the
-burden of communicating with IO devices directly, this allows the CPU's to 
-concentrate on data processing. 
+burden of communicating with IO devices directly, this allows the CPU's to
+concentrate on data processing.
 
-IOP's can use one or more links ( known as channel paths ) to talk to each 
+IOP's can use one or more links ( known as channel paths ) to talk to each
 IO device. It first checks for path availability & chooses an available one,
 then starts ( & sometimes terminates IO ).
 There are two types of channel path: ESCON & the Parallel IO interface.
 
 IO devices are attached to control units, control units provide the
-logic to interface the channel paths & channel path IO protocols to 
+logic to interface the channel paths & channel path IO protocols to
 the IO devices, they can be integrated with the devices or housed separately
-& often talk to several similar devices ( typical examples would be raid 
-controllers or a control unit which connects to 1000 3270 terminals ).
+& often talk to several similar devices ( typical examples would be raid
+controllers or a control unit which connects to 1000 3270 terminals )::
 
 
-    +---------------------------------------------------------------+
-    | +-----+ +-----+ +-----+ +-----+  +----------+  +----------+   |
-    | | CPU | | CPU | | CPU | | CPU |  |  Main    |  | Expanded |   |
-    | |     | |     | |     | |     |  |  Memory  |  |  Storage |   |
-    | +-----+ +-----+ +-----+ +-----+  +----------+  +----------+   | 
-    |---------------------------------------------------------------+
-    |   IOP        |      IOP      |       IOP                      |
-    |---------------------------------------------------------------
-    | C | C | C | C | C | C | C | C | C | C | C | C | C | C | C | C | 
-    ----------------------------------------------------------------
-         ||                                              ||
-         ||  Bus & Tag Channel Path                      || ESCON
-         ||  ======================                      || Channel
-         ||  ||                  ||                      || Path
-    +----------+               +----------+         +----------+
-    |          |               |          |         |          |
-    |    CU    |               |    CU    |         |    CU    |
-    |          |               |          |         |          |
-    +----------+               +----------+         +----------+
-       |      |                     |                |       |
-+----------+ +----------+      +----------+   +----------+ +----------+
-|I/O Device| |I/O Device|      |I/O Device|   |I/O Device| |I/O Device|
-+----------+ +----------+      +----------+   +----------+ +----------+
-  CPU = Central Processing Unit    
-  C = Channel                      
-  IOP = IP Processor               
-  CU = Control Unit
+      +---------------------------------------------------------------+
+      | +-----+ +-----+ +-----+ +-----+  +----------+  +----------+   |
+      | | CPU | | CPU | | CPU | | CPU |  |  Main    |  | Expanded |   |
+      | |     | |     | |     | |     |  |  Memory  |  |  Storage |   |
+      | +-----+ +-----+ +-----+ +-----+  +----------+  +----------+   |
+      |---------------------------------------------------------------+
+      |   IOP        |      IOP      |       IOP                      |
+      |---------------------------------------------------------------
+      | C | C | C | C | C | C | C | C | C | C | C | C | C | C | C | C |
+      ----------------------------------------------------------------
+	   ||                                              ||
+	   ||  Bus & Tag Channel Path                      || ESCON
+	   ||  ======================                      || Channel
+	   ||  ||                  ||                      || Path
+      +----------+               +----------+         +----------+
+      |          |               |          |         |          |
+      |    CU    |               |    CU    |         |    CU    |
+      |          |               |          |         |          |
+      +----------+               +----------+         +----------+
+	 |      |                     |                |       |
+  +----------+ +----------+      +----------+   +----------+ +----------+
+  |I/O Device| |I/O Device|      |I/O Device|   |I/O Device| |I/O Device|
+  +----------+ +----------+      +----------+   +----------+ +----------+
+    CPU = Central Processing Unit
+    C = Channel
+    IOP = IP Processor
+    CU = Control Unit
 
 The 390 IO systems come in 2 flavours the current 390 machines support both
 
@@ -1447,7 +1683,7 @@ The Older 360 & 370 Interface,sometimes called the Parallel I/O interface,
 sometimes called Bus-and Tag & sometimes Original Equipment Manufacturers
 Interface (OEMI).
 
-This byte wide Parallel channel path/bus has parity & data on the "Bus" cable 
+This byte wide Parallel channel path/bus has parity & data on the "Bus" cable
 and control lines on the "Tag" cable. These can operate in byte multiplex mode
 for sharing between several slow devices or burst mode and monopolize the
 channel for the whole burst. Up to 256 devices can be addressed on one of these
@@ -1459,13 +1695,13 @@ support only transfer rates of 3.0, 2.0 & 1.0 MB/sec.
 One of these paths can be daisy chained to up to 8 control units.
 
 
-ESCON if fibre optic it is also called FICON 
+ESCON if fibre optic it is also called FICON
 Was introduced by IBM in 1990. Has 2 fibre optic cables and uses either leds or
 lasers for communication at a signaling rate of up to 200 megabits/sec. As
 10bits are transferred for every 8 bits info this drops to 160 megabits/sec
 and to 18.6 Megabytes/sec once control info and CRC are added. ESCON only
 operates in burst mode.
- 
+
 ESCONs typical max cable length is 3km for the led version and 20km for the
 laser version known as XDF (extended distance facility). This can be further
 extended by using an ESCON director which triples the above mentioned ranges.
@@ -1489,31 +1725,29 @@ Debugging IO on s/390 & z/Architecture under VM
 
 Now we are ready to go on with IO tracing commands under VM
 
-A few self explanatory queries:
-Q OSA
-Q CTC
-Q DISK ( This command is CMS specific )
-Q DASD
+A few self explanatory queries::
 
+	Q OSA
+	Q CTC
+	Q DISK ( This command is CMS specific )
+	Q DASD
 
+Q OSA on my machine returns::
 
-
-
-
-Q OSA on my machine returns
-OSA  7C08 ON OSA   7C08 SUBCHANNEL = 0000
-OSA  7C09 ON OSA   7C09 SUBCHANNEL = 0001
-OSA  7C14 ON OSA   7C14 SUBCHANNEL = 0002
-OSA  7C15 ON OSA   7C15 SUBCHANNEL = 0003
+	OSA  7C08 ON OSA   7C08 SUBCHANNEL = 0000
+	OSA  7C09 ON OSA   7C09 SUBCHANNEL = 0001
+	OSA  7C14 ON OSA   7C14 SUBCHANNEL = 0002
+	OSA  7C15 ON OSA   7C15 SUBCHANNEL = 0003
 
 If you have a guest with certain privileges you may be able to see devices
 which don't belong to you. To avoid this, add the option V.
-e.g.
-Q V OSA
+e.g.::
+
+	Q V OSA
 
 Now using the device numbers returned by this command we will
 Trace the io starting up on the first device 7c08 & 7c09
-In our simplest case we can trace the 
+In our simplest case we can trace the
 start subchannels
 like TR SSCH 7C08-7C09
 or the halt subchannels
@@ -1524,34 +1758,47 @@ A good trick is tracing all the IO's and CCWS and spooling them into the reader
 of another VM guest so he can ftp the logfile back to his own machine. I'll do
 a small bit of this and give you a look at the output.
 
-1) Spool stdout to VM reader
-SP PRT TO (another vm guest ) or * for the local vm guest
-2) Fill the reader with the trace
-TR IO 7c08-7c09 INST INT CCW PRT RUN
-3) Start up linux 
-i 00c  
-4) Finish the trace
-TR END
-5) close the reader
-C PRT
-6) list reader contents
-RDRLIST
-7) copy it to linux4's minidisk 
-RECEIVE / LOG TXT A1 ( replace
+1) Spool stdout to VM reader::
+
+	SP PRT TO (another vm guest ) or * for the local vm guest
+
+2) Fill the reader with the trace::
+
+	TR IO 7c08-7c09 INST INT CCW PRT RUN
+
+3) Start up linux::
+
+	i 00c
+4) Finish the trace::
+
+	TR END
+
+5) close the reader::
+
+	C PRT
+
+6) list reader contents::
+
+	RDRLIST
+
+7) copy it to linux4's minidisk::
+
+	RECEIVE / LOG TXT A1 ( replace
+
 8)
 filel & press F11 to look at it
-You should see something like:
+You should see something like::
 
-00020942' SSCH  B2334000    0048813C    CC 0    SCH 0000    DEV 7C08
-          CPA 000FFDF0   PARM 00E2C9C4    KEY 0  FPI C0  LPM 80
-          CCW    000FFDF0  E4200100 00487FE8   0000  E4240100 ........
-          IDAL                                      43D8AFE8
-          IDAL                                      0FB76000
-00020B0A'   I/O DEV 7C08 -> 000197BC'   SCH 0000   PARM 00E2C9C4
-00021628' TSCH  B2354000 >> 00488164    CC 0    SCH 0000    DEV 7C08
-          CCWA 000FFDF8   DEV STS 0C  SCH STS 00  CNT 00EC
-           KEY 0   FPI C0  CC 0   CTLS 4007
-00022238' STSCH B2344000 >> 00488108    CC 0    SCH 0000    DEV 7C08
+  00020942' SSCH  B2334000    0048813C    CC 0    SCH 0000    DEV 7C08
+	    CPA 000FFDF0   PARM 00E2C9C4    KEY 0  FPI C0  LPM 80
+	    CCW    000FFDF0  E4200100 00487FE8   0000  E4240100 ........
+	    IDAL                                      43D8AFE8
+	    IDAL                                      0FB76000
+  00020B0A'   I/O DEV 7C08 -> 000197BC'   SCH 0000   PARM 00E2C9C4
+  00021628' TSCH  B2354000 >> 00488164    CC 0    SCH 0000    DEV 7C08
+	    CCWA 000FFDF8   DEV STS 0C  SCH STS 00  CNT 00EC
+	     KEY 0   FPI C0  CC 0   CTLS 4007
+  00022238' STSCH B2344000 >> 00488108    CC 0    SCH 0000    DEV 7C08
 
 If you don't like messing up your readed ( because you possibly booted from it )
 you can alternatively spool it to another readers guest.
@@ -1563,43 +1810,58 @@ These commands are listed only because they have
 been of use to me in the past & may be of use to
 you too. For more complete info on each of the commands
 use type HELP <command> from CMS.
-detaching devices
-DET <devno range>
-ATT <devno range> <guest> 
+
+detaching devices::
+
+	DET <devno range>
+	ATT <devno range> <guest>
+
 attach a device to guest * for your own guest
-READY <devno> cause VM to issue a fake interrupt.
 
-The VARY command is normally only available to VM administrators.
-VARY ON PATH <path> TO <devno range>
-VARY OFF PATH <PATH> FROM <devno range>
+READY <devno>
+	cause VM to issue a fake interrupt.
+
+The VARY command is normally only available to VM administrators::
+
+	VARY ON PATH <path> TO <devno range>
+	VARY OFF PATH <PATH> FROM <devno range>
+
 This is used to switch on or off channel paths to devices.
 
 Q CHPID <channel path ID>
-This displays state of devices using this channel path
+   This displays state of devices using this channel path
+
 D SCHIB <subchannel>
-This displays the subchannel information SCHIB block for the device.
-this I believe is also only available to administrators.
+   This displays the subchannel information SCHIB block for the device.
+   this I believe is also only available to administrators.
+
 DEFINE CTC <devno>
-defines a virtual CTC channel to channel connection
-2 need to be defined on each guest for the CTC driver to use.
+  defines a virtual CTC channel to channel connection
+  2 need to be defined on each guest for the CTC driver to use.
+
 COUPLE  devno userid remote devno
-Joins a local virtual device to a remote virtual device
-( commonly used for the CTC driver ).
+  Joins a local virtual device to a remote virtual device
+  ( commonly used for the CTC driver ).
+
+Building a VM ramdisk under CMS which linux can use::
+
+	def vfb-<blocksize> <subchannel> <number blocks>
 
-Building a VM ramdisk under CMS which linux can use
-def vfb-<blocksize> <subchannel> <number blocks>
 blocksize is commonly 4096 for linux.
-Formatting it
-format <subchannel> <driver letter e.g. x> (blksize <blocksize>
 
-Sharing a disk between multiple guests
-LINK userid devno1 devno2 mode password
+Formatting it::
+
+	format <subchannel> <driver letter e.g. x> (blksize <blocksize>
+
+Sharing a disk between multiple guests::
+
+	LINK userid devno1 devno2 mode password
 
 
 
 GDB on S390
 ===========
-N.B. if compiling for debugging gdb works better without optimisation 
+N.B. if compiling for debugging gdb works better without optimisation
 ( see Compiling programs for debugging )
 
 invocation
@@ -1609,113 +1871,169 @@ gdb <victim program> <optional corefile>
 Online help
 -----------
 help: gives help on commands
-e.g.
-help
-help display
+
+e.g.::
+
+	help
+	help display
+
 Note gdb's online help is very good use it.
 
 
 Assembly
 --------
-info registers: displays registers other than floating point.
-info all-registers: displays floating points as well.
-disassemble: disassembles
-e.g.
-disassemble without parameters will disassemble the current function
-disassemble $pc $pc+10 
+info registers:
+  displays registers other than floating point.
+
+info all-registers:
+  displays floating points as well.
+
+disassemble:
+  disassembles
+
+e.g.::
+
+	disassemble without parameters will disassemble the current function
+	disassemble $pc $pc+10
 
 Viewing & modifying variables
 -----------------------------
-print or p: displays variable or register
+print or p:
+  displays variable or register
+
 e.g. p/x $sp will display the stack pointer
 
-display: prints variable or register each time program stops
-e.g.
-display/x $pc will display the program counter
-display argc
+display:
+  prints variable or register each time program stops
 
-undisplay : undo's display's
+e.g.::
 
-info breakpoints: shows all current breakpoints
+	display/x $pc will display the program counter
+	display argc
 
-info stack: shows stack back trace (if this doesn't work too well, I'll show
-you the stacktrace by hand below).
+undisplay:
+  undo's display's
 
-info locals: displays local variables.
+info breakpoints:
+  shows all current breakpoints
 
-info args: display current procedure arguments.
+info stack:
+  shows stack back trace (if this doesn't work too well, I'll show
+  you the stacktrace by hand below).
 
-set args: will set argc & argv each time the victim program is invoked.
+info locals:
+  displays local variables.
 
-set <variable>=value
-set argc=100
-set $pc=0
+info args:
+  display current procedure arguments.
+
+set args:
+  will set argc & argv each time the victim program is invoked
+
+e.g.::
+
+	set <variable>=value
+	set argc=100
+	set $pc=0
 
 
 
 Modifying execution
 -------------------
-step: steps n lines of sourcecode
-step steps 1 line.
-step 100 steps 100 lines of code.
+step:
+  steps n lines of sourcecode
 
-next: like step except this will not step into subroutines
+step
+  steps 1 line.
 
-stepi: steps a single machine code instruction.
-e.g. stepi 100
+step 100
+  steps 100 lines of code.
 
-nexti: steps a single machine code instruction but will not step into
-subroutines.
+next:
+	like step except this will not step into subroutines
 
-finish: will run until exit of the current routine
+stepi:
+	steps a single machine code instruction.
 
-run: (re)starts a program
+e.g.::
 
-cont: continues a program
+	stepi 100
 
-quit: exits gdb.
+nexti:
+	steps a single machine code instruction but will not step into
+	subroutines.
+
+finish:
+	will run until exit of the current routine
+
+run:
+	(re)starts a program
+
+cont:
+	continues a program
+
+quit:
+	exits gdb.
 
 
 breakpoints
 ------------
 
 break
-sets a breakpoint
-e.g.
+  sets a breakpoint
 
-break main
+e.g.::
 
-break *$pc
-
-break *0x400618
+	break main
+	break *$pc
+	break *0x400618
 
 Here's a really useful one for large programs
+
 rbr
-Set a breakpoint for all functions matching REGEXP
-e.g.
-rbr 390
+	Set a breakpoint for all functions matching REGEXP
+
+e.g.::
+
+	rbr 390
+
 will set a breakpoint with all functions with 390 in their name.
 
 info breakpoints
-lists all breakpoints
+	lists all breakpoints
+
+delete:
+	delete breakpoint by number or delete them all
 
-delete: delete breakpoint by number or delete them all
 e.g.
-delete 1 will delete the first breakpoint
-delete will delete them all
 
-watch: This will set a watchpoint ( usually hardware assisted ),
+delete 1
+	will delete the first breakpoint
+
+
+delete
+	will delete them all
+
+watch:
+	This will set a watchpoint ( usually hardware assisted ),
+
 This will watch a variable till it changes
+
 e.g.
-watch cnt, will watch the variable cnt till it changes.
+
+watch cnt
+	will watch the variable cnt till it changes.
+
 As an aside unfortunately gdb's, architecture independent watchpoint code
 is inconsistent & not very good, watchpoints usually work but not always.
 
-info watchpoints: Display currently active watchpoints
+info watchpoints:
+	Display currently active watchpoints
 
 condition: ( another useful one )
-Specify breakpoint number N to break only if COND is true.
-Usage is `condition N COND', where N is an integer and COND is an
+	Specify breakpoint number N to break only if COND is true.
+
+Usage is `condition N COND`, where N is an integer and COND is an
 expression to be evaluated whenever breakpoint N is reached.
 
 
@@ -1723,41 +2041,51 @@ expression to be evaluated whenever breakpoint N is reached.
 User defined functions/macros
 -----------------------------
 define: ( Note this is very very useful,simple & powerful )
+
 usage define <name> <list of commands> end
 
-examples which you should consider putting into .gdbinit in your home directory
-define d
-stepi
-disassemble $pc $pc+10
-end
+examples which you should consider putting into .gdbinit in your home
+directory::
 
-define e
-nexti
-disassemble $pc $pc+10
-end
+	define d
+	stepi
+	disassemble $pc $pc+10
+	end
+	define e
+	nexti
+	disassemble $pc $pc+10
+	end
 
 
 Other hard to classify stuff
 ----------------------------
 signal n:
-sends the victim program a signal.
-e.g. signal 3 will send a SIGQUIT.
+   sends the victim program a signal.
+
+e.g. `signal 3` will send a SIGQUIT.
 
 info signals:
-what gdb does when the victim receives certain signals.
+	what gdb does when the victim receives certain signals.
 
 list:
-e.g.
-list lists current function source
-list 1,10 list first 10 lines of current file.
+
+e.g.:
+
+list
+	lists current function source
+list 1,10
+	list first 10 lines of current file.
+
 list test.c:1,10
 
 
 directory:
-Adds directories to be searched for source if gdb cannot find the source.
-(note it is a bit sensitive about slashes)
-e.g. To add the root of the filesystem to the searchpath do
-directory //
+  Adds directories to be searched for source if gdb cannot find the source.
+  (note it is a bit sensitive about slashes)
+
+e.g. To add the root of the filesystem to the searchpath do::
+
+	directory //
 
 
 call <function>
@@ -1765,153 +2093,205 @@ This calls a function in the victim program, this is pretty powerful
 e.g.
 (gdb) call printf("hello world")
 outputs:
-$1 = 11 
+$1 = 11
 
 You might now be thinking that the line above didn't work, something extra had
 to be done.
 (gdb) call fflush(stdout)
 hello world$2 = 0
-As an aside the debugger also calls malloc & free under the hood 
+As an aside the debugger also calls malloc & free under the hood
 to make space for the "hello world" string.
 
 
 
 hints
 -----
-1) command completion works just like bash 
-( if you are a bad typist like me this really helps )
+1) command completion works just like bash
+   ( if you are a bad typist like me this really helps )
+
 e.g. hit br <TAB> & cursor up & down :-).
 
 2) if you have a debugging problem that takes a few steps to recreate
 put the steps into a file called .gdbinit in your current working directory
-if you have defined a few extra useful user defined commands put these in 
+if you have defined a few extra useful user defined commands put these in
 your home directory & they will be read each time gdb is launched.
 
-A typical .gdbinit file might be.
-break main
-run
-break runtime_exception
-cont 
+A typical .gdbinit file might be.::
+
+	break main
+	run
+	break runtime_exception
+	cont
 
 
 stack chaining in gdb by hand
 -----------------------------
-This is done using a the same trick described for VM 
-p/x (*($sp+56))&0x7fffffff get the first backchain.
+This is done using a the same trick described for VM::
+
+	p/x (*($sp+56))&0x7fffffff
+
+get the first backchain.
 
 For z/Architecture
 Replace 56 with 112 & ignore the &0x7fffffff
 in the macros below & do nasty casts to longs like the following
 as gdb unfortunately deals with printed arguments as ints which
 messes up everything.
-i.e. here is a 3rd backchain dereference
-p/x *(long *)(***(long ***)$sp+112)
 
+i.e. here is a 3rd backchain dereference::
+
+	p/x *(long *)(***(long ***)$sp+112)
+
+
+this outputs::
+
+	$5 = 0x528f18
 
-this outputs 
-$5 = 0x528f18 
 on my machine.
-Now you can use 
-info symbol (*($sp+56))&0x7fffffff 
-you might see something like.
-rl_getc + 36 in section .text  telling you what is located at address 0x528f18
-Now do.
-p/x (*(*$sp+56))&0x7fffffff 
-This outputs
-$6 = 0x528ed0
-Now do.
-info symbol (*(*$sp+56))&0x7fffffff
-rl_read_key + 180 in section .text
-now do
-p/x (*(**$sp+56))&0x7fffffff
+
+Now you can use::
+
+	info symbol (*($sp+56))&0x7fffffff
+
+you might see something like::
+
+	rl_getc + 36 in section .text
+
+telling you what is located at address 0x528f18
+Now do::
+
+	p/x (*(*$sp+56))&0x7fffffff
+
+This outputs::
+
+	$6 = 0x528ed0
+
+Now do::
+
+	info symbol (*(*$sp+56))&0x7fffffff
+	rl_read_key + 180 in section .text
+
+now do::
+
+	p/x (*(**$sp+56))&0x7fffffff
+
 & so on.
 
 Disassembling instructions without debug info
 ---------------------------------------------
 gdb typically complains if there is a lack of debugging
-symbols in the disassemble command with 
+symbols in the disassemble command with
 "No function contains specified address." To get around
-this do 
-x/<number lines to disassemble>xi <address>
-e.g.
-x/20xi 0x400730
+this do::
 
+	x/<number lines to disassemble>xi <address>
 
+e.g.::
 
-Note: Remember gdb has history just like bash you don't need to retype the
-whole line just use the up & down arrows.
+	x/20xi 0x400730
+
+
+
+Note:
+  Remember gdb has history just like bash you don't need to retype the
+  whole line just use the up & down arrows.
 
 
 
 For more info
 -------------
-From your linuxbox do 
-man gdb or info gdb.
+From your linuxbox do::
+
+	man gdb
+
+or::
+
+	info gdb.
 
 core dumps
 ----------
-What a core dump ?,
+
+What a core dump ?
+^^^^^^^^^^^^^^^^^^
+
 A core dump is a file generated by the kernel (if allowed) which contains the
 registers and all active pages of the program which has crashed.
+
 From this file gdb will allow you to look at the registers, stack trace and
 memory of the program as if it just crashed on your system. It is usually
 called core and created in the current working directory.
+
 This is very useful in that a customer can mail a core dump to a technical
 support department and the technical support department can reconstruct what
 happened. Provided they have an identical copy of this program with debugging
 symbols compiled in and the source base of this build is available.
+
 In short it is far more useful than something like a crash log could ever hope
 to be.
 
-Why have I never seen one ?.
-Probably because you haven't used the command 
-ulimit -c unlimited in bash
-to allow core dumps, now do 
-ulimit -a 
+Why have I never seen one ?
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Probably because you haven't used the command::
+
+	ulimit -c unlimited in bash
+
+to allow core dumps, now do::
+
+	ulimit -a
+
 to verify that the limit was accepted.
 
 A sample core dump
-To create this I'm going to do
-ulimit -c unlimited
-gdb 
-to launch gdb (my victim app. ) now be bad & do the following from another 
-telnet/xterm session to the same machine
-ps -aux | grep gdb
-kill -SIGSEGV <gdb's pid>
-or alternatively use killall -SIGSEGV gdb if you have the killall command.
-Now look at the core dump.
-./gdb core
-Displays the following
-GNU gdb 4.18
-Copyright 1998 Free Software Foundation, Inc.
-GDB is free software, covered by the GNU General Public License, and you are
-welcome to change it and/or distribute copies of it under certain conditions.
-Type "show copying" to see the conditions.
-There is absolutely no warranty for GDB.  Type "show warranty" for details.
-This GDB was configured as "s390-ibm-linux"...
-Core was generated by `./gdb'.
-Program terminated with signal 11, Segmentation fault.
-Reading symbols from /usr/lib/libncurses.so.4...done.
-Reading symbols from /lib/libm.so.6...done.
-Reading symbols from /lib/libc.so.6...done.
-Reading symbols from /lib/ld-linux.so.2...done.
-#0  0x40126d1a in read () from /lib/libc.so.6
-Setting up the environment for debugging gdb.
-Breakpoint 1 at 0x4dc6f8: file utils.c, line 471.
-Breakpoint 2 at 0x4d87a4: file top.c, line 2609.
-(top-gdb) info stack
-#0  0x40126d1a in read () from /lib/libc.so.6
-#1  0x528f26 in rl_getc (stream=0x7ffffde8) at input.c:402
-#2  0x528ed0 in rl_read_key () at input.c:381
-#3  0x5167e6 in readline_internal_char () at readline.c:454
-#4  0x5168ee in readline_internal_charloop () at readline.c:507
-#5  0x51692c in readline_internal () at readline.c:521
-#6  0x5164fe in readline (prompt=0x7ffff810)
-    at readline.c:349
-#7  0x4d7a8a in command_line_input (prompt=0x564420 "(gdb) ", repeat=1,
-    annotation_suffix=0x4d6b44 "prompt") at top.c:2091
-#8  0x4d6cf0 in command_loop () at top.c:1345
-#9  0x4e25bc in main (argc=1, argv=0x7ffffdf4) at main.c:635
+   To create this I'm going to do::
+
+	ulimit -c unlimited
+	gdb
+
+to launch gdb (my victim app. ) now be bad & do the following from another
+telnet/xterm session to the same machine::
+
+	ps -aux | grep gdb
+	kill -SIGSEGV <gdb's pid>
+
+or alternatively use `killall -SIGSEGV gdb` if you have the killall command.
+
+Now look at the core dump::
+
+	./gdb core
+
+Displays the following::
+
+  GNU gdb 4.18
+  Copyright 1998 Free Software Foundation, Inc.
+  GDB is free software, covered by the GNU General Public License, and you are
+  welcome to change it and/or distribute copies of it under certain conditions.
+  Type "show copying" to see the conditions.
+  There is absolutely no warranty for GDB.  Type "show warranty" for details.
+  This GDB was configured as "s390-ibm-linux"...
+  Core was generated by `./gdb'.
+  Program terminated with signal 11, Segmentation fault.
+  Reading symbols from /usr/lib/libncurses.so.4...done.
+  Reading symbols from /lib/libm.so.6...done.
+  Reading symbols from /lib/libc.so.6...done.
+  Reading symbols from /lib/ld-linux.so.2...done.
+  #0  0x40126d1a in read () from /lib/libc.so.6
+  Setting up the environment for debugging gdb.
+  Breakpoint 1 at 0x4dc6f8: file utils.c, line 471.
+  Breakpoint 2 at 0x4d87a4: file top.c, line 2609.
+  (top-gdb) info stack
+  #0  0x40126d1a in read () from /lib/libc.so.6
+  #1  0x528f26 in rl_getc (stream=0x7ffffde8) at input.c:402
+  #2  0x528ed0 in rl_read_key () at input.c:381
+  #3  0x5167e6 in readline_internal_char () at readline.c:454
+  #4  0x5168ee in readline_internal_charloop () at readline.c:507
+  #5  0x51692c in readline_internal () at readline.c:521
+  #6  0x5164fe in readline (prompt=0x7ffff810)
+      at readline.c:349
+  #7  0x4d7a8a in command_line_input (prompt=0x564420 "(gdb) ", repeat=1,
+      annotation_suffix=0x4d6b44 "prompt") at top.c:2091
+  #8  0x4d6cf0 in command_loop () at top.c:1345
+  #9  0x4e25bc in main (argc=1, argv=0x7ffffdf4) at main.c:635
 
 
 LDD
@@ -1919,27 +2299,32 @@ LDD
 This is a program which lists the shared libraries which a library needs,
 Note you also get the relocations of the shared library text segments which
 help when using objdump --source.
-e.g.
- ldd ./gdb
-outputs
-libncurses.so.4 => /usr/lib/libncurses.so.4 (0x40018000)
-libm.so.6 => /lib/libm.so.6 (0x4005e000)
-libc.so.6 => /lib/libc.so.6 (0x40084000)
-/lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
+
+e.g.::
+
+	ldd ./gdb
+
+outputs::
+
+  libncurses.so.4 => /usr/lib/libncurses.so.4 (0x40018000)
+  libm.so.6 => /lib/libm.so.6 (0x4005e000)
+  libc.so.6 => /lib/libc.so.6 (0x40084000)
+  /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
 
 
 Debugging shared libraries
 ==========================
 Most programs use shared libraries, however it can be very painful
-when you single step instruction into a function like printf for the 
+when you single step instruction into a function like printf for the
 first time & you end up in functions like _dl_runtime_resolve this is
-the ld.so doing lazy binding, lazy binding is a concept in ELF where 
-shared library functions are not loaded into memory unless they are 
+the ld.so doing lazy binding, lazy binding is a concept in ELF where
+shared library functions are not loaded into memory unless they are
 actually used, great for saving memory but a pain to debug.
-To get around this either relink the program -static or exit gdb type 
-export LD_BIND_NOW=true this will stop lazy binding & restart the gdb'ing 
+
+To get around this either relink the program -static or exit gdb type
+export LD_BIND_NOW=true this will stop lazy binding & restart the gdb'ing
 the program in question.
- 
+
 
 
 Debugging modules
@@ -1955,106 +2340,127 @@ It is a filesystem created by the kernel with files which are created on demand
 by the kernel if read, or can be used to modify kernel parameters,
 it is a powerful concept.
 
-e.g.
-
-cat /proc/sys/net/ipv4/ip_forward 
-On my machine outputs 
-0 
-telling me ip_forwarding is not on to switch it on I can do
-echo 1 >  /proc/sys/net/ipv4/ip_forward
-cat it again
-cat /proc/sys/net/ipv4/ip_forward 
-On my machine now outputs
-1
+e.g.::
+
+	cat /proc/sys/net/ipv4/ip_forward
+
+On my machine outputs::
+
+	0
+
+telling me ip_forwarding is not on to switch it on I can do::
+
+	echo 1 >  /proc/sys/net/ipv4/ip_forward
+
+cat it again::
+
+	cat /proc/sys/net/ipv4/ip_forward
+
+On my machine now outputs::
+
+	1
+
 IP forwarding is on.
+
 There is a lot of useful info in here best found by going in and having a look
 around, so I'll take you through some entries I consider important.
 
 All the processes running on the machine have their own entry defined by
 /proc/<pid>
-So lets have a look at the init process
-cd /proc/1
 
-cat cmdline
-emits
-init [2]
+So lets have a look at the init process::
+
+	cd /proc/1
+	cat cmdline
+
+emits::
+
+	init [2]
+
+::
+
+	cd /proc/1/fd
 
-cd /proc/1/fd
 This contains numerical entries of all the open files,
-some of these you can cat e.g. stdout (2)
+some of these you can cat e.g. stdout (2)::
 
-cat /proc/29/maps
-on my machine emits
+	cat /proc/29/maps
 
-00400000-00478000 r-xp 00000000 5f:00 4103       /bin/bash
-00478000-0047e000 rw-p 00077000 5f:00 4103       /bin/bash
-0047e000-00492000 rwxp 00000000 00:00 0
-40000000-40015000 r-xp 00000000 5f:00 14382      /lib/ld-2.1.2.so
-40015000-40016000 rw-p 00014000 5f:00 14382      /lib/ld-2.1.2.so
-40016000-40017000 rwxp 00000000 00:00 0
-40017000-40018000 rw-p 00000000 00:00 0
-40018000-4001b000 r-xp 00000000 5f:00 14435      /lib/libtermcap.so.2.0.8
-4001b000-4001c000 rw-p 00002000 5f:00 14435      /lib/libtermcap.so.2.0.8
-4001c000-4010d000 r-xp 00000000 5f:00 14387      /lib/libc-2.1.2.so
-4010d000-40111000 rw-p 000f0000 5f:00 14387      /lib/libc-2.1.2.so
-40111000-40114000 rw-p 00000000 00:00 0
-40114000-4011e000 r-xp 00000000 5f:00 14408      /lib/libnss_files-2.1.2.so
-4011e000-4011f000 rw-p 00009000 5f:00 14408      /lib/libnss_files-2.1.2.so
-7fffd000-80000000 rwxp ffffe000 00:00 0
+on my machine emits::
+
+  00400000-00478000 r-xp 00000000 5f:00 4103       /bin/bash
+  00478000-0047e000 rw-p 00077000 5f:00 4103       /bin/bash
+  0047e000-00492000 rwxp 00000000 00:00 0
+  40000000-40015000 r-xp 00000000 5f:00 14382      /lib/ld-2.1.2.so
+  40015000-40016000 rw-p 00014000 5f:00 14382      /lib/ld-2.1.2.so
+  40016000-40017000 rwxp 00000000 00:00 0
+  40017000-40018000 rw-p 00000000 00:00 0
+  40018000-4001b000 r-xp 00000000 5f:00 14435      /lib/libtermcap.so.2.0.8
+  4001b000-4001c000 rw-p 00002000 5f:00 14435      /lib/libtermcap.so.2.0.8
+  4001c000-4010d000 r-xp 00000000 5f:00 14387      /lib/libc-2.1.2.so
+  4010d000-40111000 rw-p 000f0000 5f:00 14387      /lib/libc-2.1.2.so
+  40111000-40114000 rw-p 00000000 00:00 0
+  40114000-4011e000 r-xp 00000000 5f:00 14408      /lib/libnss_files-2.1.2.so
+  4011e000-4011f000 rw-p 00009000 5f:00 14408      /lib/libnss_files-2.1.2.so
+  7fffd000-80000000 rwxp ffffe000 00:00 0
 
 
 Showing us the shared libraries init uses where they are in memory
 & memory access permissions for each virtual memory area.
 
 /proc/1/cwd is a softlink to the current working directory.
-/proc/1/root is the root of the filesystem for this process. 
+
+/proc/1/root is the root of the filesystem for this process.
 
 /proc/1/mem is the current running processes memory which you
 can read & write to like a file.
+
 strace uses this sometimes as it is a bit faster than the
 rather inefficient ptrace interface for peeking at DATA.
 
+::
 
-cat status 
+  cat status
 
-Name:   init
-State:  S (sleeping)
-Pid:    1
-PPid:   0
-Uid:    0       0       0       0
-Gid:    0       0       0       0
-Groups:
-VmSize:      408 kB
-VmLck:         0 kB
-VmRSS:       208 kB
-VmData:       24 kB
-VmStk:         8 kB
-VmExe:       368 kB
-VmLib:         0 kB
-SigPnd: 0000000000000000
-SigBlk: 0000000000000000
-SigIgn: 7fffffffd7f0d8fc
-SigCgt: 00000000280b2603
-CapInh: 00000000fffffeff
-CapPrm: 00000000ffffffff
-CapEff: 00000000fffffeff
+  Name:   init
+  State:  S (sleeping)
+  Pid:    1
+  PPid:   0
+  Uid:    0       0       0       0
+  Gid:    0       0       0       0
+  Groups:
+  VmSize:      408 kB
+  VmLck:         0 kB
+  VmRSS:       208 kB
+  VmData:       24 kB
+  VmStk:         8 kB
+  VmExe:       368 kB
+  VmLib:         0 kB
+  SigPnd: 0000000000000000
+  SigBlk: 0000000000000000
+  SigIgn: 7fffffffd7f0d8fc
+  SigCgt: 00000000280b2603
+  CapInh: 00000000fffffeff
+  CapPrm: 00000000ffffffff
+  CapEff: 00000000fffffeff
+
+  User PSW:    070de000 80414146
+  task: 004b6000 tss: 004b62d8 ksp: 004b7ca8 pt_regs: 004b7f68
+  User GPRS:
+  00000400  00000000  0000000b  7ffffa90
+  00000000  00000000  00000000  0045d9f4
+  0045cafc  7ffffa90  7fffff18  0045cb08
+  00010400  804039e8  80403af8  7ffff8b0
+  User ACRS:
+  00000000  00000000  00000000  00000000
+  00000001  00000000  00000000  00000000
+  00000000  00000000  00000000  00000000
+  00000000  00000000  00000000  00000000
+  Kernel BackChain  CallChain    BackChain  CallChain
+	 004b7ca8   8002bd0c     004b7d18   8002b92c
+	 004b7db8   8005cd50     004b7e38   8005d12a
+	 004b7f08   80019114
 
-User PSW:    070de000 80414146
-task: 004b6000 tss: 004b62d8 ksp: 004b7ca8 pt_regs: 004b7f68
-User GPRS:
-00000400  00000000  0000000b  7ffffa90
-00000000  00000000  00000000  0045d9f4
-0045cafc  7ffffa90  7fffff18  0045cb08
-00010400  804039e8  80403af8  7ffff8b0
-User ACRS:
-00000000  00000000  00000000  00000000
-00000001  00000000  00000000  00000000
-00000000  00000000  00000000  00000000
-00000000  00000000  00000000  00000000
-Kernel BackChain  CallChain    BackChain  CallChain
-       004b7ca8   8002bd0c     004b7d18   8002b92c
-       004b7db8   8005cd50     004b7e38   8005d12a
-       004b7f08   80019114                     
 Showing among other things memory usage & status of some signals &
 the processes'es registers from the kernel task_structure
 as well as a backchain which may be useful if a process crashes
@@ -2067,11 +2473,16 @@ debug feature
 Some of our drivers now support a "debug feature" in
 /proc/s390dbf see s390dbf.txt in the linux/Documentation directory
 for more info.
-e.g. 
-to switch on the lcs "debug feature"
-echo 5 > /proc/s390dbf/lcs/level
-& then after the error occurred.
-cat /proc/s390dbf/lcs/sprintf >/logfile
+
+e.g.
+to switch on the lcs "debug feature"::
+
+	echo 5 > /proc/s390dbf/lcs/level
+
+& then after the error occurred::
+
+	cat /proc/s390dbf/lcs/sprintf >/logfile
+
 the logfile now contains some information which may help
 tech support resolve a problem in the field.
 
@@ -2083,35 +2494,50 @@ ifconfig is a quite useful command
 it gives the current state of network drivers.
 
 If you suspect your network device driver is dead
-one way to check is type 
-ifconfig <network device> 
+one way to check is type::
+
+	ifconfig <network device>
+
 e.g. tr0
-You should see something like
-tr0       Link encap:16/4 Mbps Token Ring (New)  HWaddr 00:04:AC:20:8E:48
-          inet addr:9.164.185.132  Bcast:9.164.191.255  Mask:255.255.224.0
-          UP BROADCAST RUNNING MULTICAST  MTU:2000  Metric:1
-          RX packets:246134 errors:0 dropped:0 overruns:0 frame:0
-          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
-          collisions:0 txqueuelen:100
+
+You should see something like::
+
+	ifconfig tr0
+	tr0      Link encap:16/4 Mbps Token Ring (New)  HWaddr 00:04:AC:20:8E:48
+		inet addr:9.164.185.132  Bcast:9.164.191.255  Mask:255.255.224.0
+		UP BROADCAST RUNNING MULTICAST  MTU:2000  Metric:1
+		RX packets:246134 errors:0 dropped:0 overruns:0 frame:0
+		TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
+		collisions:0 txqueuelen:100
 
 if the device doesn't say up
-try
-/etc/rc.d/init.d/network start 
+try::
+
+	/etc/rc.d/init.d/network start
+
 ( this starts the network stack & hopefully calls ifconfig tr0 up ).
 ifconfig looks at the output of /proc/net/dev and presents it in a more
 presentable form.
+
 Now ping the device from a machine in the same subnet.
+
 if the RX packets count & TX packets counts don't increment you probably
 have problems.
-next 
-cat /proc/net/arp
+
+next::
+
+	cat /proc/net/arp
+
 Do you see any hardware addresses in the cache if not you may have problems.
-Next try
-ping -c 5 <broadcast_addr> i.e. the Bcast field above in the output of
+Next try::
+
+	ping -c 5 <broadcast_addr>
+
+i.e. the Bcast field above in the output of
 ifconfig. Do you see any replies from machines other than the local machine
 if not you may have problems. also if the TX packets count in ifconfig
-hasn't incremented either you have serious problems in your driver 
-(e.g. the txbusy field of the network device being stuck on ) 
+hasn't incremented either you have serious problems in your driver
+(e.g. the txbusy field of the network device being stuck on )
 or you may have multiple network devices connected.
 
 
@@ -2119,28 +2545,43 @@ chandev
 -------
 There is a new device layer for channel devices, some
 drivers e.g. lcs are registered with this layer.
+
 If the device uses the channel device layer you'll be
-able to find what interrupts it uses & the current state 
+able to find what interrupts it uses & the current state
 of the device.
+
 See the manpage chandev.8 &type cat /proc/chandev for more info.
 
 
 SysRq
 =====
 This is now supported by linux for s/390 & z/Architecture.
-To enable it do compile the kernel with 
-Kernel Hacking -> Magic SysRq Key Enabled
-echo "1" > /proc/sys/kernel/sysrq
-also type
-echo "8" >/proc/sys/kernel/printk
+
+To enable it do compile the kernel with::
+
+	Kernel Hacking -> Magic SysRq Key Enabled
+
+Then::
+
+	echo "1" > /proc/sys/kernel/sysrq
+
+also type::
+
+	echo "8" >/proc/sys/kernel/printk
+
 To make printk output go to console.
-On 390 all commands are prefixed with
-^-
-e.g.
-^-t will show tasks.
-^-? or some unknown command will display help.
+
+On 390 all commands are prefixed with::
+
+	^-
+
+e.g.::
+
+	^-t will show tasks.
+	^-? or some unknown command will display help.
+
 The sysrq key reading is very picky ( I have to type the keys in an
- xterm session & paste them  into the x3270 console )
+xterm session & paste them  into the x3270 console )
 & it may be wise to predefine the keys as described in the VM hints above
 
 This is particularly useful for syncing disks unmounting & rebooting
@@ -2150,19 +2591,19 @@ Read Documentation/admin-guide/sysrq.rst for more info
 
 References:
 ===========
-Enterprise Systems Architecture Reference Summary
-Enterprise Systems Architecture Principles of Operation
-Hartmut Penners s390 stack frame sheet.
-IBM Mainframe Channel Attachment a technology brief from a CISCO webpage
-Various bits of man & info pages of Linux.
-Linux & GDB source.
-Various info & man pages.
-CMS Help on tracing commands.
-Linux for s/390 Elf Application Binary Interface
-Linux for z/Series Elf Application Binary Interface ( Both Highly Recommended )
-z/Architecture Principles of Operation SA22-7832-00
-Enterprise Systems Architecture/390 Reference Summary SA22-7209-01 & the
-Enterprise Systems Architecture/390 Principles of Operation SA22-7201-05
+- Enterprise Systems Architecture Reference Summary
+- Enterprise Systems Architecture Principles of Operation
+- Hartmut Penners s390 stack frame sheet.
+- IBM Mainframe Channel Attachment a technology brief from a CISCO webpage
+- Various bits of man & info pages of Linux.
+- Linux & GDB source.
+- Various info & man pages.
+- CMS Help on tracing commands.
+- Linux for s/390 Elf Application Binary Interface
+- Linux for z/Series Elf Application Binary Interface ( Both Highly Recommended )
+- z/Architecture Principles of Operation SA22-7832-00
+- Enterprise Systems Architecture/390 Reference Summary SA22-7209-01 & the
+- Enterprise Systems Architecture/390 Principles of Operation SA22-7201-05
 
 Special Thanks
 ==============
diff --git a/Documentation/s390/driver-model.txt b/Documentation/s390/driver-model.rst
similarity index 73%
rename from Documentation/s390/driver-model.txt
rename to Documentation/s390/driver-model.rst
index ed265cf54cde..ad4bc2dbea43 100644
--- a/Documentation/s390/driver-model.txt
+++ b/Documentation/s390/driver-model.rst
@@ -1,5 +1,6 @@
+=============================
 S/390 driver model interfaces
------------------------------
+=============================
 
 1. CCW devices
 --------------
@@ -7,13 +8,13 @@ S/390 driver model interfaces
 All devices which can be addressed by means of ccws are called 'CCW devices' -
 even if they aren't actually driven by ccws.
 
-All ccw devices are accessed via a subchannel, this is reflected in the 
-structures under devices/:
+All ccw devices are accessed via a subchannel, this is reflected in the
+structures under devices/::
 
-devices/
+  devices/
      - system/
      - css0/
-           - 0.0.0000/0.0.0815/
+	   - 0.0.0000/0.0.0815/
 	   - 0.0.0001/0.0.4711/
 	   - 0.0.0002/
 	   - 0.1.0000/0.1.1234/
@@ -35,14 +36,18 @@ be found under bus/ccw/devices/.
 
 All ccw devices export some data via sysfs.
 
-cutype:	    The control unit type / model.
+cutype:
+	The control unit type / model.
 
-devtype:    The device type / model, if applicable.
+devtype:
+	The device type / model, if applicable.
 
-availability: Can be 'good' or 'boxed'; 'no path' or 'no device' for
+availability:
+	      Can be 'good' or 'boxed'; 'no path' or 'no device' for
 	      disconnected devices.
 
-online:     An interface to set the device online and offline.
+online:
+	    An interface to set the device online and offline.
 	    In the special case of the device being disconnected (see the
 	    notify function under 1.2), piping 0 to online will forcibly delete
 	    the device.
@@ -52,9 +57,11 @@ The device drivers can add entries to export per-device data and interfaces.
 There is also some data exported on a per-subchannel basis (see under
 bus/css/devices/):
 
-chpids:	    Via which chpids the device is connected.
+chpids:
+	Via which chpids the device is connected.
 
-pimpampom:  The path installed, path available and path operational masks.
+pimpampom:
+	The path installed, path available and path operational masks.
 
 There also might be additional data, for example for block devices.
 
@@ -74,77 +81,93 @@ b. After a. has been performed, if necessary, the device is finally brought up
 ------------------------------------
 
 The basic struct ccw_device and struct ccw_driver data structures can be found
-under include/asm/ccwdev.h.
+under include/asm/ccwdev.h::
 
-struct ccw_device {
-        spinlock_t *ccwlock;
-        struct ccw_device_private *private;
-	struct ccw_device_id id;	
+  struct ccw_device {
+	spinlock_t *ccwlock;
+	struct ccw_device_private *private;
+	struct ccw_device_id id;
 
-	struct ccw_driver *drv;		
-	struct device dev;		
+	struct ccw_driver *drv;
+	struct device dev;
 	int online;
 
 	void (*handler) (struct ccw_device *dev, unsigned long intparm,
-                         struct irb *irb);
-};
+			 struct irb *irb);
+  };
 
-struct ccw_driver {
-	struct module *owner;		
-	struct ccw_device_id *ids;	
-	int (*probe) (struct ccw_device *); 
+  struct ccw_driver {
+	struct module *owner;
+	struct ccw_device_id *ids;
+	int (*probe) (struct ccw_device *);
 	int (*remove) (struct ccw_device *);
 	int (*set_online) (struct ccw_device *);
 	int (*set_offline) (struct ccw_device *);
 	int (*notify) (struct ccw_device *, int);
 	struct device_driver driver;
 	char *name;
-};
+  };
 
 The 'private' field contains data needed for internal i/o operation only, and
 is not available to the device driver.
 
 Each driver should declare in a MODULE_DEVICE_TABLE into which CU types/models
 and/or device types/models it is interested. This information can later be found
-in the struct ccw_device_id fields:
+in the struct ccw_device_id fields::
 
-struct ccw_device_id {
-	__u16	match_flags;	
+  struct ccw_device_id {
+	__u16   match_flags;
 
-	__u16	cu_type;	
-	__u16	dev_type;	
-	__u8	cu_model;	
-	__u8	dev_model;	
+	__u16   cu_type;
+	__u16   dev_type;
+	__u8    cu_model;
+	__u8    dev_model;
 
 	unsigned long driver_info;
-};
+  };
 
 The functions in ccw_driver should be used in the following way:
-probe:   This function is called by the device layer for each device the driver
+
+probe:
+	 This function is called by the device layer for each device the driver
 	 is interested in. The driver should only allocate private structures
 	 to put in dev->driver_data and create attributes (if needed). Also,
 	 the interrupt handler (see below) should be set here.
 
-int (*probe) (struct ccw_device *cdev); 
+::
 
-Parameters:  cdev     - the device to be probed.
+  int (*probe) (struct ccw_device *cdev);
 
+Parameters:
+		cdev
+			- the device to be probed.
 
-remove:  This function is called by the device layer upon removal of the driver,
+
+remove:
+	 This function is called by the device layer upon removal of the driver,
 	 the device or the module. The driver should perform cleanups here.
 
-int (*remove) (struct ccw_device *cdev);
+::
 
-Parameters:   cdev    - the device to be removed.
+  int (*remove) (struct ccw_device *cdev);
 
+Parameters:
+		cdev
+			- the device to be removed.
 
-set_online: This function is called by the common I/O layer when the device is
+
+set_online:
+	    This function is called by the common I/O layer when the device is
 	    activated via the 'online' attribute. The driver should finally
 	    setup and activate the device here.
 
-int (*set_online) (struct ccw_device *);
+::
 
-Parameters:   cdev	- the device to be activated. The common layer has
+  int (*set_online) (struct ccw_device *);
+
+Parameters:
+		cdev
+			- the device to be activated. The common layer has
 			  verified that the device is not already online.
 
 
@@ -152,15 +175,22 @@ set_offline: This function is called by the common I/O layer when the device is
 	     de-activated via the 'online' attribute. The driver should shut
 	     down the device, but not de-allocate its private data.
 
-int (*set_offline) (struct ccw_device *);
+::
 
-Parameters:   cdev       - the device to be deactivated. The common layer has
+  int (*set_offline) (struct ccw_device *);
+
+Parameters:
+		cdev
+			- the device to be deactivated. The common layer has
 			   verified that the device is online.
 
 
-notify: This function is called by the common I/O layer for some state changes
+notify:
+	This function is called by the common I/O layer for some state changes
 	of the device.
+
 	Signalled to the driver are:
+
 	* In online state, device detached (CIO_GONE) or last path gone
 	  (CIO_NO_PATH). The driver must return !0 to keep the device; for
 	  return code 0, the device will be deleted as usual (also when no
@@ -173,32 +203,40 @@ notify: This function is called by the common I/O layer for some state changes
 	  return code of the notify function the device driver signals if it
 	  wants the device back: !0 for keeping, 0 to make the device being
 	  removed and re-registered.
-	
-int (*notify) (struct ccw_device *, int);
 
-Parameters:   cdev    - the device whose state changed.
-	      event   - the event that happened. This can be one of CIO_GONE,
-		        CIO_NO_PATH or CIO_OPER.
+::
+
+  int (*notify) (struct ccw_device *, int);
+
+Parameters:
+		cdev
+			- the device whose state changed.
+
+		event
+			- the event that happened. This can be one of CIO_GONE,
+			  CIO_NO_PATH or CIO_OPER.
 
 The handler field of the struct ccw_device is meant to be set to the interrupt
-handler for the device. In order to accommodate drivers which use several 
+handler for the device. In order to accommodate drivers which use several
 distinct handlers (e.g. multi subchannel devices), this is a member of ccw_device
 instead of ccw_driver.
 The handler is registered with the common layer during set_online() processing
 before the driver is called, and is deregistered during set_offline() after the
-driver has been called. Also, after registering / before deregistering, path 
+driver has been called. Also, after registering / before deregistering, path
 grouping resp. disbanding of the path group (if applicable) are performed.
 
-void (*handler) (struct ccw_device *dev, unsigned long intparm, struct irb *irb);
+::
 
-Parameters:	dev	- the device the handler is called for
+  void (*handler) (struct ccw_device *dev, unsigned long intparm, struct irb *irb);
+
+Parameters:     dev     - the device the handler is called for
 		intparm - the intparm which allows the device driver to identify
-                          the i/o the interrupt is associated with, or to recognize
-                          the interrupt as unsolicited.
-                irb     - interruption response block which contains the accumulated
-                          status.
+			  the i/o the interrupt is associated with, or to recognize
+			  the interrupt as unsolicited.
+		irb     - interruption response block which contains the accumulated
+			  status.
 
-The device driver is called from the common ccw_device layer and can retrieve 
+The device driver is called from the common ccw_device layer and can retrieve
 information about the interrupt from the irb parameter.
 
 
@@ -237,23 +275,27 @@ only the logical state and not the physical state, since we cannot track the
 latter consistently due to lacking machine support (we don't need to be aware
 of it anyway).
 
-status - Can be 'online' or 'offline'.
+status
+       - Can be 'online' or 'offline'.
 	 Piping 'on' or 'off' sets the chpid logically online/offline.
 	 Piping 'on' to an online chpid triggers path reprobing for all devices
 	 the chpid connects to. This can be used to force the kernel to re-use
 	 a channel path the user knows to be online, but the machine hasn't
 	 created a machine check for.
 
-type - The physical type of the channel path.
+type
+       - The physical type of the channel path.
 
-shared - Whether the channel path is shared.
+shared
+       - Whether the channel path is shared.
 
-cmg - The channel measurement group.
+cmg
+       - The channel measurement group.
 
 3. System devices
 -----------------
 
-3.1 xpram 
+3.1 xpram
 ---------
 
 xpram shows up under devices/system/ as 'xpram'.
@@ -279,9 +321,8 @@ Netiucv connections show up under devices/iucv/ as "netiucv<ifnum>". The interfa
 number is assigned sequentially to the connections defined via the 'connection'
 attribute.
 
-user			  - shows the connection partner.
-
-buffer			  - maximum buffer size.
-			    Pipe to it to change buffer size.
-
+user
+    - shows the connection partner.
 
+buffer
+    - maximum buffer size. Pipe to it to change buffer size.
diff --git a/Documentation/s390/index.rst b/Documentation/s390/index.rst
new file mode 100644
index 000000000000..1a914da2a07b
--- /dev/null
+++ b/Documentation/s390/index.rst
@@ -0,0 +1,30 @@
+:orphan:
+
+=================
+s390 Architecture
+=================
+
+.. toctree::
+    :maxdepth: 1
+
+    cds
+    3270
+    debugging390
+    driver-model
+    monreader
+    qeth
+    s390dbf
+    vfio-ap
+    vfio-ccw
+    zfcpdump
+    dasd
+    common_io
+
+    text_files
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/s390/monreader.txt b/Documentation/s390/monreader.rst
similarity index 81%
rename from Documentation/s390/monreader.txt
rename to Documentation/s390/monreader.rst
index d3729585fdb0..1e857575c113 100644
--- a/Documentation/s390/monreader.txt
+++ b/Documentation/s390/monreader.rst
@@ -1,24 +1,26 @@
+=================================================
+Linux API for read access to z/VM Monitor Records
+=================================================
 
 Date  : 2004-Nov-26
+
 Author: Gerald Schaefer (geraldsc@de.ibm.com)
 
 
-             Linux API for read access to z/VM Monitor Records
-             =================================================
 
 
 Description
 ===========
 This item delivers a new Linux API in the form of a misc char device that is
 usable from user space and allows read access to the z/VM Monitor Records
-collected by the *MONITOR System Service of z/VM.
+collected by the `*MONITOR` System Service of z/VM.
 
 
 User Requirements
 =================
 The z/VM guest on which you want to access this API needs to be configured in
-order to allow IUCV connections to the *MONITOR service, i.e. it needs the
-IUCV *MONITOR statement in its user entry. If the monitor DCSS to be used is
+order to allow IUCV connections to the `*MONITOR` service, i.e. it needs the
+IUCV `*MONITOR` statement in its user entry. If the monitor DCSS to be used is
 restricted (likely), you also need the NAMESAVE <DCSS NAME> statement.
 This item will use the IUCV device driver to access the z/VM services, so you
 need a kernel with IUCV support. You also need z/VM version 4.4 or 5.1.
@@ -50,7 +52,9 @@ Your guest virtual storage has to end below the starting address of the DCSS
 and you have to specify the "mem=" kernel parameter in your parmfile with a
 value greater than the ending address of the DCSS.
 
-Example: DEF STOR 140M
+Example::
+
+	DEF STOR 140M
 
 This defines 140MB storage size for your guest, the parameter "mem=160M" is
 added to the parmfile.
@@ -66,24 +70,27 @@ kernel, the kernel parameter "monreader.mondcss=<DCSS NAME>" can be specified
 in the parmfile.
 
 The default name for the DCSS is "MONDCSS" if none is specified. In case that
-there are other users already connected to the *MONITOR service (e.g.
+there are other users already connected to the `*MONITOR` service (e.g.
 Performance Toolkit), the monitor DCSS is already defined and you have to use
 the same DCSS. The CP command Q MONITOR (Class E privileged) shows the name
 of the monitor DCSS, if already defined, and the users connected to the
-*MONITOR service.
+`*MONITOR` service.
 Refer to the "z/VM Performance" book (SC24-6109-00) on how to create a monitor
 DCSS if your z/VM doesn't have one already, you need Class E privileges to
 define and save a DCSS.
 
 Example:
 --------
-modprobe monreader mondcss=MYDCSS
+
+::
+
+	modprobe monreader mondcss=MYDCSS
 
 This loads the module and sets the DCSS name to "MYDCSS".
 
 NOTE:
 -----
-This API provides no interface to control the *MONITOR service, e.g. specify
+This API provides no interface to control the `*MONITOR` service, e.g. specify
 which data should be collected. This can be done by the CP command MONITOR
 (Class E privileged), see "CP Command and Utility Reference".
 
@@ -98,6 +105,7 @@ If your distribution does not support udev, a device node will not be created
 automatically and you have to create it manually after loading the module.
 Therefore you need to know the major and minor numbers of the device. These
 numbers can be found in /sys/class/misc/monreader/dev.
+
 Typing cat /sys/class/misc/monreader/dev will give an output of the form
 <major>:<minor>. The device node can be created via the mknod command, enter
 mknod <name> c <major> <minor>, where <name> is the name of the device node
@@ -105,10 +113,13 @@ to be created.
 
 Example:
 --------
-# modprobe monreader
-# cat /sys/class/misc/monreader/dev
-10:63
-# mknod /dev/monreader c 10 63
+
+::
+
+	# modprobe monreader
+	# cat /sys/class/misc/monreader/dev
+	10:63
+	# mknod /dev/monreader c 10 63
 
 This loads the module with the default monitor DCSS (MONDCSS) and creates a
 device node.
@@ -133,20 +144,21 @@ last byte of data. The start address is needed to handle "end-of-frame" records
 correctly (domain 1, record 13), i.e. it can be used to determine the record
 start offset relative to a 4K page (frame) boundary.
 
-See "Appendix A: *MONITOR" in the "z/VM Performance" document for a description
+See "Appendix A: `*MONITOR`" in the "z/VM Performance" document for a description
 of the monitor control element layout. The layout of the monitor records can
 be found here (z/VM 5.1): http://www.vm.ibm.com/pubs/mon510/index.html
 
-The layout of the data stream provided by the monreader device is as follows:
-...
-<0 byte read>
-<first MCE>              \
-<first set of records>    |
-...                       |- data set
-<last MCE>                |
-<last set of records>    /
-<0 byte read>
-...
+The layout of the data stream provided by the monreader device is as follows::
+
+	...
+	<0 byte read>
+	<first MCE>              \
+	<first set of records>    |
+	...                       |- data set
+	<last MCE>                |
+	<last set of records>    /
+	<0 byte read>
+	...
 
 There may be more than one combination of MCE and corresponding record set
 within one data set and the end of each data set is indicated by a successful
@@ -165,15 +177,19 @@ As with most char devices, error conditions are indicated by returning a
 negative value for the number of bytes read. In this case, the errno variable
 indicates the error condition:
 
-EIO: reply failed, read data is invalid and the application
+EIO:
+     reply failed, read data is invalid and the application
      should discard the data read since the last successful read with 0 size.
-EFAULT: copy_to_user failed, read data is invalid and the application should
-        discard the data read since the last successful read with 0 size.
-EAGAIN: occurs on a non-blocking read if there is no data available at the
-        moment. There is no data missing or corrupted, just try again or rather
-        use polling for non-blocking reads.
-EOVERFLOW: message limit reached, the data read since the last successful
-           read with 0 size is valid but subsequent records may be missing.
+EFAULT:
+	copy_to_user failed, read data is invalid and the application should
+	discard the data read since the last successful read with 0 size.
+EAGAIN:
+	occurs on a non-blocking read if there is no data available at the
+	moment. There is no data missing or corrupted, just try again or rather
+	use polling for non-blocking reads.
+EOVERFLOW:
+	   message limit reached, the data read since the last successful
+	   read with 0 size is valid but subsequent records may be missing.
 
 In the last case (EOVERFLOW) there may be missing data, in the first two cases
 (EIO, EFAULT) there will be missing data. It's up to the application if it will
@@ -183,7 +199,7 @@ Open:
 -----
 Only one user is allowed to open the char device. If it is already in use, the
 open function will fail (return a negative value) and set errno to EBUSY.
-The open function may also fail if an IUCV connection to the *MONITOR service
+The open function may also fail if an IUCV connection to the `*MONITOR` service
 cannot be established. In this case errno will be set to EIO and an error
 message with an IPUSER SEVER code will be printed into syslog. The IPUSER SEVER
 codes are described in the "z/VM Performance" book, Appendix A.
@@ -194,4 +210,3 @@ As soon as the device is opened, incoming messages will be accepted and they
 will account for the message limit, i.e. opening the device without reading
 from it will provoke the "message limit reached" error (EOVERFLOW error code)
 eventually.
-
diff --git a/Documentation/s390/qeth.txt b/Documentation/s390/qeth.rst
similarity index 62%
rename from Documentation/s390/qeth.txt
rename to Documentation/s390/qeth.rst
index aa06fcf5f8c2..f02fdaa68de0 100644
--- a/Documentation/s390/qeth.txt
+++ b/Documentation/s390/qeth.rst
@@ -1,8 +1,12 @@
+=============================
 IBM s390 QDIO Ethernet Driver
+=============================
 
 OSA and HiperSockets Bridge Port Support
+========================================
 
 Uevents
+-------
 
 To generate the events the device must be assigned a role of either
 a primary or a secondary Bridge Port. For more information, see
@@ -13,12 +17,15 @@ of some configured Bridge Port device on the channel changes, a udev
 event with ACTION=CHANGE is emitted on behalf of the corresponding
 ccwgroup device. The event has the following attributes:
 
-BRIDGEPORT=statechange -  indicates that the Bridge Port device changed
+BRIDGEPORT=statechange
+  indicates that the Bridge Port device changed
   its state.
 
-ROLE={primary|secondary|none} - the role assigned to the port.
+ROLE={primary|secondary|none}
+  the role assigned to the port.
 
-STATE={active|standby|inactive} - the newly assumed state of the port.
+STATE={active|standby|inactive}
+  the newly assumed state of the port.
 
 When run on HiperSockets Bridge Capable Port hardware with host address
 notifications enabled, a udev event with ACTION=CHANGE is emitted.
@@ -26,25 +33,32 @@ It is emitted on behalf of the corresponding ccwgroup device when a host
 or a VLAN is registered or unregistered on the network served by the device.
 The event has the following attributes:
 
-BRIDGEDHOST={reset|register|deregister|abort} - host address
+BRIDGEDHOST={reset|register|deregister|abort}
+  host address
   notifications are started afresh, a new host or VLAN is registered or
   deregistered on the Bridge Port HiperSockets channel, or address
   notifications are aborted.
 
-VLAN=numeric-vlan-id - VLAN ID on which the event occurred. Not included
+VLAN=numeric-vlan-id
+  VLAN ID on which the event occurred. Not included
   if no VLAN is involved in the event.
 
-MAC=xx:xx:xx:xx:xx:xx - MAC address of the host that is being registered
+MAC=xx:xx:xx:xx:xx:xx
+  MAC address of the host that is being registered
   or deregistered from the HiperSockets channel. Not reported if the
   event reports the creation or destruction of a VLAN.
 
-NTOK_BUSID=x.y.zzzz - device bus ID (CSSID, SSID and device number).
+NTOK_BUSID=x.y.zzzz
+  device bus ID (CSSID, SSID and device number).
 
-NTOK_IID=xx - device IID.
+NTOK_IID=xx
+  device IID.
 
-NTOK_CHPID=xx - device CHPID.
+NTOK_CHPID=xx
+  device CHPID.
 
-NTOK_CHID=xxxx - device channel ID.
+NTOK_CHID=xxxx
+  device channel ID.
 
-Note that the NTOK_* attributes refer to devices other than  the one
+Note that the `NTOK_*` attributes refer to devices other than  the one
 connected to the system on which the OS is running.
diff --git a/Documentation/s390/s390dbf.txt b/Documentation/s390/s390dbf.rst
similarity index 43%
rename from Documentation/s390/s390dbf.txt
rename to Documentation/s390/s390dbf.rst
index 61329fd62e89..ec2a1faa414b 100644
--- a/Documentation/s390/s390dbf.txt
+++ b/Documentation/s390/s390dbf.rst
@@ -1,34 +1,38 @@
+==================
 S390 Debug Feature
 ==================
 
-files: arch/s390/kernel/debug.c
-       arch/s390/include/asm/debug.h
+files:
+      - arch/s390/kernel/debug.c
+      - arch/s390/include/asm/debug.h
 
 Description:
 ------------
-The goal of this feature is to provide a kernel debug logging API 
-where log records can be stored efficiently in memory, where each component 
+The goal of this feature is to provide a kernel debug logging API
+where log records can be stored efficiently in memory, where each component
 (e.g. device drivers) can have one separate debug log.
 One purpose of this is to inspect the debug logs after a production system crash
 in order to analyze the reason for the crash.
+
 If the system still runs but only a subcomponent which uses dbf fails,
 it is possible to look at the debug logs on a live system via the Linux
 debugfs filesystem.
+
 The debug feature may also very useful for kernel and driver development.
 
 Design:
 -------
-Kernel components (e.g. device drivers) can register themselves at the debug 
-feature with the function call debug_register(). This function initializes a 
-debug log for the caller. For each debug log exists a number of debug areas 
+Kernel components (e.g. device drivers) can register themselves at the debug
+feature with the function call debug_register(). This function initializes a
+debug log for the caller. For each debug log exists a number of debug areas
 where exactly one is active at one time.  Each debug area consists of contiguous
 pages in memory. In the debug areas there are stored debug entries (log records)
-which are written by event- and exception-calls. 
+which are written by event- and exception-calls.
 
 An event-call writes the specified debug entry to the active debug
-area and updates the log pointer for the active area. If the end 
-of the active debug area is reached, a wrap around is done (ring buffer) 
-and the next debug entry will be written at the beginning of the active 
+area and updates the log pointer for the active area. If the end
+of the active debug area is reached, a wrap around is done (ring buffer)
+and the next debug entry will be written at the beginning of the active
 debug area.
 
 An exception-call writes the specified debug entry to the log and
@@ -37,7 +41,7 @@ that the records which describe the origin of the exception are not
 overwritten when a wrap around for the current area occurs.
 
 The debug areas themselves are also ordered in form of a ring buffer.
-When an exception is thrown in the last debug area, the following debug 
+When an exception is thrown in the last debug area, the following debug
 entries are then written again in the very first area.
 
 There are three versions for the event- and exception-calls: One for
@@ -76,244 +80,359 @@ through writing a number string "x" to the 'level' debugfs file which is
 provided for every debug log. Debugging can be switched off completely
 by using "-" on the 'level' debugfs file.
 
-Example:
+Example::
 
-> echo "-" > /sys/kernel/debug/s390dbf/dasd/level
+	> echo "-" > /sys/kernel/debug/s390dbf/dasd/level
 
 It is also possible to deactivate the debug feature globally for every
 debug log. You can change the behavior using  2 sysctl parameters in
 /proc/sys/s390dbf:
+
 There are currently 2 possible triggers, which stop the debug feature
 globally. The first possibility is to use the "debug_active" sysctl. If
 set to 1 the debug feature is running. If "debug_active" is set to 0 the
 debug feature is turned off.
+
 The second trigger which stops the debug feature is a kernel oops.
 That prevents the debug feature from overwriting debug information that
 happened before the oops. After an oops you can reactivate the debug feature
 by piping 1 to /proc/sys/s390dbf/debug_active. Nevertheless, its not
 suggested to use an oopsed kernel in a production environment.
+
 If you want to disallow the deactivation of the debug feature, you can use
 the "debug_stoppable" sysctl. If you set "debug_stoppable" to 0 the debug
 feature cannot be stopped. If the debug feature is already stopped, it
 will stay deactivated.
 
+----------------------------------------------------------------------------
+
 Kernel Interfaces:
 ------------------
 
-----------------------------------------------------------------------------
-debug_info_t *debug_register(char *name, int pages, int nr_areas,
-                             int buf_size);
+::
 
-Parameter:    name:        Name of debug log (e.g. used for debugfs entry)
-              pages:       number of pages, which will be allocated per area
-              nr_areas:    number of debug areas
-              buf_size:    size of data area in each debug entry
+  debug_info_t *debug_register(char *name, int pages, int nr_areas,
+			       int buf_size);
 
-Return Value: Handle for generated debug area   
-              NULL if register failed 
+Parameter:
+	      name:
+			   Name of debug log (e.g. used for debugfs entry)
+	      pages:
+			   Number of pages, which will be allocated per area
+	      nr_areas:
+			   Number of debug areas
+	      buf_size:
+			   Size of data area in each debug entry
 
-Description:  Allocates memory for a debug log     
-              Must not be called within an interrupt handler 
+Return Value:
+	Handle for generated debug area
 
-----------------------------------------------------------------------------
-debug_info_t *debug_register_mode(char *name, int pages, int nr_areas,
-				  int buf_size, mode_t mode, uid_t uid,
-				  gid_t gid);
-
-Parameter:    name:	   Name of debug log (e.g. used for debugfs entry)
-	      pages:	   Number of pages, which will be allocated per area
-	      nr_areas:    Number of debug areas
-	      buf_size:    Size of data area in each debug entry
-	      mode:	   File mode for debugfs files. E.g. S_IRWXUGO
-	      uid:	   User ID for debugfs files. Currently only 0 is
-			   supported.
-	      gid:	   Group ID for debugfs files. Currently only 0 is
-			   supported.
-
-Return Value: Handle for generated debug area
-	      NULL if register failed
+	  NULL if register failed
 
 Description:  Allocates memory for a debug log
 	      Must not be called within an interrupt handler
 
+----------------------------------------------------------------------------
+
+::
+
+  debug_info_t *debug_register_mode(char *name, int pages, int nr_areas,
+				    int buf_size, mode_t mode, uid_t uid,
+				    gid_t gid);
+
+Parameter:
+	      name:
+			   Name of debug log (e.g. used for debugfs entry)
+	      pages:
+			   Number of pages, which will be allocated per area
+	      nr_areas:
+			   Number of debug areas
+	      buf_size:
+			   Size of data area in each debug entry
+	      mode:
+			   File mode for debugfs files. E.g. S_IRWXUGO
+	      uid:
+			   User ID for debugfs files. Currently only 0 is
+			   supported.
+	      gid:
+			   Group ID for debugfs files. Currently only 0 is
+			   supported.
+
+Return Value:
+	      Handle for generated debug area
+
+		NULL if register failed
+
+Description:
+	      Allocates memory for a debug log
+	      Must not be called within an interrupt handler
+
 ---------------------------------------------------------------------------
-void debug_unregister (debug_info_t * id);
 
-Parameter:     id:   handle for debug log  
+::
 
-Return Value:  none 
+  void debug_unregister (debug_info_t * id);
 
-Description:   frees memory for a debug log and removes all registered debug
+Parameter:
+	       id:
+		    handle for debug log
+
+Return Value:
+	       none
+
+Description:
+	       frees memory for a debug log and removes all registered debug
 	       views.
-               Must not be called within an interrupt handler 
+
+	       Must not be called within an interrupt handler
 
 ---------------------------------------------------------------------------
-void debug_set_level (debug_info_t * id, int new_level);
 
-Parameter:     id:        handle for debug log  
-               new_level: new debug level 
+::
+
+  void debug_set_level (debug_info_t * id, int new_level);
+
+Parameter:     id:        handle for debug log
+	       new_level: new debug level
 
-Return Value:  none 
+Return Value:
+	       none
 
-Description:   Sets new actual debug level if new_level is valid. 
+Description:
+	       Sets new actual debug level if new_level is valid.
 
 ---------------------------------------------------------------------------
-bool debug_level_enabled (debug_info_t * id, int level);
 
-Parameter:    id:	  handle for debug log
-	      level:	  debug level
+::
+
+  bool debug_level_enabled (debug_info_t * id, int level);
+
+Parameter:
+	      id:
+			  handle for debug log
+	      level:
+			  debug level
 
-Return Value: True if level is less or equal to the current debug level.
+Return Value:
+	      True if level is less or equal to the current debug level.
 
-Description:  Returns true if debug events for the specified level would be
+Description:
+	      Returns true if debug events for the specified level would be
 	      logged. Otherwise returns false.
+
 ---------------------------------------------------------------------------
-void debug_stop_all(void);
 
-Parameter:     none
+::
+
+  void debug_stop_all(void);
+
+Parameter:
+	       none
 
-Return Value:  none
+Return Value:
+	       none
 
-Description:   stops the debug feature if stopping is allowed. Currently
-               used in case of a kernel oops.
+Description:
+	       stops the debug feature if stopping is allowed. Currently
+	       used in case of a kernel oops.
 
 ---------------------------------------------------------------------------
-debug_entry_t* debug_event (debug_info_t* id, int level, void* data, 
-                            int length);
 
-Parameter:     id:     handle for debug log  
-               level:  debug level           
-               data:   pointer to data for debug entry  
-               length: length of data in bytes       
+::
 
-Return Value:  Address of written debug entry 
+  debug_entry_t* debug_event (debug_info_t* id, int level, void* data,
+			      int length);
 
-Description:   writes debug entry to active debug area (if level <= actual 
-               debug level)    
+Parameter:
+	       id:
+		       handle for debug log
+	       level:
+		       debug level
+	       data:
+		       pointer to data for debug entry
+	       length:
+		       length of data in bytes
+
+Return Value:
+	       Address of written debug entry
+
+Description:
+	       writes debug entry to active debug area (if level <= actual
+	       debug level)
 
 ---------------------------------------------------------------------------
-debug_entry_t* debug_int_event (debug_info_t * id, int level, 
-                                unsigned int data);
-debug_entry_t* debug_long_event(debug_info_t * id, int level,
-                                unsigned long data);
 
-Parameter:     id:     handle for debug log  
-               level:  debug level           
-               data:   integer value for debug entry           
+::
+
+  debug_entry_t* debug_int_event (debug_info_t * id, int level,
+				  unsigned int data);
+  debug_entry_t* debug_long_event(debug_info_t * id, int level,
+				  unsigned long data);
 
-Return Value:  Address of written debug entry 
+Parameter:
+	       id:
+		       handle for debug log
+	       level:
+		       debug level
+	       data:
+		       integer value for debug entry
 
-Description:   writes debug entry to active debug area (if level <= actual 
-               debug level)    
+Return Value:
+	       Address of written debug entry
+
+Description:
+	       writes debug entry to active debug area (if level <= actual
+	       debug level)
 
 ---------------------------------------------------------------------------
-debug_entry_t* debug_text_event (debug_info_t * id, int level, 
-                                 const char* data);
 
-Parameter:     id:     handle for debug log  
-               level:  debug level           
-               data:   string for debug entry  
+::
+
+  debug_entry_t* debug_text_event (debug_info_t * id, int level,
+				   const char* data);
+
+Parameter:
+	       id:
+		       handle for debug log
+	       level:
+		       debug level
+	       data:
+		       string for debug entry
 
-Return Value:  Address of written debug entry 
+Return Value:
+	       Address of written debug entry
 
-Description:   writes debug entry in ascii format to active debug area 
-               (if level <= actual debug level)     
+Description:
+	       writes debug entry in ascii format to active debug area
+	       (if level <= actual debug level)
 
 ---------------------------------------------------------------------------
-debug_entry_t* debug_sprintf_event (debug_info_t * id, int level, 
-                                    char* string,...);
 
-Parameter:     id:    handle for debug log 
-               level: debug level
-               string: format string for debug entry 
-               ...: varargs used as in sprintf()
+::
+
+  debug_entry_t* debug_sprintf_event (debug_info_t * id, int level,
+				      char* string,...);
+
+Parameter:
+	       id:
+		      handle for debug log
+	       level:
+		      debug level
+	       string:
+		      format string for debug entry
+	       ...:
+		      varargs used as in sprintf()
 
 Return Value:  Address of written debug entry
 
-Description:   writes debug entry with format string and varargs (longs) to 
-               active debug area (if level $<=$ actual debug level). 
-               floats and long long datatypes cannot be used as varargs.
+Description:
+	       writes debug entry with format string and varargs (longs) to
+	       active debug area (if level $<=$ actual debug level).
+	       floats and long long datatypes cannot be used as varargs.
 
 ---------------------------------------------------------------------------
 
-debug_entry_t* debug_exception (debug_info_t* id, int level, void* data, 
-                                int length);
+::
 
-Parameter:     id:     handle for debug log  
-               level:  debug level           
-               data:   pointer to data for debug entry  
-               length: length of data in bytes       
+  debug_entry_t* debug_exception (debug_info_t* id, int level, void* data,
+				  int length);
 
-Return Value:  Address of written debug entry 
+Parameter:
+	       id:
+		       handle for debug log
+	       level:
+		       debug level
+	       data:
+		       pointer to data for debug entry
+	       length:
+		       length of data in bytes
 
-Description:   writes debug entry to active debug area (if level <= actual 
-               debug level) and switches to next debug area  
+Return Value:
+	       Address of written debug entry
+
+Description:
+	       writes debug entry to active debug area (if level <= actual
+	       debug level) and switches to next debug area
 
 ---------------------------------------------------------------------------
-debug_entry_t* debug_int_exception (debug_info_t * id, int level, 
-                                    unsigned int data);
-debug_entry_t* debug_long_exception(debug_info_t * id, int level,
-                                    unsigned long data);
 
-Parameter:     id:     handle for debug log  
-               level:  debug level           
-               data:   integer value for debug entry           
+::
+
+  debug_entry_t* debug_int_exception (debug_info_t * id, int level,
+				      unsigned int data);
+  debug_entry_t* debug_long_exception(debug_info_t * id, int level,
+				      unsigned long data);
+
+Parameter:     id:     handle for debug log
+	       level:  debug level
+	       data:   integer value for debug entry
 
-Return Value:  Address of written debug entry 
+Return Value:  Address of written debug entry
 
-Description:   writes debug entry to active debug area (if level <= actual 
-               debug level) and switches to next debug area  
+Description:   writes debug entry to active debug area (if level <= actual
+	       debug level) and switches to next debug area
 
 ---------------------------------------------------------------------------
-debug_entry_t* debug_text_exception (debug_info_t * id, int level, 
-                                     const char* data);
 
-Parameter:     id:     handle for debug log  
-               level:  debug level           
-               data:   string for debug entry  
+::
+
+  debug_entry_t* debug_text_exception (debug_info_t * id, int level,
+				       const char* data);
 
-Return Value:  Address of written debug entry 
+Parameter:     id:     handle for debug log
+	       level:  debug level
+	       data:   string for debug entry
 
-Description:   writes debug entry in ascii format to active debug area 
-               (if level <= actual debug level) and switches to next debug 
-               area  
+Return Value:  Address of written debug entry
+
+Description:   writes debug entry in ascii format to active debug area
+	       (if level <= actual debug level) and switches to next debug
+	       area
 
 ---------------------------------------------------------------------------
-debug_entry_t* debug_sprintf_exception (debug_info_t * id, int level,
-                                        char* string,...);
 
-Parameter:     id:    handle for debug log  
-               level: debug level  
-               string: format string for debug entry  
-               ...: varargs used as in sprintf()
+::
+
+  debug_entry_t* debug_sprintf_exception (debug_info_t * id, int level,
+					  char* string,...);
 
-Return Value:  Address of written debug entry 
+Parameter:     id:    handle for debug log
+	       level: debug level
+	       string: format string for debug entry
+	       ...: varargs used as in sprintf()
 
-Description:   writes debug entry with format string and varargs (longs) to 
-               active debug area (if level $<=$ actual debug level) and
-               switches to next debug area. 
-               floats and long long datatypes cannot be used as varargs.
+Return Value:  Address of written debug entry
+
+Description:   writes debug entry with format string and varargs (longs) to
+	       active debug area (if level $<=$ actual debug level) and
+	       switches to next debug area.
+	       floats and long long datatypes cannot be used as varargs.
 
 ---------------------------------------------------------------------------
 
-int debug_register_view (debug_info_t * id, struct debug_view *view);
+::
+
+  int debug_register_view (debug_info_t * id, struct debug_view *view);
 
-Parameter:     id:    handle for debug log  
-               view:  pointer to debug view struct 
+Parameter:     id:    handle for debug log
+	       view:  pointer to debug view struct
 
-Return Value:  0  : ok 
-               < 0: Error 
+Return Value:  0  : ok
+	       < 0: Error
 
 Description:   registers new debug view and creates debugfs dir entry
 
 ---------------------------------------------------------------------------
-int debug_unregister_view (debug_info_t * id, struct debug_view *view); 
 
-Parameter:     id:    handle for debug log  
-               view:  pointer to debug view struct 
+::
 
-Return Value:  0  : ok 
-               < 0: Error 
+  int debug_unregister_view (debug_info_t * id, struct debug_view *view);
+
+Parameter:     id:    handle for debug log
+	       view:  pointer to debug view struct
+
+Return Value:  0  : ok
+	       < 0: Error
 
 Description:   unregisters debug view and removes debugfs dir entry
 
@@ -323,113 +442,117 @@ Predefined views:
 -----------------
 
 extern struct debug_view debug_hex_ascii_view;
+
 extern struct debug_view debug_raw_view;
+
 extern struct debug_view debug_sprintf_view;
 
 Examples
 --------
 
-/*
- * hex_ascii- + raw-view Example
- */
+::
 
-#include <linux/init.h>
-#include <asm/debug.h>
+  /*
+   * hex_ascii- + raw-view Example
+   */
 
-static debug_info_t* debug_info;
+  #include <linux/init.h>
+  #include <asm/debug.h>
 
-static int init(void)
-{
-    /* register 4 debug areas with one page each and 4 byte data field */
+  static debug_info_t* debug_info;
 
-    debug_info = debug_register ("test", 1, 4, 4 );
-    debug_register_view(debug_info,&debug_hex_ascii_view);
-    debug_register_view(debug_info,&debug_raw_view);
+  static int init(void)
+  {
+      /* register 4 debug areas with one page each and 4 byte data field */
 
-    debug_text_event(debug_info, 4 , "one ");
-    debug_int_exception(debug_info, 4, 4711);
-    debug_event(debug_info, 3, &debug_info, 4);
+      debug_info = debug_register ("test", 1, 4, 4 );
+      debug_register_view(debug_info,&debug_hex_ascii_view);
+      debug_register_view(debug_info,&debug_raw_view);
 
-    return 0;
-}
+      debug_text_event(debug_info, 4 , "one ");
+      debug_int_exception(debug_info, 4, 4711);
+      debug_event(debug_info, 3, &debug_info, 4);
 
-static void cleanup(void)
-{
-    debug_unregister (debug_info);
-}
+      return 0;
+  }
 
-module_init(init);
-module_exit(cleanup);
+  static void cleanup(void)
+  {
+      debug_unregister (debug_info);
+  }
+
+  module_init(init);
+  module_exit(cleanup);
 
 ---------------------------------------------------------------------------
 
-/*
- * sprintf-view Example
- */
+::
 
-#include <linux/init.h>
-#include <asm/debug.h>
+  /*
+   * sprintf-view Example
+   */
 
-static debug_info_t* debug_info;
+  #include <linux/init.h>
+  #include <asm/debug.h>
 
-static int init(void)
-{
-    /* register 4 debug areas with one page each and data field for */
-    /* format string pointer + 2 varargs (= 3 * sizeof(long))       */
+  static debug_info_t* debug_info;
 
-    debug_info = debug_register ("test", 1, 4, sizeof(long) * 3);
-    debug_register_view(debug_info,&debug_sprintf_view);
+  static int init(void)
+  {
+      /* register 4 debug areas with one page each and data field for */
+      /* format string pointer + 2 varargs (= 3 * sizeof(long))       */
 
-    debug_sprintf_event(debug_info, 2 , "first event in %s:%i\n",__FILE__,__LINE__);
-    debug_sprintf_exception(debug_info, 1, "pointer to debug info: %p\n",&debug_info);
+      debug_info = debug_register ("test", 1, 4, sizeof(long) * 3);
+      debug_register_view(debug_info,&debug_sprintf_view);
 
-    return 0;
-}
+      debug_sprintf_event(debug_info, 2 , "first event in %s:%i\n",__FILE__,__LINE__);
+      debug_sprintf_exception(debug_info, 1, "pointer to debug info: %p\n",&debug_info);
 
-static void cleanup(void)
-{
-    debug_unregister (debug_info);
-}
-
-module_init(init);
-module_exit(cleanup);
+      return 0;
+  }
 
+  static void cleanup(void)
+  {
+      debug_unregister (debug_info);
+  }
 
+  module_init(init);
+  module_exit(cleanup);
 
 Debugfs Interface
-----------------
-Views to the debug logs can be investigated through reading the corresponding 
+-----------------
+Views to the debug logs can be investigated through reading the corresponding
 debugfs-files:
 
-Example:
+Example::
 
-> ls /sys/kernel/debug/s390dbf/dasd
-flush  hex_ascii  level pages raw
-> cat /sys/kernel/debug/s390dbf/dasd/hex_ascii | sort -k2,2 -s
-00 00974733272:680099 2 - 02 0006ad7e  07 ea 4a 90 | ....
-00 00974733272:682210 2 - 02 0006ade6  46 52 45 45 | FREE
-00 00974733272:682213 2 - 02 0006adf6  07 ea 4a 90 | ....
-00 00974733272:682281 1 * 02 0006ab08  41 4c 4c 43 | EXCP 
-01 00974733272:682284 2 - 02 0006ab16  45 43 4b 44 | ECKD
-01 00974733272:682287 2 - 02 0006ab28  00 00 00 04 | ....
-01 00974733272:682289 2 - 02 0006ab3e  00 00 00 20 | ... 
-01 00974733272:682297 2 - 02 0006ad7e  07 ea 4a 90 | ....
-01 00974733272:684384 2 - 00 0006ade6  46 52 45 45 | FREE
-01 00974733272:684388 2 - 00 0006adf6  07 ea 4a 90 | ....
+  > ls /sys/kernel/debug/s390dbf/dasd
+  flush  hex_ascii  level pages raw
+  > cat /sys/kernel/debug/s390dbf/dasd/hex_ascii | sort -k2,2 -s
+  00 00974733272:680099 2 - 02 0006ad7e  07 ea 4a 90 | ....
+  00 00974733272:682210 2 - 02 0006ade6  46 52 45 45 | FREE
+  00 00974733272:682213 2 - 02 0006adf6  07 ea 4a 90 | ....
+  00 00974733272:682281 1 * 02 0006ab08  41 4c 4c 43 | EXCP
+  01 00974733272:682284 2 - 02 0006ab16  45 43 4b 44 | ECKD
+  01 00974733272:682287 2 - 02 0006ab28  00 00 00 04 | ....
+  01 00974733272:682289 2 - 02 0006ab3e  00 00 00 20 | ...
+  01 00974733272:682297 2 - 02 0006ad7e  07 ea 4a 90 | ....
+  01 00974733272:684384 2 - 00 0006ade6  46 52 45 45 | FREE
+  01 00974733272:684388 2 - 00 0006adf6  07 ea 4a 90 | ....
 
 See section about predefined views for explanation of the above output!
 
 Changing the debug level
 ------------------------
 
-Example:
+Example::
 
 
-> cat /sys/kernel/debug/s390dbf/dasd/level
-3
-> echo "5" > /sys/kernel/debug/s390dbf/dasd/level
-> cat /sys/kernel/debug/s390dbf/dasd/level
-5
+  > cat /sys/kernel/debug/s390dbf/dasd/level
+  3
+  > echo "5" > /sys/kernel/debug/s390dbf/dasd/level
+  > cat /sys/kernel/debug/s390dbf/dasd/level
+  5
 
 Flushing debug areas
 --------------------
@@ -439,11 +562,13 @@ are flushed.
 
 Examples:
 
-1. Flush debug area 0:
-> echo "0" > /sys/kernel/debug/s390dbf/dasd/flush
+1. Flush debug area 0::
 
-2. Flush all debug areas:
-> echo "-" > /sys/kernel/debug/s390dbf/dasd/flush
+     > echo "0" > /sys/kernel/debug/s390dbf/dasd/flush
+
+2. Flush all debug areas::
+
+     > echo "-" > /sys/kernel/debug/s390dbf/dasd/flush
 
 Changing the size of debug areas
 ------------------------------------
@@ -453,23 +578,27 @@ also flush the debug areas.
 
 Example:
 
-Define 4 pages for the debug areas of debug feature "dasd":
-> echo "4" > /sys/kernel/debug/s390dbf/dasd/pages
+Define 4 pages for the debug areas of debug feature "dasd"::
+
+  > echo "4" > /sys/kernel/debug/s390dbf/dasd/pages
 
 Stooping the debug feature
 --------------------------
 Example:
 
-1. Check if stopping is allowed
-> cat /proc/sys/s390dbf/debug_stoppable
-2. Stop debug feature
-> echo 0 > /proc/sys/s390dbf/debug_active
+1. Check if stopping is allowed::
+
+     > cat /proc/sys/s390dbf/debug_stoppable
+
+2. Stop debug feature::
+
+     > echo 0 > /proc/sys/s390dbf/debug_active
 
 lcrash Interface
 ----------------
 It is planned that the dump analysis tool lcrash gets an additional command
-'s390dbf' to display all the debug logs. With this tool it will be possible 
-to investigate the debug logs on a live system and with a memory dump after 
+'s390dbf' to display all the debug logs. With this tool it will be possible
+to investigate the debug logs on a live system and with a memory dump after
 a system crash.
 
 Investigating raw memory
@@ -494,32 +623,35 @@ order to see the debug entries well formatted.
 Predefined Views
 ----------------
 
-There are three predefined views: hex_ascii, raw and sprintf. 
-The hex_ascii view shows the data field in hex and ascii representation 
-(e.g. '45 43 4b 44 | ECKD'). 
+There are three predefined views: hex_ascii, raw and sprintf.
+The hex_ascii view shows the data field in hex and ascii representation
+(e.g. '45 43 4b 44 | ECKD').
 The raw view returns a bytestream as the debug areas are stored in memory.
 
 The sprintf view formats the debug entries in the same way as the sprintf
 function would do. The sprintf event/exception functions write to the
-debug entry a pointer to the format string (size = sizeof(long)) 
-and for each vararg a long value. So e.g. for a debug entry with a format 
-string plus two varargs one would need to allocate a (3 * sizeof(long)) 
+debug entry a pointer to the format string (size = sizeof(long))
+and for each vararg a long value. So e.g. for a debug entry with a format
+string plus two varargs one would need to allocate a (3 * sizeof(long))
 byte data area in the debug_register() function.
 
-IMPORTANT: Using "%s" in sprintf event functions is dangerous. You can only
-use "%s" in the sprintf event functions, if the memory for the passed string is
-available as long as the debug feature exists. The reason behind this is that
-due to performance considerations only a pointer to the string is stored in
-the debug feature. If you log a string that is freed afterwards, you will get
-an OOPS when inspecting the debug feature, because then the debug feature will
-access the already freed memory.
+IMPORTANT:
+  Using "%s" in sprintf event functions is dangerous. You can only
+  use "%s" in the sprintf event functions, if the memory for the passed string
+  is available as long as the debug feature exists. The reason behind this is
+  that due to performance considerations only a pointer to the string is stored
+  in  the debug feature. If you log a string that is freed afterwards, you will
+  get an OOPS when inspecting the debug feature, because then the debug feature
+  will access the already freed memory.
 
-NOTE: If using the sprintf view do NOT use other event/exception functions
-than the sprintf-event and -exception functions.
+NOTE:
+  If using the sprintf view do NOT use other event/exception functions
+  than the sprintf-event and -exception functions.
 
 The format of the hex_ascii and sprintf view is as follows:
+
 - Number of area
-- Timestamp (formatted as seconds and microseconds since 00:00:00 Coordinated 
+- Timestamp (formatted as seconds and microseconds since 00:00:00 Coordinated
   Universal Time (UTC), January 1, 1970)
 - level of debug entry
 - Exception flag (* = Exception)
@@ -528,140 +660,144 @@ The format of the hex_ascii and sprintf view is as follows:
 - data field
 
 The format of the raw view is:
+
 - Header as described in debug.h
-- datafield 
+- datafield
 
-A typical line of the hex_ascii view will look like the following (first line 
+A typical line of the hex_ascii view will look like the following (first line
 is only for explanation and will not be displayed when 'cating' the view):
 
 area  time           level exception cpu caller    data (hex + ascii)
 --------------------------------------------------------------------------
-00    00964419409:440690 1 -         00  88023fe   
+00    00964419409:440690 1 -         00  88023fe
 
 
 Defining views
 --------------
 
 Views are specified with the 'debug_view' structure. There are defined
-callback functions which are used for reading and writing the debugfs files:
+callback functions which are used for reading and writing the debugfs files::
 
-struct debug_view {
-        char name[DEBUG_MAX_PROCF_LEN];  
-        debug_prolog_proc_t* prolog_proc; 
-        debug_header_proc_t* header_proc;
-        debug_format_proc_t* format_proc;
-        debug_input_proc_t*  input_proc;
+  struct debug_view {
+	char name[DEBUG_MAX_PROCF_LEN];
+	debug_prolog_proc_t* prolog_proc;
+	debug_header_proc_t* header_proc;
+	debug_format_proc_t* format_proc;
+	debug_input_proc_t*  input_proc;
 	void*                private_data;
-};
+  };
 
-where
+where::
 
-typedef int (debug_header_proc_t) (debug_info_t* id,
-                                   struct debug_view* view,
-                                   int area,
-                                   debug_entry_t* entry,
-                                   char* out_buf);
+  typedef int (debug_header_proc_t) (debug_info_t* id,
+				     struct debug_view* view,
+				     int area,
+				     debug_entry_t* entry,
+				     char* out_buf);
 
-typedef int (debug_format_proc_t) (debug_info_t* id,
-                                   struct debug_view* view, char* out_buf,
-                                   const char* in_buf);
-typedef int (debug_prolog_proc_t) (debug_info_t* id,
-                                   struct debug_view* view,
-                                   char* out_buf);
-typedef int (debug_input_proc_t) (debug_info_t* id,
-                                  struct debug_view* view,
-                                  struct file* file, const char* user_buf,
-                                  size_t in_buf_size, loff_t* offset);
+  typedef int (debug_format_proc_t) (debug_info_t* id,
+				     struct debug_view* view, char* out_buf,
+				     const char* in_buf);
+  typedef int (debug_prolog_proc_t) (debug_info_t* id,
+				     struct debug_view* view,
+				     char* out_buf);
+  typedef int (debug_input_proc_t) (debug_info_t* id,
+				    struct debug_view* view,
+				    struct file* file, const char* user_buf,
+				    size_t in_buf_size, loff_t* offset);
 
 
 The "private_data" member can be used as pointer to view specific data.
 It is not used by the debug feature itself.
 
-The output when reading a debugfs file is structured like this:
+The output when reading a debugfs file is structured like this::
 
-"prolog_proc output"
+  "prolog_proc output"
 
-"header_proc output 1"  "format_proc output 1"
-"header_proc output 2"  "format_proc output 2"
-"header_proc output 3"  "format_proc output 3"
-...
+  "header_proc output 1"  "format_proc output 1"
+  "header_proc output 2"  "format_proc output 2"
+  "header_proc output 3"  "format_proc output 3"
+  ...
 
 When a view is read from the debugfs, the Debug Feature calls the
 'prolog_proc' once for writing the prolog.
-Then 'header_proc' and 'format_proc' are called for each 
+Then 'header_proc' and 'format_proc' are called for each
 existing debug entry.
 
-The input_proc can be used to implement functionality when it is written to 
+The input_proc can be used to implement functionality when it is written to
 the view (e.g. like with 'echo "0" > /sys/kernel/debug/s390dbf/dasd/level).
 
 For header_proc there can be used the default function
 debug_dflt_header_fn() which is defined in debug.h.
 and which produces the same header output as the predefined views.
-E.g:
-00 00964419409:440761 2 - 00 88023ec
+E.g::
+
+  00 00964419409:440761 2 - 00 88023ec
 
 In order to see how to use the callback functions check the implementation
 of the default views!
 
-Example
+Example::
 
-#include <asm/debug.h>
+  #include <asm/debug.h>
 
-#define UNKNOWNSTR "data: %08x"
+  #define UNKNOWNSTR "data: %08x"
 
-const char* messages[] =
-{"This error...........\n",
- "That error...........\n",
- "Problem..............\n",
- "Something went wrong.\n",
- "Everything ok........\n",
- NULL
-};
+  const char* messages[] =
+  {"This error...........\n",
+   "That error...........\n",
+   "Problem..............\n",
+   "Something went wrong.\n",
+   "Everything ok........\n",
+   NULL
+  };
 
-static int debug_test_format_fn(
-   debug_info_t * id, struct debug_view *view, 
-   char *out_buf, const char *in_buf
-)
-{
-  int i, rc = 0;
+  static int debug_test_format_fn(
+     debug_info_t * id, struct debug_view *view,
+     char *out_buf, const char *in_buf
+  )
+  {
+    int i, rc = 0;
 
-  if(id->buf_size >= 4) {
-     int msg_nr = *((int*)in_buf);
-     if(msg_nr < sizeof(messages)/sizeof(char*) - 1)
-        rc += sprintf(out_buf, "%s", messages[msg_nr]);	
-     else
-        rc += sprintf(out_buf, UNKNOWNSTR, msg_nr);
+    if(id->buf_size >= 4) {
+       int msg_nr = *((int*)in_buf);
+       if(msg_nr < sizeof(messages)/sizeof(char*) - 1)
+	  rc += sprintf(out_buf, "%s", messages[msg_nr]);
+       else
+	  rc += sprintf(out_buf, UNKNOWNSTR, msg_nr);
+    }
+   out:
+     return rc;
   }
- out:
-   return rc;
-}
 
-struct debug_view debug_test_view = {
-  "myview",                 /* name of view */
-  NULL,                     /* no prolog */
-  &debug_dflt_header_fn,    /* default header for each entry */
-  &debug_test_format_fn,    /* our own format function */
-  NULL,                     /* no input function */
-  NULL                      /* no private data */
-};
+  struct debug_view debug_test_view = {
+    "myview",                 /* name of view */
+    NULL,                     /* no prolog */
+    &debug_dflt_header_fn,    /* default header for each entry */
+    &debug_test_format_fn,    /* our own format function */
+    NULL,                     /* no input function */
+    NULL                      /* no private data */
+  };
 
-=====
 test:
 =====
-debug_info_t *debug_info;
-...
-debug_info = debug_register ("test", 0, 4, 4 ));
-debug_register_view(debug_info, &debug_test_view);
-for(i = 0; i < 10; i ++) debug_int_event(debug_info, 1, i);
 
-> cat /sys/kernel/debug/s390dbf/test/myview
-00 00964419734:611402 1 - 00 88042ca   This error...........
-00 00964419734:611405 1 - 00 88042ca   That error...........
-00 00964419734:611408 1 - 00 88042ca   Problem..............
-00 00964419734:611411 1 - 00 88042ca   Something went wrong.
-00 00964419734:611414 1 - 00 88042ca   Everything ok........
-00 00964419734:611417 1 - 00 88042ca   data: 00000005
-00 00964419734:611419 1 - 00 88042ca   data: 00000006
-00 00964419734:611422 1 - 00 88042ca   data: 00000007
-00 00964419734:611425 1 - 00 88042ca   data: 00000008
-00 00964419734:611428 1 - 00 88042ca   data: 00000009
+::
+
+  debug_info_t *debug_info;
+  ...
+  debug_info = debug_register ("test", 0, 4, 4 ));
+  debug_register_view(debug_info, &debug_test_view);
+  for(i = 0; i < 10; i ++) debug_int_event(debug_info, 1, i);
+
+  > cat /sys/kernel/debug/s390dbf/test/myview
+  00 00964419734:611402 1 - 00 88042ca   This error...........
+  00 00964419734:611405 1 - 00 88042ca   That error...........
+  00 00964419734:611408 1 - 00 88042ca   Problem..............
+  00 00964419734:611411 1 - 00 88042ca   Something went wrong.
+  00 00964419734:611414 1 - 00 88042ca   Everything ok........
+  00 00964419734:611417 1 - 00 88042ca   data: 00000005
+  00 00964419734:611419 1 - 00 88042ca   data: 00000006
+  00 00964419734:611422 1 - 00 88042ca   data: 00000007
+  00 00964419734:611425 1 - 00 88042ca   data: 00000008
+  00 00964419734:611428 1 - 00 88042ca   data: 00000009
diff --git a/Documentation/s390/text_files.rst b/Documentation/s390/text_files.rst
new file mode 100644
index 000000000000..c94d05d4fa17
--- /dev/null
+++ b/Documentation/s390/text_files.rst
@@ -0,0 +1,11 @@
+ibm 3270 changelog
+------------------
+
+.. include:: 3270.ChangeLog
+    :literal:
+
+ibm 3270 config3270.sh
+----------------------
+
+.. literalinclude:: config3270.sh
+    :language: shell
diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.rst
similarity index 72%
rename from Documentation/s390/vfio-ap.txt
rename to Documentation/s390/vfio-ap.rst
index 65167cfe4485..b5c51f7c748d 100644
--- a/Documentation/s390/vfio-ap.txt
+++ b/Documentation/s390/vfio-ap.rst
@@ -1,4 +1,9 @@
-Introduction:
+===============================
+Adjunct Processor (AP) facility
+===============================
+
+
+Introduction
 ============
 The Adjunct Processor (AP) facility is an IBM Z cryptographic facility comprised
 of three AP instructions and from 1 up to 256 PCIe cryptographic adapter cards.
@@ -11,7 +16,7 @@ framework. This implementation relies considerably on the s390 virtualization
 facilities which do most of the hard work of providing direct access to AP
 devices.
 
-AP Architectural Overview:
+AP Architectural Overview
 =========================
 To facilitate the comprehension of the design, let's start with some
 definitions:
@@ -31,13 +36,13 @@ definitions:
   in the LPAR, the AP bus detects the AP adapter cards assigned to the LPAR and
   creates a sysfs device for each assigned adapter. For example, if AP adapters
   4 and 10 (0x0a) are assigned to the LPAR, the AP bus will create the following
-  sysfs device entries:
+  sysfs device entries::
 
     /sys/devices/ap/card04
     /sys/devices/ap/card0a
 
   Symbolic links to these devices will also be created in the AP bus devices
-  sub-directory:
+  sub-directory::
 
     /sys/bus/ap/devices/[card04]
     /sys/bus/ap/devices/[card04]
@@ -84,7 +89,7 @@ definitions:
   the cross product of the AP adapter and usage domain numbers detected when the
   AP bus module is loaded. For example, if adapters 4 and 10 (0x0a) and usage
   domains 6 and 71 (0x47) are assigned to the LPAR, the AP bus will create the
-  following sysfs entries:
+  following sysfs entries::
 
     /sys/devices/ap/card04/04.0006
     /sys/devices/ap/card04/04.0047
@@ -92,7 +97,7 @@ definitions:
     /sys/devices/ap/card0a/0a.0047
 
   The following symbolic links to these devices will be created in the AP bus
-  devices subdirectory:
+  devices subdirectory::
 
     /sys/bus/ap/devices/[04.0006]
     /sys/bus/ap/devices/[04.0047]
@@ -112,7 +117,7 @@ definitions:
   domain that is not one of the usage domains, but the modified domain
   must be one of the control domains.
 
-AP and SIE:
+AP and SIE
 ==========
 Let's now take a look at how AP instructions executed on a guest are interpreted
 by the hardware.
@@ -153,7 +158,7 @@ and 2 and usage domains 5 and 6 are assigned to a guest, the APQNs (1,5), (1,6),
 
 The APQNs can provide secure key functionality - i.e., a private key is stored
 on the adapter card for each of its domains - so each APQN must be assigned to
-at most one guest or to the linux host.
+at most one guest or to the linux host::
 
    Example 1: Valid configuration:
    ------------------------------
@@ -181,8 +186,8 @@ at most one guest or to the linux host.
    This is an invalid configuration because both guests have access to
    APQN (1,6).
 
-The Design:
-===========
+The Design
+==========
 The design introduces three new objects:
 
 1. AP matrix device
@@ -205,43 +210,43 @@ The VFIO AP (vfio_ap) device driver serves the following purposes:
 Reserve APQNs for exclusive use of KVM guests
 ---------------------------------------------
 The following block diagram illustrates the mechanism by which APQNs are
-reserved:
+reserved::
 
-                              +------------------+
-               7 remove       |                  |
-         +--------------------> cex4queue driver |
-         |                    |                  |
-         |                    +------------------+
-         |
-         |
-         |                    +------------------+          +-----------------+
-         |  5 register driver |                  | 3 create |                 |
-         |   +---------------->   Device core    +---------->  matrix device  |
-         |   |                |                  |          |                 |
-         |   |                +--------^---------+          +-----------------+
-         |   |                         |
-         |   |                         +-------------------+
-         |   | +-----------------------------------+       |
-         |   | |      4 register AP driver         |       | 2 register device
-         |   | |                                   |       |
-+--------+---+-v---+                      +--------+-------+-+
-|                  |                      |                  |
-|      ap_bus      +--------------------- >  vfio_ap driver  |
-|                  |       8 probe        |                  |
-+--------^---------+                      +--^--^------------+
-6 edit   |                                   |  |
-  apmask |     +-----------------------------+  | 9 mdev create
-  aqmask |     |           1 modprobe           |
-+--------+-----+---+           +----------------+-+         +------------------+
-|                  |           |                  |8 create |     mediated     |
-|      admin       |           | VFIO device core |--------->     matrix       |
-|                  +           |                  |         |     device       |
-+------+-+---------+           +--------^---------+         +--------^---------+
-       | |                              |                            |
-       | | 9 create vfio_ap-passthrough |                            |
-       | +------------------------------+                            |
-       +-------------------------------------------------------------+
-                   10  assign adapter/domain/control domain
+				+------------------+
+		 7 remove       |                  |
+	   +--------------------> cex4queue driver |
+	   |                    |                  |
+	   |                    +------------------+
+	   |
+	   |
+	   |                    +------------------+          +----------------+
+	   |  5 register driver |                  | 3 create |                |
+	   |   +---------------->   Device core    +---------->  matrix device |
+	   |   |                |                  |          |                |
+	   |   |                +--------^---------+          +----------------+
+	   |   |                         |
+	   |   |                         +-------------------+
+	   |   | +-----------------------------------+       |
+	   |   | |      4 register AP driver         |       | 2 register device
+	   |   | |                                   |       |
+  +--------+---+-v---+                      +--------+-------+-+
+  |                  |                      |                  |
+  |      ap_bus      +--------------------- >  vfio_ap driver  |
+  |                  |       8 probe        |                  |
+  +--------^---------+                      +--^--^------------+
+  6 edit   |                                   |  |
+    apmask |     +-----------------------------+  | 9 mdev create
+    aqmask |     |           1 modprobe           |
+  +--------+-----+---+           +----------------+-+         +----------------+
+  |                  |           |                  |8 create |     mediated   |
+  |      admin       |           | VFIO device core |--------->     matrix     |
+  |                  +           |                  |         |     device     |
+  +------+-+---------+           +--------^---------+         +--------^-------+
+	 | |                              |                            |
+	 | | 9 create vfio_ap-passthrough |                            |
+	 | +------------------------------+                            |
+	 +-------------------------------------------------------------+
+		     10  assign adapter/domain/control domain
 
 The process for reserving an AP queue for use by a KVM guest is:
 
@@ -250,7 +255,7 @@ The process for reserving an AP queue for use by a KVM guest is:
    device with the device core. This will serve as the parent device for
    all mediated matrix devices used to configure an AP matrix for a guest.
 3. The /sys/devices/vfio_ap/matrix device is created by the device core
-4  The vfio_ap device driver will register with the AP bus for AP queue devices
+4. The vfio_ap device driver will register with the AP bus for AP queue devices
    of type 10 and higher (CEX4 and newer). The driver will provide the vfio_ap
    driver's probe and remove callback interfaces. Devices older than CEX4 queues
    are not supported to simplify the implementation by not needlessly
@@ -266,13 +271,14 @@ The process for reserving an AP queue for use by a KVM guest is:
    it.
 9. The administrator creates a passthrough type mediated matrix device to be
    used by a guest
-10 The administrator assigns the adapters, usage domains and control domains
-   to be exclusively used by a guest.
+10. The administrator assigns the adapters, usage domains and control domains
+    to be exclusively used by a guest.
 
 Set up the VFIO mediated device interfaces
 ------------------------------------------
 The VFIO AP device driver utilizes the common interface of the VFIO mediated
 device core driver to:
+
 * Register an AP mediated bus driver to add a mediated matrix device to and
   remove it from a VFIO group.
 * Create and destroy a mediated matrix device
@@ -280,25 +286,25 @@ device core driver to:
 * Add a mediated matrix device to and remove it from an IOMMU group
 
 The following high-level block diagram shows the main components and interfaces
-of the VFIO AP mediated matrix device driver:
+of the VFIO AP mediated matrix device driver::
 
- +-------------+
- |             |
- | +---------+ | mdev_register_driver() +--------------+
- | |  Mdev   | +<-----------------------+              |
- | |  bus    | |                        | vfio_mdev.ko |
- | | driver  | +----------------------->+              |<-> VFIO user
- | +---------+ |    probe()/remove()    +--------------+    APIs
- |             |
- |  MDEV CORE  |
- |   MODULE    |
- |   mdev.ko   |
- | +---------+ | mdev_register_device() +--------------+
- | |Physical | +<-----------------------+              |
- | | device  | |                        |  vfio_ap.ko  |<-> matrix
- | |interface| +----------------------->+              |    device
- | +---------+ |       callback         +--------------+
- +-------------+
+   +-------------+
+   |             |
+   | +---------+ | mdev_register_driver() +--------------+
+   | |  Mdev   | +<-----------------------+              |
+   | |  bus    | |                        | vfio_mdev.ko |
+   | | driver  | +----------------------->+              |<-> VFIO user
+   | +---------+ |    probe()/remove()    +--------------+    APIs
+   |             |
+   |  MDEV CORE  |
+   |   MODULE    |
+   |   mdev.ko   |
+   | +---------+ | mdev_register_device() +--------------+
+   | |Physical | +<-----------------------+              |
+   | | device  | |                        |  vfio_ap.ko  |<-> matrix
+   | |interface| +----------------------->+              |    device
+   | +---------+ |       callback         +--------------+
+   +-------------+
 
 During initialization of the vfio_ap module, the matrix device is registered
 with an 'mdev_parent_ops' structure that provides the sysfs attribute
@@ -306,7 +312,8 @@ structures, mdev functions and callback interfaces for managing the mediated
 matrix device.
 
 * sysfs attribute structures:
-  * supported_type_groups
+
+  supported_type_groups
     The VFIO mediated device framework supports creation of user-defined
     mediated device types. These mediated device types are specified
     via the 'supported_type_groups' structure when a device is registered
@@ -318,61 +325,72 @@ matrix device.
 
     The VFIO AP device driver will register one mediated device type for
     passthrough devices:
+
       /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough
+
     Only the read-only attributes required by the VFIO mdev framework will
-    be provided:
-        ... name
-        ... device_api
-        ... available_instances
-        ... device_api
-        Where:
-        * name: specifies the name of the mediated device type
-        * device_api: the mediated device type's API
-        * available_instances: the number of mediated matrix passthrough devices
-                               that can be created
-        * device_api: specifies the VFIO API
-  * mdev_attr_groups
+    be provided::
+
+	... name
+	... device_api
+	... available_instances
+	... device_api
+
+    Where:
+
+	* name:
+	    specifies the name of the mediated device type
+	* device_api:
+	    the mediated device type's API
+	* available_instances:
+	    the number of mediated matrix passthrough devices
+	    that can be created
+	* device_api:
+	    specifies the VFIO API
+  mdev_attr_groups
     This attribute group identifies the user-defined sysfs attributes of the
     mediated device. When a device is registered with the VFIO mediated device
     framework, the sysfs attribute files identified in the 'mdev_attr_groups'
     structure will be created in the mediated matrix device's directory. The
     sysfs attributes for a mediated matrix device are:
-    * assign_adapter:
-    * unassign_adapter:
+
+    assign_adapter / unassign_adapter:
       Write-only attributes for assigning/unassigning an AP adapter to/from the
       mediated matrix device. To assign/unassign an adapter, the APID of the
       adapter is echoed to the respective attribute file.
-    * assign_domain:
-    * unassign_domain:
+    assign_domain / unassign_domain:
       Write-only attributes for assigning/unassigning an AP usage domain to/from
       the mediated matrix device. To assign/unassign a domain, the domain
       number of the the usage domain is echoed to the respective attribute
       file.
-    * matrix:
+    matrix:
       A read-only file for displaying the APQNs derived from the cross product
       of the adapter and domain numbers assigned to the mediated matrix device.
-    * assign_control_domain:
-    * unassign_control_domain:
+    assign_control_domain / unassign_control_domain:
       Write-only attributes for assigning/unassigning an AP control domain
       to/from the mediated matrix device. To assign/unassign a control domain,
       the ID of the domain to be assigned/unassigned is echoed to the respective
       attribute file.
-    * control_domains:
+    control_domains:
       A read-only file for displaying the control domain numbers assigned to the
       mediated matrix device.
 
 * functions:
-  * create:
+
+  create:
     allocates the ap_matrix_mdev structure used by the vfio_ap driver to:
+
     * Store the reference to the KVM structure for the guest using the mdev
     * Store the AP matrix configuration for the adapters, domains, and control
       domains assigned via the corresponding sysfs attributes files
-  * remove:
+
+  remove:
     deallocates the mediated matrix device's ap_matrix_mdev structure. This will
     be allowed only if a running guest is not using the mdev.
 
 * callback interfaces
-  * open:
+
+  open:
     The vfio_ap driver uses this callback to register a
     VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the mdev matrix
     device. The open is invoked when QEMU connects the VFIO iommu group
@@ -380,16 +398,17 @@ matrix device.
     to configure the KVM guest is provided via this callback. The KVM structure,
     is used to configure the guest's access to the AP matrix defined via the
     mediated matrix device's sysfs attribute files.
-  * release:
+  release:
     unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the
     mdev matrix device and deconfigures the guest's AP matrix.
 
-Configure the APM, AQM and ADM in the CRYCB:
+Configure the APM, AQM and ADM in the CRYCB
 -------------------------------------------
 Configuring the AP matrix for a KVM guest will be performed when the
 VFIO_GROUP_NOTIFY_SET_KVM notifier callback is invoked. The notifier
 function is called when QEMU connects to KVM. The guest's AP matrix is
 configured via it's CRYCB by:
+
 * Setting the bits in the APM corresponding to the APIDs assigned to the
   mediated matrix device via its 'assign_adapter' interface.
 * Setting the bits in the AQM corresponding to the domains assigned to the
@@ -418,12 +437,12 @@ available to a KVM guest via the following CPU model features:
 
 Note: If the user chooses to specify a CPU model different than the 'host'
 model to QEMU, the CPU model features and facilities need to be turned on
-explicitly; for example:
+explicitly; for example::
 
      /usr/bin/qemu-system-s390x ... -cpu z13,ap=on,apqci=on,apft=on
 
 A guest can be precluded from using AP features/facilities by turning them off
-explicitly; for example:
+explicitly; for example::
 
      /usr/bin/qemu-system-s390x ... -cpu host,ap=off,apqci=off,apft=off
 
@@ -435,7 +454,7 @@ the APFT facility is not installed on the guest, then the probe of device
 drivers will fail since only type 10 and newer devices can be configured for
 guest use.
 
-Example:
+Example
 =======
 Let's now provide an example to illustrate how KVM guests may be given
 access to AP facilities. For this example, we will show how to configure
@@ -444,30 +463,36 @@ look like this:
 
 Guest1
 ------
+=========== ===== ============
 CARD.DOMAIN TYPE  MODE
-------------------------------
+=========== ===== ============
 05          CEX5C CCA-Coproc
 05.0004     CEX5C CCA-Coproc
 05.00ab     CEX5C CCA-Coproc
 06          CEX5A Accelerator
 06.0004     CEX5A Accelerator
 06.00ab     CEX5C CCA-Coproc
+=========== ===== ============
 
 Guest2
 ------
+=========== ===== ============
 CARD.DOMAIN TYPE  MODE
-------------------------------
+=========== ===== ============
 05          CEX5A Accelerator
 05.0047     CEX5A Accelerator
 05.00ff     CEX5A Accelerator
+=========== ===== ============
 
 Guest2
 ------
+=========== ===== ============
 CARD.DOMAIN TYPE  MODE
-------------------------------
+=========== ===== ============
 06          CEX5A Accelerator
 06.0047     CEX5A Accelerator
 06.00ff     CEX5A Accelerator
+=========== ===== ============
 
 These are the steps:
 
@@ -492,25 +517,26 @@ These are the steps:
    * VFIO_MDEV_DEVICE
    * KVM
 
-   If using make menuconfig select the following to build the vfio_ap module:
-   -> Device Drivers
-      -> IOMMU Hardware Support
-         select S390 AP IOMMU Support
-      -> VFIO Non-Privileged userspace driver framework
-         -> Mediated device driver frramework
-            -> VFIO driver for Mediated devices
-   -> I/O subsystem
-      -> VFIO support for AP devices
+   If using make menuconfig select the following to build the vfio_ap module::
+
+     -> Device Drivers
+	-> IOMMU Hardware Support
+	   select S390 AP IOMMU Support
+	-> VFIO Non-Privileged userspace driver framework
+	   -> Mediated device driver frramework
+	      -> VFIO driver for Mediated devices
+     -> I/O subsystem
+	-> VFIO support for AP devices
 
 2. Secure the AP queues to be used by the three guests so that the host can not
    access them. To secure them, there are two sysfs files that specify
    bitmasks marking a subset of the APQN range as 'usable by the default AP
    queue device drivers' or 'not usable by the default device drivers' and thus
    available for use by the vfio_ap device driver'. The location of the sysfs
-   files containing the masks are:
+   files containing the masks are::
 
-   /sys/bus/ap/apmask
-   /sys/bus/ap/aqmask
+     /sys/bus/ap/apmask
+     /sys/bus/ap/aqmask
 
    The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
    (APID). Each bit in the mask, from left to right (i.e., from most significant
@@ -526,7 +552,7 @@ These are the steps:
    queue device drivers; otherwise, the APQI is usable by the vfio_ap device
    driver.
 
-   Take, for example, the following mask:
+   Take, for example, the following mask::
 
       0x7dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
 
@@ -548,68 +574,70 @@ These are the steps:
       respective sysfs mask file in one of two formats:
 
       * An absolute hex string starting with 0x - like "0x12345678" - sets
-        the mask. If the given string is shorter than the mask, it is padded
-        with 0s on the right; for example, specifying a mask value of 0x41 is
-        the same as specifying:
+	the mask. If the given string is shorter than the mask, it is padded
+	with 0s on the right; for example, specifying a mask value of 0x41 is
+	the same as specifying::
 
-           0x4100000000000000000000000000000000000000000000000000000000000000
+	   0x4100000000000000000000000000000000000000000000000000000000000000
 
-        Keep in mind that the mask reads from left to right (i.e., most
-        significant to least significant bit in big endian order), so the mask
-        above identifies device numbers 1 and 7 (01000001).
+	Keep in mind that the mask reads from left to right (i.e., most
+	significant to least significant bit in big endian order), so the mask
+	above identifies device numbers 1 and 7 (01000001).
 
-        If the string is longer than the mask, the operation is terminated with
-        an error (EINVAL).
+	If the string is longer than the mask, the operation is terminated with
+	an error (EINVAL).
 
       * Individual bits in the mask can be switched on and off by specifying
-        each bit number to be switched in a comma separated list. Each bit
-        number string must be prepended with a ('+') or minus ('-') to indicate
-        the corresponding bit is to be switched on ('+') or off ('-'). Some
-        valid values are:
+	each bit number to be switched in a comma separated list. Each bit
+	number string must be prepended with a ('+') or minus ('-') to indicate
+	the corresponding bit is to be switched on ('+') or off ('-'). Some
+	valid values are:
 
-           "+0"    switches bit 0 on
-           "-13"   switches bit 13 off
-           "+0x41" switches bit 65 on
-           "-0xff" switches bit 255 off
+	   - "+0"    switches bit 0 on
+	   - "-13"   switches bit 13 off
+	   - "+0x41" switches bit 65 on
+	   - "-0xff" switches bit 255 off
 
-           The following example:
-              +0,-6,+0x47,-0xf0
+	The following example:
 
-              Switches bits 0 and 71 (0x47) on
-              Switches bits 6 and 240 (0xf0) off
+	      +0,-6,+0x47,-0xf0
 
-        Note that the bits not specified in the list remain as they were before
-        the operation.
+	Switches bits 0 and 71 (0x47) on
+
+	Switches bits 6 and 240 (0xf0) off
+
+	Note that the bits not specified in the list remain as they were before
+	the operation.
 
    2. The masks can also be changed at boot time via parameters on the kernel
       command line like this:
 
-         ap.apmask=0xffff ap.aqmask=0x40
+	 ap.apmask=0xffff ap.aqmask=0x40
 
-         This would create the following masks:
+	 This would create the following masks::
 
-            apmask:
-            0xffff000000000000000000000000000000000000000000000000000000000000
+	    apmask:
+	    0xffff000000000000000000000000000000000000000000000000000000000000
 
-            aqmask:
-            0x4000000000000000000000000000000000000000000000000000000000000000
+	    aqmask:
+	    0x4000000000000000000000000000000000000000000000000000000000000000
 
-         Resulting in these two pools:
+	 Resulting in these two pools::
 
-            default drivers pool:    adapter 0-15, domain 1
-            alternate drivers pool:  adapter 16-255, domains 0, 2-255
+	    default drivers pool:    adapter 0-15, domain 1
+	    alternate drivers pool:  adapter 16-255, domains 0, 2-255
 
-   Securing the APQNs for our example:
-   ----------------------------------
+Securing the APQNs for our example
+----------------------------------
    To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004, 06.0047,
    06.00ab, and 06.00ff for use by the vfio_ap device driver, the corresponding
-   APQNs can either be removed from the default masks:
+   APQNs can either be removed from the default masks::
 
       echo -5,-6 > /sys/bus/ap/apmask
 
       echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask
 
-   Or the masks can be set as follows:
+   Or the masks can be set as follows::
 
       echo 0xf9ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff \
       > apmask
@@ -620,19 +648,19 @@ These are the steps:
    This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004,
    06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device driver. The
    sysfs directory for the vfio_ap device driver will now contain symbolic links
-   to the AP queue devices bound to it:
+   to the AP queue devices bound to it::
 
-   /sys/bus/ap
-   ... [drivers]
-   ...... [vfio_ap]
-   ......... [05.0004]
-   ......... [05.0047]
-   ......... [05.00ab]
-   ......... [05.00ff]
-   ......... [06.0004]
-   ......... [06.0047]
-   ......... [06.00ab]
-   ......... [06.00ff]
+     /sys/bus/ap
+     ... [drivers]
+     ...... [vfio_ap]
+     ......... [05.0004]
+     ......... [05.0047]
+     ......... [05.00ab]
+     ......... [05.00ff]
+     ......... [06.0004]
+     ......... [06.0047]
+     ......... [06.00ab]
+     ......... [06.00ff]
 
    Keep in mind that only type 10 and newer adapters (i.e., CEX4 and later)
    can be bound to the vfio_ap device driver. The reason for this is to
@@ -645,96 +673,96 @@ These are the steps:
    queue device can be read from the parent card's sysfs directory. For example,
    to see the hardware type of the queue 05.0004:
 
-   cat /sys/bus/ap/devices/card05/hwtype
+     cat /sys/bus/ap/devices/card05/hwtype
 
    The hwtype must be 10 or higher (CEX4 or newer) in order to be bound to the
    vfio_ap device driver.
 
 3. Create the mediated devices needed to configure the AP matrixes for the
    three guests and to provide an interface to the vfio_ap driver for
-   use by the guests:
+   use by the guests::
 
-   /sys/devices/vfio_ap/matrix/
-   --- [mdev_supported_types]
-   ------ [vfio_ap-passthrough] (passthrough mediated matrix device type)
-   --------- create
-   --------- [devices]
+     /sys/devices/vfio_ap/matrix/
+     --- [mdev_supported_types]
+     ------ [vfio_ap-passthrough] (passthrough mediated matrix device type)
+     --------- create
+     --------- [devices]
 
-   To create the mediated devices for the three guests:
+   To create the mediated devices for the three guests::
 
 	uuidgen > create
 	uuidgen > create
 	uuidgen > create
 
-        or
+	or
 
-        echo $uuid1 > create
-        echo $uuid2 > create
-        echo $uuid3 > create
+	echo $uuid1 > create
+	echo $uuid2 > create
+	echo $uuid3 > create
 
    This will create three mediated devices in the [devices] subdirectory named
    after the UUID written to the create attribute file. We call them $uuid1,
-   $uuid2 and $uuid3 and this is the sysfs directory structure after creation:
+   $uuid2 and $uuid3 and this is the sysfs directory structure after creation::
 
-   /sys/devices/vfio_ap/matrix/
-   --- [mdev_supported_types]
-   ------ [vfio_ap-passthrough]
-   --------- [devices]
-   ------------ [$uuid1]
-   --------------- assign_adapter
-   --------------- assign_control_domain
-   --------------- assign_domain
-   --------------- matrix
-   --------------- unassign_adapter
-   --------------- unassign_control_domain
-   --------------- unassign_domain
+     /sys/devices/vfio_ap/matrix/
+     --- [mdev_supported_types]
+     ------ [vfio_ap-passthrough]
+     --------- [devices]
+     ------------ [$uuid1]
+     --------------- assign_adapter
+     --------------- assign_control_domain
+     --------------- assign_domain
+     --------------- matrix
+     --------------- unassign_adapter
+     --------------- unassign_control_domain
+     --------------- unassign_domain
 
-   ------------ [$uuid2]
-   --------------- assign_adapter
-   --------------- assign_control_domain
-   --------------- assign_domain
-   --------------- matrix
-   --------------- unassign_adapter
-   ----------------unassign_control_domain
-   ----------------unassign_domain
+     ------------ [$uuid2]
+     --------------- assign_adapter
+     --------------- assign_control_domain
+     --------------- assign_domain
+     --------------- matrix
+     --------------- unassign_adapter
+     ----------------unassign_control_domain
+     ----------------unassign_domain
 
-   ------------ [$uuid3]
-   --------------- assign_adapter
-   --------------- assign_control_domain
-   --------------- assign_domain
-   --------------- matrix
-   --------------- unassign_adapter
-   ----------------unassign_control_domain
-   ----------------unassign_domain
+     ------------ [$uuid3]
+     --------------- assign_adapter
+     --------------- assign_control_domain
+     --------------- assign_domain
+     --------------- matrix
+     --------------- unassign_adapter
+     ----------------unassign_control_domain
+     ----------------unassign_domain
 
 4. The administrator now needs to configure the matrixes for the mediated
    devices $uuid1 (for Guest1), $uuid2 (for Guest2) and $uuid3 (for Guest3).
 
-   This is how the matrix is configured for Guest1:
+   This is how the matrix is configured for Guest1::
 
       echo 5 > assign_adapter
       echo 6 > assign_adapter
       echo 4 > assign_domain
       echo 0xab > assign_domain
 
-      Control domains can similarly be assigned using the assign_control_domain
-      sysfs file.
+   Control domains can similarly be assigned using the assign_control_domain
+   sysfs file.
 
-      If a mistake is made configuring an adapter, domain or control domain,
-      you can use the unassign_xxx files to unassign the adapter, domain or
-      control domain.
+   If a mistake is made configuring an adapter, domain or control domain,
+   you can use the unassign_xxx files to unassign the adapter, domain or
+   control domain.
 
-      To display the matrix configuration for Guest1:
+   To display the matrix configuration for Guest1::
 
-         cat matrix
+	 cat matrix
 
-   This is how the matrix is configured for Guest2:
+   This is how the matrix is configured for Guest2::
 
       echo 5 > assign_adapter
       echo 0x47 > assign_domain
       echo 0xff > assign_domain
 
-   This is how the matrix is configured for Guest3:
+   This is how the matrix is configured for Guest3::
 
       echo 6 > assign_adapter
       echo 0x47 > assign_domain
@@ -783,24 +811,24 @@ These are the steps:
    configured for the system. If a control domain number higher than the maximum
    is specified, the operation will terminate with an error (ENODEV).
 
-5. Start Guest1:
+5. Start Guest1::
 
-   /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
-      -device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid1 ...
+     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
+	-device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid1 ...
 
-7. Start Guest2:
+7. Start Guest2::
 
-   /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
-      -device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid2 ...
+     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
+	-device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid2 ...
 
-7. Start Guest3:
+7. Start Guest3::
 
-   /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
-      -device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid3 ...
+     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
+	-device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid3 ...
 
 When the guest is shut down, the mediated matrix devices may be removed.
 
-Using our example again, to remove the mediated matrix device $uuid1:
+Using our example again, to remove the mediated matrix device $uuid1::
 
    /sys/devices/vfio_ap/matrix/
       --- [mdev_supported_types]
@@ -809,18 +837,19 @@ Using our example again, to remove the mediated matrix device $uuid1:
       ------------ [$uuid1]
       --------------- remove
 
+::
 
    echo 1 > remove
 
-   This will remove all of the mdev matrix device's sysfs structures including
-   the mdev device itself. To recreate and reconfigure the mdev matrix device,
-   all of the steps starting with step 3 will have to be performed again. Note
-   that the remove will fail if a guest using the mdev is still running.
+This will remove all of the mdev matrix device's sysfs structures including
+the mdev device itself. To recreate and reconfigure the mdev matrix device,
+all of the steps starting with step 3 will have to be performed again. Note
+that the remove will fail if a guest using the mdev is still running.
 
-   It is not necessary to remove an mdev matrix device, but one may want to
-   remove it if no guest will use it during the remaining lifetime of the linux
-   host. If the mdev matrix device is removed, one may want to also reconfigure
-   the pool of adapters and queues reserved for use by the default drivers.
+It is not necessary to remove an mdev matrix device, but one may want to
+remove it if no guest will use it during the remaining lifetime of the linux
+host. If the mdev matrix device is removed, one may want to also reconfigure
+the pool of adapters and queues reserved for use by the default drivers.
 
 Limitations
 ===========
diff --git a/Documentation/s390/vfio-ccw.txt b/Documentation/s390/vfio-ccw.rst
similarity index 89%
rename from Documentation/s390/vfio-ccw.txt
rename to Documentation/s390/vfio-ccw.rst
index 2be11ad864ff..1f6d0b56d53e 100644
--- a/Documentation/s390/vfio-ccw.txt
+++ b/Documentation/s390/vfio-ccw.rst
@@ -1,3 +1,4 @@
+==================================
 vfio-ccw: the basic infrastructure
 ==================================
 
@@ -11,9 +12,11 @@ virtual machine, while vfio is the means.
 Different than other hardware architectures, s390 has defined a unified
 I/O access method, which is so called Channel I/O. It has its own access
 patterns:
+
 - Channel programs run asynchronously on a separate (co)processor.
 - The channel subsystem will access any memory designated by the caller
   in the channel program directly, i.e. there is no iommu involved.
+
 Thus when we introduce vfio support for these devices, we realize it
 with a mediated device (mdev) implementation. The vfio mdev will be
 added to an iommu group, so as to make itself able to be managed by the
@@ -24,6 +27,7 @@ to perform I/O instructions.
 
 This document does not intend to explain the s390 I/O architecture in
 every detail. More information/reference could be found here:
+
 - A good start to know Channel I/O in general:
   https://en.wikipedia.org/wiki/Channel_I/O
 - s390 architecture:
@@ -80,6 +84,7 @@ until interrupted. The I/O completion result is received by the
 interrupt handler in the form of interrupt response block (IRB).
 
 Back to vfio-ccw, in short:
+
 - ORBs and channel programs are built in guest kernel (with guest
   physical addresses).
 - ORBs and channel programs are passed to the host kernel.
@@ -106,6 +111,7 @@ it gets sent to hardware.
 
 Within this implementation, we have two drivers for two types of
 devices:
+
 - The vfio_ccw driver for the physical subchannel device.
   This is an I/O subchannel driver for the real subchannel device.  It
   realizes a group of callbacks and registers to the mdev framework as a
@@ -137,7 +143,7 @@ devices:
   vfio_pin_pages and a vfio_unpin_pages interfaces from the vfio iommu
   backend for the physical devices to pin and unpin pages by demand.
 
-Below is a high Level block diagram.
+Below is a high Level block diagram::
 
  +-------------+
  |             |
@@ -158,6 +164,7 @@ Below is a high Level block diagram.
  +-------------+
 
 The process of how these work together.
+
 1. vfio_ccw.ko drives the physical I/O subchannel, and registers the
    physical device (with callbacks) to mdev framework.
    When vfio_ccw probing the subchannel device, it registers device
@@ -178,17 +185,17 @@ vfio-ccw I/O region
 
 An I/O region is used to accept channel program request from user
 space and store I/O interrupt result for user space to retrieve. The
-definition of the region is:
+definition of the region is::
 
-struct ccw_io_region {
-#define ORB_AREA_SIZE 12
-	__u8	orb_area[ORB_AREA_SIZE];
-#define SCSW_AREA_SIZE 12
-	__u8	scsw_area[SCSW_AREA_SIZE];
-#define IRB_AREA_SIZE 96
-	__u8	irb_area[IRB_AREA_SIZE];
-	__u32	ret_code;
-} __packed;
+  struct ccw_io_region {
+  #define ORB_AREA_SIZE 12
+	  __u8    orb_area[ORB_AREA_SIZE];
+  #define SCSW_AREA_SIZE 12
+	  __u8    scsw_area[SCSW_AREA_SIZE];
+  #define IRB_AREA_SIZE 96
+	  __u8    irb_area[IRB_AREA_SIZE];
+	  __u32   ret_code;
+  } __packed;
 
 While starting an I/O request, orb_area should be filled with the
 guest ORB, and scsw_area should be filled with the SCSW of the Virtual
@@ -205,7 +212,7 @@ vfio-ccw follows what vfio-pci did on the s390 platform and uses
 vfio-iommu-type1 as the vfio iommu backend.
 
 * CCW translation APIs
-  A group of APIs (start with 'cp_') to do CCW translation. The CCWs
+  A group of APIs (start with `cp_`) to do CCW translation. The CCWs
   passed in by a user space program are organized with their guest
   physical memory addresses. These APIs will copy the CCWs into kernel
   space, and assemble a runnable kernel channel program by updating the
@@ -217,12 +224,14 @@ vfio-iommu-type1 as the vfio iommu backend.
   This driver utilizes the CCW translation APIs and introduces
   vfio_ccw, which is the driver for the I/O subchannel devices you want
   to pass through.
-  vfio_ccw implements the following vfio ioctls:
+  vfio_ccw implements the following vfio ioctls::
+
     VFIO_DEVICE_GET_INFO
     VFIO_DEVICE_GET_IRQ_INFO
     VFIO_DEVICE_GET_REGION_INFO
     VFIO_DEVICE_RESET
     VFIO_DEVICE_SET_IRQS
+
   This provides an I/O region, so that the user space program can pass a
   channel program to the kernel, to do further CCW translation before
   issuing them to a real device.
@@ -236,32 +245,49 @@ bit more detail how an I/O request triggered by the QEMU guest will be
 handled (without error handling).
 
 Explanation:
-Q1-Q7: QEMU side process.
-K1-K5: Kernel side process.
 
-Q1. Get I/O region info during initialization.
-Q2. Setup event notifier and handler to handle I/O completion.
+- Q1-Q7: QEMU side process.
+- K1-K5: Kernel side process.
+
+Q1.
+    Get I/O region info during initialization.
+
+Q2.
+    Setup event notifier and handler to handle I/O completion.
 
 ... ...
 
-Q3. Intercept a ssch instruction.
-Q4. Write the guest channel program and ORB to the I/O region.
-    K1. Copy from guest to kernel.
-    K2. Translate the guest channel program to a host kernel space
-        channel program, which becomes runnable for a real device.
-    K3. With the necessary information contained in the orb passed in
-        by QEMU, issue the ccwchain to the device.
-    K4. Return the ssch CC code.
-Q5. Return the CC code to the guest.
+Q3.
+    Intercept a ssch instruction.
+Q4.
+    Write the guest channel program and ORB to the I/O region.
+
+    K1.
+	Copy from guest to kernel.
+    K2.
+	Translate the guest channel program to a host kernel space
+	channel program, which becomes runnable for a real device.
+    K3.
+	With the necessary information contained in the orb passed in
+	by QEMU, issue the ccwchain to the device.
+    K4.
+	Return the ssch CC code.
+Q5.
+    Return the CC code to the guest.
 
 ... ...
 
-    K5. Interrupt handler gets the I/O result and write the result to
-        the I/O region.
-    K6. Signal QEMU to retrieve the result.
-Q6. Get the signal and event handler reads out the result from the I/O
+    K5.
+	Interrupt handler gets the I/O result and write the result to
+	the I/O region.
+    K6.
+	Signal QEMU to retrieve the result.
+
+Q6.
+    Get the signal and event handler reads out the result from the I/O
     region.
-Q7. Update the irb for the guest.
+Q7.
+    Update the irb for the guest.
 
 Limitations
 -----------
@@ -295,6 +321,6 @@ Reference
 1. ESA/s390 Principles of Operation manual (IBM Form. No. SA22-7832)
 2. ESA/390 Common I/O Device Commands manual (IBM Form. No. SA22-7204)
 3. https://en.wikipedia.org/wiki/Channel_I/O
-4. Documentation/s390/cds.txt
+4. Documentation/s390/cds.rst
 5. Documentation/vfio.txt
 6. Documentation/vfio-mediated-device.txt
diff --git a/Documentation/s390/zfcpdump.txt b/Documentation/s390/zfcpdump.rst
similarity index 97%
rename from Documentation/s390/zfcpdump.txt
rename to Documentation/s390/zfcpdump.rst
index b064aa59714d..54e8e7caf7e7 100644
--- a/Documentation/s390/zfcpdump.txt
+++ b/Documentation/s390/zfcpdump.rst
@@ -1,4 +1,6 @@
+==================================
 The s390 SCSI dump tool (zfcpdump)
+==================================
 
 System z machines (z900 or higher) provide hardware support for creating system
 dumps on SCSI disks. The dump process is initiated by booting a dump tool, which
diff --git a/MAINTAINERS b/MAINTAINERS
index 72d1e5da0779..dce53f6414b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13738,7 +13738,7 @@ L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
 S:	Supported
 F:	drivers/s390/cio/vfio_ccw*
-F:	Documentation/s390/vfio-ccw.txt
+F:	Documentation/s390/vfio-ccw.rst
 F:	include/uapi/linux/vfio_ccw.h
 
 S390 ZCRYPT DRIVER
@@ -13758,7 +13758,7 @@ S:	Supported
 F:	drivers/s390/crypto/vfio_ap_drv.c
 F:	drivers/s390/crypto/vfio_ap_private.h
 F:	drivers/s390/crypto/vfio_ap_ops.c
-F:	Documentation/s390/vfio-ap.txt
+F:	Documentation/s390/vfio-ap.rst
 
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.ibm.com>
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 067713f7a377..bb528dcdf4a5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -833,9 +833,9 @@ config CRASH_DUMP
 	  Crash dump kernels are loaded in the main kernel with kexec-tools
 	  into a specially reserved region and then later executed after
 	  a crash by kdump/kexec.
-	  Refer to <file:Documentation/s390/zfcpdump.txt> for more details on this.
+	  Refer to <file:Documentation/s390/zfcpdump.rst> for more details on this.
 	  This option also enables s390 zfcpdump.
-	  See also <file:Documentation/s390/zfcpdump.txt>
+	  See also <file:Documentation/s390/zfcpdump.rst>
 
 endmenu
 
diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index c305d39f5016..b94783f71322 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -152,7 +152,7 @@ static inline debug_entry_t *debug_text_event(debug_info_t *id, int level,
 
 /*
  * IMPORTANT: Use "%s" in sprintf format strings with care! Only pointers are
- * stored in the s390dbf. See Documentation/s390/s390dbf.txt for more details!
+ * stored in the s390dbf. See Documentation/s390/s390dbf.rst for more details!
  */
 extern debug_entry_t *
 __debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
@@ -210,7 +210,7 @@ static inline debug_entry_t *debug_text_exception(debug_info_t *id, int level,
 
 /*
  * IMPORTANT: Use "%s" in sprintf format strings with care! Only pointers are
- * stored in the s390dbf. See Documentation/s390/s390dbf.txt for more details!
+ * stored in the s390dbf. See Documentation/s390/s390dbf.rst for more details!
  */
 extern debug_entry_t *
 __debug_sprintf_exception(debug_info_t *id, int level, char *string, ...)
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 405a60538630..08f812475f5e 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -4,7 +4,7 @@
  * dumps on SCSI disks (zfcpdump). The "zcore/mem" debugfs file shows the same
  * dump format as s390 standalone dumps.
  *
- * For more information please refer to Documentation/s390/zfcpdump.txt
+ * For more information please refer to Documentation/s390/zfcpdump.rst
  *
  * Copyright IBM Corp. 2003, 2008
  * Author(s): Michael Holzheu
-- 
2.21.0
