Return-Path: <linux-kernel-owner+w=401wt.eu-S1761702AbZBYPM3@vger.kernel.org>
Message-Id: <20090225150830.837687942@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 14/46] hvc_iucv: Provide IUCV z/VM user ID filtering
Content-Disposition: inline; filename=113-hvc_iucv-auth.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

This patch introduces the kernel parameter hvc_iucv_allow= that specifies
a comma-separated list of z/VM user IDs.
If specified, the z/VM IUCV hypervisor console device driver accepts IUCV
connections from listed z/VM user IDs only.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/kernel-parameters.txt |    3 
 drivers/char/hvc_iucv.c             |  254 ++++++++++++++++++++++++++++++++++--
 2 files changed, 249 insertions(+), 8 deletions(-)

Index: quilt-2.6/Documentation/kernel-parameters.txt
===================================================================
--- quilt-2.6.orig/Documentation/kernel-parameters.txt
+++ quilt-2.6/Documentation/kernel-parameters.txt
@@ -829,6 +829,9 @@ and is between 256 and 4096 characters. 
 
 	hvc_iucv=	[S390] Number of z/VM IUCV hypervisor console (HVC)
 			       terminal devices. Valid values: 0..8
+	hvc_iucv_allow=	[S390] Comma-separated list of z/VM user IDs.
+			       If specified, z/VM IUCV HVC accepts connections
+			       from listed z/VM user IDs only.
 
 	i8042.debug	[HW] Toggle i8042 debug mode
 	i8042.direct	[HW] Put keyboard port into non-translated mode
Index: quilt-2.6/drivers/char/hvc_iucv.c
===================================================================
--- quilt-2.6.orig/drivers/char/hvc_iucv.c
+++ quilt-2.6/drivers/char/hvc_iucv.c
@@ -13,10 +13,11 @@
 
 #include <linux/types.h>
 #include <asm/ebcdic.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mempool.h>
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/tty.h>
 #include <linux/wait.h>
 #include <net/iucv/iucv.h>
@@ -95,6 +96,12 @@ static unsigned long hvc_iucv_devices = 
 /* Array of allocated hvc iucv tty lines... */
 static struct hvc_iucv_private *hvc_iucv_table[MAX_HVC_IUCV_LINES];
 #define IUCV_HVC_CON_IDX	(0)
+/* List of z/VM user ID filter entries (struct iucv_vmid_filter) */
+#define MAX_VMID_FILTER		(500)
+static size_t hvc_iucv_filter_size;
+static void *hvc_iucv_filter;
+static const char *hvc_iucv_filter_string;
+static DEFINE_RWLOCK(hvc_iucv_filter_lock);
 
 /* Kmem cache and mempool for iucv_tty_buffer elements */
 static struct kmem_cache *hvc_iucv_buffer_cache;
