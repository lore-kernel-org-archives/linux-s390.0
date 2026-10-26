Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980258;
	b=MCfTWCVccwY6y5dA8aNIHtIpGFadP7MFfZvTfdl7s+8Hjc3Lf3R7iRCp2j8yQ5AVtJvx
	 v9Pncjc4P6M5ClKUuoP3JsTXk6pTwGXSO4bzJCPoJiKGZDBSjvM/EVLhHz/sddIZMJizb
	 RlC2deCflysVDc2B0a37JrjLFQCPfAtTK1rrpGwOOnGuPdWzMJcV/pKS9HSoiEGw8NLXq
	 ZpHboOdQIIaIM5soosg/M5QysfUXehMkHj+Hl3vYbfUyehTofbD9dXNLmt4+ik9ce/J/U
	 Jfr7wimMVLYL4hUne3EscwQldemBcawnMhL1DQnHQskr1xbqamQ8dr01qfJusk75c8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980258;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=zkV0DSYY1q2xiz5WJX/niGx/d7Lw7ICLtD+7Nzqc/EE=;
	b=cr6ezNr/KmUynKQUyY/11x12nI9gLoI/9Tt95hEQxo7kBtAbpu1FSGkOB7O+0yHg8lzj
	 aaZNMVXoni2YCRUlqM2kUgrrREN54kuc9y9hhhpfQmcPlK14cGNTKqjUfTu4Fh1Co72+h
	 lGQ1FOM5IRMsXp4hrfVDqNMb9qAcNRoQLlxYzQjGT4wJn8d+DoM6hdPeY71YqdkL7Nzwe
	 3vVFr/suSeWtDTYPtueqscCQZy+LTNeq5KyttVnXVV+R1+P6vl9r9KlnEwerSyvfuNyhk
	 4oTktmFyw6foTaEndYIs7+QXXBbX6Af4TKmX5Jmx6Adkbp4GxtH/LqJTk2Zdnd2K4hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="A4/DwLqj";
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EED606A31A;
	Mon, 26 Oct 2026 02:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=A4/DwLqj
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zkV0DSYY1q2xiz5WJX/niGx/d7Lw7ICLtD+7Nzqc/EE=;
	b=A4/DwLqj9bOFxt5jV1aHRDIbIvOm+m2aGeOnwHabNmmuXnOs+Peabb0o1Z/UV2H6NIOnZJZp0
	uXbSQ9bcLJqQ0YRCDlMkBLaeUL+Wopvmw/TrIt2Ji3woo7Dc27yvo9Z2//TZk/IpOQQwsvXJ81I
	STqRtfEiiseBYGD+s3ZMQe0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jCcP63p9WzRhSF;
	Mon, 26 Oct 2026 10:03:54 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 993D340575;
	Mon, 26 Oct 2026 10:04:01 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 10:03:59 +0800
Message-ID: <02118069-9360-4055-bc61-2ee2dd3486c9@huawei.com>
Date: Mon, 26 Oct 2026 10:03:58 +0800
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/hotplug: Remove unused idle_task_exit
To: Srikar Dronamraju <srikar@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo
 Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
	<kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Jiaxun Yang
	<jiaxun.yang@flygoat.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Scott
 Wood <oss@buserror.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato
	<ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller"
	<davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, Srikar Dronamraju
	<srikar@linux.vnet.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Kees Cook <kees@kernel.org>, mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Marc Zyngier <maz@kernel.org>, Pengjie Zhang <zhangpengjie2@huawei.com>,
	Thierry Reding <treding@nvidia.com>, Xi Ruoyao <xry111@xry111.site>, "Rafael
 J. Wysocki (Intel)" <rafael@kernel.org>, Tiezhu Yang
	<yangtiezhu@loongson.cn>, Rong Bao <rong.bao@csmantle.top>, Hui Wang
	<hui.wang@canonical.com>, Frederic Weisbecker <frederic@kernel.org>, Thorsten
 Blum <thorsten.blum@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>
References: <20261016095711.1364609-1-srikar@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261016095711.1364609-1-srikar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/10/16 17:56, Srikar Dronamraju 写道:
> Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
> MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
> idle_task_exit() into the scheduler CPU hotplug path using
> sched_force_init_mm().
> 
> As a result, idle_task_exit() is now an empty stub and the remaining
> architecture call sites have no effect.

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

