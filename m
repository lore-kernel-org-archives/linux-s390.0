Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/25] s390/smp: Make cpu notifier symetric
Date: Thu,  3 Nov 2016 15:50:06 +0100
Message-Id: <20161103145021.28528-11-bigeasy@linutronix.de>
In-Reply-To: <20161103145021.28528-1-bigeasy@linutronix.de>
References: <20161103145021.28528-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Thomas Gleixner <tglx@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason to remove the sysfs cpu files when the CPU is dead, they
can be removed when the cpu is prepared to go down. Doing it at
DOWN_PREPARE allows us to convert it to a symetric hotplug state in the
next step.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/s390/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 35531fe1c5ea..1a21e66c484a 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1056,9 +1056,10 @@ static int smp_cpu_notify(struct notifier_block *sel=
f, unsigned long action,
=20
 	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_ONLINE:
+	case CPU_DOWN_FAILED:
 		err =3D sysfs_create_group(&s->kobj, &cpu_online_attr_group);
 		break;
-	case CPU_DEAD:
+	case CPU_DOWN_PREPARE::
 		sysfs_remove_group(&s->kobj, &cpu_online_attr_group);
 		break;
 	}
--=20
2.10.2
