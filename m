Return-Path: <linux-kernel-owner+w=401wt.eu-S1760804AbYG1R6z@vger.kernel.org>
Message-Id: <20080728175513.891488179@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/15] kmsg: convert monreader printk messages to kmsg api.
Content-Disposition: inline; filename=813-kmsg-monreader.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/monreader |  135 ++++++++++++++++++++++++++++++++++++++
 drivers/s390/char/monreader.c     |   39 ++++------
 2 files changed, 151 insertions(+), 23 deletions(-)

Index: quilt-2.6/Documentation/s390/kmsg/monreader
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/monreader
@@ -0,0 +1,135 @@
+/*?
+ * Tag: monreader.1
+ * Text: "Reading monitor data failed with rc=%i"
+ * Severity: Error
+ * Parameter:
+ *   @1: return code
+ * Description:
+ * The z/VM *MONITOR record device driver failed to read monitor data
+ * because the IUCV REPLY function failed. The read function against
+ * the monitor record device returns EIO. All monitor data that has been read
+ * since the last read with 0 size is incorrect.
+ * User action:
+ * Disregard all monitor data that has been read since the last read with
+ * 0 size. If the device driver has been compiled as a separate module, unload
+ * and reload the monreader module. If the device driver has been compiled
+ * into the kernel, reboot Linux. For more information about possible causes
+ * of the error see the IUCV section in "z/VM CP Programming Services" and
+ * the *MONITOR section in "z/VM Performance".
+ */
+
+/*?
+ * Tag: monreader.2
+ * Text: "z/VM *MONITOR system service disconnected with rc=%i"
+ * Severity: Error
+ * Parameter:
+ *   @1: IPUSER SEVER return code
+ * Description:
+ * The z/VM *MONITOR record device driver receives monitor records through
+ * an IUCV connection to the z/VM *MONITOR system service. This connection
+ * has been severed and the read function of the z/VM *MONITOR device driver
+ * returns EIO. All data received since the last read with 0 size is incorrect.
+ * User action:
+ * Disregard all monitor data read since the last read with 0 size. Close and
+ * reopen the monitor record device. For information about the IPUSER SEVER
+ * return codes see "z/VM Performance".
+ */
+
+/*?
+ * Tag: monreader.3
+ * Text: "The read queue for monitor data is full"
+ * Severity: Warning
+ * Description:
+ * The read function of the z/VM *MONITOR device driver returns EOVERFLOW
+ * because not enough monitor data has been read since the monitor device
+ * has been opened. Monitor data already read are valid and subsequent reads
+ * return valid data but some intermediate data might be missing.
+ * User action:
+ * Be aware that monitor data might be missing. Assure that you regularly
+ * read monitor data after opening the monitor record device.
+ */
+
+/*?
+ * Tag: monreader.4
+ * Text: "Connecting to the z/VM *MONITOR system service failed with rc=%i"
+ * Severity: Error
+ * Parameter:
+ *   @1: IUCV CONNECT return code
+ * Description:
+ * The z/VM *MONITOR record device driver receives monitor records through
+ * an IUCV connection to the z/VM *MONITOR system service. This connection
+ * could not be established when the monitor record device was opened. If
+ * the return code is 15, your z/VM guest virtual machine is not authorized
+ * to connect to the *MONITOR system service.
+ * User action:
+ * If the return code is 15, ensure that the IUCV *MONITOR statement is
+ * included in the z/VM directory entry for your z/VM guest virtual machine.
+ * For other IUCV CONNECT return codes see the IUCV section in "CP Programming
+ * Services" and the *MONITOR section in "z/VM  Performance".
+ */
+
+/*?
+ * Tag: monreader.5
+ * Text: "Disconnecting the z/VM *MONITOR system service failed with rc=%i"
+ * Severity: Warning
+ * Parameter:
+ *   @1: IUCV SEVER return code
+ * Description:
+ * The z/VM *MONITOR record device driver receives monitor data through an
+ * IUCV connection to the z/VM *MONITOR system service. This connection
+ * could not be closed when the monitor record device was closed. You might
+ * not be able to resume monitoring.
+ * User action:
+ * No immediate action is necessary. If you cannot open the monitor record
+ * device in the future, reboot Linux. For information about the IUCV SEVER
+ * return codes see the IUCV section in "CP Programming Services" and the
+ * *MONITOR section in "z/VM  Performance".
+ */
+
+/*?
+ * Tag: monreader.6
+ * Text: "The z/VM *MONITOR record device driver cannot be loaded without z/VM"
+ * Severity: Error
+ * Description:
+ * The z/VM *MONITOR record device driver uses z/VM system services to provide
+ * monitor data about z/VM guest operating systems to applications on Linux.
+ * On Linux instances that run in environments other than the z/VM hypervisor,
+ * the z/VM *MONITOR record device driver does not provide any useful
+ * function and the corresponding monreader module cannot be loaded.
+ * User action:
+ * Load the z/VM *MONITOR record device driver only on Linux instances that run
+ * as guest operating systems of the z/VM hypervisor. If the z/VM *MONITOR
+ * record device driver has been compiled into the kernel, ignore this message.
+ */
+
+/*?
+ * Tag: monreader.7
+ * Text: "The z/VM *MONITOR record device driver failed to register with IUCV"
+ * Severity: Error
+ * Description:
+ * The z/VM *MONITOR record device driver receives monitor data through an IUCV
+ * connection and needs to register with the IUCV device driver. This
+ * registration failed and the z/VM *MONITOR record device driver was not
+ * loaded. A possible cause of this problem is insufficient memory.
+ * User action:
+ * Free some memory and try again to load the module. If the z/VM *MONITOR
+ * record device driver has been compiled into the kernel, you might have to
+ * configure more memory and reboot Linux. If you do not want to read monitor
+ * data, ignore this message.
+ */
+
+/*?
+ * Tag: monreader.8
+ * Text: "The specified *MONITOR DCSS %s does not have the required type SC"
+ * Severity: Error
+ * Parameter:
+ *   @1: DCSS name
+ * Description:
+ * The DCSS that was specified with the monreader.mondcss kernel parameter or
+ * with the mondcss module parameter cannot be a *MONITOR DCSS because it is
+ * not of type SC.
+ * User action:
+ * Confirm that you are using the name of the DCSS that has been configured as
+ * the *MONITOR DCSS on the z/VM hypervisor. If the default name, MONDCSS, is
+ * used, omit the monreader.mondcss or mondcss parameter.
+ */
Index: quilt-2.6/drivers/s390/char/monreader.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/monreader.c
+++ quilt-2.6/drivers/s390/char/monreader.c
@@ -23,20 +23,10 @@
 #include <asm/uaccess.h>
 #include <asm/ebcdic.h>
 #include <asm/extmem.h>
