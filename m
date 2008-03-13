Return-Path: <linux-kernel-owner+w=401wt.eu-S1752691AbYCMM3D@vger.kernel.org>
Subject: Re: [patch 06/10] cpu topology support for s390.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080312161137.63bdfa67.akpm@linux-foundation.org>
References: <20080312173155.703966894@de.ibm.com>
	 <20080312173217.505558934@de.ibm.com>
	 <20080312161137.63bdfa67.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 13:28:27 +0100
Message-Id: <1205411307.26537.64.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 16:11 -0700, Andrew Morton wrote:
> > +#include <asm/delay.h>
> > +#include <asm/s390_ext.h>
> > +
> > +#define CPU_BITS 64
> > +
> > +struct tl_cpu {
> > +	unsigned char reserved[6];
> > +	unsigned short origin;
> > +	unsigned long mask[CPU_BITS / BITS_PER_LONG];
> > +};
> 
> mask[] will be too small for CPU_BITS=65 ;)

We could add the +(BITS_PER_LONG - 1) logic but what for? The CPU_BITS
is defined right above and it will be increased in steps of 64.

> > ...
> >
> > +static union tl_entry *next_tle(union tl_entry *tle)
> > +{
> > +	if (tle->nl)
> > +		return (union tl_entry *)((struct tl_container *)tle + 1);
> > +	else
> > +		return (union tl_entry *)((struct tl_cpu *)tle + 1);
> > +}
> 
> omg.

The length of the current tle depends on the type, the next type is
located behind the current one. Expect for the typecasting and the union
trick this is what needs to be done.

> > +static void tl_to_cores(struct tl_info *info)
> > +{
> > +	union tl_entry *tle, *end;
> > +	struct core_info *core = &core_info;
> > +
> > +	mutex_lock(&smp_cpu_state_mutex);
> > +	clear_cores();
> > +	tle = (union tl_entry *)&info->tle;
> 
> and this cast was unneeded!
> 
> > +	end = (union tl_entry *)((unsigned long)info + info->length);
> 
> I'd suggest that you take a look at all the pointer arith games which are
> being played in this code and see if it can be done better with a more
> appropriate use of the C type system.  Before someone dies.

The only thing that I can see that we could do is to get rid of the
unions and do the pointer arithmetic with the tl_cpu / tl_container
structs by hand. The data stored by ptf is structured in a way that
makes it rather hard to write decent C code.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
