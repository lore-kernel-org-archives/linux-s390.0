Return-Path: <linux-kernel-owner+w=401wt.eu-S1755748AbYCLXM1@vger.kernel.org>
Date: Wed, 12 Mar 2008 16:11:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 06/10] cpu topology support for s390.
Message-Id: <20080312161137.63bdfa67.akpm@linux-foundation.org>
In-Reply-To: <20080312173217.505558934@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
	<20080312173217.505558934@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 12 Mar 2008 18:32:01 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Add s390 backend so we can give the scheduler some hints about the
> cpu topology.
> 
> ===================================================================
> --- /dev/null
> +++ quilt-2.6/arch/s390/kernel/topology.c
> @@ -0,0 +1,271 @@
> +/*
> + *  arch/s390/kernel/topology.c
> + *
> + *    Copyright IBM Corp. 2007
> + *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/bootmem.h>
> +#include <linux/sched.h>
> +#include <linux/workqueue.h>
> +#include <linux/cpu.h>
> +#include <linux/smp.h>
> +#include <asm/delay.h>
> +#include <asm/s390_ext.h>
> +
> +#define CPU_BITS 64
> +
> +struct tl_cpu {
> +	unsigned char reserved[6];
> +	unsigned short origin;
> +	unsigned long mask[CPU_BITS / BITS_PER_LONG];
> +};

mask[] will be too small for CPU_BITS=65 ;)

> ...
>
> +static union tl_entry *next_tle(union tl_entry *tle)
> +{
> +	if (tle->nl)
> +		return (union tl_entry *)((struct tl_container *)tle + 1);
> +	else
> +		return (union tl_entry *)((struct tl_cpu *)tle + 1);
> +}

omg.

> +static void tl_to_cores(struct tl_info *info)
> +{
> +	union tl_entry *tle, *end;
> +	struct core_info *core = &core_info;
> +
> +	mutex_lock(&smp_cpu_state_mutex);
> +	clear_cores();
> +	tle = (union tl_entry *)&info->tle;

and this cast was unneeded!

> +	end = (union tl_entry *)((unsigned long)info + info->length);

I'd suggest that you take a look at all the pointer arith games which are
being played in this code and see if it can be done better with a more
appropriate use of the C type system.  Before someone dies.