+#include <asm/kmsg.h>
 
-//#define MON_DEBUG			/* Debug messages on/off */
 
-#define MON_NAME "monreader"
-
-#define P_INFO(x...)	printk(KERN_INFO MON_NAME " info: " x)
-#define P_ERROR(x...)	printk(KERN_ERR MON_NAME " error: " x)
-#define P_WARNING(x...)	printk(KERN_WARNING MON_NAME " warning: " x)
-
-#ifdef MON_DEBUG
-#define P_DEBUG(x...)   printk(KERN_DEBUG MON_NAME " debug: " x)
-#else
-#define P_DEBUG(x...)   do {} while (0)
-#endif
+#define KMSG_COMPONENT "monreader"
 
 #define MON_COLLECT_SAMPLE 0x80
 #define MON_COLLECT_EVENT  0x40
@@ -172,7 +162,7 @@ static int mon_send_reply(struct mon_msg
 	} else
 		monmsg->replied_msglim = 1;
 	if (rc) {
-		P_ERROR("read, IUCV reply failed with rc = %i\n\n", rc);
+		kmsg_err(1, "Reading monitor data failed with rc=%i\n", rc);
 		return -EIO;
 	}
 	return 0;
@@ -251,7 +241,8 @@ static void mon_iucv_path_severed(struct
 {
 	struct mon_private *monpriv = path->private;
 
-	P_ERROR("IUCV connection severed with rc = 0x%X\n", ipuser[0]);
+	kmsg_err(2, "z/VM *MONITOR system service disconnected with rc=%i\n",
+		 ipuser[0]);
 	iucv_path_sever(path, NULL);
 	atomic_set(&monpriv->iucv_severed, 1);
 	wake_up(&mon_conn_wait_queue);
@@ -266,8 +257,7 @@ static void mon_iucv_message_pending(str
 	memcpy(&monpriv->msg_array[monpriv->write_index]->msg,
 	       msg, sizeof(*msg));
 	if (atomic_inc_return(&monpriv->msglim_count) == MON_MSGLIM) {
-		P_WARNING("IUCV message pending, message limit (%i) reached\n",
-			  MON_MSGLIM);
+		kmsg_warn(3, "The read queue for monitor data is full\n");
 		monpriv->msg_array[monpriv->write_index]->msglim_reached = 1;
 	}
 	monpriv->write_index = (monpriv->write_index + 1) % MON_MSGLIM;
@@ -311,8 +301,8 @@ static int mon_open(struct inode *inode,
 	rc = iucv_path_connect(monpriv->path, &monreader_iucv_handler,
 			       MON_SERVICE, NULL, user_data_connect, monpriv);
 	if (rc) {
-		P_ERROR("iucv connection to *MONITOR failed with "
-			"IPUSER SEVER code = %i\n", rc);
+		kmsg_err(4, "Connecting to the z/VM *MONITOR system service "
+			    "failed with rc=%i\n", rc);
 		rc = -EIO;
 		goto out_path;
 	}
@@ -353,7 +343,8 @@ static int mon_close(struct inode *inode
 	 */
 	rc = iucv_path_sever(monpriv->path, user_data_sever);
 	if (rc)
-		P_ERROR("close, iucv_sever failed with rc = %i\n", rc);
+		kmsg_warn(5, "Disconnecting the z/VM *MONITOR system service "
+			     "failed with rc=%i\n", rc);
 
 	atomic_set(&monpriv->iucv_severed, 0);
 	atomic_set(&monpriv->iucv_connected, 0);
@@ -469,7 +460,8 @@ static int __init mon_init(void)
 	int rc;
 
 	if (!MACHINE_IS_VM) {
-		P_ERROR("not running under z/VM, driver not loaded\n");
+		kmsg_err(6, "The z/VM *MONITOR record device driver cannot be "
+			    "loaded without z/VM\n");
 		return -ENODEV;
 	}
 
@@ -478,7 +470,8 @@ static int __init mon_init(void)
 	 */
 	rc = iucv_register(&monreader_iucv_handler, 1);
 	if (rc) {
-		P_ERROR("failed to register with iucv driver\n");
+		kmsg_err(7, "The z/VM *MONITOR record device driver failed to "
+			    "register with IUCV\n");
 		return rc;
 	}
 
@@ -488,8 +481,8 @@ static int __init mon_init(void)
 		goto out_iucv;
 	}
 	if (rc != SEG_TYPE_SC) {
-		P_ERROR("segment %s has unsupported type, should be SC\n",
-			mon_dcss_name);
+		kmsg_err(8, "The specified *MONITOR DCSS %s does not have the "
+			    "required type SC\n", mon_dcss_name);
 		rc = -EINVAL;
 		goto out_iucv;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
