Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436612AbfIWKnO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 06:43:14 -0400
Subject: Re: [kvm-unit-tests PATCH v3 4/6] s390x: Add initial smp code
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b60eee55-f013-411a-0e52-3f40a990b1c4@redhat.com>
Date: Mon, 23 Sep 2019 12:43:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190920080356.1948-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 20/09/2019 10.03, Janosch Frank wrote:
> Let's add a rudimentary SMP library, which will scan for cpus and has
> helper functions that manage the cpu state.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> new file mode 100644
> index 0000000..05379b0
> --- /dev/null
> +++ b/lib/s390x/smp.c
> @@ -0,0 +1,263 @@
> +/*
> + * s390x smp
> + * Based on Linux's arch/s390/kernel/smp.c and
> + * arch/s390/include/asm/sigp.h
> + *
> + * Copyright (c) 2019 IBM Corp
> + *
> + * Authors:
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + */
> +#include <libcflat.h>
> +#include <asm/arch_def.h>
> +#include <asm/sigp.h>
> +#include <asm/page.h>
> +#include <asm/barrier.h>
> +#include <asm/spinlock.h>
> +#include <asm/asm-offsets.h>
> +
> +#include <alloc.h>
> +#include <alloc_page.h>
> +
> +#include "smp.h"
> +#include "sclp.h"
> +
> +static char cpu_info_buffer[PAGE_SIZE] __attribute__((__aligned__(4096)));
> +static struct cpu *cpus;
> +static struct cpu *cpu0;
> +static struct spinlock lock;
> +
> +extern void smp_cpu_setup_state(void);
> +
> +int smp_query_num_cpus(void)
> +{
> +	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
> +	return info->nr_configured;
> +}
> +
> +struct cpu *smp_cpu_from_addr(uint16_t addr)
> +{
> +	int i, num = smp_query_num_cpus();
> +	struct cpu *cpu = NULL;
> +
> +	for (i = 0; i < num; i++) {
> +		if (cpus[i].addr == addr)
> +			cpu = &cpus[i];

Small optimization: Add a "break" here. Or "return &cpus[i]" directly
and "return NULL" after the loop, getting rid of the "cpu" variable.

> +	}
> +	return cpu;
> +}
> +
> +bool smp_cpu_stopped(uint16_t addr)
> +{
> +	uint32_t status;
> +
> +	if (sigp(addr, SIGP_SENSE, 0, &status) != SIGP_CC_STATUS_STORED)
> +		return false;
> +	return !!(status & (SIGP_STATUS_CHECK_STOP|SIGP_STATUS_STOPPED));
> +}
> +
> +bool smp_cpu_running(uint16_t addr)
> +{
> +	if (sigp(addr, SIGP_SENSE_RUNNING, 0, NULL) != SIGP_CC_STATUS_STORED)
> +		return true;
> +	/* Status stored condition code is equivalent to cpu not running. */
> +	return false;
> +}
> +
> +static int smp_cpu_stop_nolock(uint16_t addr, bool store)
> +{
> +	struct cpu *cpu;
> +	uint8_t order = store ? SIGP_STOP_AND_STORE_STATUS : SIGP_STOP;
> +
> +	cpu = smp_cpu_from_addr(addr);
> +	if (!cpu || cpu == cpu0)
> +		return -1;
> +
> +	if (sigp_retry(addr, order, 0, NULL))
> +		return -1;
> +
> +	while (!smp_cpu_stopped(addr))
> +		mb();
> +	cpu->active = false;
> +	return 0;
> +}
> +
> +int smp_cpu_stop(uint16_t addr)
> +{
> +	int rc = 0;

You could drop the "= 0" here.

> +	spin_lock(&lock);
> +	rc = smp_cpu_stop_nolock(addr, false);
> +	spin_unlock(&lock);
> +	return rc;
> +}
> +
> +int smp_cpu_stop_store_status(uint16_t addr)
> +{
> +	int rc = 0;

dito.

> +	spin_lock(&lock);
> +	rc = smp_cpu_stop_nolock(addr, true);
> +	spin_unlock(&lock);
> +	return rc;
> +}
> +
> +int smp_cpu_restart(uint16_t addr)
> +{
> +	int rc = -1;
> +	struct cpu *cpu;
> +
> +	spin_lock(&lock);
> +	cpu = smp_cpu_from_addr(addr);
> +	if (!cpu)
> +		goto out;
> +
> +	rc = sigp(addr, SIGP_RESTART, 0, NULL);
> +	cpu->active = true;
> +out:

For such simple code, I'd prefer:

	if (cpu) {
		rc = sigp(addr, SIGP_RESTART, 0, NULL);
		cpu->active = true;
	}

instead of using a "goto" ... anyway, just my 0.02 €.

> +	spin_unlock(&lock);
> +	return rc;
> +}
> +
> +int smp_cpu_start(uint16_t addr, struct psw psw)
> +{
> +	int rc = -1;
> +	struct cpu *cpu;
> +	struct lowcore *lc;
> +
> +	spin_lock(&lock);
> +	cpu = smp_cpu_from_addr(addr);
> +	if (!cpu)
> +		goto out;
> +
> +	lc = cpu->lowcore;
> +	lc->restart_new_psw.mask = psw.mask;
> +	lc->restart_new_psw.addr = psw.addr;
> +	rc = sigp(addr, SIGP_RESTART, 0, NULL);
> +out:

dito, could be done without "goto".

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
> +	cpu->lowcore = (void *)-1UL;
> +	cpu->stack = (void *)-1UL;
> +
> +out:

dito. Well, it's just a matter of taste, I think. I'm also fine if you
want to keep it this way.

> +	spin_unlock(&lock);
> +	return rc;
> +}

... just cosmetic nits, patch looks fine to me now, so feel free to add:

Reviewed-by: Thomas Huth <thuth@redhat.com>
