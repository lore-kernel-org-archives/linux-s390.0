Return-Path: <linux-kernel-owner+w=401wt.eu-S1753779AbYIILHP@vger.kernel.org>
Subject: [GIT PULL] 2.6.27-rc5 updates for s390
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Tue, 09 Sep 2008 12:51:35 +0200
Message-Id: <1220957495.1699.14.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

Three cio bug fixes and a CVE for a ptrace bug that can cause a kernel crash.

Cornelia Huck (2):
      [S390] cio: Correct cleanup on error.
      [S390] cio: handle ssch() return codes correctly.

Jarod Wilson (1):
      [S390] CVE-2008-1514: prevent ptrace padding area read/write in 31-bit mode

Peter Oberparleiter (1):
      [S390] cio: allow offline processing for disconnected devices

 arch/s390/kernel/compat_ptrace.h |    1 +
 arch/s390/kernel/ptrace.c        |   28 ++++++++++++++++++++++++++++
 drivers/s390/cio/chp.c           |    7 ++++---
 drivers/s390/cio/cio.c           |    4 +++-
 drivers/s390/cio/css.c           |   32 ++++++++++++++++++--------------
 drivers/s390/cio/device_fsm.c    |    7 +++++++
 6 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/compat_ptrace.h b/arch/s390/kernel/compat_ptrace.h
index cde81fa..a2be3a9 100644
--- a/arch/s390/kernel/compat_ptrace.h
+++ b/arch/s390/kernel/compat_ptrace.h
@@ -42,6 +42,7 @@ struct user_regs_struct32
 	u32 gprs[NUM_GPRS];
 	u32 acrs[NUM_ACRS];
 	u32 orig_gpr2;
+	/* nb: there's a 4-byte hole here */
 	s390_fp_regs fp_regs;
 	/*
 	 * These per registers are in here so that gdb can modify them
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 2815bfe..c8b0828 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -170,6 +170,13 @@ static unsigned long __peek_user(struct task_struct *child, addr_t addr)
 		 */
 		tmp = (addr_t) task_pt_regs(child)->orig_gpr2;
 
+	} else if (addr < (addr_t) &dummy->regs.fp_regs) {
+		/*
+		 * prevent reads of padding hole between
+		 * orig_gpr2 and fp_regs on s390.
+		 */
+		tmp = 0;
+
 	} else if (addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
 		/* 
 		 * floating point regs. are stored in the thread structure
@@ -270,6 +277,13 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 		 */
 		task_pt_regs(child)->orig_gpr2 = data;
 
+	} else if (addr < (addr_t) &dummy->regs.fp_regs) {
+		/*
+		 * prevent writes of padding hole between
+		 * orig_gpr2 and fp_regs on s390.
+		 */
+		return 0;
+
 	} else if (addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure
@@ -428,6 +442,13 @@ static u32 __peek_user_compat(struct task_struct *child, addr_t addr)
 		 */
 		tmp = *(__u32*)((addr_t) &task_pt_regs(child)->orig_gpr2 + 4);
 
+	} else if (addr < (addr_t) &dummy32->regs.fp_regs) {
+		/*
+		 * prevent reads of padding hole between
+		 * orig_gpr2 and fp_regs on s390.
+		 */
+		tmp = 0;
+
 	} else if (addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure 
@@ -514,6 +535,13 @@ static int __poke_user_compat(struct task_struct *child,
 		 */
 		*(__u32*)((addr_t) &task_pt_regs(child)->orig_gpr2 + 4) = tmp;
 
+	} else if (addr < (addr_t) &dummy32->regs.fp_regs) {
+		/*
+		 * prevent writess of padding hole between
+		 * orig_gpr2 and fp_regs on s390.
+		 */
+		return 0;
+
 	} else if (addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
 		 * floating point regs. are stored in the thread structure 
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index db00b05..f1216cf 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -423,7 +423,7 @@ int chp_new(struct chp_id chpid)
 	ret = sysfs_create_group(&chp->dev.kobj, &chp_attr_group);
 	if (ret) {
 		device_unregister(&chp->dev);
-		goto out_free;
+		goto out;
 	}
 	mutex_lock(&channel_subsystems[chpid.cssid]->mutex);
 	if (channel_subsystems[chpid.cssid]->cm_enabled) {
@@ -432,14 +432,15 @@ int chp_new(struct chp_id chpid)
 			sysfs_remove_group(&chp->dev.kobj, &chp_attr_group);
 			device_unregister(&chp->dev);
 			mutex_unlock(&channel_subsystems[chpid.cssid]->mutex);
-			goto out_free;
+			goto out;
 		}
 	}
 	channel_subsystems[chpid.cssid]->chps[chpid.id] = chp;
 	mutex_unlock(&channel_subsystems[chpid.cssid]->mutex);
-	return ret;
+	goto out;
 out_free:
 	kfree(chp);
+out:
 	return ret;
 }
 
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 33bff8f..5954b90 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -208,8 +208,10 @@ cio_start_key (struct subchannel *sch,	/* subchannel structure */
 	case 1:		/* status pending */
 	case 2:		/* busy */
 		return -EBUSY;
-	default:		/* device/path not operational */
+	case 3:		/* device/path not operational */
 		return cio_start_handle_notoper(sch, lpm);
+	default:
+		return ccode;
 	}
 }
 
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 51489ef..1261e1a 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -633,6 +633,11 @@ channel_subsystem_release(struct device *dev)
 
 	css = to_css(dev);
 	mutex_destroy(&css->mutex);
