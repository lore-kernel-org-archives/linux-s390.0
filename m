Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535B450917;
	Fri, 16 Oct 2026 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144802; cv=none; b=cbNn+Pncp6uO0CwHllYQU0f75ZulaQ/h7BSFItn4pQh/BIm0cb1vgtKDCwTeptV5CUhwMao9XVhmdcbJ/EMT9Glz3dgkxGBeQnfyZT/q5evuVCnaE6rrcCdptxjbfpQpzhf0w4xCYbJ7nUjNRS62XtAIsXzdqgdXuJFcVMx/H2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144802; c=relaxed/simple;
	bh=CKj8pg5pD0CV12I761oL5c+eI8DxTIQfvceplwjqP8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=On3o0BIbh9xZmbkpti0WaMuAB4Lh4vqI9UGaTAVp8n/wk/Oll7b66VBHseFoaSDb2VZZE6TeHLisMJo4pbpr64MZt9nM+Bike//PMSOgv1qYhvqKafDTX2iIbW68/RAhE+GBg83Xqpr7WgTmURy/wNb+3lQ6j5TPsmq+byOi0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GYXjmrv3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GYXjmrv3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G9Z4WQ3000591;
	Fri, 16 Oct 2026 09:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xvJwv3pA4begPR69A5CKA7e8Cvo9Y09czqcNKQRYg
	44=; b=GYXjmrv35nJ8QNbSpG1xFT94WLiXppQqeo6r9qCkipZVfCdwSNZrN6x2Z
	ik3Oa6JvOZtZYy6q7NzK+z83JjoXEYvwMdoT62iilGTs+bYAJv7Zrqm7Pip11qAF
	/JvxdLFx/+ksm6LLW2dx5Z4Q5RVkUmu2n7KJtFQI83oCXd5wVYg8A6WxWkO/sYup
	aLChYKAZOXsXN0v9X01kqN0L+/g1GaJCNfNsaRPlmHHe3A3b+0xtloOtuZrrCYeT
	oyqb9GXh7ZZMRMLnEay/vG6F4geTy1Aygzld/+CgxMv6h7jUcC8640pvdGaRb1HH
	jad3W4SXRKmGLVRnD0UF3IphiWbBg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhxnfq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 09:58:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69G61OW92057774;
	Fri, 16 Oct 2026 09:58:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hawqwva24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 09:58:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69G9wbec44564932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 09:58:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8506C20040;
	Fri, 16 Oct 2026 09:58:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BCA22004D;
	Fri, 16 Oct 2026 09:58:26 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.124.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 09:58:26 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Scott Wood <oss@buserror.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        mrigendrachaubey <mrigendra.chaubey@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Pengjie Zhang <zhangpengjie2@huawei.com>,
        Thierry Reding <treding@nvidia.com>, Xi Ruoyao <xry111@xry111.site>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Rong Bao <rong.bao@csmantle.top>,
        Hui Wang <hui.wang@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH] sched/hotplug: Remove unused idle_task_exit
Date: Fri, 16 Oct 2026 15:26:40 +0530
Message-ID: <20261016095711.1364609-1-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzOCBTYWx0ZWRfX2LzCHajlMKu+
 WDtTDJv54Iv9QPqy8eXThgjll9cI6vk98Xia7sNQNzLz0iA9UQMxo9T4JDrtlaySjak8f2UjSEd
 Man6OOgM5+Hl7tROJSddQ5/YcpqKA64=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzOCBTYWx0ZWRfXxPVaXQpsBLnv
 6z+C5BHGYHI7dsBwmDBM7/aw3OFa9cQce3YujqdLd85f16xLKUYwqaqmo2cRYCGuXDO87Uz+20s
 GFOYucFhskUW1bJQ/nml9hw87uMMdArZSMfkYs86RYMSw1rLxdVMX0Mgdl4ak2LTC/HEEpiYHeM
 W3LSMj/37aDwUPliZ6l0P+Ho7epMe8j60+Ajf4lhXY88Ms3n/d+UfVRhl7AuEDr1/IvaX4Bkfv0
 TU+z2Sy1Ym1uEeHEJWE/P0MkRy1KTtClq0VEw7vbH1fcxyuc1BuJlTFMi99tofcDkT9ByaV23/f
 +2uo34MZtiBitJu9YAuYqmyPjZIfG2eKw6EKwgjdU4OIxbEoE7jOJuOHIcalYMXqxSGF5hf4z6N
 /b2aspsLLa+QAnBGfDztKC2GwvGrPFe/+wibZU4+n/NSICd48Vpplx1tsG/nMJYbetSXxa/HwUB
 L0I90BLIf9qGK21rN0A==
