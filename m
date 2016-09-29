From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
Date: Thu, 29 Sep 2016 13:05:13 +0200
Message-ID: <e0cfa717-0f23-f326-2907-2524ad755f91@de.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
 <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
 <f521d8cb-c38b-a608-eca8-a5c45184bbca@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <f521d8cb-c38b-a608-eca8-a5c45184bbca@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 09/29/2016 12:40 PM, Christian Borntraeger wrote:
> On 09/29/2016 12:23 PM, Christian Borntraeger wrote:
>> On 09/29/2016 12:10 PM, Peter Zijlstra wrote:
>>> On Thu, Jul 21, 2016 at 07:45:10AM -0400, Pan Xinhui wrote:
>>>> change from v2:
>>>> 	no code change, fix typos, update some comments
>>>>
>>>> change from v1:
>>>> 	a simplier definition of default vcpu_is_preempted
>>>> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
>>>> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
>>>> 	add more comments
>>>> 	thanks boqun and Peter's suggestion.
>>>>
>>>> This patch set aims to fix lock holder preemption issues.
>>>
>>> So I really like the concept, but I would also really like to see
>>> support for more hypervisors included before we can move forward with
>>> this.
>>>
>>> Please consider s390 and (x86/arm) KVM. Once we have a few, more can
>>> follow later, but I think its important to not only have PPC support for
>>> this.
>>
>> Actually the s390 preemted check via sigp sense running  is available for
>> all hypervisors (z/VM, LPAR and KVM) which implies everywhere as you can no
>> longer buy s390 systems without LPAR.
>>
>> As Heiko already pointed out we could simply use a small inline function
>> that calls cpu_is_preempted from arch/s390/lib/spinlock (or smp_vcpu_scheduled from smp.c)
> 
> Maybe something like
> (untested and just pasted, so white space damaged)

Now tested. With 8 host cpus and 16 guest cpus perf bench sched shows the
same improvements as in Pan Xinhuis cover letter.
Also the runtime shrinks a lot.

> 
> diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
> index 63ebf37..6e82986 100644
> --- a/arch/s390/include/asm/spinlock.h
> +++ b/arch/s390/include/asm/spinlock.h
> @@ -21,6 +21,13 @@ _raw_compare_and_swap(unsigned int *lock, unsigned int old, unsigned int new)
>         return __sync_bool_compare_and_swap(lock, old, new);
>  }
> 
> +int arch_vcpu_is_preempted(int cpu);
> +#define vcpu_is_preempted cpu_is_preempted
> +static inline bool cpu_is_preempted(int cpu)
> +{
> +       return arch_vcpu_is_preempted(cpu);
> +}
> +
>  /*
>   * Simple spin lock operations.  There are two variants, one clears IRQ's
>   * on the local processor, one does not.
> diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
> index e5f50a7..260d179 100644
> --- a/arch/s390/lib/spinlock.c
> +++ b/arch/s390/lib/spinlock.c
> @@ -37,7 +37,7 @@ static inline void _raw_compare_and_delay(unsigned int *lock, unsigned int old)
>         asm(".insn rsy,0xeb0000000022,%0,0,%1" : : "d" (old), "Q" (*lock));
>  }
> 
> -static inline int cpu_is_preempted(int cpu)
> +int arch_vcpu_is_preempted(int cpu)
>  {
>         if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
>                 return 0;
> @@ -45,6 +45,7 @@ static inline int cpu_is_preempted(int cpu)
>                 return 0;
>         return 1;
>  }
> +EXPORT_SYMBOL(arch_vcpu_is_preempted);
> 
>  void arch_spin_lock_wait(arch_spinlock_t *lp)
>  {
> 
> 
> 
> If ok I can respin into a proper patch.
