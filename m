Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110812134907.816664005@linux.vnet.ibm.com>
Date: Fri, 12 Aug 2011 15:48:55 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 6/8] s390: Do first kdump checksum test before really starting kdump
References: <20110812134849.748973593@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-arch-backend-entry.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: vgoyal@redhat.com
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

With this patch first the kdump checksums in purgatory are verified (with
start_kdump(0)) before kdump is started. This allows us to do the shutdown
actions defined under /sys/firmware as recovery action in case kdump is
overwritten. The main use case is to define stand-alone dump as recovery
action.

We have to split the purgatory function into "checksum test" and "real
execution", because we have to switch to the IPL CPU when we execute kdump.
After the switch it is not possible to return from the called function.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/kernel/machine_kexec.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -325,8 +325,16 @@ void machine_kexec(struct kimage *image)
 {
 	tracer_disable();
 #ifdef CONFIG_CRASH_DUMP
-	if (image->type == KEXEC_TYPE_CRASH)
+	if (image->type == KEXEC_TYPE_CRASH) {
+		int (*start_kdump)(int) = (void *)image->start;
+		int rc;
+		__arch_local_irq_stnsm(0xfb); /* disable DAT */
+		rc = start_kdump(0);
+		__arch_local_irq_stosm(0x04); /* enable DAT */
+		if (rc)
+			return;
 		smp_switch_to_ipl_cpu(__machine_kdump, image);
+	}
 #endif
 	smp_send_stop();
 	smp_switch_to_ipl_cpu(__machine_kexec, image);
