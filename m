Return-Path: <linux-kernel-owner+w=401wt.eu-S1758551AbXJDL3x@vger.kernel.org>
Message-Id: <20071004112825.649678293@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/34] cio: Kerneldoc comments for cmf.
Content-Disposition: inline; filename=004-cio-cmfdoc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

- Fix existing kerneldoc-style comments.
- Move descriptions of functions from cmb.h to cmf.c.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/cmf.c |   87 +++++++++++++++++++++++++++++++++++++++++--------
 include/asm-s390/cmb.h |   65 ++++++++----------------------------
 2 files changed, 89 insertions(+), 63 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -74,19 +74,20 @@ enum cmb_index {
  * enum cmb_format - types of supported measurement block formats
  *
  * @CMF_BASIC:      traditional channel measurement blocks supported
- * 		    by all machines that we run on
+ *		    by all machines that we run on
  * @CMF_EXTENDED:   improved format that was introduced with the z990
- * 		    machine
- * @CMF_AUTODETECT: default: use extended format when running on a z990
- *                  or later machine, otherwise fall back to basic format
- **/
+ *		    machine
+ * @CMF_AUTODETECT: default: use extended format when running on a machine
+ *		    supporting extended format, otherwise fall back to
+ *		    basic format
+ */
 enum cmb_format {
 	CMF_BASIC,
 	CMF_EXTENDED,
 	CMF_AUTODETECT = -1,
 };
 
-/**
+/*
  * format - actual format for all measurement blocks
  *
  * The format module parameter can be set to a value of 0 (zero)
@@ -107,6 +108,7 @@ module_param(format, bool, 0444);
  *		either with the help of a special pool or with kmalloc
  * @free:	free memory allocated with @alloc
  * @set:	enable or disable measurement
+ * @read:	read a measurement entry at an index
  * @readall:	read a measurement block in a common format
  * @reset:	clear the data in the associated measurement block and
  *		reset its time stamp
@@ -120,7 +122,7 @@ struct cmb_operations {
 	int  (*readall)(struct ccw_device *, struct cmbdata *);
 	void (*reset)  (struct ccw_device *);
 	void *(*align) (void *);
-
+/* private: */
 	struct attribute_group *attr_group;
 };
 static struct cmb_operations *cmbops;
