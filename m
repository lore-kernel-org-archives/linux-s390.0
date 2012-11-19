From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:23:47 +0000
Subject: [PATCH 278/493] s390: remove use of __devinit
Message-Id: <1353349642-3677-278-git-send-email-wfp5p@virginia.edu>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-s390@vger.kernel.org 
---
 arch/s390/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index ea431e5..ca9ea40 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -623,9 +623,9 @@ static struct sclp_cpu_info *smp_get_cpu_info(void)
 	return info;
 }
 
-static int __devinit smp_add_present_cpu(int cpu);
+static int smp_add_present_cpu(int cpu);
 
-static int __devinit __smp_rescan_cpus(struct sclp_cpu_info *info,
+static int __smp_rescan_cpus(struct sclp_cpu_info *info,
 				       int sysfs_add)
 {
 	struct pcpu *pcpu;
@@ -986,7 +986,7 @@ static int __cpuinit smp_cpu_notify(struct notifier_block *self,
 	return notifier_from_errno(err);
 }
 
-static int __devinit smp_add_present_cpu(int cpu)
+static int smp_add_present_cpu(int cpu)
 {
 	struct cpu *c = &pcpu_devices[cpu].cpu;
 	struct device *s = &c->dev;
-- 
1.8.0
