Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Dec 2010 10:18:27 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.37-rc5
Message-ID: <20101207101827.2c8d03ba@mschwide.boeblingen.de.ibm.com>
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

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Heiko Carstens (1):
      [S390] nohz/s390: fix arch_needs_cpu() return value on offline cpus

Sebastian Ott (1):
      [S390] css: fix rsid evaluation for 2nd crw

 arch/s390/kernel/vtime.c |   19 +++++++++++++++++++
 drivers/s390/cio/css.c   |    2 +-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 56c8687..7eff9b7 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -19,6 +19,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/rcupdate.h>
 #include <linux/posix-timers.h>
+#include <linux/cpu.h>
 
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
@@ -566,6 +567,23 @@ void init_cpu_vtimer(void)
 	__ctl_set_bit(0,10);
 }
 
+static int __cpuinit s390_nohz_notify(struct notifier_block *self,
+				      unsigned long action, void *hcpu)
+{
+	struct s390_idle_data *idle;
+	long cpu = (long) hcpu;
+
+	idle = &per_cpu(s390_idle, cpu);
+	switch (action) {
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		idle->nohz_delay = 0;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 void __init vtime_init(void)
 {
 	/* request the cpu timer external interrupt */
@@ -574,5 +592,6 @@ void __init vtime_init(void)
 
 	/* Enable cpu timer interrupts on the boot cpu. */
 	init_cpu_vtimer();
+	cpu_notifier(s390_nohz_notify, 0);
 }
 
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index a5050e2..825951b 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -635,7 +635,7 @@ static void css_process_crw(struct crw *crw0, struct crw *crw1, int overflow)
 	init_subchannel_id(&mchk_schid);
 	mchk_schid.sch_no = crw0->rsid;
 	if (crw1)
-		mchk_schid.ssid = (crw1->rsid >> 8) & 3;
+		mchk_schid.ssid = (crw1->rsid >> 4) & 3;
 
 	/*
 	 * Since we are always presented with IPI in the CRW, we have to
