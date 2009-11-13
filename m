Return-Path: <linux-kernel-owner+w=401wt.eu-S1755644AbZKMOxs@vger.kernel.org>
Date: Fri, 13 Nov 2009 15:53:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.32-rc7
Message-ID: <20091113155349.37d8be88@mschwide.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

another 4 s390 bug fixes for 2.6.32.
Please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Christian Borntraeger (1):
      [S390] s390: fix single stepping on svc0

Gerald Schaefer (1):
      [S390] monreader: fix use after free bug with suspend/resume

Martin Schwidefsky (2):
      [S390] reset cputime accounting after IPL from NSS
      [S390] sclp: undo quiesce handler override on resume

 arch/s390/kernel/early.c         |    9 +++++++
 arch/s390/kernel/entry.S         |    8 +++---
 arch/s390/kernel/entry64.S       |    8 +++---
 drivers/s390/char/monreader.c    |    1 +
 drivers/s390/char/sclp_quiesce.c |   48 ++++++++++++++++++++++++++++++--------
 5 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index bf8b4ae..e49e9e0 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -55,6 +55,7 @@ static void __init reset_tod_clock(void)
 		disabled_wait(0);
 
 	sched_clock_base_cc = TOD_UNIX_EPOCH;
+	S390_lowcore.last_update_clock = sched_clock_base_cc;
 }
 
 #ifdef CONFIG_SHARED_KERNEL
@@ -167,6 +168,14 @@ static noinline __init void create_kernel_nss(void)
 		return;
 	}
 
+	/* re-initialize cputime accounting. */
+	sched_clock_base_cc = get_clock();
+	S390_lowcore.last_update_clock = sched_clock_base_cc;
+	S390_lowcore.last_update_timer = 0x7fffffffffffffffULL;
+	S390_lowcore.user_timer = 0;
+	S390_lowcore.system_timer = 0;
+	asm volatile("SPT 0(%0)" : : "a" (&S390_lowcore.last_update_timer));
+
 	/* re-setup boot command line with new ipl vm parms */
 	ipl_update_parameters();
 	setup_boot_command_line();
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index f43d2ee..48215d1 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -565,10 +565,10 @@ pgm_svcper:
 	lh	%r7,0x8a		# get svc number from lowcore
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	TRACE_IRQS_OFF
-	l	%r1,__TI_task(%r9)
-	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
-	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
-	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
+	l	%r8,__TI_task(%r9)
+	mvc	__THREAD_per+__PER_atmid(2,%r8),__LC_PER_ATMID
+	mvc	__THREAD_per+__PER_address(4,%r8),__LC_PER_ADDRESS
+	mvc	__THREAD_per+__PER_access_id(1,%r8),__LC_PER_ACCESS_ID
 	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
 	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index a6f7b20..9aff1d4 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -543,10 +543,10 @@ pgm_svcper:
 	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
 	llgh	%r7,__LC_SVC_INT_CODE	# get svc number from lowcore
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
-	lg	%r1,__TI_task(%r9)
-	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
-	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
-	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
+	lg	%r8,__TI_task(%r9)
+	mvc	__THREAD_per+__PER_atmid(2,%r8),__LC_PER_ATMID
+	mvc	__THREAD_per+__PER_address(8,%r8),__LC_PER_ADDRESS
+	mvc	__THREAD_per+__PER_access_id(1,%r8),__LC_PER_ACCESS_ID
 	oi	__TI_flags+7(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
 	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
diff --git a/drivers/s390/char/monreader.c b/drivers/s390/char/monreader.c
index 89ece1c..66e21dd 100644
--- a/drivers/s390/char/monreader.c
+++ b/drivers/s390/char/monreader.c
@@ -357,6 +357,7 @@ static int mon_close(struct inode *inode, struct file *filp)
 	atomic_set(&monpriv->msglim_count, 0);
 	monpriv->write_index  = 0;
 	monpriv->read_index   = 0;
+	dev_set_drvdata(monreader_device, NULL);
 
 	for (i = 0; i < MON_MSGLIM; i++)
 		kfree(monpriv->msg_array[i]);
diff --git a/drivers/s390/char/sclp_quiesce.c b/drivers/s390/char/sclp_quiesce.c
index 84c191c..05909a7 100644
--- a/drivers/s390/char/sclp_quiesce.c
+++ b/drivers/s390/char/sclp_quiesce.c
@@ -20,9 +20,12 @@
 
 #include "sclp.h"
 
+static void (*old_machine_restart)(char *);
+static void (*old_machine_halt)(void);
+static void (*old_machine_power_off)(void);
+
 /* Shutdown handler. Signal completion of shutdown by loading special PSW. */
-static void
-do_machine_quiesce(void)
+static void do_machine_quiesce(void)
 {
 	psw_t quiesce_psw;
 
@@ -33,23 +36,48 @@ do_machine_quiesce(void)
 }
 
 /* Handler for quiesce event. Start shutdown procedure. */
-static void
-sclp_quiesce_handler(struct evbuf_header *evbuf)
+static void sclp_quiesce_handler(struct evbuf_header *evbuf)
 {
-	_machine_restart = (void *) do_machine_quiesce;
-	_machine_halt = do_machine_quiesce;
-	_machine_power_off = do_machine_quiesce;
+	if (_machine_restart != (void *) do_machine_quiesce) {
+		old_machine_restart = _machine_restart;
+		old_machine_halt = _machine_halt;
+		old_machine_power_off = _machine_power_off;
+		_machine_restart = (void *) do_machine_quiesce;
+		_machine_halt = do_machine_quiesce;
+		_machine_power_off = do_machine_quiesce;
+	}
 	ctrl_alt_del();
 }
 
+/* Undo machine restart/halt/power_off modification on resume */
+static void sclp_quiesce_pm_event(struct sclp_register *reg,
+				  enum sclp_pm_event sclp_pm_event)
+{
+	switch (sclp_pm_event) {
+	case SCLP_PM_EVENT_RESTORE:
+		if (old_machine_restart) {
+			_machine_restart = old_machine_restart;
+			_machine_halt = old_machine_halt;
+			_machine_power_off = old_machine_power_off;
+			old_machine_restart = NULL;
+			old_machine_halt = NULL;
+			old_machine_power_off = NULL;
+		}
+		break;
+	case SCLP_PM_EVENT_FREEZE:
+	case SCLP_PM_EVENT_THAW:
+		break;
+	}
+}
+
 static struct sclp_register sclp_quiesce_event = {
 	.receive_mask = EVTYP_SIGQUIESCE_MASK,
-	.receiver_fn = sclp_quiesce_handler
+	.receiver_fn = sclp_quiesce_handler,
+	.pm_event_fn = sclp_quiesce_pm_event
 };
 
 /* Initialize quiesce driver. */
-static int __init
-sclp_quiesce_init(void)
+static int __init sclp_quiesce_init(void)
 {
 	return sclp_register(&sclp_quiesce_event);
 }