+	if (css->pseudo_subchannel) {
+		/* Implies that it has been generated but never registered. */
+		css_subchannel_release(&css->pseudo_subchannel->dev);
+		css->pseudo_subchannel = NULL;
+	}
 	kfree(css);
 }
 
@@ -785,11 +790,15 @@ init_channel_subsystem (void)
 		}
 		channel_subsystems[i] = css;
 		ret = setup_css(i);
-		if (ret)
-			goto out_free;
+		if (ret) {
+			kfree(channel_subsystems[i]);
+			goto out_unregister;
+		}
 		ret = device_register(&css->device);
-		if (ret)
-			goto out_free_all;
+		if (ret) {
+			put_device(&css->device);
+			goto out_unregister;
+		}
 		if (css_chsc_characteristics.secm) {
 			ret = device_create_file(&css->device,
 						 &dev_attr_cm_enable);
@@ -802,7 +811,7 @@ init_channel_subsystem (void)
 	}
 	ret = register_reboot_notifier(&css_reboot_notifier);
 	if (ret)
-		goto out_pseudo;
+		goto out_unregister;
 	css_init_done = 1;
 
 	/* Enable default isc for I/O subchannels. */
@@ -810,18 +819,12 @@ init_channel_subsystem (void)
 
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
-out_pseudo:
-	device_unregister(&channel_subsystems[i]->pseudo_subchannel->dev);
 out_file:
-	device_remove_file(&channel_subsystems[i]->device,
-			   &dev_attr_cm_enable);
+	if (css_chsc_characteristics.secm)
+		device_remove_file(&channel_subsystems[i]->device,
+				   &dev_attr_cm_enable);
 out_device:
 	device_unregister(&channel_subsystems[i]->device);
-out_free_all:
-	kfree(channel_subsystems[i]->pseudo_subchannel->lock);
-	kfree(channel_subsystems[i]->pseudo_subchannel);
-out_free:
-	kfree(channel_subsystems[i]);
 out_unregister:
 	while (i > 0) {
 		struct channel_subsystem *css;
@@ -829,6 +832,7 @@ out_unregister:
 		i--;
 		css = channel_subsystems[i];
 		device_unregister(&css->pseudo_subchannel->dev);
+		css->pseudo_subchannel = NULL;
 		if (css_chsc_characteristics.secm)
 			device_remove_file(&css->device,
 					   &dev_attr_cm_enable);
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 550508d..84cc9ea 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -658,6 +658,13 @@ ccw_device_offline(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
 
+	/* Allow ccw_device_offline while disconnected. */
+	if (cdev->private->state == DEV_STATE_DISCONNECTED ||
+	    cdev->private->state == DEV_STATE_NOT_OPER) {
+		cdev->private->flags.donotify = 0;
+		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
+		return 0;
+	}
 	if (ccw_device_is_orphan(cdev)) {
 		ccw_device_done(cdev, DEV_STATE_OFFLINE);
 		return 0;
