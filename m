Return-Path: <linux-kernel-owner+w=401wt.eu-S1764078AbXEULBm@vger.kernel.org>
Message-Id: <20070521110108.214724333@de.ibm.com>
References: <20070521105118.955425052@de.ibm.com>
Date: Mon, 21 May 2007 12:51:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/5] cio: Update documentation.
Content-Disposition: inline; filename=001-cio-docu.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

- read_dev_chars()/read_conf_data() are deprecated. Don't document them, but
  advise to issue the channel program from the driver itself.
- Remove some really obsolete and incorrect stuff.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/cds.txt |   82 ++-------------------------------------------
 1 file changed, 4 insertions(+), 78 deletions(-)

Index: quilt-2.6/Documentation/s390/cds.txt
===================================================================
--- quilt-2.6.orig/Documentation/s390/cds.txt
+++ quilt-2.6/Documentation/s390/cds.txt
@@ -51,13 +51,8 @@ The major changes are:
 * The interrupt handlers must be adapted to use a ccw_device as argument.
   Moreover, they don't return a devstat, but an irb.
 * Before initiating an io, the options must be set via ccw_device_set_options().
-
-read_dev_chars()	
-   read device characteristics
-   
-read_conf_data()
-read_conf_data_lpm()
-   read configuration data.
+* Instead of calling read_dev_chars()/read_conf_data(), the driver issues
+  the channel program and handles the interrupt itself.
 
 ccw_device_get_ciw()
    get commands from extended sense data.
@@ -130,11 +125,6 @@ present their hardware status by the sam
 has to call every single device driver registered on this IRQ in order to
 determine the device driver owning the device that raised the interrupt.
 
-In order not to introduce a new I/O concept to the common Linux code,
-Linux/390 preserves the IRQ concept and semantically maps the ESA/390
-subchannels to Linux as IRQs. This allows Linux/390 to support up to 64k
-different IRQs, uniquely representing a single device each.
-
 Up to kernel 2.4, Linux/390 used to provide interfaces via the IRQ (subchannel).
 For internal use of the common I/O layer, these are still there. However, 
 device drivers should use the new calling interface via the ccw_device only.
@@ -151,9 +141,8 @@ information during their initialization 
 support using the information saved in the struct ccw_device given to them.
 This methods implies that Linux/390 doesn't require to probe for free (not
 armed) interrupt request lines (IRQs) to drive its devices with. Where
-applicable, the device drivers can use the read_dev_chars() to retrieve device
-characteristics. This can be done without having to request device ownership
-previously.
+applicable, the device drivers can use issue the READ DEVICE CHARACTERISTICS
+ccw to retrieve device characteristics in its online routine.
 
 In order to allow for easy I/O initiation the CDS layer provides a
 ccw_device_start() interface that takes a device specific channel program (one
@@ -170,69 +159,6 @@ SUBCHANNEL (HSCH) command without having
 also covered by ccw_device_halt().
 
 
-read_dev_chars() - Read Device Characteristics
-
-This routine returns the characteristics for the device specified.
-
-The function is meant to be called with the device already enabled; that is,
-at earliest during set_online() processing.
-
-The ccw_device must not be locked prior to calling read_dev_chars().
-
-The function may be called enabled or disabled.
-
-int read_dev_chars(struct ccw_device *cdev, void **buffer, int length );
-
-cdev   - the ccw_device the information is requested for.
-buffer - pointer to a buffer pointer. The buffer pointer itself
-         must contain a valid buffer area.
-length - length of the buffer provided.
-
-The read_dev_chars() function returns :
-
-      0 - successful completion
--ENODEV - cdev invalid
--EINVAL - an invalid parameter was detected, or the function was called early.
--EBUSY  - an irrecoverable I/O error occurred or the device is not
-          operational.
-
-
-read_conf_data(), read_conf_data_lpm() - Read Configuration Data
-
-Retrieve the device dependent configuration data. Please have a look at your 
-device dependent I/O commands for the device specific layout of the node 
-descriptor elements. read_conf_data_lpm() will retrieve the configuration data
-for a specific path.
-
-The function is meant to be called with the device already enabled; that is,
-at earliest during set_online() processing.
-
-The function may be called enabled or disabled, but the device must not be
-locked
-
-int read_conf_data(struct ccw_device, void **buffer, int *length);
-int read_conf_data_lpm(struct ccw_device, void **buffer, int *length, __u8 lpm);
-
-cdev   - the ccw_device the data is requested for.
-buffer - Pointer to a buffer pointer. The read_conf_data() routine
-         will allocate a buffer and initialize the buffer pointer
-         accordingly. It's the device driver's responsibility to
-         release the kernel memory if no longer needed. 
-length - Length of the buffer allocated and retrieved.
-lpm    - Logical path mask to be used for retrieving the data. If
-         zero the data is retrieved on the next path available.
-
-The read_conf_data() function returns :
-          0 - Successful completion
--ENODEV     - cdev invalid.
--EINVAL     - An invalid parameter was detected, or the function was called early.
--EIO        - An irrecoverable I/O error occurred or the device is
-              not operational.
--ENOMEM     - The read_conf_data() routine couldn't obtain storage.
--EOPNOTSUPP - The device doesn't support the read configuration 
-              data command.
-
-
 get_ciw() - get command information word
 
 This call enables a device driver to get information about supported commands

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
