From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 04 Jan 2010 10:21:34 +0000
Subject: Re: [patch 1/3] S390-HWBKPT: Prepare s390 for hardware breakpoint
Message-Id: <4B41BE5E.3040009@linux.vnet.ibm.com>
In-Reply-To: <20091218215655.GA13103@osiris.boeblingen.de.ibm.com>
References: <20091218215655.GA13103@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Heiko Carstens wrote:
> On Mon, Dec 14, 2009 at 07:27:24PM +0530, Mahesh Salgaonkar wrote:
>> Prepare the s390 code for HW Breakpoint infrastructure patches by including
>> relevant constant definitions and function declarations.
> 
> Why split this? Especially it would be nice to have function declarations and
> the functions in the same patch :)
>

Sure, will merge the first 2 patches.

>> Index: linux-2.6-tip/arch/s390/include/asm/hw_breakpoint.h
>> ===================================================================
>> --- /dev/null
>> +++ linux-2.6-tip/arch/s390/include/asm/hw_breakpoint.h
>> @@ -0,0 +1,65 @@
>> + */
>> +#ifndef	_S390_HW_BREAKPOINT_H
>> +#define	_S390_HW_BREAKPOINT_H
>> +
>> +#ifdef	__KERNEL__
> 
> This header isn't exported, so the ifdef seems to be unnecessary.
> 
>> +#define	__ARCH_HW_BREAKPOINT_H
> 
> Seems to be unnecessary as well.
> 
>> +extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>> +				     unsigned long val, void *data);
>> +
>> +int arch_install_hw_breakpoint(struct perf_event *bp);
>> +void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>> +void hw_breakpoint_pmu_read(struct perf_event *bp);
>> +void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
>> +
>> +extern void arch_fill_perf_breakpoint(struct perf_event *bp);
> 
> At least this function doesn't exist in your second patch.
> 
Will remove it.

>> Index: linux-2.6-tip/kernel/hw_breakpoint.c
>> ===================================================================
>> --- linux-2.6-tip.orig/kernel/hw_breakpoint.c
>> +++ linux-2.6-tip/kernel/hw_breakpoint.c
>> @@ -30,6 +30,9 @@
>>   * This file contains the arch-independent routines.
>>   */
>>
>> +#ifdef CONFIG_S390
>> +#include <asm/bitsperlong.h>
>> +#endif
> 
> Please don't add CONFIG_S390 ifdefs in common code, unless it cannot be
> avoided. Why is this needed?
> 
>>  #include <linux/irqflags.h>

This was included to avoid compilation errors. The 'asm/irqflags.h' 
included from 'linux/irqflags' uses "BITS_PER_LONG" #def which is 
declared in 'asm/bitsperlong.h'.

>>  #include <linux/kallsyms.h>
>>  #include <linux/notifier.h>