@@ -471,6 +473,7 @@ static void cmf_generic_reset(struct ccw
  *
  * @mem:	pointer to CMBs (only in basic measurement mode)
  * @list:	contains a linked list of all subchannels
+ * @num_channels: number of channels to be measured
  * @lock:	protect concurrent access to @mem and @list
  */
 struct cmb_area {
@@ -503,10 +506,20 @@ module_param_named(maxchannels, cmb_area
 
 /**
  * struct cmb - basic channel measurement block
+ * @ssch_rsch_count: number of ssch and rsch
+ * @sample_count: number of samples
+ * @device_connect_time: time of device connect
+ * @function_pending_time: time of function pending
+ * @device_disconnect_time: time of device disconnect
+ * @control_unit_queuing_time: time of control unit queuing
+ * @device_active_only_time: time of device active only
+ * @reserved: unused in basic measurement mode
+ *
+ * The measurement block as used by the hardware. The fields are described
+ * further in z/Architecture Principles of Operation, chapter 17.
  *
- * cmb as used by the hardware the fields are described in z/Architecture
- * Principles of Operation, chapter 17.
- * The area to be a contiguous array and may not be reallocated or freed.
+ * The cmb area made up from these blocks must be a contiguous array and may
+ * not be reallocated or freed.
  * Only one cmb area can be present in the system.
  */
 struct cmb {
@@ -804,9 +817,20 @@ static struct cmb_operations cmbops_basi
 
 /**
  * struct cmbe - extended channel measurement block
+ * @ssch_rsch_count: number of ssch and rsch
+ * @sample_count: number of samples
+ * @device_connect_time: time of device connect
+ * @function_pending_time: time of function pending
+ * @device_disconnect_time: time of device disconnect
+ * @control_unit_queuing_time: time of control unit queuing
+ * @device_active_only_time: time of device active only
+ * @device_busy_time: time of device busy
+ * @initial_command_response_time: initial command response time
+ * @reserved: unused
  *
- * cmb as used by the hardware, may be in any 64 bit physical location,
- * the fields are described in z/Architecture Principles of Operation,
+ * The measurement block as used by the hardware. May be in any 64 bit physical
+ * location.
+ * The fields are described further in z/Architecture Principles of Operation,
  * third edition, chapter 17.
  */
 struct cmbe {
@@ -1218,7 +1242,15 @@ static ssize_t cmb_enable_store(struct d
 
 DEVICE_ATTR(cmb_enable, 0644, cmb_enable_show, cmb_enable_store);
 
-/* enable_cmf/disable_cmf: module interface for cmf (de)activation */
+/**
+ * enable_cmf() - switch on the channel measurement for a specific device
+ *  @cdev:	The ccw device to be enabled
+ *
+ *  Returns %0 for success or a negative error value.
+ *
+ *  Context:
+ *    non-atomic
+ */
 int enable_cmf(struct ccw_device *cdev)
 {
 	int ret;
@@ -1240,6 +1272,15 @@ int enable_cmf(struct ccw_device *cdev)
 	return ret;
 }
 
+/**
+ * disable_cmf() - switch off the channel measurement for a specific device
+ *  @cdev:	The ccw device to be disabled
+ *
+ *  Returns %0 for success or a negative error value.
+ *
+ *  Context:
+ *    non-atomic
+ */
 int disable_cmf(struct ccw_device *cdev)
 {
 	int ret;
@@ -1252,11 +1293,31 @@ int disable_cmf(struct ccw_device *cdev)
 	return ret;
 }
 
+/**
+ * cmf_read() - read one value from the current channel measurement block
+ * @cdev:	the channel to be read
+ * @index:	the index of the value to be read
+ *
+ * Returns the value read or %0 if the value cannot be read.
+ *
+ *  Context:
+ *    any
+ */
 u64 cmf_read(struct ccw_device *cdev, int index)
 {
 	return cmbops->read(cdev, index);
 }
 
+/**
+ * cmf_readall() - read the current channel measurement block
+ * @cdev:	the channel to be read
+ * @data:	a pointer to a data block that will be filled
+ *
+ * Returns %0 on success, a negative error value otherwise.
+ *
+ *  Context:
+ *    any
+ */
 int cmf_readall(struct ccw_device *cdev, struct cmbdata *data)
 {
 	return cmbops->readall(cdev, data);
Index: quilt-2.6/include/asm-s390/cmb.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cmb.h
+++ quilt-2.6/include/asm-s390/cmb.h
@@ -1,29 +1,29 @@
 #ifndef S390_CMB_H
 #define S390_CMB_H
 /**
- * struct cmbdata -- channel measurement block data for user space
+ * struct cmbdata - channel measurement block data for user space
+ * @size: size of the stored data
+ * @elapsed_time: time since last sampling
+ * @ssch_rsch_count: number of ssch and rsch
+ * @sample_count: number of samples
+ * @device_connect_time: time of device connect
+ * @function_pending_time: time of function pending
+ * @device_disconnect_time: time of device disconnect
+ * @control_unit_queuing_time: time of control unit queuing
+ * @device_active_only_time: time of device active only
+ * @device_busy_time: time of device busy (ext. format)
+ * @initial_command_response_time: initial command response time (ext. format)
  *
- * @size:	size of the stored data
- * @ssch_rsch_count: XXX
- * @sample_count:
- * @device_connect_time:
- * @function_pending_time:
- * @device_disconnect_time:
- * @control_unit_queuing_time:
- * @device_active_only_time:
- * @device_busy_time:
- * @initial_command_response_time:
- *
- * all values are stored as 64 bit for simplicity, especially
+ * All values are stored as 64 bit for simplicity, especially
  * in 32 bit emulation mode. All time values are normalized to
  * nanoseconds.
  * Currently, two formats are known, which differ by the size of
  * this structure, i.e. the last two members are only set when
  * the extended channel measurement facility (first shipped in
  * z990 machines) is activated.
- * Potentially, more fields could be added, which results in a
+ * Potentially, more fields could be added, which would result in a
  * new ioctl number.
- **/
+ */
 struct cmbdata {
 	__u64 size;
 	__u64 elapsed_time;
@@ -49,44 +49,9 @@ struct cmbdata {
 
 #ifdef __KERNEL__
 struct ccw_device;
-/**
- * enable_cmf() - switch on the channel measurement for a specific device
- *  @cdev:	The ccw device to be enabled
- *  returns 0 for success or a negative error value.
- *
- *  Context:
- *    non-atomic
- **/
 extern int enable_cmf(struct ccw_device *cdev);
-
-/**
- * disable_cmf() - switch off the channel measurement for a specific device
- *  @cdev:	The ccw device to be disabled
- *  returns 0 for success or a negative error value.
- *
- *  Context:
- *    non-atomic
- **/
 extern int disable_cmf(struct ccw_device *cdev);
-
-/**
- * cmf_read() - read one value from the current channel measurement block
- * @cmf:	the channel to be read
- * @index:	the name of the value that is read
- *
- *  Context:
- *    any
- **/
-
 extern u64 cmf_read(struct ccw_device *cdev, int index);
-/**
- * cmf_readall() - read one value from the current channel measurement block
- * @cmf:	the channel to be read
- * @data:	a pointer to a data block that will be filled
- *
- *  Context:
- *    any
- **/
 extern int cmf_readall(struct ccw_device *cdev, struct cmbdata *data);
 
 #endif /* __KERNEL__ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