@@ -618,6 +625,27 @@ static void hvc_iucv_notifier_del(struct
 }
 
 /**
+ * hvc_iucv_filter_connreq() - Filter connection request based on z/VM user ID
+ * @ipvmid:	Originating z/VM user ID (right padded with blanks)
+ *
+ * Returns 0 if the z/VM user ID @ipvmid is allowed to connection, otherwise
+ * non-zero.
+ */
+static int hvc_iucv_filter_connreq(u8 ipvmid[8])
+{
+	size_t i;
+
+	/* Note: default policy is ACCEPT if no filter is set */
+	if (!hvc_iucv_filter_size)
+		return 0;
+
+	for (i = 0; i < hvc_iucv_filter_size; i++)
+		if (0 == memcmp(ipvmid, hvc_iucv_filter + (8 * i), 8))
+			return 0;
+	return 1;
+}
+
+/**
  * hvc_iucv_path_pending() - IUCV handler to process a connection request.
  * @path:	Pending path (struct iucv_path)
  * @ipvmid:	z/VM system identifier of originator
@@ -641,6 +669,7 @@ static	int hvc_iucv_path_pending(struct 
 {
 	struct hvc_iucv_private *priv;
 	u8 nuser_data[16];
+	u8 vm_user_id[9];
 	int i, rc;
 
 	priv = NULL;
@@ -653,6 +682,20 @@ static	int hvc_iucv_path_pending(struct 
 	if (!priv)
 		return -ENODEV;
 
+	/* Enforce that ipvmid is allowed to connect to us */
+	read_lock(&hvc_iucv_filter_lock);
+	rc = hvc_iucv_filter_connreq(ipvmid);
+	read_unlock(&hvc_iucv_filter_lock);
+	if (rc) {
+		iucv_path_sever(path, ipuser);
+		iucv_path_free(path);
+		memcpy(vm_user_id, ipvmid, 8);
+		vm_user_id[8] = 0;
+		pr_info("A connection request from z/VM user ID %s "
+			"was refused\n", vm_user_id);
+		return 0;
+	}
+
 	spin_lock(&priv->lock);
 
 	/* If the terminal is already connected or being severed, then sever
@@ -877,6 +920,171 @@ static int __init hvc_iucv_alloc(int id,
 }
 
 /**
+ * hvc_iucv_parse_filter() - Parse filter for a single z/VM user ID
+ * @filter:	String containing a comma-separated list of z/VM user IDs
+ */
+static const char *hvc_iucv_parse_filter(const char *filter, char *dest)
+{
+	const char *nextdelim, *residual;
+	size_t len;
+
+	nextdelim = strchr(filter, ',');
+	if (nextdelim) {
+		len = nextdelim - filter;
+		residual = nextdelim + 1;
+	} else {
+		len = strlen(filter);
+		residual = filter + len;
+	}
+
+	if (len == 0)
+		return ERR_PTR(-EINVAL);
+
+	/* check for '\n' (if called from sysfs) */
+	if (filter[len - 1] == '\n')
+		len--;
+
+	if (len > 8)
+		return ERR_PTR(-EINVAL);
+
+	/* pad with blanks and save upper case version of user ID */
+	memset(dest, ' ', 8);
+	while (len--)
+		dest[len] = toupper(filter[len]);
+	return residual;
+}
+
+/**
+ * hvc_iucv_setup_filter() - Set up z/VM user ID filter
+ * @filter:	String consisting of a comma-separated list of z/VM user IDs
+ *
+ * The function parses the @filter string and creates an array containing
+ * the list of z/VM user ID filter entries.
+ * Return code 0 means success, -EINVAL if the filter is syntactically
+ * incorrect, -ENOMEM if there was not enough memory to allocate the
+ * filter list array, or -ENOSPC if too many z/VM user IDs have been specified.
+ */
+static int hvc_iucv_setup_filter(const char *val)
+{
+	const char *residual;
+	int err;
+	size_t size, count;
+	void *array, *old_filter;
+
+	count = strlen(val);
+	if (count == 0 || (count == 1 && val[0] == '\n')) {
+		size  = 0;
+		array = NULL;
+		goto out_replace_filter;	/* clear filter */
+	}
+
+	/* count user IDs in order to allocate sufficient memory */
+	size = 1;
+	residual = val;
+	while ((residual = strchr(residual, ',')) != NULL) {
+		residual++;
+		size++;
+	}
+
+	/* check if the specified list exceeds the filter limit */
+	if (size > MAX_VMID_FILTER)
+		return -ENOSPC;
+
+	array = kzalloc(size * 8, GFP_KERNEL);
+	if (!array)
+		return -ENOMEM;
+
+	count = size;
+	residual = val;
+	while (*residual && count) {
+		residual = hvc_iucv_parse_filter(residual,
+						 array + ((size - count) * 8));
+		if (IS_ERR(residual)) {
+			err = PTR_ERR(residual);
+			kfree(array);
+			goto out_err;
+		}
+		count--;
+	}
+
+out_replace_filter:
+	write_lock_bh(&hvc_iucv_filter_lock);
+	old_filter = hvc_iucv_filter;
+	hvc_iucv_filter_size = size;
+	hvc_iucv_filter = array;
+	write_unlock_bh(&hvc_iucv_filter_lock);
+	kfree(old_filter);
+
+	err = 0;
+out_err:
+	return err;
+}
+
+/**
+ * param_set_vmidfilter() - Set z/VM user ID filter parameter
+ * @val:	String consisting of a comma-separated list of z/VM user IDs
+ * @kp:		Kernel parameter pointing to hvc_iucv_filter array
+ *
+ * The function sets up the z/VM user ID filter specified as comma-separated
+ * list of user IDs in @val.
+ * Note: If it is called early in the boot process, @val is stored and
+ *	 parsed later in hvc_iucv_init().
+ */
+static int param_set_vmidfilter(const char *val, struct kernel_param *kp)
+{
+	int rc;
+
+	if (!MACHINE_IS_VM || !hvc_iucv_devices)
+		return -ENODEV;
+
+	if (!val)
+		return -EINVAL;
+
+	rc = 0;
+	if (slab_is_available())
+		rc = hvc_iucv_setup_filter(val);
+	else
+		hvc_iucv_filter_string = val;	/* defer... */
+	return rc;
+}
+
+/**
+ * param_get_vmidfilter() - Get z/VM user ID filter
+ * @buffer:	Buffer to store z/VM user ID filter,
+ *		(buffer size assumption PAGE_SIZE)
+ * @kp:		Kernel parameter pointing to the hvc_iucv_filter array
+ *
+ * The function stores the filter as a comma-separated list of z/VM user IDs
+ * in @buffer. Typically, sysfs routines call this function for attr show.
+ */
+static int param_get_vmidfilter(char *buffer, struct kernel_param *kp)
+{
+	int rc;
+	size_t index, len;
+	void *start, *end;
+
+	if (!MACHINE_IS_VM || !hvc_iucv_devices)
+		return -ENODEV;
+
+	rc = 0;
+	read_lock_bh(&hvc_iucv_filter_lock);
+	for (index = 0; index < hvc_iucv_filter_size; index++) {
+		start = hvc_iucv_filter + (8 * index);
+		end   = memchr(start, ' ', 8);
+		len   = (end) ? end - start : 8;
+		memcpy(buffer + rc, start, len);
+		rc += len;
+		buffer[rc++] = ',';
+	}
+	read_unlock_bh(&hvc_iucv_filter_lock);
+	if (rc)
+		buffer[--rc] = '\0';	/* replace last comma and update rc */
+	return rc;
+}
+
+#define param_check_vmidfilter(name, p) __param_check(name, p, void)
+
+/**
  * hvc_iucv_init() - z/VM IUCV HVC device driver initialization
  */
 static int __init hvc_iucv_init(void)
