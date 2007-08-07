Return-Path: <linux-kernel-owner+w=401wt.eu-S933701AbXHGLTM@vger.kernel.org>
Message-Id: <20070807111847.793994160@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/18] cio: Fix some coding style issues in cmf.
Content-Disposition: inline; filename=102-cio-cmfstyle.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Fix some formatting and correct a comment.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cmf.c |  133 ++++++++++++++++++++++++++-----------------------
 include/asm-s390/cmb.h |    8 +-
 2 files changed, 77 insertions(+), 64 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -45,7 +45,8 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-/* parameter to enable cmf during boot, possible uses are:
+/*
+ * parameter to enable cmf during boot, possible uses are:
  *  "s390cmf" -- enable cmf and allocate 2 MB of ram so measuring can be
  *               used on any subchannel
  *  "s390cmf=<num>" -- enable cmf and allocate enough memory to measure
@@ -84,6 +85,7 @@ enum cmb_format {
 	CMF_EXTENDED,
 	CMF_AUTODETECT = -1,
 };
+
 /**
  * format - actual format for all measurement blocks
  *
@@ -111,13 +113,13 @@ module_param(format, bool, 0444);
  * @align:	align an allocated block so that the hardware can use it
  */
 struct cmb_operations {
-	int (*alloc)  (struct ccw_device*);
-	void(*free)   (struct ccw_device*);
-	int (*set)    (struct ccw_device*, u32);
-	u64 (*read)   (struct ccw_device*, int);
-	int (*readall)(struct ccw_device*, struct cmbdata *);
-	void (*reset) (struct ccw_device*);
-	void * (*align) (void *);
+	int  (*alloc)  (struct ccw_device *);
+	void (*free)   (struct ccw_device *);
+	int  (*set)    (struct ccw_device *, u32);
+	u64  (*read)   (struct ccw_device *, int);
+	int  (*readall)(struct ccw_device *, struct cmbdata *);
+	void (*reset)  (struct ccw_device *);
+	void *(*align) (void *);
 
 	struct attribute_group *attr_group;
 };
@@ -130,9 +132,11 @@ struct cmb_data {
 	unsigned long long last_update;  /* when last_block was updated */
 };
 
