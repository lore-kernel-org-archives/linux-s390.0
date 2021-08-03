Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686A4C432BE
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D18160BD3
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 14:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhHCORS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:17:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbhHCORR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Aug 2021 10:17:17 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uaki9fQLj1MkzriRH3NHbpRwMmzcJeDXfssyd8zuEL8=;
        b=jTpIscGhO1q1MqzCg/lGFpXa0f2WnTrlFD2fGlSMBNGkKAJOrbXKxYEz8kUP+011c/tv+T
        evrt/I+nnXE9jNB8+NgMuEAqGuIrLUTVl+r9X+nIiRBHjGHRjGucyk4JKAerZhu55Bh3J/
        LSecTW9WsD70fTuN73Ios0hH0BnYz+ISmqAmh+YGYfw8GrlyPqdj0qwTVpLBcJCMl7POc9
        t96wUWHk+Uk+4HSEZyQagZ7O+IPCUURPN+HnF7owkJycL8lpMUiC3ROUzHHsbhTy1GisAd
        aKpF3hu3HPnsqte+pcAF9gctwTds/gTX8e4eUwrRJKu4YLxIaGp5Mcmw32+tBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uaki9fQLj1MkzriRH3NHbpRwMmzcJeDXfssyd8zuEL8=;
        b=L1FswKe+W/s5X2YasHc3pAv8CcS+EfMoNt1AS4HiYEpY2uukc4icAHmZkQWmOaB2hZ+NjD
        xNLlu9yKnMb6f0Cw==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 04/38] s390: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:47 +0200
Message-Id: <20210803141621.780504-5-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/s390/hypfs/hypfs_diag0c.c  | 10 +++++-----
 arch/s390/kernel/diag.c         |  4 ++--
 arch/s390/kernel/irq.c          |  4 ++--
 arch/s390/kernel/perf_cpum_cf.c |  4 ++--
 arch/s390/kernel/processor.c    |  4 ++--
 arch/s390/kernel/smp.c          |  8 ++++----
 arch/s390/kernel/topology.c     |  4 ++--
 arch/s390/mm/maccess.c          |  4 ++--
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag0c.c b/arch/s390/hypfs/hypfs_diag0c.c
index 6c43d2ba20797..5cd3d8478ac18 100644
--- a/arch/s390/hypfs/hypfs_diag0c.c
+++ b/arch/s390/hypfs/hypfs_diag0c.c
@@ -33,12 +33,12 @@ static void *diag0c_store(unsigned int *count)
 	unsigned int cpu_count, cpu, i;
 	void **cpu_vec;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	cpu_count =3D num_online_cpus();
 	cpu_vec =3D kmalloc_array(num_possible_cpus(), sizeof(*cpu_vec),
 				GFP_KERNEL);
 	if (!cpu_vec)
-		goto fail_put_online_cpus;
+		goto fail_unlock_cpus;
 	/* Note: Diag 0c needs 8 byte alignment and real storage */
 	diag0c_data =3D kzalloc(struct_size(diag0c_data, entry, cpu_count),
 			      GFP_KERNEL | GFP_DMA);
@@ -54,13 +54,13 @@ static void *diag0c_store(unsigned int *count)
 	on_each_cpu(diag0c_fn, cpu_vec, 1);
 	*count =3D cpu_count;
 	kfree(cpu_vec);
-	put_online_cpus();
+	cpus_read_unlock();
 	return diag0c_data;
=20
 fail_kfree_cpu_vec:
 	kfree(cpu_vec);
-fail_put_online_cpus:
-	put_online_cpus();
+fail_unlock_cpus:
+	cpus_read_unlock();
 	return ERR_PTR(-ENOMEM);
 }
=20
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index a3f47464c3f17..4c2ac7ceef94a 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -59,7 +59,7 @@ static int show_diag_stat(struct seq_file *m, void *v)
 	unsigned long n =3D (unsigned long) v - 1;
 	int cpu, prec, tmp;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	if (n =3D=3D 0) {
 		seq_puts(m, "         ");
=20
@@ -78,7 +78,7 @@ static int show_diag_stat(struct seq_file *m, void *v)
 		}
 		seq_printf(m, "    %s\n", diag_map[n-1].name);
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 	return 0;
 }
