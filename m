Return-Path: <linux-kernel-owner+w=401wt.eu-S1758283AbXJDLal@vger.kernel.org>
Message-Id: <20071004112825.903779557@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/34] cio: Add docbook comments.
Content-Disposition: inline; filename=005-cio-docbook.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Comment a bunch of function in docbook style and convert existing
comments on structures to docbook.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/ccwgroup.c   |   67 +++++++--
 drivers/s390/cio/device.c     |   64 +++++++--
 drivers/s390/cio/device_ops.c |  241 ++++++++++++++++++++++++++++++-----
 include/asm-s390/ccwdev.h     |   75 ++++------
 include/asm-s390/ccwgroup.h   |   32 +++-
 include/asm-s390/cio.h        |  288 +++++++++++++++++++++++++++++-------------
 6 files changed, 575 insertions(+), 192 deletions(-)

Index: quilt-2.6/drivers/s390/cio/ccwgroup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwgroup.c
+++ quilt-2.6/drivers/s390/cio/ccwgroup.c
@@ -152,16 +152,24 @@ __ccwgroup_create_symlinks(struct ccwgro
 	return 0;
 }
 
-/*
- * try to add a new ccwgroup device for one driver
- * argc and argv[] are a list of bus_id's of devices
- * belonging to the driver.
+/**
+ * ccwgroup_create() - create and register a ccw group device
+ * @root: parent device for the new device
+ * @creator_id: identifier of creating driver
+ * @cdrv: ccw driver of slave devices
+ * @argc: number of slave devices
+ * @argv: bus ids of slave devices
+ *
+ * Create and register a new ccw group device as a child of @root. Slave
+ * devices are obtained from the list of bus ids given in @argv[] and must all
+ * belong to @cdrv.
+ * Returns:
+ *  %0 on success and an error code on failure.
+ * Context:
+ *  non-atomic
  */
-int
-ccwgroup_create(struct device *root,
-		unsigned int creator_id,
-		struct ccw_driver *cdrv,
-		int argc, char *argv[])
+int ccwgroup_create(struct device *root, unsigned int creator_id,
+		    struct ccw_driver *cdrv, int argc, char *argv[])
 {
 	struct ccwgroup_device *gdev;
 	int i;
@@ -390,8 +398,13 @@ static struct bus_type ccwgroup_bus_type
 	.remove = ccwgroup_remove,
 };
 
