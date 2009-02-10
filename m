From: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: [Patch] [s390] Fix init irq proc build break.
Date: Tue, 10 Feb 2009 16:45:15 +0530
Message-ID: <499161C3.2070407@in.ibm.com>
References: <20090210194121.80256b72.sfr@canb.auug.org.au> <4991573C.8000609@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080908080101070106080007"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4991573C.8000609@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-s390.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080908080101070106080007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

* Embed init_irq_proc(s390) within CONFIG_PROC_FS to fix a build break.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

Thanks
-Sachin



--------------080908080101070106080007
Content-Type: text/x-patch;
 name="fix-init-irq-proc-build-break-on-s390.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-init-irq-proc-build-break-on-s390.patch"

* Embed init_irq_proc(s390) within CONFIG_PROC_FS to fix a build break.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
--- a/arch/s390/kernel/irq.c	2009-02-10 18:30:01.000000000 +0530
+++ b/arch/s390/kernel/irq.c	2009-02-10 19:01:44.000000000 +0530
@@ -95,6 +95,7 @@ asmlinkage void do_softirq(void)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_PROC_FS
 void init_irq_proc(void)
 {
 	struct proc_dir_entry *root_irq_dir;
@@ -102,3 +103,4 @@ void init_irq_proc(void)
 	root_irq_dir = proc_mkdir("irq", NULL);
 	create_prof_cpu_mask(root_irq_dir);
 }
+#endif

--------------080908080101070106080007--
