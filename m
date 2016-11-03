Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/25] s390/smp: Convert to hotplug state machine
Date: Thu,  3 Nov 2016 15:50:07 +0100
Message-Id: <20161103145021.28528-12-bigeasy@linutronix.de>
In-Reply-To: <20161103145021.28528-1-bigeasy@linutronix.de>
References: <20161103145021.28528-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

cpuhp_setup_state() invokes the startup callback on all online cpus with
the proper protection, so we can remove the cpu hotplug protection from the
init function and the creation of the per cpu files for online cpus in
smp_add_present_cpu(). smp_add_present_cpu() is called also called from
__smp_rescan_cpus(), but this callpath never adds an online cpu, it merily
adds newly present cpus, so the creation of the cpu files is not required.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/s390/kernel/smp.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 1a21e66c484a..b613aa989e40 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1047,23 +1047,18 @@ static struct attribute_group cpu_online_attr_group=
 =3D {
 	.attrs =3D cpu_online_attrs,
 };
=20
-static int smp_cpu_notify(struct notifier_block *self, unsigned long actio=
n,
-			  void *hcpu)
+static int smp_cpu_online(unsigned int cpu)
 {
-	unsigned int cpu =3D (unsigned int)(long)hcpu;
 	struct device *s =3D &per_cpu(cpu_device, cpu)->dev;
-	int err =3D 0;
=20
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_ONLINE:
-	case CPU_DOWN_FAILED:
-		err =3D sysfs_create_group(&s->kobj, &cpu_online_attr_group);
-		break;
-	case CPU_DOWN_PREPARE::
-		sysfs_remove_group(&s->kobj, &cpu_online_attr_group);
-		break;
-	}
-	return notifier_from_errno(err);
+	return sysfs_create_group(&s->kobj, &cpu_online_attr_group);
+}
+static int smp_cpu_pre_down(unsigned int cpu)
+{
+	struct device *s =3D &per_cpu(cpu_device, cpu)->dev;
+
+	sysfs_remove_group(&s->kobj, &cpu_online_attr_group);
+	return 0;
 }
=20
 static int smp_add_present_cpu(int cpu)
@@ -1084,20 +1079,13 @@ static int smp_add_present_cpu(int cpu)
 	rc =3D sysfs_create_group(&s->kobj, &cpu_common_attr_group);
 	if (rc)
 		goto out_cpu;
-	if (cpu_online(cpu)) {
-		rc =3D sysfs_create_group(&s->kobj, &cpu_online_attr_group);
-		if (rc)
-			goto out_online;
-	}
+
 	rc =3D topology_cpu_init(c);
 	if (rc)
 		goto out_topology;
 	return 0;
=20
 out_topology:
-	if (cpu_online(cpu))
-		sysfs_remove_group(&s->kobj, &cpu_online_attr_group);
-out_online:
 	sysfs_remove_group(&s->kobj, &cpu_common_attr_group);
 out_cpu:
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1150,17 +1138,15 @@ static int __init s390_smp_init(void)
 	if (rc)
 		return rc;
 #endif
-	cpu_notifier_register_begin();
 	for_each_present_cpu(cpu) {
 		rc =3D smp_add_present_cpu(cpu);
 		if (rc)
 			goto out;
 	}
=20
-	__hotcpu_notifier(smp_cpu_notify, 0);
-
+	rc =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "s390/smp:online",
+			       smp_cpu_online, smp_cpu_pre_down);
 out:
-	cpu_notifier_register_done();
 	return rc;
 }
 subsys_initcall(s390_smp_init);
--=20
2.10.2
