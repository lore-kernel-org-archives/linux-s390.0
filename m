Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbfIBNVe (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Sep 2019 09:21:34 -0400
Subject: Re: [kvm-unit-tests PATCH 4/6] s390x: Add initial smp code
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <af43e842-9aee-9407-2a97-354efe2b81e1@redhat.com>
Date: Mon, 2 Sep 2019 15:21:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190829121459.1708-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 29/08/2019 14.14, Janosch Frank wrote:
> Let's add a rudimentary SMP library, which will scan for cpus and has
> helper functions that manage the cpu state.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h |   8 ++
>  lib/s390x/asm/sigp.h     |  29 ++++-
>  lib/s390x/io.c           |   5 +-
>  lib/s390x/sclp.h         |   1 +
>  lib/s390x/smp.c          | 272 +++++++++++++++++++++++++++++++++++++++
>  lib/s390x/smp.h          |  51 ++++++++
>  s390x/Makefile           |   1 +
>  s390x/cstart64.S         |   7 +
>  8 files changed, 368 insertions(+), 6 deletions(-)
>  create mode 100644 lib/s390x/smp.c
>  create mode 100644 lib/s390x/smp.h
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 5f8f45e..d5a7f51 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -157,6 +157,14 @@ struct cpuid {
>  	uint64_t reserved : 15;
>  };
>  
> +static inline unsigned short stap(void)
> +{
> +	unsigned short cpu_address;
> +
> +	asm volatile("stap %0" : "=Q" (cpu_address));
> +	return cpu_address;
> +}
> +
>  static inline int tprot(unsigned long addr)
>  {
>  	int cc;
> diff --git a/lib/s390x/asm/sigp.h b/lib/s390x/asm/sigp.h
> index fbd94fc..ce85eb7 100644
> --- a/lib/s390x/asm/sigp.h
> +++ b/lib/s390x/asm/sigp.h
> @@ -46,14 +46,33 @@
>  
>  #ifndef __ASSEMBLER__
>  
> -static inline void sigp_stop(void)
> +
> +static inline int sigp(uint16_t addr, uint8_t order, unsigned long parm,
> +		       uint32_t *status)
>  {
> -	register unsigned long status asm ("1") = 0;
> -	register unsigned long cpu asm ("2") = 0;
> +	register unsigned long reg1 asm ("1") = parm;
> +	int cc;
>  
>  	asm volatile(
> -		"	sigp %0,%1,0(%2)\n"
> -		: "+d" (status)  : "d" (cpu), "d" (SIGP_STOP) : "cc");
> +		"	sigp	%1,%2,0(%3)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28\n"
> +		: "=d" (cc), "+d" (reg1) : "d" (addr), "a" (order) : "cc");
> +	if (status)
> +		*status = reg1;
> +	return cc;
> +}
> +
> +static inline int sigp_retry(uint16_t addr, uint8_t order, unsigned long parm,
> +			     uint32_t *status)
> +{
> +	int cc;
> +
> +retry:
> +	cc = sigp(addr, order, parm, status);
> +	if (cc == 2)
> +		goto retry;

Please change to:

	do {
		cc = sigp(addr, order, parm, status);
	} while (cc == 2);

> +	return cc;
>  }
>  
>  #endif /* __ASSEMBLER__ */
[...]
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> new file mode 100644
> index 0000000..b1b636a
> --- /dev/null
> +++ b/lib/s390x/smp.c
[...]
> +int smp_cpu_restart(uint16_t addr)
> +{
> +	int rc = 0;
> +	struct cpu *cpu;
> +
> +	spin_lock(&lock);
> +	cpu = smp_cpu_from_addr(addr);
> +	if (!cpu) {
> +		rc = -ENOENT;
> +		goto out;
> +	}
> +
> +	rc = sigp(cpu->addr, SIGP_RESTART, 0, NULL);

I think you could use "addr" instead of "cpu->addr" here.

> +	cpu->active = true;
> +out:
> +	spin_unlock(&lock);
> +	return rc;
> +}
> +
> +int smp_cpu_start(uint16_t addr, struct psw psw)
> +{
> +	int rc = 0;
> +	struct cpu *cpu;
> +	struct lowcore *lc;
> +
> +	spin_lock(&lock);
> +	cpu = smp_cpu_from_addr(addr);
> +	if (!cpu) {
> +		rc = -ENOENT;
> +		goto out;
> +	}
> +
> +	lc = cpu->lowcore;
> +	lc->restart_new_psw.mask = psw.mask;
> +	lc->restart_new_psw.addr = psw.addr;
> +	rc = sigp(cpu->addr, SIGP_RESTART, 0, NULL);

dito

> +out:
> +	spin_unlock(&lock);
> +	return rc;
> +}
> +
> +int smp_cpu_destroy(uint16_t addr)
> +{
> +	struct cpu *cpu;
> +	int rc = 0;
> +
> +	spin_lock(&lock);
> +	rc = smp_cpu_stop_nolock(addr, false);
> +	if (rc)
> +		goto out;
> +
> +	cpu = smp_cpu_from_addr(addr);
> +	free_pages(cpu->lowcore, 2 * PAGE_SIZE);
> +	free_pages(cpu->stack, 4 * PAGE_SIZE);

Maybe do this afterwards to make sure that nobody uses a dangling pointer:

	cpu->lowcore = cpu->stack = -1UL;

?

> +out:
> +	spin_unlock(&lock);
> +	return rc;
> +}
> +
> +int smp_cpu_setup(uint16_t addr, struct psw psw)
> +{
> +	struct lowcore *lc;
> +	struct cpu *cpu;
> +	int rc = 0;
> +
> +	spin_lock(&lock);
> +
> +	if (!cpus) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	cpu = smp_cpu_from_addr(addr);
> +
> +	if (!cpu) {
> +		rc = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (cpu->active) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	sigp_retry(cpu->addr, SIGP_INITIAL_CPU_RESET, 0, NULL);
> +
> +	lc = alloc_pages(1);
> +	cpu->lowcore = lc;
> +	memset(lc, 0, PAGE_SIZE * 2);
> +	sigp_retry(cpu->addr, SIGP_SET_PREFIX, (unsigned long )lc, NULL);
> +
> +	/* Copy all exception psws. */
> +	memcpy(lc, cpu0->lowcore, 512);
> +
> +	/* Setup stack */
> +	cpu->stack = (uint64_t *)alloc_pages(2);
> +
> +	/* Start without DAT and any other mask bits. */
> +	cpu->lowcore->sw_int_grs[14] = psw.addr;
> +	cpu->lowcore->sw_int_grs[15] = (uint64_t)cpu->stack + (PAGE_SIZE * 4) / sizeof(cpu->stack);

The end-of-stack calculation looks wrong to me. I think you either meant:

 ... = (uint64_t)(cpu->stack + (PAGE_SIZE * 4) / sizeof(*cpu->stack));

or:

 ... = (uint64_t)cpu->stack + (PAGE_SIZE * 4);

?

> +	lc->restart_new_psw.mask = 0x0000000180000000UL;
> +	lc->restart_new_psw.addr = (unsigned long)smp_cpu_setup_state;

Maybe use "(uint64_t)" instead of "(unsigned long)"?

> +	lc->sw_int_cr0 = 0x0000000000040000UL;
> +
> +	/* Start processing */
> +	cpu->active = true;
> +	rc = sigp_retry(cpu->addr, SIGP_RESTART, 0, NULL);

Should cpu->active only be set to true if rc == 0 ?

> +out:
> +	spin_unlock(&lock);
> +	return rc;
> +}
> +
> +/*
> + * Disregarding state, stop all cpus that once were online except for
> + * calling cpu.
> + */
> +void smp_teardown(void)
> +{
> +	int i = 0;
> +	uint16_t this_cpu = stap();
> +	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
> +
> +	spin_lock(&lock);
> +	for (; i < info->nr_configured; i++) {
> +		if (cpus[i].active &&
> +		    cpus[i].addr != this_cpu) {
> +			sigp_retry(cpus[i].addr, SIGP_STOP, 0, NULL);

Maybe set cpus[i].active = false afterwards ?

> +		}
> +	}
> +	spin_unlock(&lock);
> +}

 Thomas
