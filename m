From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECK
Date: Wed, 27 Feb 2013 12:42:17 -0800
Message-ID: <512E6FA9.4060504@codeaurora.org>
References: <1361934016-22630-1-git-send-email-sboyd@codeaurora.org> <201302272032.21014.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <201302272032.21014.arnd@arndb.de>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Chris Metcalf <cmetcalf@tilera.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/27/13 12:32, Arnd Bergmann wrote:
> On Wednesday 27 February 2013, Stephen Boyd wrote:
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 28be08c..ae80518 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1292,6 +1292,24 @@ config LATENCYTOP
>>  	  Enable this option if you want to use the LatencyTOP tool
>>  	  to find out which userspace is blocking on what kernel operations.
>>  
>> +config ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>> +	bool
>> +
>> +config DEBUG_STRICT_USER_COPY_CHECKS
>> +	bool "Strict user copy size checks"
>> +	depends on ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>> +	depends on DEBUG_KERNEL && !TRACE_BRANCH_PROFILING
>> +	help
>> +	  Enabling this option turns a certain set of sanity checks for user
>> +	  copy operations into compile time failures.
>> +
>> +	  The copy_from_user() etc checks are there to help test if there
>> +	  are sufficient security checks on the length argument of
>> +	  the copy operation, by having gcc prove that the argument is
>> +	  within bounds.
>> +
>> +	  If unsure, say N.
>> +
> Is there actually any architecture dependency left after this?
> I wonder if we actually need the ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
> symbol, or could just show the DEBUG_STRICT_USER_COPY_CHECKS option
> on all architectures.
>
> It's fine to do your patch as a first step though, which would not
> change the behavior.

A lot of arches seem to not want to enable it because false positives
are everywhere. It really depends on how good the compiler is at doing
constant propagation and dead code removal.

>
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 32f4455..59fabd0 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -15,6 +15,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>>  	 earlycpio.o percpu-refcount.o
>>  
>> +lib-$(CONFIG_ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS) += usercopy.o
>>  lib-$(CONFIG_MMU) += ioremap.o
>>  lib-$(CONFIG_SMP) += cpumask.o
>>
> I think this should instead be
>
> +lib-$(DEBUG_STRICT_USER_COPY_CHECKS) += usercopy.o
>
> No point building that file if we are not using it.

We still need it to link the kernel because the callers of the function
don't have ifdefs. Also, all arches were doing an obj-y before, so this
is equivalent.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