-/* our user interface is designed in terms of nanoseconds,
+/*
+ * Our user interface is designed in terms of nanoseconds,
  * while the hardware measures total times in its own
- * unit.*/
+ * unit.
+ */
 static inline u64 time_to_nsec(u32 value)
 {
 	return ((u64)value) * 128000ull;
@@ -159,12 +163,13 @@ static inline u64 time_to_avg_nsec(u32 v
 	return ret;
 }
 
-/* activate or deactivate the channel monitor. When area is NULL,
+/*
+ * Activate or deactivate the channel monitor. When area is NULL,
  * the monitor is deactivated. The channel monitor needs to
  * be active in order to measure subchannels, which also need
- * to be enabled. */
-static inline void
-cmf_activate(void *area, unsigned int onoff)
+ * to be enabled.
+ */
+static inline void cmf_activate(void *area, unsigned int onoff)
 {
 	register void * __gpr2 asm("2");
 	register long __gpr1 asm("1");
@@ -175,8 +180,8 @@ cmf_activate(void *area, unsigned int on
 	asm("schm" : : "d" (__gpr2), "d" (__gpr1) );
 }
 
-static int
-set_schib(struct ccw_device *cdev, u32 mme, int mbfc, unsigned long address)
+static int set_schib(struct ccw_device *cdev, u32 mme, int mbfc,
+		     unsigned long address)
 {
 	int ret;
 	int retry;
@@ -484,15 +489,14 @@ static struct cmb_area cmb_area = {
 
 /* ****** old style CMB handling ********/
 
-/** int maxchannels
- *
+/*
  * Basic channel measurement blocks are allocated in one contiguous
  * block of memory, which can not be moved as long as any channel
  * is active. Therefore, a maximum number of subchannels needs to
  * be defined somewhere. This is a module parameter, defaulting to
  * a resonable value of 1024, or 32 kb of memory.
  * Current kernels don't allow kmalloc with more than 128kb, so the
- * maximum is 4096
+ * maximum is 4096.
  */
 
 module_param_named(maxchannels, cmb_area.num_channels, uint, 0444);
@@ -516,8 +520,9 @@ struct cmb {
 	u32 reserved[2];
 };
 
-/* insert a single device into the cmb_area list
- * called with cmb_area.lock held from alloc_cmb
+/*
+ * Insert a single device into the cmb_area list.
+ * Called with cmb_area.lock held from alloc_cmb.
  */
 static int alloc_cmb_single(struct ccw_device *cdev,
 			    struct cmb_data *cmb_data)
@@ -532,9 +537,11 @@ static int alloc_cmb_single(struct ccw_d
 		goto out;
 	}
 
-	/* find first unused cmb in cmb_area.mem.
-	 * this is a little tricky: cmb_area.list
-	 * remains sorted by ->cmb->hw_data pointers */
+	/*
+	 * Find first unused cmb in cmb_area.mem.
+	 * This is a little tricky: cmb_area.list
+	 * remains sorted by ->cmb->hw_data pointers.
+	 */
 	cmb = cmb_area.mem;
 	list_for_each_entry(node, &cmb_area.list, cmb_list) {
 		struct cmb_data *data;
@@ -558,8 +565,7 @@ out:
 	return ret;
 }
 
-static int
-alloc_cmb (struct ccw_device *cdev)
+static int alloc_cmb(struct ccw_device *cdev)
 {
 	int ret;
 	struct cmb *mem;
@@ -667,7 +673,7 @@ static int set_cmb(struct ccw_device *cd
 	return set_schib_wait(cdev, mme, 0, offset);
 }
 
-static u64 read_cmb (struct ccw_device *cdev, int index)
+static u64 read_cmb(struct ccw_device *cdev, int index)
 {
 	struct cmb *cmb;
 	u32 val;
@@ -717,7 +723,7 @@ out:
 	return ret;
 }
 
-static int readall_cmb (struct ccw_device *cdev, struct cmbdata *data)
+static int readall_cmb(struct ccw_device *cdev, struct cmbdata *data)
 {
 	struct cmb *cmb;
 	struct cmb_data *cmb_data;
@@ -813,10 +819,12 @@ struct cmbe {
 	u32 reserved[7];
 };
 
-/* kmalloc only guarantees 8 byte alignment, but we need cmbe
+/*
+ * kmalloc only guarantees 8 byte alignment, but we need cmbe
  * pointers to be naturally aligned. Make sure to allocate
- * enough space for two cmbes */
-static inline struct cmbe* cmbe_align(struct cmbe *c)
+ * enough space for two cmbes.
+ */
+static inline struct cmbe *cmbe_align(struct cmbe *c)
 {
 	unsigned long addr;
 	addr = ((unsigned long)c + sizeof (struct cmbe) - sizeof(long)) &
@@ -824,7 +832,7 @@ static inline struct cmbe* cmbe_align(st
 	return (struct cmbe*)addr;
 }
 
-static int alloc_cmbe (struct ccw_device *cdev)
+static int alloc_cmbe(struct ccw_device *cdev)
 {
 	struct cmbe *cmbe;
 	struct cmb_data *cmb_data;
@@ -870,7 +878,7 @@ out_free:
 	return ret;
 }
 
-static void free_cmbe (struct ccw_device *cdev)
+static void free_cmbe(struct ccw_device *cdev)
 {
 	struct cmb_data *cmb_data;
 
@@ -909,7 +917,7 @@ static int set_cmbe(struct ccw_device *c
 }
 
 
-static u64 read_cmbe (struct ccw_device *cdev, int index)
+static u64 read_cmbe(struct ccw_device *cdev, int index)
 {
 	struct cmbe *cmb;
 	struct cmb_data *cmb_data;
@@ -967,7 +975,7 @@ out:
 	return ret;
 }
 
-static int readall_cmbe (struct ccw_device *cdev, struct cmbdata *data)
+static int readall_cmbe(struct ccw_device *cdev, struct cmbdata *data)
 {
 	struct cmbe *cmb;
 	struct cmb_data *cmb_data;
@@ -1046,15 +1054,15 @@ static struct cmb_operations cmbops_exte
 };
 
 
-static ssize_t
-cmb_show_attr(struct device *dev, char *buf, enum cmb_index idx)
+static ssize_t cmb_show_attr(struct device *dev, char *buf, enum cmb_index idx)
 {
 	return sprintf(buf, "%lld\n",
 		(unsigned long long) cmf_read(to_ccwdev(dev), idx));
 }
 
-static ssize_t
-cmb_show_avg_sample_interval(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t cmb_show_avg_sample_interval(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct ccw_device *cdev;
 	long interval;
@@ -1076,8 +1084,9 @@ cmb_show_avg_sample_interval(struct devi
 	return sprintf(buf, "%ld\n", interval);
 }
 
-static ssize_t
-cmb_show_avg_utilization(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t cmb_show_avg_utilization(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct cmbdata data;
 	u64 utilization;
@@ -1109,12 +1118,14 @@ cmb_show_avg_utilization(struct device *
 }
 
 #define cmf_attr(name) \
-static ssize_t show_ ## name (struct device * dev, struct device_attribute *attr, char * buf) \
+static ssize_t show_ ## name (struct device *dev, \
+			      struct device_attribute *attr, char *buf) \
 { return cmb_show_attr((dev), buf, cmb_ ## name); } \
 static DEVICE_ATTR(name, 0444, show_ ## name, NULL);
 
 #define cmf_attr_avg(name) \
-static ssize_t show_avg_ ## name (struct device * dev, struct device_attribute *attr, char * buf) \
+static ssize_t show_avg_ ## name (struct device *dev, \
+				  struct device_attribute *attr, char *buf) \
 { return cmb_show_attr((dev), buf, cmb_ ## name); } \
 static DEVICE_ATTR(avg_ ## name, 0444, show_avg_ ## name, NULL);
 
@@ -1128,7 +1139,8 @@ cmf_attr_avg(device_active_only_time);
 cmf_attr_avg(device_busy_time);
 cmf_attr_avg(initial_command_response_time);
 
-static DEVICE_ATTR(avg_sample_interval, 0444, cmb_show_avg_sample_interval, NULL);
+static DEVICE_ATTR(avg_sample_interval, 0444, cmb_show_avg_sample_interval,
+		   NULL);
 static DEVICE_ATTR(avg_utilization, 0444, cmb_show_avg_utilization, NULL);
 
 static struct attribute *cmf_attributes[] = {
@@ -1169,12 +1181,16 @@ static struct attribute_group cmf_attr_g
 	.attrs = cmf_attributes_ext,
 };
 
-static ssize_t cmb_enable_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t cmb_enable_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
 {
 	return sprintf(buf, "%d\n", to_ccwdev(dev)->private->cmb ? 1 : 0);
 }
 
-static ssize_t cmb_enable_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t c)
+static ssize_t cmb_enable_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t c)
 {
 	struct ccw_device *cdev;
 	int ret;
@@ -1200,8 +1216,7 @@ static ssize_t cmb_enable_store(struct d
 DEVICE_ATTR(cmb_enable, 0644, cmb_enable_show, cmb_enable_store);
 
 /* enable_cmf/disable_cmf: module interface for cmf (de)activation */
-int
-enable_cmf(struct ccw_device *cdev)
+int enable_cmf(struct ccw_device *cdev)
 {
 	int ret;
 
@@ -1222,8 +1237,7 @@ enable_cmf(struct ccw_device *cdev)
 	return ret;
 }
 
-int
-disable_cmf(struct ccw_device *cdev)
+int disable_cmf(struct ccw_device *cdev)
 {
 	int ret;
 
@@ -1235,14 +1249,12 @@ disable_cmf(struct ccw_device *cdev)
 	return ret;
 }
 
-u64
-cmf_read(struct ccw_device *cdev, int index)
+u64 cmf_read(struct ccw_device *cdev, int index)
 {
 	return cmbops->read(cdev, index);
 }
 
-int
-cmf_readall(struct ccw_device *cdev, struct cmbdata *data)
+int cmf_readall(struct ccw_device *cdev, struct cmbdata *data)
 {
 	return cmbops->readall(cdev, data);
 }
@@ -1254,15 +1266,16 @@ int cmf_reenable(struct ccw_device *cdev
 	return cmbops->set(cdev, 2);
 }
 
-static int __init
-init_cmf(void)
+static int __init init_cmf(void)
 {
 	char *format_string;
 	char *detect_string = "parameter";
 
-	/* We cannot really autoprobe this. If the user did not give a parameter,
-	   see if we are running on z990 or up, otherwise fall back to basic mode. */
-
+	/*
+	 * If the user did not give a parameter, see if we are running on a
+	 * machine supporting extended measurement blocks, otherwise fall back
+	 * to basic mode.
+	 */
 	if (format == CMF_AUTODETECT) {
 		if (!css_characteristics_avail ||
 		    !css_general_characteristics.ext_mb) {
@@ -1288,7 +1301,7 @@ init_cmf(void)
 		}
 		break;
 	case CMF_EXTENDED:
- 		format_string = "extended";
+		format_string = "extended";
 		cmbops = &cmbops_extended;
 		break;
 	default:
Index: quilt-2.6/include/asm-s390/cmb.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cmb.h
+++ quilt-2.6/include/asm-s390/cmb.h
@@ -41,11 +41,11 @@ struct cmbdata {
 };
 
 /* enable channel measurement */
-#define BIODASDCMFENABLE	_IO(DASD_IOCTL_LETTER,32)
+#define BIODASDCMFENABLE	_IO(DASD_IOCTL_LETTER, 32)
 /* enable channel measurement */
-#define BIODASDCMFDISABLE	_IO(DASD_IOCTL_LETTER,33)
+#define BIODASDCMFDISABLE	_IO(DASD_IOCTL_LETTER, 33)
 /* read channel measurement data */
-#define BIODASDREADALLCMB	_IOWR(DASD_IOCTL_LETTER,33,struct cmbdata)
+#define BIODASDREADALLCMB	_IOWR(DASD_IOCTL_LETTER, 33, struct cmbdata)
 
 #ifdef __KERNEL__
 struct ccw_device;
@@ -87,7 +87,7 @@ extern u64 cmf_read(struct ccw_device *c
  *  Context:
  *    any
  **/
-extern int cmf_readall(struct ccw_device *cdev, struct cmbdata*data);
+extern int cmf_readall(struct ccw_device *cdev, struct cmbdata *data);
 
 #endif /* __KERNEL__ */
 #endif /* S390_CMB_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
