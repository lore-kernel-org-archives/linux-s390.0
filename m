Return-Path: <linux-kernel-owner+w=401wt.eu-S1753799AbZCXVO3@vger.kernel.org>
From: stoyboyker@gmail.com
Subject: [PATCH 05/13] [s390] changed ioctls to unlocked
Date: Tue, 24 Mar 2009 16:12:40 -0500
Message-Id: <1237929168-15341-6-git-send-email-stoyboyker@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Stoyan Gaydarov <stoyboyker@gmail.com>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Stoyan Gaydarov <stoyboyker@gmail.com>

Signed-off-by: Stoyan Gaydarov <stoyboyker@gmail.com>
---
 drivers/s390/char/tape_char.c  |   47 +++++++++++++++++++++++----------
 drivers/s390/char/vmwatchdog.c |   57 ++++++++++++++++++++++++++--------------
 2 files changed, 70 insertions(+), 34 deletions(-)

diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index be0ce22..158564f 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -35,8 +35,7 @@ static ssize_t tapechar_read(struct file *, char __user *, size_t, loff_t *);
 static ssize_t tapechar_write(struct file *, const char __user *, size_t, loff_t *);
 static int tapechar_open(struct inode *,struct file *);
 static int tapechar_release(struct inode *,struct file *);
-static int tapechar_ioctl(struct inode *, struct file *, unsigned int,
-			  unsigned long);
+static long tapechar_ioctl(struct file *, unsigned int, unsigned long);
 static long tapechar_compat_ioctl(struct file *, unsigned int,
 			  unsigned long);
 
@@ -45,7 +44,7 @@ static const struct file_operations tape_fops =
 	.owner = THIS_MODULE,
 	.read = tapechar_read,
 	.write = tapechar_write,
-	.ioctl = tapechar_ioctl,
+	.unlocked_ioctl = tapechar_ioctl,
 	.compat_ioctl = tapechar_compat_ioctl,
 	.open = tapechar_open,
 	.release = tapechar_release,
@@ -354,13 +353,14 @@ tapechar_release(struct inode *inode, struct file *filp)
 /*
  * Tape device io controls.
  */