> 
> Remove the calls to idle_task_exit() and the now unused stub.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
>  arch/arm/kernel/smp.c                        | 2 --
>  arch/arm64/kernel/smp.c                      | 2 --
>  arch/csky/kernel/smp.c                       | 2 --
>  arch/loongarch/kernel/smp.c                  | 2 --
>  arch/mips/cavium-octeon/smp.c                | 1 -
>  arch/mips/kernel/smp-bmips.c                 | 1 -
>  arch/mips/kernel/smp-cps.c                   | 1 -
>  arch/mips/loongson64/smp.c                   | 1 -
>  arch/parisc/kernel/process.c                 | 2 --
>  arch/powerpc/platforms/85xx/smp.c            | 2 --
>  arch/powerpc/platforms/powermac/smp.c        | 2 --
>  arch/powerpc/platforms/powernv/smp.c         | 1 -
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 --
>  arch/powerpc/platforms/pseries/pmem.c        | 1 -
>  arch/riscv/kernel/cpu-hotplug.c              | 2 --
>  arch/s390/kernel/smp.c                       | 1 -
>  arch/sh/kernel/smp.c                         | 1 -
>  arch/sparc/kernel/smp_64.c                   | 2 --
>  arch/x86/kernel/smpboot.c                    | 2 --
>  arch/xtensa/kernel/smp.c                     | 1 -
>  include/linux/sched/hotplug.h                | 2 --
>  21 files changed, 33 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index b5fb4697bc3f..bbfbbe728b7a 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -319,8 +319,6 @@ void __noreturn arch_cpu_idle_dead(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> -	idle_task_exit();
> -
>  	local_irq_disable();
>  
>  	/*
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index a61dc3016a11..afb5aa65d737 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -370,8 +370,6 @@ void __noreturn cpu_die(void)
>  	unsigned int cpu = smp_processor_id();
>  	const struct cpu_operations *ops = get_cpu_ops(cpu);
>  
> -	idle_task_exit();
> -
>  	local_daif_mask();
>  
>  	/* Tell cpuhp_bp_sync_dead() that this CPU is now safe to dispose of */
> diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
> index 92dbbf3e0205..e6333ccc335a 100644
> --- a/arch/csky/kernel/smp.c
> +++ b/arch/csky/kernel/smp.c
> @@ -294,8 +294,6 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
>  
>  void __noreturn arch_cpu_idle_dead(void)
>  {
> -	idle_task_exit();
> -
>  	cpuhp_ap_report_dead();
>  
>  	while (!secondary_stack)
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 11f54837f56c..6b21af1c25e0 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -478,7 +478,6 @@ static void __noreturn idle_play_dead(void)
>  	register uint64_t addr;
>  	register void (*init_fn)(void);
>  
> -	idle_task_exit();
>  	local_irq_enable();
>  	set_csr_ecfg(ECFGF_IPI);
>  	__this_cpu_write(cpu_state, CPU_DEAD);
> @@ -503,7 +502,6 @@ static void __noreturn poll_play_dead(void)
>  	register uint64_t addr;
>  	register void (*init_fn)(void);
>  
> -	idle_task_exit();
>  	__this_cpu_write(cpu_state, CPU_DEAD);
>  
>  	__smp_mb();
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 054e331b3202..0e557e76d616 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -344,7 +344,6 @@ void play_dead(void)
>  {
>  	int cpu = cpu_number_map(cvmx_get_core_num());
>  
> -	idle_task_exit();
>  	cpuhp_ap_report_dead();
>  	octeon_processor_boot = 0xff;
>  	per_cpu(cpu_state, cpu) = CPU_DEAD;
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index 35b8d810833c..e4a523b7c988 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -391,7 +391,6 @@ static void bmips_cpu_die(unsigned int cpu)
>  
>  void __ref play_dead(void)
>  {
> -	idle_task_exit();
>  	cpuhp_ap_report_dead();
>  
>  	/* flush data cache */
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index b01ebaace48e..51e68a42bcc8 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -804,7 +804,6 @@ void play_dead(void)
>  	unsigned int cpu;
>  
>  	local_irq_disable();
> -	idle_task_exit();
>  	cpu = smp_processor_id();
>  	cpu_death = CPU_DEATH_POWER;
>  
> diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
> index e584299d0fde..73eca9c44b04 100644
> --- a/arch/mips/loongson64/smp.c
> +++ b/arch/mips/loongson64/smp.c
> @@ -766,7 +766,6 @@ void play_dead(void)
>  	unsigned int cpu = smp_processor_id();
>  	void (*play_dead_at_ckseg1)(int *);
>  
> -	idle_task_exit();
>  	cpuhp_ap_report_dead();
>  
>  	prid_imp = read_c0_prid() & PRID_IMP_MASK;
> diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
> index 703644e5bfc4..8606ecde4c30 100644
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -164,8 +164,6 @@ EXPORT_SYMBOL(running_on_qemu);
>  void __noreturn arch_cpu_idle_dead(void)
>  {
>  #ifdef CONFIG_HOTPLUG_CPU
> -	idle_task_exit();
> -
>  	local_irq_disable();
>  
>  	/* Tell the core that this CPU is now safe to dispose of. */
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index 32fa5fb557c0..9dc81e4226f0 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -121,8 +121,6 @@ static void smp_85xx_cpu_offline_self(void)
>  	/* mask all irqs to prevent cpu wakeup */
>  	qoriq_pm_ops->irq_mask(cpu);
>  
> -	idle_task_exit();
> -
>  	mtspr(SPRN_TCR, 0);
>  	mtspr(SPRN_TSR, mfspr(SPRN_TSR));
>  
> diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
> index 88e92af8acf9..f8e674cfcdd7 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -925,7 +925,6 @@ static void pmac_cpu_offline_self(void)
>  	int cpu = smp_processor_id();
>  
>  	local_irq_disable();
> -	idle_task_exit();
>  	pr_debug("CPU%d offline\n", cpu);
>  	generic_set_cpu_dead(cpu);
>  	smp_wmb();
> @@ -940,7 +939,6 @@ static void pmac_cpu_offline_self(void)
>  	int cpu = smp_processor_id();
>  
>  	local_irq_disable();
> -	idle_task_exit();
>  
>  	/*
>  	 * turn off as much as possible, we'll be
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index b1201dbafcaf..9a480c924020 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -172,7 +172,6 @@ static void pnv_cpu_offline_self(void)
>  
>  	/* Standard hot unplug procedure */
>  
> -	idle_task_exit();
>  	cpu = smp_processor_id();
>  	DBG("CPU%d offline\n", cpu);
>  	generic_set_cpu_dead(cpu);
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index bc6926dbf148..1ade9a811157 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -19,7 +19,6 @@
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> -#include <linux/sched.h>	/* for idle_task_exit */
>  #include <linux/sched/hotplug.h>
>  #include <linux/cpu.h>
>  #include <linux/of.h>
> @@ -64,7 +63,6 @@ static void pseries_cpu_offline_self(void)
>  	unsigned int hwcpu = hard_smp_processor_id();
>  
>  	local_irq_disable();
> -	idle_task_exit();
>  	if (xive_enabled())
>  		xive_teardown_cpu();
>  	else
> diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
> index 0f1d45f32e4a..af48dfebb640 100644
> --- a/arch/powerpc/platforms/pseries/pmem.c
> +++ b/arch/powerpc/platforms/pseries/pmem.c
> @@ -9,7 +9,6 @@
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> -#include <linux/sched.h>	/* for idle_task_exit */
>  #include <linux/sched/hotplug.h>
>  #include <linux/cpu.h>
>  #include <linux/of.h>
> diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
> index 0bc56d8381b6..348043122593 100644
> --- a/arch/riscv/kernel/cpu-hotplug.c
> +++ b/arch/riscv/kernel/cpu-hotplug.c
> @@ -66,8 +66,6 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
>   */
>  void __noreturn arch_cpu_idle_dead(void)
>  {
> -	idle_task_exit();
> -
>  	cpuhp_ap_report_dead();
>  
>  	cpu_ops->cpu_stop();
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 32499cad86f0..dd1d40ec5440 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -918,7 +918,6 @@ void __cpu_die(unsigned int cpu)
>  
>  void __noreturn cpu_die(void)
>  {
> -	idle_task_exit();
>  	pcpu_sigp_retry(this_cpu_ptr(&pcpu_devices), SIGP_STOP, 0);
>  	for (;;) ;
>  }
> diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
> index 108d808767fa..afd57bdce04e 100644
> --- a/arch/sh/kernel/smp.c
> +++ b/arch/sh/kernel/smp.c
> @@ -108,7 +108,6 @@ int native_cpu_disable(unsigned int cpu)
>  
>  void play_dead_common(void)
>  {
> -	idle_task_exit();
>  	irq_ctx_exit(raw_smp_processor_id());
>  	mb();
>  
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 371460e34484..e98b5ddebc9e 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1290,8 +1290,6 @@ void cpu_play_dead(void)
>  	int cpu = smp_processor_id();
>  	unsigned long pstate;
>  
> -	idle_task_exit();
> -
>  	if (tlb_type == hypervisor) {
>  		struct trap_per_cpu *tb = &trap_block[cpu];
>  
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ba01a9e919b7..dcbaf3f27862 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1407,8 +1407,6 @@ int native_cpu_disable(void)
>  
>  void play_dead_common(void)
>  {
> -	idle_task_exit();
> -
>  	cpuhp_ap_report_dead();
>  
>  	local_irq_disable();
> diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
> index e4c25d0c2158..094e1da933a6 100644
> --- a/arch/xtensa/kernel/smp.c
> +++ b/arch/xtensa/kernel/smp.c
> @@ -336,7 +336,6 @@ void __noreturn arch_cpu_idle_dead(void)
>   */
>  void __ref cpu_die(void)
>  {
> -	idle_task_exit();
>  	local_irq_disable();
>  	__asm__ __volatile__(
>  			"	movi	a2, cpu_restart\n"
> diff --git a/include/linux/sched/hotplug.h b/include/linux/sched/hotplug.h
> index 17e04859b9a4..18fa3e63123e 100644
> --- a/include/linux/sched/hotplug.h
> +++ b/include/linux/sched/hotplug.h
> @@ -18,6 +18,4 @@ extern int sched_cpu_dying(unsigned int cpu);
>  # define sched_cpu_dying	NULL
>  #endif
>  
> -static inline void idle_task_exit(void) {}
> -
>  #endif /* _LINUX_SCHED_HOTPLUG_H */

-- 
Best regards,
Jinjie