@@ -884,19 +1092,44 @@ static int __init hvc_iucv_init(void)
 	int rc;
 	unsigned int i;
 
+	if (!hvc_iucv_devices)
+		return -ENODEV;
+
 	if (!MACHINE_IS_VM) {
 		pr_notice("The z/VM IUCV HVC device driver cannot "
 			   "be used without z/VM\n");
-		return -ENODEV;
+		rc = -ENODEV;
+		goto out_error;
 	}
 
-	if (!hvc_iucv_devices)
-		return -ENODEV;
-
 	if (hvc_iucv_devices > MAX_HVC_IUCV_LINES) {
 		pr_err("%lu is not a valid value for the hvc_iucv= "
 			"kernel parameter\n", hvc_iucv_devices);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out_error;
+	}
+
+	/* parse hvc_iucv_allow string and create z/VM user ID filter list */
+	if (hvc_iucv_filter_string) {
+		rc = hvc_iucv_setup_filter(hvc_iucv_filter_string);
+		switch (rc) {
+		case 0:
+			break;
+		case -ENOMEM:
+			pr_err("Allocating memory failed with "
+				"reason code=%d\n", 3);
+			goto out_error;
+		case -EINVAL:
+			pr_err("hvc_iucv_allow= does not specify a valid "
+				"z/VM user ID list\n");
+			goto out_error;
+		case -ENOSPC:
+			pr_err("hvc_iucv_allow= specifies too many "
+				"z/VM user IDs\n");
+			goto out_error;
+		default:
+			goto out_error;
+		}
 	}
 
 	hvc_iucv_buffer_cache = kmem_cache_create(KMSG_COMPONENT,
@@ -904,7 +1137,8 @@ static int __init hvc_iucv_init(void)
 					   0, 0, NULL);
 	if (!hvc_iucv_buffer_cache) {
 		pr_err("Allocating memory failed with reason code=%d\n", 1);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out_error;
 	}
 
 	hvc_iucv_mempool = mempool_create_slab_pool(MEMPOOL_MIN_NR,
@@ -912,7 +1146,8 @@ static int __init hvc_iucv_init(void)
 	if (!hvc_iucv_mempool) {
 		pr_err("Allocating memory failed with reason code=%d\n", 2);
 		kmem_cache_destroy(hvc_iucv_buffer_cache);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out_error;
 	}
 
 	/* register the first terminal device as console
@@ -956,6 +1191,8 @@ out_error_hvc:
 out_error_memory:
 	mempool_destroy(hvc_iucv_mempool);
 	kmem_cache_destroy(hvc_iucv_buffer_cache);
+out_error:
+	hvc_iucv_devices = 0; /* ensure that we do not provide any device */
 	return rc;
 }
 
@@ -971,3 +1208,4 @@ static	int __init hvc_iucv_config(char *
 
 device_initcall(hvc_iucv_init);
 __setup("hvc_iucv=", hvc_iucv_config);
+core_param(hvc_iucv_allow, hvc_iucv_filter, vmidfilter, 0640);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
