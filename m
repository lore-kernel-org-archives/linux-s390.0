Return-Path: <linux-kernel-owner+w=401wt.eu-S1756532AbZJ3KEr@vger.kernel.org>
Date: Fri, 30 Oct 2009 11:04:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.32-rc5
Message-ID: <20091030110450.608a6671@mschwide.boeblingen.de.ibm.com>
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

the latest bug fixes for s390, please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Heiko Carstens (5):
      [S390] smp: fix prefix handling of offlined cpus
      [S390] call home: fix error handling in init function
      [S390] call home: fix string length handling
      [S390] smp: fix sigp stop handling
      [S390] smp: fix sigp sense handling

Martin Schwidefsky (2):
      [S390] s/r: cmm resume fix
      [S390] cputime: fix overflow on 31 bit systems

Sebastian Ott (1):
      [S390] call home: fix local buffer usage in proc handler

 arch/s390/include/asm/cputime.h |    6 ++--
 arch/s390/kernel/ipl.c          |    7 ++---
 arch/s390/kernel/smp.c          |    7 +++--
 arch/s390/kernel/swsusp_asm64.S |    2 +
 drivers/s390/char/sclp_async.c  |   47 +++++++++++++++------------------------
 drivers/s390/net/smsgiucv.c     |    7 +++++-
 6 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index 24b1244..f23961a 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -78,7 +78,7 @@ cputime64_to_jiffies64(cputime64_t cputime)
 static inline unsigned int
 cputime_to_msecs(const cputime_t cputime)
 {
-	return __div(cputime, 4096000);
+	return cputime_div(cputime, 4096000);
 }
 
 static inline cputime_t
@@ -160,7 +160,7 @@ cputime_to_timeval(const cputime_t cputime, struct timeval *value)
 static inline clock_t
 cputime_to_clock_t(cputime_t cputime)
 {
-	return __div(cputime, 4096000000ULL / USER_HZ);
+	return cputime_div(cputime, 4096000000ULL / USER_HZ);
 }
 
 static inline cputime_t