=20
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 234d085257eb1..3a3145c4a3ba4 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -228,7 +228,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	int index =3D *(loff_t *) v;
 	int cpu, irq;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	if (index =3D=3D 0) {
 		seq_puts(p, "           ");
 		for_each_online_cpu(cpu)
@@ -258,7 +258,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 	}
 out:
-	put_online_cpus();
+	cpus_read_unlock();
 	return 0;
 }
=20
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_c=
f.c
index d7dc36ec0a60e..2e3bb633acf6c 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1138,7 +1138,7 @@ static long cfset_ioctl(struct file *file, unsigned i=
nt cmd, unsigned long arg)
 {
 	int ret;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&cfset_ctrset_mutex);
 	switch (cmd) {
 	case S390_HWCTR_START:
@@ -1155,7 +1155,7 @@ static long cfset_ioctl(struct file *file, unsigned i=
nt cmd, unsigned long arg)
 		break;
 	}
 	mutex_unlock(&cfset_ctrset_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 	return ret;
 }
=20
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 82df39b17bb55..d8089a79b3f65 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -210,7 +210,7 @@ static inline void *c_update(loff_t *pos)
=20
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	get_online_cpus();
+	cpus_read_lock();
 	return c_update(pos);
 }
=20
@@ -222,7 +222,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t=
 *pos)
=20
 static void c_stop(struct seq_file *m, void *v)
 {
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 const struct seq_operations cpuinfo_op =3D {
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 8984711f72ede..b18cab79c370a 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -793,7 +793,7 @@ static int __smp_rescan_cpus(struct sclp_core_info *inf=
o, bool early)
 	u16 core_id;
 	int nr, i;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smp_cpu_state_mutex);
 	nr =3D 0;
 	cpumask_xor(&avail, cpu_possible_mask, cpu_present_mask);
@@ -816,7 +816,7 @@ static int __smp_rescan_cpus(struct sclp_core_info *inf=
o, bool early)
 		nr +=3D smp_add_core(&info->core[i], &avail, configured, early);
 	}
 	mutex_unlock(&smp_cpu_state_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 	return nr;
 }
=20
@@ -1055,7 +1055,7 @@ static ssize_t cpu_configure_store(struct device *dev,
 		return -EINVAL;
 	if (val !=3D 0 && val !=3D 1)
 		return -EINVAL;
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smp_cpu_state_mutex);
 	rc =3D -EBUSY;
 	/* disallow configuration changes of online cpus and cpu 0 */
@@ -1104,7 +1104,7 @@ static ssize_t cpu_configure_store(struct device *dev,
 	}
 out:
 	mutex_unlock(&smp_cpu_state_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 	return rc ? rc : count;
 }
 static DEVICE_ATTR(configure, 0644, cpu_configure_show, cpu_configure_stor=
e);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 26aa2614ee352..d2458a29618fa 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -406,7 +406,7 @@ static ssize_t dispatching_store(struct device *dev,
 	if (val !=3D 0 && val !=3D 1)
 		return -EINVAL;
 	rc =3D 0;
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smp_cpu_state_mutex);
 	if (cpu_management =3D=3D val)
 		goto out;
@@ -417,7 +417,7 @@ static ssize_t dispatching_store(struct device *dev,
 	topology_expect_change();
 out:
 	mutex_unlock(&smp_cpu_state_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 	return rc ? rc : count;
 }
 static DEVICE_ATTR_RW(dispatching);
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index a0f54bd5e98ab..9663ce3625bcd 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -228,7 +228,7 @@ void *xlate_dev_mem_ptr(phys_addr_t addr)
 	void *bounce =3D (void *) addr;
 	unsigned long size;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	preempt_disable();
 	if (is_swapped(addr)) {
 		size =3D PAGE_SIZE - (addr & ~PAGE_MASK);
@@ -237,7 +237,7 @@ void *xlate_dev_mem_ptr(phys_addr_t addr)
 			memcpy_absolute(bounce, (void *) addr, size);
 	}
 	preempt_enable();
-	put_online_cpus();
+	cpus_read_unlock();
 	return bounce;
 }
=20
--=20
2.32.0