-static int
-tapechar_ioctl(struct inode *inp, struct file *filp,
-	       unsigned int no, unsigned long data)
+static long
+tapechar_ioctl(struct file *filp, unsigned int no, unsigned long data)
 {
 	struct tape_device *device;
 	int rc;
 
+	lock_kernel();
+
 	DBF_EVENT(6, "TCHAR:ioct\n");
 
 	device = (struct tape_device *) filp->private_data;
@@ -368,10 +368,14 @@ tapechar_ioctl(struct inode *inp, struct file *filp,
 	if (no == MTIOCTOP) {
 		struct mtop op;
 
-		if (copy_from_user(&op, (char __user *) data, sizeof(op)) != 0)
+		if (copy_from_user(&op, (char __user *) data, sizeof(op)) != 0) {
+			unlock_kernel();
 			return -EFAULT;
-		if (op.mt_count < 0)
+		}
+		if (op.mt_count < 0) {
+			unlock_kernel();
 			return -EINVAL;
+		}
 
 		/*
 		 * Operations that change tape position should write final
@@ -405,6 +409,7 @@ tapechar_ioctl(struct inode *inp, struct file *filp,
 			else
 				device->required_tapemarks -= op.mt_count;
 		}
+		unlock_kernel();
 		return rc;
 	}
 	if (no == MTIOCPOS) {
@@ -412,11 +417,16 @@ tapechar_ioctl(struct inode *inp, struct file *filp,
 		struct mtpos pos;
 
 		rc = tape_mtop(device, MTTELL, 1);
-		if (rc < 0)
+		if (rc < 0) {
+			unlock_kernel();
 			return rc;
+		}
 		pos.mt_blkno = rc;
-		if (copy_to_user((char __user *) data, &pos, sizeof(pos)) != 0)
+		if (copy_to_user((char __user *) data, &pos, sizeof(pos)) != 0) {
+			unlock_kernel();
 			return -EFAULT;
+		}
+		unlock_kernel();
 		return 0;
 	}
 	if (no == MTIOCGET) {
@@ -436,8 +446,10 @@ tapechar_ioctl(struct inode *inp, struct file *filp,
 		if (device->medium_state == MS_LOADED) {
 			rc = tape_mtop(device, MTTELL, 1);
 
-			if (rc < 0)
+			if (rc < 0) {
+				unlock_kernel();
 				return rc;
+			}
 
 			if (rc == 0)
 				get.mt_gstat |= GMT_BOT(~0);
@@ -445,15 +457,22 @@ tapechar_ioctl(struct inode *inp, struct file *filp,
 			get.mt_blkno = rc;
 		}
 
-		if (copy_to_user((char __user *) data, &get, sizeof(get)) != 0)
+		if (copy_to_user((char __user *) data, &get, sizeof(get)) != 0) {
+			unlock_kernel();
 			return -EFAULT;
+		}
 
+		unlock_kernel();
 		return 0;
 	}
 	/* Try the discipline ioctl function. */
-	if (device->discipline->ioctl_fn == NULL)
+	if (device->discipline->ioctl_fn == NULL) {
+		unlock_kernel();
 		return -EINVAL;
-	return device->discipline->ioctl_fn(device, no, data);
+	}
+	long ret = device->discipline->ioctl_fn(device, no, data);
+	unlock_kernel();
+	return ret;
 }
 
 static long
diff --git a/drivers/s390/char/vmwatchdog.c b/drivers/s390/char/vmwatchdog.c
index 21a2a82..de39c40 100644
--- a/drivers/s390/char/vmwatchdog.c
+++ b/drivers/s390/char/vmwatchdog.c
@@ -149,53 +149,70 @@ static struct watchdog_info vmwdt_info = {
 	.identity = "z/VM Watchdog Timer",
 };
 
-static int vmwdt_ioctl(struct inode *i, struct file *f,
-			  unsigned int cmd, unsigned long arg)
+static long vmwdt_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
+	lock_kernel();
+	long ret;
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
 		if (copy_to_user((void __user *)arg, &vmwdt_info,
 					sizeof(vmwdt_info)))
-			return -EFAULT;
-		return 0;
+			ret = -EFAULT;
+		else
+			ret = 0;
+		break;
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, (int __user *)arg);
+		ret = put_user(0, (int __user *)arg);
+		break;
 	case WDIOC_GETTEMP:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	case WDIOC_SETOPTIONS:
 		{
-			int options, ret;
-			if (get_user(options, (int __user *)arg))
-				return -EFAULT;
+			int options;
+			if (get_user(options, (int __user *)arg)) {
+				ret = -EFAULT;
+				break;
+			}
 			ret = -EINVAL;
 			if (options & WDIOS_DISABLECARD) {
 				ret = vmwdt_disable();
 				if (ret)
-					return ret;
+					break;
 			}
 			if (options & WDIOS_ENABLECARD) {
 				ret = vmwdt_keepalive();
 			}
-			return ret;
+			break;
 		}
 	case WDIOC_GETTIMEOUT:
-		return put_user(vmwdt_interval, (int __user *)arg);
+		ret = put_user(vmwdt_interval, (int __user *)arg);
+		break;
 	case WDIOC_SETTIMEOUT:
 		{
 			int interval;
-			if (get_user(interval, (int __user *)arg))
-				return -EFAULT;
-			if (interval < MIN_INTERVAL)
-				return -EINVAL;
+			if (get_user(interval, (int __user *)arg)) {
+				ret = -EFAULT;
+				break;
+			}
+			if (interval < MIN_INTERVAL) {
+				ret = -EINVAL;
+				break;
+			}
 			vmwdt_interval = interval;
 		}
-		return vmwdt_keepalive();
+		ret = vmwdt_keepalive();
+		break;
 	case WDIOC_KEEPALIVE:
-		return vmwdt_keepalive();
+		ret = vmwdt_keepalive();
+		break;
 	}
+	if(!ret)
+		ret = -EINVAL;
 
-	return -EINVAL;
+	unlock_kernel();
+	return ret;
 }
 
 static ssize_t vmwdt_write(struct file *f, const char __user *buf,
@@ -226,7 +243,7 @@ static ssize_t vmwdt_write(struct file *f, const char __user *buf,
 static const struct file_operations vmwdt_fops = {
 	.open    = &vmwdt_open,
 	.release = &vmwdt_close,
-	.ioctl   = &vmwdt_ioctl,
+	.unlocked_ioctl   = &vmwdt_ioctl,
 	.write   = &vmwdt_write,
 	.owner   = THIS_MODULE,
 };
-- 
1.6.2