-int
-ccwgroup_driver_register (struct ccwgroup_driver *cdriver)
+/**
+ * ccwgroup_driver_register() - register a ccw group driver
+ * @cdriver: driver to be registered
+ *
+ * This function is mainly a wrapper around driver_register().
+ */
+int ccwgroup_driver_register(struct ccwgroup_driver *cdriver)
 {
 	/* register our new driver with the core */
 	cdriver->driver.bus = &ccwgroup_bus_type;
@@ -406,8 +419,13 @@ __ccwgroup_match_all(struct device *dev,
 	return 1;
 }
 
-void
-ccwgroup_driver_unregister (struct ccwgroup_driver *cdriver)
+/**
+ * ccwgroup_driver_unregister() - deregister a ccw group driver
+ * @cdriver: driver to be deregistered
+ *
+ * This function is mainly a wrapper around driver_unregister().
+ */
+void ccwgroup_driver_unregister(struct ccwgroup_driver *cdriver)
 {
 	struct device *dev;
 
@@ -427,8 +445,16 @@ ccwgroup_driver_unregister (struct ccwgr
 	driver_unregister(&cdriver->driver);
 }
 
-int
-ccwgroup_probe_ccwdev(struct ccw_device *cdev)
+/**
+ * ccwgroup_probe_ccwdev() - probe function for slave devices
+ * @cdev: ccw device to be probed
+ *
+ * This is a dummy probe function for ccw devices that are slave devices in
+ * a ccw group device.
+ * Returns:
+ *  always %0
+ */
+int ccwgroup_probe_ccwdev(struct ccw_device *cdev)
 {
 	return 0;
 }
@@ -452,8 +478,15 @@ __ccwgroup_get_gdev_by_cdev(struct ccw_d
 	return NULL;
 }
 
-void
-ccwgroup_remove_ccwdev(struct ccw_device *cdev)
+/**
+ * ccwgroup_remove_ccwdev() - remove function for slave devices
+ * @cdev: ccw device to be removed
+ *
+ * This is a remove function for ccw devices that are slave devices in a ccw
+ * group device. It sets the ccw device offline and also deregisters the
+ * embedding ccw group device.
+ */
+void ccwgroup_remove_ccwdev(struct ccw_device *cdev)
 {
 	struct ccwgroup_device *gdev;
 
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -357,8 +357,18 @@ ccw_device_remove_disconnected(struct cc
 			      cdev->private->dev_id.devno);
 }
 
-int
-ccw_device_set_offline(struct ccw_device *cdev)
+/**
+ * ccw_device_set_offline() - disable a ccw device for I/O
+ * @cdev: target ccw device
+ *
+ * This function calls the driver's set_offline() function for @cdev, if
+ * given, and then disables @cdev.
+ * Returns:
+ *   %0 on success and a negative error value on failure.
+ * Context:
+ *  enabled, ccw device lock not held
+ */
+int ccw_device_set_offline(struct ccw_device *cdev)
 {
 	int ret;
 
@@ -396,8 +406,19 @@ ccw_device_set_offline(struct ccw_device
  	return ret;
 }
 
-int
-ccw_device_set_online(struct ccw_device *cdev)
+/**
+ * ccw_device_set_online() - enable a ccw device for I/O
+ * @cdev: target ccw device
+ *
+ * This function first enables @cdev and then calls the driver's set_online()
+ * function for @cdev, if given. If set_online() returns an error, @cdev is
+ * disabled again.
+ * Returns:
+ *   %0 on success and a negative error value on failure.
+ * Context:
+ *  enabled, ccw device lock not held
+ */
+int ccw_device_set_online(struct ccw_device *cdev)
 {
 	int ret;
 
@@ -1326,8 +1347,19 @@ __ccwdev_check_busid(struct device *dev,
 }
 
 
-struct ccw_device *
-get_ccwdev_by_busid(struct ccw_driver *cdrv, const char *bus_id)
+/**
+ * get_ccwdev_by_busid() - obtain device from a bus id
+ * @cdrv: driver the device is owned by
+ * @bus_id: bus id of the device to be searched
+ *
+ * This function searches all devices owned by @cdrv for a device with a bus
+ * id matching @bus_id.
+ * Returns:
+ *  If a match is found, its reference count of the found device is increased
+ *  and it is returned; else %NULL is returned.
+ */
+struct ccw_device *get_ccwdev_by_busid(struct ccw_driver *cdrv,
+				       const char *bus_id)
 {
 	struct device *dev;
 	struct device_driver *drv;
@@ -1409,8 +1441,15 @@ struct bus_type ccw_bus_type = {
 	.remove = ccw_device_remove,
 };
 
-int
-ccw_driver_register (struct ccw_driver *cdriver)
+/**
+ * ccw_driver_register() - register a ccw driver
+ * @cdriver: driver to be registered
+ *
+ * This function is mainly a wrapper around driver_register().
+ * Returns:
+ *   %0 on success and a negative error value on failure.
+ */
+int ccw_driver_register(struct ccw_driver *cdriver)
 {
 	struct device_driver *drv = &cdriver->driver;
 
@@ -1420,8 +1459,13 @@ ccw_driver_register (struct ccw_driver *
 	return driver_register(drv);
 }
 
-void
-ccw_driver_unregister (struct ccw_driver *cdriver)
+/**
+ * ccw_driver_unregister() - deregister a ccw driver
+ * @cdriver: driver to be deregistered
+ *
+ * This function is mainly a wrapper around driver_unregister().
+ */
+void ccw_driver_unregister(struct ccw_driver *cdriver)
 {
 	driver_unregister(&cdriver->driver);
 }
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c
+++ quilt-2.6/drivers/s390/cio/device_ops.c
@@ -25,6 +25,16 @@
 #include "device.h"
 #include "chp.h"
 
+/**
+ * ccw_device_set_options_mask() - set some options and unset the rest
+ * @cdev: device for which the options are to be set
+ * @flags: options to be set
+ *
+ * All flags specified in @flags are set, all flags not specified in @flags
+ * are cleared.
+ * Returns:
+ *   %0 on success, -%EINVAL on an invalid flag combination.
+ */
 int ccw_device_set_options_mask(struct ccw_device *cdev, unsigned long flags)
 {
        /*
@@ -40,6 +50,15 @@ int ccw_device_set_options_mask(struct c
 	return 0;
 }
 
+/**
+ * ccw_device_set_options() - set some options
+ * @cdev: device for which the options are to be set
+ * @flags: options to be set
+ *
+ * All flags specified in @flags are set, the remainder is left untouched.
+ * Returns:
+ *   %0 on success, -%EINVAL if an invalid flag combination would ensue.
+ */
 int ccw_device_set_options(struct ccw_device *cdev, unsigned long flags)
 {
        /*
@@ -59,6 +78,13 @@ int ccw_device_set_options(struct ccw_de
 	return 0;
 }
 
+/**
+ * ccw_device_clear_options() - clear some options
+ * @cdev: device for which the options are to be cleared
+ * @flags: options to be cleared
+ *
+ * All flags specified in @flags are cleared, the remainder is left untouched.
+ */
 void ccw_device_clear_options(struct ccw_device *cdev, unsigned long flags)
 {
 	cdev->private->options.fast &= (flags & CCWDEV_EARLY_NOTIFICATION) == 0;
@@ -67,8 +93,22 @@ void ccw_device_clear_options(struct ccw
 	cdev->private->options.force &= (flags & CCWDEV_ALLOW_FORCE) == 0;
 }
 
-int
-ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
+/**
+ * ccw_device_clear() - terminate I/O request processing
+ * @cdev: target ccw device
+ * @intparm: interruption parameter; value is only used if no I/O is
+ *	     outstanding, otherwise the intparm associated with the I/O request
+ *	     is returned
+ *
+ * ccw_device_clear() calls csch on @cdev's subchannel.
+ * Returns:
+ *  %0 on success,
+ *  -%ENODEV on device not operational,
+ *  -%EINVAL on invalid device state.
+ * Context:
+ *  Interrupts disabled, ccw device lock held
+ */
+int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
 {
 	struct subchannel *sch;
 	int ret;
@@ -89,10 +129,33 @@ ccw_device_clear(struct ccw_device *cdev
 	return ret;
 }
 
-int
-ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
-		     unsigned long intparm, __u8 lpm, __u8 key,
-		     unsigned long flags)
+/**
+ * ccw_device_start_key() - start a s390 channel program with key
+ * @cdev: target ccw device
+ * @cpa: logical start address of channel program
+ * @intparm: user specific interruption parameter; will be presented back to
+ *	     @cdev's interrupt handler. Allows a device driver to associate
+ *	     the interrupt with a particular I/O request.
+ * @lpm: defines the channel path to be used for a specific I/O request. A
+ *	 value of 0 will make cio use the opm.
+ * @key: storage key to be used for the I/O
+ * @flags: additional flags; defines the action to be performed for I/O
+ *	   processing.
+ *
+ * Start a S/390 channel program. When the interrupt arrives, the
+ * IRQ handler is called, either immediately, delayed (dev-end missing,
+ * or sense required) or never (no IRQ handler registered).
+ * Returns:
+ *  %0, if the operation was successful;
+ *  -%EBUSY, if the device is busy, or status pending;
+ *  -%EACCES, if no path specified in @lpm is operational;
+ *  -%ENODEV, if the device is not operational.
+ * Context:
+ *  Interrupts disabled, ccw device lock held
+ */
+int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
+			 unsigned long intparm, __u8 lpm, __u8 key,
+			 unsigned long flags)
 {
 	struct subchannel *sch;
 	int ret;
@@ -135,11 +198,38 @@ ccw_device_start_key(struct ccw_device *
 	return ret;
 }
 
-
-int
-ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
-			     unsigned long intparm, __u8 lpm, __u8 key,
-			     unsigned long flags, int expires)
+/**
+ * ccw_device_start_timeout_key() - start a s390 channel program with timeout and key
+ * @cdev: target ccw device
+ * @cpa: logical start address of channel program
+ * @intparm: user specific interruption parameter; will be presented back to
+ *	     @cdev's interrupt handler. Allows a device driver to associate
+ *	     the interrupt with a particular I/O request.
+ * @lpm: defines the channel path to be used for a specific I/O request. A
+ *	 value of 0 will make cio use the opm.
+ * @key: storage key to be used for the I/O
+ * @flags: additional flags; defines the action to be performed for I/O
+ *	   processing.
+ * @expires: timeout value in jiffies
+ *
+ * Start a S/390 channel program. When the interrupt arrives, the
+ * IRQ handler is called, either immediately, delayed (dev-end missing,
+ * or sense required) or never (no IRQ handler registered).
+ * This function notifies the device driver if the channel program has not
+ * completed during the time specified by @expires. If a timeout occurs, the
+ * channel program is terminated via xsch, hsch or csch, and the device's
+ * interrupt handler will be called with an irb containing ERR_PTR(-%ETIMEDOUT).
+ * Returns:
+ *  %0, if the operation was successful;
+ *  -%EBUSY, if the device is busy, or status pending;
+ *  -%EACCES, if no path specified in @lpm is operational;
+ *  -%ENODEV, if the device is not operational.
+ * Context:
+ *  Interrupts disabled, ccw device lock held
+ */
+int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
+				 unsigned long intparm, __u8 lpm, __u8 key,
+				 unsigned long flags, int expires)
 {
 	int ret;
 
@@ -152,18 +242,67 @@ ccw_device_start_timeout_key(struct ccw_
 	return ret;
 }
 
-int
-ccw_device_start(struct ccw_device *cdev, struct ccw1 *cpa,
-		 unsigned long intparm, __u8 lpm, unsigned long flags)
+/**
+ * ccw_device_start() - start a s390 channel program
+ * @cdev: target ccw device
+ * @cpa: logical start address of channel program
+ * @intparm: user specific interruption parameter; will be presented back to
+ *	     @cdev's interrupt handler. Allows a device driver to associate
+ *	     the interrupt with a particular I/O request.
+ * @lpm: defines the channel path to be used for a specific I/O request. A
+ *	 value of 0 will make cio use the opm.
+ * @flags: additional flags; defines the action to be performed for I/O
+ *	   processing.
+ *
+ * Start a S/390 channel program. When the interrupt arrives, the
+ * IRQ handler is called, either immediately, delayed (dev-end missing,
+ * or sense required) or never (no IRQ handler registered).
+ * Returns:
+ *  %0, if the operation was successful;
+ *  -%EBUSY, if the device is busy, or status pending;
+ *  -%EACCES, if no path specified in @lpm is operational;
+ *  -%ENODEV, if the device is not operational.
+ * Context:
+ *  Interrupts disabled, ccw device lock held
+ */
+int ccw_device_start(struct ccw_device *cdev, struct ccw1 *cpa,
+		     unsigned long intparm, __u8 lpm, unsigned long flags)
 {
 	return ccw_device_start_key(cdev, cpa, intparm, lpm,
 				    PAGE_DEFAULT_KEY, flags);
 }
 
-int
-ccw_device_start_timeout(struct ccw_device *cdev, struct ccw1 *cpa,
-			 unsigned long intparm, __u8 lpm, unsigned long flags,
-			 int expires)
+/**
+ * ccw_device_start_timeout() - start a s390 channel program with timeout
+ * @cdev: target ccw device
+ * @cpa: logical start address of channel program
+ * @intparm: user specific interruption parameter; will be presented back to
+ *	     @cdev's interrupt handler. Allows a device driver to associate
+ *	     the interrupt with a particular I/O request.
+ * @lpm: defines the channel path to be used for a specific I/O request. A
+ *	 value of 0 will make cio use the opm.
+ * @flags: additional flags; defines the action to be performed for I/O
+ *	   processing.
+ * @expires: timeout value in jiffies
+ *
+ * Start a S/390 channel program. When the interrupt arrives, the
+ * IRQ handler is called, either immediately, delayed (dev-end missing,
+ * or sense required) or never (no IRQ handler registered).
+ * This function notifies the device driver if the channel program has not
+ * completed during the time specified by @expires. If a timeout occurs, the
+ * channel program is terminated via xsch, hsch or csch, and the device's
+ * interrupt handler will be called with an irb containing ERR_PTR(-%ETIMEDOUT).
+ * Returns:
+ *  %0, if the operation was successful;
+ *  -%EBUSY, if the device is busy, or status pending;
+ *  -%EACCES, if no path specified in @lpm is operational;
+ *  -%ENODEV, if the device is not operational.
+ * Context:
+ *  Interrupts disabled, ccw device lock held
+ */
+int ccw_device_start_timeout(struct ccw_device *cdev, struct ccw1 *cpa,
+			     unsigned long intparm, __u8 lpm,
+			     unsigned long flags, int expires)
 {
 	return ccw_device_start_timeout_key(cdev, cpa, intparm, lpm,
 					    PAGE_DEFAULT_KEY, flags,
@@ -171,8 +310,23 @@ ccw_device_start_timeout(struct ccw_devi
 }
 
 
-int
-ccw_device_halt(struct ccw_device *cdev, unsigned long intparm)
+/**
+ * ccw_device_halt() - halt I/O request processing
+ * @cdev: target ccw device
+ * @intparm: interruption parameter; value is only used if no I/O is
+ *	     outstanding, otherwise the intparm associated with the I/O request
+ *	     is returned
+ *
+ * ccw_device_halt() calls hsch on @cdev's subchannel.
+ * Returns:
+ *  %0 on success,
+ *  -%ENODEV on device not operational,
+ *  -%EINVAL on invalid device state,
+ *  -%EBUSY on device busy or interrupt pending.
+ * Context:
+ *  Interrupts disabled, ccw device lock held
+ */
+int ccw_device_halt(struct ccw_device *cdev, unsigned long intparm)
 {
 	struct subchannel *sch;
 	int ret;
@@ -193,8 +347,20 @@ ccw_device_halt(struct ccw_device *cdev,
 	return ret;
 }
 
-int
-ccw_device_resume(struct ccw_device *cdev)
+/**
+ * ccw_device_resume() - resume channel program execution
+ * @cdev: target ccw device
+ *
+ * ccw_device_resume() calls rsch on @cdev's subchannel.
+ * Returns:
+ *  %0 on success,
+ *  -%ENODEV on device not operational,
+ *  -%EINVAL on invalid device state,
+ *  -%EBUSY on device busy or interrupt pending.
+ * Context:
+ *  Interrupts disabled, ccw device lock held
+ */
+int ccw_device_resume(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
 
@@ -260,11 +426,21 @@ ccw_device_call_handler(struct ccw_devic
 	return 1;
 }
 
-/*
- * Search for CIW command in extended sense data.
+/**
+ * ccw_device_get_ciw() - Search for CIW command in extended sense data.
+ * @cdev: ccw device to inspect
+ * @ct: command type to look for
+ *
+ * During SenseID, command information words (CIWs) describing special
+ * commands available to the device may have been stored in the extended
+ * sense data. This function searches for CIWs of a specified command
+ * type in the extended sense data.
+ * Returns:
+ *  %NULL if no extended sense data has been stored or if no CIW of the
+ *  specified command type could be found,
+ *  else a pointer to the CIW of the specified command type.
  */
-struct ciw *
-ccw_device_get_ciw(struct ccw_device *cdev, __u32 ct)
+struct ciw *ccw_device_get_ciw(struct ccw_device *cdev, __u32 ct)
 {
 	int ciw_cnt;
 
@@ -276,8 +452,14 @@ ccw_device_get_ciw(struct ccw_device *cd
 	return NULL;
 }
 
-__u8
-ccw_device_get_path_mask(struct ccw_device *cdev)
+/**
+ * ccw_device_get_path_mask() - get currently available paths
+ * @cdev: ccw device to be queried
+ * Returns:
+ *  %0 if no subchannel for the device is available,
+ *  else the mask of currently available paths for the ccw device's subchannel.
+ */
+__u8 ccw_device_get_path_mask(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
 
@@ -357,8 +539,7 @@ out_unlock:
 	return ret;
 }
 
-void *
-ccw_device_get_chp_desc(struct ccw_device *cdev, int chp_no)
+void *ccw_device_get_chp_desc(struct ccw_device *cdev, int chp_no)
 {
 	struct subchannel *sch;
 	struct chp_id chpid;
Index: quilt-2.6/include/asm-s390/ccwdev.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ccwdev.h
+++ quilt-2.6/include/asm-s390/ccwdev.h
@@ -67,36 +67,53 @@ ccw_device_id_match(const struct ccw_dev
 	return NULL;
 }
 
-/* The struct ccw device is our replacement for the globally accessible
- * ioinfo array. ioinfo will mutate into a subchannel device later.
+/**
+ * struct ccw_device - channel attached device
+ * @ccwlock: pointer to device lock
+ * @id: id of this device
+ * @drv: ccw driver for this device
+ * @dev: embedded device structure
+ * @online: online status of device
+ * @handler: interrupt handler
  *
- * Reference: Documentation/s390/driver-model.txt */
+ * @handler is a member of the device rather than the driver since a driver
+ * can have different interrupt handlers for different ccw devices
+ * (multi-subchannel drivers).
+ */
 struct ccw_device {
 	spinlock_t *ccwlock;
+/* private: */
 	struct ccw_device_private *private;	/* cio private information */
-	struct ccw_device_id id;	/* id of this device, driver_info is
-					   set by ccw_find_driver */
-	struct ccw_driver *drv;		/* */
-	struct device dev;		/* */
+/* public: */
+	struct ccw_device_id id;
+	struct ccw_driver *drv;
+	struct device dev;
 	int online;
-	/* This is sick, but a driver can have different interrupt handlers 
-	   for different ccw_devices (multi-subchannel drivers)... */
 	void (*handler) (struct ccw_device *, unsigned long, struct irb *);
 };
 
 
-/* Each ccw driver registers with the ccw root bus */
+/**
+ * struct ccw driver - device driver for channel attached devices
+ * @owner: owning module
+ * @ids: ids supported by this driver
+ * @probe: function called on probe
+ * @remove: function called on remove
+ * @set_online: called when setting device online
+ * @set_offline: called when setting device offline
+ * @notify: notify driver of device state changes
+ * @driver: embedded device driver structure
+ * @name: device driver name
+ */
 struct ccw_driver {
-	struct module *owner;		/* for automatic MOD_INC_USE_COUNT   */
-	struct ccw_device_id *ids;	/* probe driver with these devs      */
-	int (*probe) (struct ccw_device *); /* ask driver to probe dev 	     */
+	struct module *owner;
+	struct ccw_device_id *ids;
+	int (*probe) (struct ccw_device *);
 	void (*remove) (struct ccw_device *);
-					/* device is no longer available     */
 	int (*set_online) (struct ccw_device *);
 	int (*set_offline) (struct ccw_device *);
 	int (*notify) (struct ccw_device *, int);
-	struct device_driver driver;	/* higher level structure, don't init
-					   this from your driver	     */
+	struct device_driver driver;
 	char *name;
 };
 
@@ -124,36 +141,10 @@ extern void ccw_device_clear_options(str
 /* Allow forced onlining of boxed devices. */
 #define CCWDEV_ALLOW_FORCE              0x0008
 
-/*
- * ccw_device_start()
- *
- *  Start a S/390 channel program. When the interrupt arrives, the
- *  IRQ handler is called, either immediately, delayed (dev-end missing,
- *  or sense required) or never (no IRQ handler registered).
- *  Depending on the action taken, ccw_device_start() returns:  
- *                           0	     - Success
- *			     -EBUSY  - Device busy, or status pending
- *			     -ENODEV - Device not operational
- *                           -EINVAL - Device invalid for operation
- */
 extern int ccw_device_start(struct ccw_device *, struct ccw1 *,
 			    unsigned long, __u8, unsigned long);
-/*
- * ccw_device_start_timeout()
- *
- * This function notifies the device driver if the channel program has not
- * completed during the specified time. If a timeout occurs, the channel
- * program is terminated via xsch(), hsch() or csch().
- */
 extern int ccw_device_start_timeout(struct ccw_device *, struct ccw1 *,
 				    unsigned long, __u8, unsigned long, int);
-/*
- * ccw_device_start_key()
- * ccw_device_start_key_timeout()
- *
- * Same as ccw_device_start() and ccw_device_start_timeout(), except a
- * storage key != default key can be provided for the I/O.
- */
 extern int ccw_device_start_key(struct ccw_device *, struct ccw1 *,
 				unsigned long, __u8, __u8, unsigned long);
 extern int ccw_device_start_timeout_key(struct ccw_device *, struct ccw1 *,
Index: quilt-2.6/include/asm-s390/ccwgroup.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ccwgroup.h
+++ quilt-2.6/include/asm-s390/ccwgroup.h
@@ -4,19 +4,41 @@
 struct ccw_device;
 struct ccw_driver;
 
+/**
+ * struct ccwgroup_device - ccw group device
+ * @creator_id: unique number of the driver
+ * @state: online/offline state
+ * @count: number of attached slave devices
+ * @dev: embedded device structure
+ * @cdev: variable number of slave devices, allocated as needed
+ */
 struct ccwgroup_device {
-	unsigned long creator_id;	/* unique number of the driver */
+	unsigned long creator_id;
 	enum {
 		CCWGROUP_OFFLINE,
 		CCWGROUP_ONLINE,
 	} state;
+/* private: */
 	atomic_t onoff;
 	struct mutex reg_mutex;
-	unsigned int count;		/* number of attached slave devices */
-	struct device	dev;		/* master device		    */
-	struct ccw_device *cdev[0];	/* variable number, allocate as needed */
+/* public: */
+	unsigned int count;
+	struct device	dev;
+	struct ccw_device *cdev[0];
 };
 
+/**
+ * struct ccwgroup_driver - driver for ccw group devices
+ * @owner: driver owner
+ * @name: driver name
+ * @max_slaves: maximum number of slave devices
+ * @driver_id: unique id
+ * @probe: function called on probe
+ * @remove: function called on remove
+ * @set_online: function called when device is set online
+ * @set_offline: function called when device is set offline
+ * @driver: embedded driver structure
+ */
 struct ccwgroup_driver {
 	struct module *owner;
 	char *name;
@@ -28,7 +50,7 @@ struct ccwgroup_driver {
 	int (*set_online) (struct ccwgroup_device *);
 	int (*set_offline) (struct ccwgroup_device *);
 
-	struct device_driver driver;		/* this driver */
+	struct device_driver driver;
 };
 
 extern int  ccwgroup_driver_register   (struct ccwgroup_driver *cdriver);
Index: quilt-2.6/include/asm-s390/cio.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cio.h
+++ quilt-2.6/include/asm-s390/cio.h
@@ -15,30 +15,50 @@
 #define LPM_ANYPATH 0xff
 #define __MAX_CSSID 0
 
-/*
- * subchannel status word
+/**
+ * struct scsw - subchannel status word
+ * @key: subchannel key
+ * @sctl: suspend control
+ * @eswf: esw format
+ * @cc: deferred condition code
+ * @fmt: format
+ * @pfch: prefetch
+ * @isic: initial-status interruption control
+ * @alcc: adress-limit checking control
+ * @ssi: supress-suspended interruption
+ * @zcc: zero condition code
+ * @ectl: extended control
+ * @pno: path not operational
+ * @res: reserved
+ * @fctl: function control
+ * @actl: activity control
+ * @stctl: status control
+ * @cpa: channel program address
+ * @dstat: device status
+ * @cstat: subchannel status
+ * @count: residual count
  */
 struct scsw {
-	__u32 key  : 4;		/* subchannel key */
-	__u32 sctl : 1; 	/* suspend control */
-	__u32 eswf : 1; 	/* ESW format */
-	__u32 cc   : 2; 	/* deferred condition code */
-	__u32 fmt  : 1; 	/* format */
-	__u32 pfch : 1; 	/* prefetch */
-	__u32 isic : 1; 	/* initial-status interruption control */
-	__u32 alcc : 1; 	/* address-limit checking control */
-	__u32 ssi  : 1; 	/* supress-suspended interruption */
-	__u32 zcc  : 1; 	/* zero condition code */
-	__u32 ectl : 1; 	/* extended control */
-	__u32 pno  : 1;	    	/* path not operational */
-	__u32 res  : 1;	    	/* reserved */
-	__u32 fctl : 3;	    	/* function control */
-	__u32 actl : 7;	    	/* activity control */
-	__u32 stctl : 5;    	/* status control */
-	__u32 cpa;	    	/* channel program address */
-	__u32 dstat : 8;    	/* device status */
-	__u32 cstat : 8;    	/* subchannel status */
-	__u32 count : 16;   	/* residual count */
+	__u32 key  : 4;
+	__u32 sctl : 1;
+	__u32 eswf : 1;
+	__u32 cc   : 2;
+	__u32 fmt  : 1;
+	__u32 pfch : 1;
+	__u32 isic : 1;
+	__u32 alcc : 1;
+	__u32 ssi  : 1;
+	__u32 zcc  : 1;
+	__u32 ectl : 1;
+	__u32 pno  : 1;
+	__u32 res  : 1;
+	__u32 fctl : 3;
+	__u32 actl : 7;
+	__u32 stctl : 5;
+	__u32 cpa;
+	__u32 dstat : 8;
+	__u32 cstat : 8;
+	__u32 count : 16;
 } __attribute__ ((packed));
 
 #define SCSW_FCTL_CLEAR_FUNC	 0x1
@@ -110,11 +130,22 @@ struct scsw {
 #define SNS2_ENV_DATA_PRESENT	0x10
 #define SNS2_INPRECISE_END	0x04
 
+/**
+ * struct ccw1 - channel command word
+ * @cmd_code: command code
+ * @flags: flags, like IDA adressing, etc.
+ * @count: byte count
+ * @cda: data address
+ *
+ * The ccw is the basic structure to build channel programs that perform
+ * operations with the device or the control unit. Only Format-1 channel
+ * command words are supported.
+ */
 struct ccw1 {
-	__u8  cmd_code;		/* command code */
-	__u8  flags;   		/* flags, like IDA addressing, etc. */
-	__u16 count;   		/* byte count */
-	__u32 cda;     		/* data address */
+	__u8  cmd_code;
+	__u8  flags;
+	__u16 count;
+	__u32 cda;
 } __attribute__ ((packed,aligned(8)));
 
 #define CCW_FLAG_DC		0x80
@@ -140,102 +171,162 @@ struct ccw1 {
 
 #define SENSE_MAX_COUNT		0x20
 
+/**
+ * struct erw - extended report word
+ * @res0: reserved
+ * @auth: authorization check
+ * @pvrf: path-verification-required flag
+ * @cpt: channel-path timeout
+ * @fsavf: failing storage address validity flag
+ * @cons: concurrent sense
+ * @scavf: secondary ccw address validity flag
+ * @fsaf: failing storage address format
+ * @scnt: sense count, if @cons == %1
+ * @res16: reserved
+ */
 struct erw {
-	__u32 res0  : 3;  	/* reserved */
-	__u32 auth  : 1;	/* Authorization check */
-	__u32 pvrf  : 1;  	/* path-verification-required flag */
-	__u32 cpt   : 1;  	/* channel-path timeout */
-	__u32 fsavf : 1;  	/* Failing storage address validity flag */
-	__u32 cons  : 1;  	/* concurrent-sense */
-	__u32 scavf : 1;	/* Secondary ccw address validity flag */
-	__u32 fsaf  : 1;	/* Failing storage address format */
-	__u32 scnt  : 6;  	/* sense count if cons == 1 */
-	__u32 res16 : 16; 	/* reserved */
+	__u32 res0  : 3;
+	__u32 auth  : 1;
+	__u32 pvrf  : 1;
+	__u32 cpt   : 1;
+	__u32 fsavf : 1;
+	__u32 cons  : 1;
+	__u32 scavf : 1;
+	__u32 fsaf  : 1;
+	__u32 scnt  : 6;
+	__u32 res16 : 16;
 } __attribute__ ((packed));
 
-/*
- * subchannel logout area
+/**
+ * struct sublog - subchannel logout area
+ * @res0: reserved
+ * @esf: extended status flags
+ * @lpum: last path used mask
+ * @arep: ancillary report
+ * @fvf: field-validity flags
+ * @sacc: storage access code
+ * @termc: termination code
+ * @devsc: device-status check
+ * @serr: secondary error
+ * @ioerr: i/o-error alert
+ * @seqc: sequence code
  */
 struct sublog {
-	__u32 res0  : 1;  	/* reserved */
-	__u32 esf   : 7;  	/* extended status flags */
-	__u32 lpum  : 8;  	/* last path used mask */
-	__u32 arep  : 1;  	/* ancillary report */
-	__u32 fvf   : 5;  	/* field-validity flags */
-	__u32 sacc  : 2;  	/* storage access code */
-	__u32 termc : 2;  	/* termination code */
-	__u32 devsc : 1;  	/* device-status check */
-	__u32 serr  : 1;  	/* secondary error */
-	__u32 ioerr : 1;  	/* i/o-error alert */
-	__u32 seqc  : 3;  	/* sequence code */
+	__u32 res0  : 1;
+	__u32 esf   : 7;
+	__u32 lpum  : 8;
+	__u32 arep  : 1;
+	__u32 fvf   : 5;
+	__u32 sacc  : 2;
+	__u32 termc : 2;
+	__u32 devsc : 1;
+	__u32 serr  : 1;
+	__u32 ioerr : 1;
+	__u32 seqc  : 3;
 } __attribute__ ((packed));
 
-/*
- * Format 0 Extended Status Word (ESW)
+/**
+ * struct esw0 - Format 0 Extended Status Word (ESW)
+ * @sublog: subchannel logout
+ * @erw: extended report word
+ * @faddr: failing storage address
+ * @saddr: secondary ccw address
  */
 struct esw0 {
-	struct sublog sublog;	/* subchannel logout */
-	struct erw erw;	    	/* extended report word */
-	__u32  faddr[2];    	/* failing storage address */
-	__u32  saddr;  		/* secondary ccw address */
+	struct sublog sublog;
+	struct erw erw;
+	__u32  faddr[2];
+	__u32  saddr;
 } __attribute__ ((packed));
 
-/*
- * Format 1 Extended Status Word (ESW)
+/**
+ * struct esw1 - Format 1 Extended Status Word (ESW)
+ * @zero0: reserved zeros
+ * @lpum: last path used mask
+ * @zero16: reserved zeros
+ * @erw: extended report word
+ * @zeros: three fullwords of zeros
  */
 struct esw1 {
-	__u8  zero0;		/* reserved zeros */
-	__u8  lpum;		/* last path used mask */
-	__u16 zero16;		/* reserved zeros */
-	struct erw erw;		/* extended report word */
-	__u32 zeros[3]; 	/* 2 fullwords of zeros */
+	__u8  zero0;
+	__u8  lpum;
+	__u16 zero16;
+	struct erw erw;
+	__u32 zeros[3];
 } __attribute__ ((packed));
 
-/*
- * Format 2 Extended Status Word (ESW)
+/**
+ * struct esw2 - Format 2 Extended Status Word (ESW)
+ * @zero0: reserved zeros
+ * @lpum: last path used mask
+ * @dcti: device-connect-time interval
+ * @erw: extended report word
+ * @zeros: three fullwords of zeros
  */
 struct esw2 {
-	__u8  zero0;		/* reserved zeros */
-	__u8  lpum;		/* last path used mask */
-	__u16 dcti;		/* device-connect-time interval */
-	struct erw erw;		/* extended report word */
-	__u32 zeros[3]; 	/* 2 fullwords of zeros */
+	__u8  zero0;
+	__u8  lpum;
+	__u16 dcti;
+	struct erw erw;
+	__u32 zeros[3];
 } __attribute__ ((packed));
 
-/*
- * Format 3 Extended Status Word (ESW)
+/**
+ * struct esw3 - Format 3 Extended Status Word (ESW)
+ * @zero0: reserved zeros
+ * @lpum: last path used mask
+ * @res: reserved
+ * @erw: extended report word
+ * @zeros: three fullwords of zeros
  */
 struct esw3 {
-	__u8  zero0;		/* reserved zeros */
-	__u8  lpum;		/* last path used mask */
-	__u16 res;		/* reserved */
-	struct erw erw;		/* extended report word */
-	__u32 zeros[3]; 	/* 2 fullwords of zeros */
+	__u8  zero0;
+	__u8  lpum;
+	__u16 res;
+	struct erw erw;
+	__u32 zeros[3];
 } __attribute__ ((packed));
 
-/*
- * interruption response block
+/**
+ * struct irb - interruption response block
+ * @scsw: subchannel status word
+ * @esw: extened status word, 4 formats
+ * @ecw: extended control word
+ *
+ * The irb that is handed to the device driver when an interrupt occurs. For
+ * solicited interrupts, the common I/O layer already performs checks whether
+ * a field is valid; a field not being valid is always passed as %0.
+ * If a unit check occured, @ecw may contain sense data; this is retrieved
+ * by the common I/O layer itself if the device doesn't support concurrent
+ * sense (so that the device driver never needs to perform basic sene itself).
+ * For unsolicited interrupts, the irb is passed as-is (expect for sense data,
+ * if applicable).
  */
 struct irb {
-	struct scsw scsw;	/* subchannel status word */
-	union {			/* extended status word, 4 formats */
+	struct scsw scsw;
+	union {
 		struct esw0 esw0;
 		struct esw1 esw1;
 		struct esw2 esw2;
 		struct esw3 esw3;
 	} esw;
-	__u8   ecw[32];		/* extended control word */
+	__u8   ecw[32];
 } __attribute__ ((packed,aligned(4)));
 
-/*
- * command information word  (CIW) layout
+/**
+ * struct ciw - command information word  (CIW) layout
+ * @et: entry type
+ * @reserved: reserved bits
+ * @ct: command type
+ * @cmd: command code
+ * @count: command count
  */
 struct ciw {
-	__u32 et       :  2; 	/* entry type */
-	__u32 reserved :  2; 	/* reserved */
-	__u32 ct       :  4; 	/* command type */
-	__u32 cmd      :  8; 	/* command */
-	__u32 count    : 16; 	/* coun */
+	__u32 et       :  2;
+	__u32 reserved :  2;
+	__u32 ct       :  4;
+	__u32 cmd      :  8;
+	__u32 count    : 16;
 } __attribute__ ((packed));
 
 #define CIW_TYPE_RCD	0x0    	/* read configuration data */
@@ -258,11 +349,32 @@ struct ciw {
 /* Sick revalidation of device. */
 #define CIO_REVALIDATE 0x0008
 
+/**
+ * struct ccw_dev_id - unique identifier for ccw devices
+ * @ssid: subchannel set id
+ * @devno: device number
+ *
+ * This structure is not directly based on any hardware structure. The
+ * hardware identifies a device by its device number and its subchannel,
+ * which is in turn identified by its id. In order to get a unique identifier
+ * for ccw devices across subchannel sets, @struct ccw_dev_id has been
+ * introduced.
+ */
 struct ccw_dev_id {
 	u8 ssid;
 	u16 devno;
 };
 
+/**
+ * ccw_device_id_is_equal() - compare two ccw_dev_ids
+ * @dev_id1: a ccw_dev_id
+ * @dev_id2: another ccw_dev_id
+ * Returns:
+ *  %1 if the two structures are equal field-by-field,
+ *  %0 if not.
+ * Context:
+ *  any
+ */
 static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
 				      struct ccw_dev_id *dev_id2)
 {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