@@ -175,7 +175,7 @@ clock_t_to_cputime(unsigned long x)
 static inline clock_t
 cputime64_to_clock_t(cputime64_t cputime)
 {
-       return __div(cputime, 4096000000ULL / USER_HZ);
+       return cputime_div(cputime, 4096000000ULL / USER_HZ);
 }
 
 struct s390_idle_data {
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index ee57a42..4890ac6 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1595,10 +1595,9 @@ static void stop_run(struct shutdown_trigger *trigger)
 {
 	if (strcmp(trigger->name, ON_PANIC_STR) == 0)
 		disabled_wait((unsigned long) __builtin_return_address(0));
-	else {
-		signal_processor(smp_processor_id(), sigp_stop);
-		for (;;);
-	}
+	while (signal_processor(smp_processor_id(), sigp_stop) == sigp_busy)
+		cpu_relax();
+	for (;;);
 }
 
 static struct shutdown_action stop_action = {SHUTDOWN_ACTION_STOP_STR,
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index c932caa..93e5203 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -76,7 +76,6 @@ static int cpu_stopped(int cpu)
 	__u32 status;
 
 	switch (signal_processor_ps(&status, 0, cpu, sigp_sense)) {
-	case sigp_order_code_accepted:
 	case sigp_status_stored:
 		/* Check for stopped and check stop state */
 		if (status & 0x50)
@@ -638,6 +637,8 @@ void __cpu_die(unsigned int cpu)
 	/* Wait until target cpu is down */
 	while (!cpu_stopped(cpu))
 		cpu_relax();
+	while (signal_processor_p(0, cpu, sigp_set_prefix) == sigp_busy)
+		udelay(10);
 	smp_free_lowcore(cpu);
 	pr_info("Processor %d stopped\n", cpu);
 }
@@ -645,8 +646,8 @@ void __cpu_die(unsigned int cpu)
 void cpu_die(void)
 {
 	idle_task_exit();
-	signal_processor(smp_processor_id(), sigp_stop);
-	BUG();
+	while (signal_processor(smp_processor_id(), sigp_stop) == sigp_busy)
+		cpu_relax();
 	for (;;);
 }
 
diff --git a/arch/s390/kernel/swsusp_asm64.S b/arch/s390/kernel/swsusp_asm64.S
index 7c8653e..0c26cc1 100644
--- a/arch/s390/kernel/swsusp_asm64.S
+++ b/arch/s390/kernel/swsusp_asm64.S
@@ -199,6 +199,7 @@ pgm_check_entry:
 	brc	2,4b			/* busy, try again */
 5:
 	sigp	%r9,%r2,__SIGP_STOP	/* stop resume (current) CPU */
+	brc	2,5b			/* busy, try again */
 6:	j	6b
 
 restart_suspend:
@@ -206,6 +207,7 @@ restart_suspend:
 	llgh	%r2,0(%r1)
 7:
 	sigp	%r9,%r2,__SIGP_SENSE	/* Wait for resume CPU */
+	brc	8,7b			/* accepted, status 0, still running */
 	brc	2,7b			/* busy, try again */
 	tmll	%r9,0x40		/* Test if resume CPU is stopped */
 	jz	7b
diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
index a4f68e5..b44462a 100644
--- a/drivers/s390/char/sclp_async.c
+++ b/drivers/s390/char/sclp_async.c
@@ -26,7 +26,6 @@ static struct sclp_async_sccb *sccb;
 static int sclp_async_send_wait(char *message);
 static struct ctl_table_header *callhome_sysctl_header;
 static DEFINE_SPINLOCK(sclp_async_lock);
-static char nodename[64];
 #define SCLP_NORMAL_WRITE	0x00
 
 struct async_evbuf {
@@ -52,9 +51,10 @@ static struct sclp_register sclp_async_register = {
 static int call_home_on_panic(struct notifier_block *self,
 			      unsigned long event, void *data)
 {
-		strncat(data, nodename, strlen(nodename));
-		sclp_async_send_wait(data);
-		return NOTIFY_DONE;
+	strncat(data, init_utsname()->nodename,
+		sizeof(init_utsname()->nodename));
+	sclp_async_send_wait(data);
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block call_home_panic_nb = {
@@ -68,15 +68,14 @@ static int proc_handler_callhome(struct ctl_table *ctl, int write,
 {
 	unsigned long val;
 	int len, rc;
-	char buf[2];
+	char buf[3];
 
-	if (!*count | (*ppos && !write)) {
+	if (!*count || (*ppos && !write)) {
 		*count = 0;
 		return 0;
 	}
 	if (!write) {
-		len =  sprintf(buf, "%d\n", callhome_enabled);
-		buf[len] = '\0';
+		len = snprintf(buf, sizeof(buf), "%d\n", callhome_enabled);
 		rc = copy_to_user(buffer, buf, sizeof(buf));
 		if (rc != 0)
 			return -EFAULT;
@@ -171,39 +170,29 @@ static int __init sclp_async_init(void)
 	rc = sclp_register(&sclp_async_register);
 	if (rc)
 		return rc;
-	callhome_sysctl_header = register_sysctl_table(kern_dir_table);
-	if (!callhome_sysctl_header) {
-		rc = -ENOMEM;
-		goto out_sclp;
-	}
-	if (!(sclp_async_register.sclp_receive_mask & EVTYP_ASYNC_MASK)) {
-		rc = -EOPNOTSUPP;
+	rc = -EOPNOTSUPP;
+	if (!(sclp_async_register.sclp_receive_mask & EVTYP_ASYNC_MASK))
 		goto out_sclp;
-	}
 	rc = -ENOMEM;
+	callhome_sysctl_header = register_sysctl_table(kern_dir_table);
+	if (!callhome_sysctl_header)
+		goto out_sclp;
 	request = kzalloc(sizeof(struct sclp_req), GFP_KERNEL);
-	if (!request)
-		goto out_sys;
 	sccb = (struct sclp_async_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
-	if (!sccb)
+	if (!request || !sccb)
 		goto out_mem;
-	rc =  atomic_notifier_chain_register(&panic_notifier_list,
-					     &call_home_panic_nb);
-	if (rc)
-		goto out_mem;
-
-	strncpy(nodename, init_utsname()->nodename, 64);
-	return 0;
-
+	rc = atomic_notifier_chain_register(&panic_notifier_list,
+					    &call_home_panic_nb);
+	if (!rc)
+		goto out;
 out_mem:
 	kfree(request);
 	free_page((unsigned long) sccb);
-out_sys:
 	unregister_sysctl_table(callhome_sysctl_header);
 out_sclp:
 	sclp_unregister(&sclp_async_register);
+out:
 	return rc;
-
 }
 module_init(sclp_async_init);
 
diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
index 102000d..3012355 100644
--- a/drivers/s390/net/smsgiucv.c
+++ b/drivers/s390/net/smsgiucv.c
@@ -158,7 +158,12 @@ static int smsg_pm_restore_thaw(struct device *dev)
 		smsg_path->flags = 0;
 		rc = iucv_path_connect(smsg_path, &smsg_handler, "*MSG    ",
 				       NULL, NULL, NULL);
-		printk(KERN_ERR "iucv_path_connect returned with rc %i\n", rc);
+#ifdef CONFIG_PM_DEBUG
+		if (rc)
+			printk(KERN_ERR
+			       "iucv_path_connect returned with rc %i\n", rc);
+#endif
+		cpcmd("SET SMSG IUCV", NULL, 0, NULL);
 	}
 	return 0;
 }
