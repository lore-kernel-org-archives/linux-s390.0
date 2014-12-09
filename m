Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20141208235955.GZ25340@linux.vnet.ibm.com>
References: <1418070276-24378-1-git-send-email-bobby.prani@gmail.com> <20141208235955.GZ25340@linux.vnet.ibm.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 8 Dec 2014 21:29:08 -0500
Message-ID: <CAJhHMCCCuTVAmMtbpQj-hiPa_spq3sd4vFKcihF+c8=paRVXYA@mail.gmail.com>
Subject: Re: [PATCH] s390: Include kvm_host.h header only if KVM is enabled
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "supporter:S390" <linux390@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, "open list:S390" <linux-s390@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 8, 2014 at 6:59 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Mon, Dec 08, 2014 at 03:24:35PM -0500, Pranith Kumar wrote:
>> KVM uses srcu structures because of which CONFIG_KVM selects CONFIG_SRCU. In
>> asm-offsets.c, we are including kvm_host.h unconditionally even though
>> CONFIG_KVM is not enabled because of which we get errors like follows:
>>
>>     In file included from arch/s390/kernel/asm-offsets.c:10:0:
>> >> include/linux/kvm_host.h:363:21: error: field 'srcu' has incomplete type
>>       struct srcu_struct srcu;
>>                          ^
>> >> include/linux/kvm_host.h:364:21: error: field 'irq_srcu' has incomplete type
>>       struct srcu_struct irq_srcu;
>>                          ^
>>     make[2]: *** [arch/s390/kernel/asm-offsets.s] Error 1
>>     make[2]: Target '__build' not remade because of errors.
>>     make[1]: *** [prepare0] Error 2
>>     make[1]: Target 'prepare' not remade because of errors.
>>     make: *** [sub-make] Error 2
>>
>> This patch fixes these by including kvm_host.h conditionally on CONFIG_KVM.
>>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>
> To make the commits bisectable, we need to combine these two patches,
> correct?
>

Yes, if the s390 maintainers raise no objections, I will combine this
with the other patch and send it.

Thanks!

>> ---
>>  arch/s390/kernel/asm-offsets.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
>> index ef279a1..055334d 100644
>> --- a/arch/s390/kernel/asm-offsets.c
>> +++ b/arch/s390/kernel/asm-offsets.c
>> @@ -7,12 +7,15 @@
>>  #define ASM_OFFSETS_C
>>
>>  #include <linux/kbuild.h>
>> -#include <linux/kvm_host.h>
>>  #include <linux/sched.h>
>>  #include <asm/idle.h>
>>  #include <asm/vdso.h>
>>  #include <asm/pgtable.h>
>>
>> +#ifdef CONFIG_KVM
>> +#include <linux/kvm_host.h>
>> +#endif
>> +
>>  /*
>>   * Make sure that the compiler is new enough. We want a compiler that
>>   * is known to work with the "Q" assembler constraint.
>> @@ -182,8 +185,10 @@ int main(void)
>>       DEFINE(__LC_PGM_TDB, offsetof(struct _lowcore, pgm_tdb));
>>       DEFINE(__THREAD_trap_tdb, offsetof(struct task_struct, thread.trap_tdb));
>>       DEFINE(__GMAP_ASCE, offsetof(struct gmap, asce));
>> +#ifdef CONFIG_KVM
>>       DEFINE(__SIE_PROG0C, offsetof(struct kvm_s390_sie_block, prog0c));
>>       DEFINE(__SIE_PROG20, offsetof(struct kvm_s390_sie_block, prog20));
>> +#endif /* CONFIG_KVM */
>>  #endif /* CONFIG_32BIT */
>>       return 0;
>>  }
>> --
>> 1.9.1
>>
>



-- 
Pranith
