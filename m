Return-Path: <linux-kernel-owner+w=401wt.eu-S1760507AbXJDLel@vger.kernel.org>
Message-Id: <20071004112829.257682953@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/34] appldata_base: Misc cpuinit annotations and bugfix
Content-Disposition: inline; filename=017-appldata-cpuinit.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Satyam Sharma <satyam@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Satyam Sharma <satyam@infradead.org>

appldata_offline_cpu() is only called from __cpuinit-marked hotplug
notifier callback and from the __exit-marked module_exit function,
therefore candidate for __cpuexit.

BTW the __exit module_exit function appldata_exit() of this driver fails to
unregister_hotcpu_notifier() the notifier_block that was registered by
appldata_init() during module startup.  This will lead to oops if hotplug
notification comes after module has been unloaded.  Let's fix this by
unregistering the notifier appropriately (before appldata_offline_cpu()'ing
the CPUs).

Signed-off-by: Satyam Sharma <satyam@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c
+++ quilt-2.6/arch/s390/appldata/appldata_base.c
@@ -547,8 +547,7 @@ static void __cpuinit appldata_online_cp
 	spin_unlock(&appldata_timer_lock);
 }
 
-static void
-appldata_offline_cpu(int cpu)
+static void __cpuexit appldata_offline_cpu(int cpu)
 {
 	del_virt_timer(&per_cpu(appldata_timer, cpu));
 	if (atomic_dec_and_test(&appldata_expire_count)) {
@@ -560,9 +559,9 @@ appldata_offline_cpu(int cpu)
 	spin_unlock(&appldata_timer_lock);
 }
 
-static int __cpuinit
-appldata_cpu_notify(struct notifier_block *self,
-		    unsigned long action, void *hcpu)
+static int __cpuinit appldata_cpu_notify(struct notifier_block *self,
+					 unsigned long action,
+					 void *hcpu)
 {
 	switch (action) {
 	case CPU_ONLINE:
@@ -646,6 +645,8 @@ static void __exit appldata_exit(void)
 	}
 	spin_unlock(&appldata_ops_lock);
 
+	unregister_hotcpu_notifier(&appldata_nb);
+
 	for_each_online_cpu(i)
 		appldata_offline_cpu(i);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