X-Proofpoint-GUID: IL0R-bRx5Zo-CVHUKEE0Opykcs2lTHKR
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad1f553 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jggbHb6qoK4FGpBOhhEA:9
X-Proofpoint-ORIG-GUID: 2M4W7yLkiR76qY99sAmf4huQ0PRMzNDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160038

Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
idle_task_exit() into the scheduler CPU hotplug path using
sched_force_init_mm().

As a result, idle_task_exit() is now an empty stub and the remaining
architecture call sites have no effect.

Remove the calls to idle_task_exit() and the now unused stub.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/arm/kernel/smp.c                        | 2 --
 arch/arm64/kernel/smp.c                      | 2 --
 arch/csky/kernel/smp.c                       | 2 --
 arch/loongarch/kernel/smp.c                  | 2 --
 arch/mips/cavium-octeon/smp.c                | 1 -
 arch/mips/kernel/smp-bmips.c                 | 1 -
 arch/mips/kernel/smp-cps.c                   | 1 -
 arch/mips/loongson64/smp.c                   | 1 -
 arch/parisc/kernel/process.c                 | 2 --
 arch/powerpc/platforms/85xx/smp.c            | 2 --
 arch/powerpc/platforms/powermac/smp.c        | 2 --
 arch/powerpc/platforms/powernv/smp.c         | 1 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 --
 arch/powerpc/platforms/pseries/pmem.c        | 1 -
 arch/riscv/kernel/cpu-hotplug.c              | 2 --
 arch/s390/kernel/smp.c                       | 1 -
 arch/sh/kernel/smp.c                         | 1 -
 arch/sparc/kernel/smp_64.c                   | 2 --
 arch/x86/kernel/smpboot.c                    | 2 --
 arch/xtensa/kernel/smp.c                     | 1 -
 include/linux/sched/hotplug.h                | 2 --
 21 files changed, 33 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b5fb4697bc3f..bbfbbe728b7a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -319,8 +319,6 @@ void __noreturn arch_cpu_idle_dead(void)
 {
 	unsigned int cpu = smp_processor_id();
 
-	idle_task_exit();
-
 	local_irq_disable();
 
 	/*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a61dc3016a11..afb5aa65d737 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -370,8 +370,6 @@ void __noreturn cpu_die(void)
 	unsigned int cpu = smp_processor_id();
 	const struct cpu_operations *ops = get_cpu_ops(cpu);
 
-	idle_task_exit();
-
 	local_daif_mask();
 
 	/* Tell cpuhp_bp_sync_dead() that this CPU is now safe to dispose of */
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 92dbbf3e0205..e6333ccc335a 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -294,8 +294,6 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 
 void __noreturn arch_cpu_idle_dead(void)
 {
-	idle_task_exit();
-
 	cpuhp_ap_report_dead();
 
 	while (!secondary_stack)
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 11f54837f56c..6b21af1c25e0 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -478,7 +478,6 @@ static void __noreturn idle_play_dead(void)
 	register uint64_t addr;
 	register void (*init_fn)(void);
 
-	idle_task_exit();
 	local_irq_enable();
 	set_csr_ecfg(ECFGF_IPI);
 	__this_cpu_write(cpu_state, CPU_DEAD);
@@ -503,7 +502,6 @@ static void __noreturn poll_play_dead(void)
 	register uint64_t addr;
 	register void (*init_fn)(void);
 
-	idle_task_exit();
 	__this_cpu_write(cpu_state, CPU_DEAD);
 
 	__smp_mb();
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 054e331b3202..0e557e76d616 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -344,7 +344,6 @@ void play_dead(void)
 {
 	int cpu = cpu_number_map(cvmx_get_core_num());
 
-	idle_task_exit();
 	cpuhp_ap_report_dead();
 	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 35b8d810833c..e4a523b7c988 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -391,7 +391,6 @@ static void bmips_cpu_die(unsigned int cpu)
 
 void __ref play_dead(void)
 {
-	idle_task_exit();
 	cpuhp_ap_report_dead();
 
 	/* flush data cache */
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index b01ebaace48e..51e68a42bcc8 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -804,7 +804,6 @@ void play_dead(void)
 	unsigned int cpu;
 
 	local_irq_disable();
-	idle_task_exit();
 	cpu = smp_processor_id();
 	cpu_death = CPU_DEATH_POWER;
 
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index e584299d0fde..73eca9c44b04 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -766,7 +766,6 @@ void play_dead(void)
 	unsigned int cpu = smp_processor_id();
 	void (*play_dead_at_ckseg1)(int *);
 
-	idle_task_exit();
 	cpuhp_ap_report_dead();
 
 	prid_imp = read_c0_prid() & PRID_IMP_MASK;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 703644e5bfc4..8606ecde4c30 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -164,8 +164,6 @@ EXPORT_SYMBOL(running_on_qemu);
 void __noreturn arch_cpu_idle_dead(void)
 {
 #ifdef CONFIG_HOTPLUG_CPU
-	idle_task_exit();
-
 	local_irq_disable();
 
 	/* Tell the core that this CPU is now safe to dispose of. */
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 32fa5fb557c0..9dc81e4226f0 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -121,8 +121,6 @@ static void smp_85xx_cpu_offline_self(void)
 	/* mask all irqs to prevent cpu wakeup */
 	qoriq_pm_ops->irq_mask(cpu);
 
-	idle_task_exit();
-
 	mtspr(SPRN_TCR, 0);
 	mtspr(SPRN_TSR, mfspr(SPRN_TSR));
 
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 88e92af8acf9..f8e674cfcdd7 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -925,7 +925,6 @@ static void pmac_cpu_offline_self(void)
 	int cpu = smp_processor_id();
 
 	local_irq_disable();
-	idle_task_exit();
 	pr_debug("CPU%d offline\n", cpu);
 	generic_set_cpu_dead(cpu);
 	smp_wmb();
@@ -940,7 +939,6 @@ static void pmac_cpu_offline_self(void)
 	int cpu = smp_processor_id();
 
 	local_irq_disable();
-	idle_task_exit();
 
 	/*
 	 * turn off as much as possible, we'll be
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index b1201dbafcaf..9a480c924020 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -172,7 +172,6 @@ static void pnv_cpu_offline_self(void)
 
 	/* Standard hot unplug procedure */
 
-	idle_task_exit();
 	cpu = smp_processor_id();
 	DBG("CPU%d offline\n", cpu);
 	generic_set_cpu_dead(cpu);
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index bc6926dbf148..1ade9a811157 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/sched.h>	/* for idle_task_exit */
 #include <linux/sched/hotplug.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
@@ -64,7 +63,6 @@ static void pseries_cpu_offline_self(void)
 	unsigned int hwcpu = hard_smp_processor_id();
 
 	local_irq_disable();
-	idle_task_exit();
 	if (xive_enabled())
 		xive_teardown_cpu();
 	else
diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index 0f1d45f32e4a..af48dfebb640 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/sched.h>	/* for idle_task_exit */
 #include <linux/sched/hotplug.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 0bc56d8381b6..348043122593 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -66,8 +66,6 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
  */
 void __noreturn arch_cpu_idle_dead(void)
 {
-	idle_task_exit();
-
 	cpuhp_ap_report_dead();
 
 	cpu_ops->cpu_stop();
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 32499cad86f0..dd1d40ec5440 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -918,7 +918,6 @@ void __cpu_die(unsigned int cpu)
 
 void __noreturn cpu_die(void)
 {
-	idle_task_exit();
 	pcpu_sigp_retry(this_cpu_ptr(&pcpu_devices), SIGP_STOP, 0);
 	for (;;) ;
 }
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 108d808767fa..afd57bdce04e 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -108,7 +108,6 @@ int native_cpu_disable(unsigned int cpu)
 
 void play_dead_common(void)
 {
-	idle_task_exit();
 	irq_ctx_exit(raw_smp_processor_id());
 	mb();
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 371460e34484..e98b5ddebc9e 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1290,8 +1290,6 @@ void cpu_play_dead(void)
 	int cpu = smp_processor_id();
 	unsigned long pstate;
 
-	idle_task_exit();
-
 	if (tlb_type == hypervisor) {
 		struct trap_per_cpu *tb = &trap_block[cpu];
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ba01a9e919b7..dcbaf3f27862 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1407,8 +1407,6 @@ int native_cpu_disable(void)
 
 void play_dead_common(void)
 {
-	idle_task_exit();
-
 	cpuhp_ap_report_dead();
 
 	local_irq_disable();
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index e4c25d0c2158..094e1da933a6 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -336,7 +336,6 @@ void __noreturn arch_cpu_idle_dead(void)
  */
 void __ref cpu_die(void)
 {
-	idle_task_exit();
 	local_irq_disable();
 	__asm__ __volatile__(
 			"	movi	a2, cpu_restart\n"
diff --git a/include/linux/sched/hotplug.h b/include/linux/sched/hotplug.h
index 17e04859b9a4..18fa3e63123e 100644
--- a/include/linux/sched/hotplug.h
+++ b/include/linux/sched/hotplug.h
@@ -18,6 +18,4 @@ extern int sched_cpu_dying(unsigned int cpu);
 # define sched_cpu_dying	NULL
 #endif
 
-static inline void idle_task_exit(void) {}
-
 #endif /* _LINUX_SCHED_HOTPLUG_H */
-- 
2.52.0

