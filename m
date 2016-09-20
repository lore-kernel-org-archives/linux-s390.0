From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Tue, 20 Sep 2016 13:19:30 +0200
Message-ID: <60adab94-f32e-2287-4821-81a88fa366d4@de.ibm.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160916085736.7857-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 09/16/2016 10:57 AM, Nicholas Piggin wrote:
> Implementing busy wait loops with cpu_relax() in callers poses
> some difficulties for powerpc.
> 
> First, we want to put our SMT thread into a low priority mode for the
> duration of the loop, but then return to normal priority after exiting
> the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> cpu_relax() does may have HMT_medium take effect before HMT_low made
> any (or much) difference.
> 
> Second, it can be beneficial for some implementations to spin on the
> exit condition with a statically predicted-not-taken branch (i.e.,
> always predict the loop will exit).
> 
> This is a quick RFC with a couple of users converted to see what
> people think. I don't use a C branch with hints, because we don't want
> the compiler moving the loop body out of line, which makes it a bit
> messy unfortunately. If there's a better way to do it, I'm all ears.
> 
> I would not propose to switch all callers immediately, just some
> core synchronisation primitives.
Just a FYA,

On s390 we have a private version of cpu_relax that yields the cpu
time slice back to the hypervisor via a hypercall. As this turned out
to be problematic in some cases there is also now a cpu_relax_lowlatency.

Now, this seems still problematic as there are too many places still 
using cpu_relax instead of cpu_relax_lowlatency. So my plan is to do 
a change of that, make cpu_relax just be a barrier and add a new 
cpu_relax_yield that gives up the time slice. (so that s390 cpu_relax
is just like any other cpu_relax)

As far as I can tell the only place where I want to change cpu_relax
to cpu_relax_lowlatency after that change is the stop machine run 
code, so I hope to have no conflicts with your changes.
> 
> ---
>  arch/powerpc/include/asm/processor.h | 22 ++++++++++++++++++++++
>  include/asm-generic/barrier.h        |  7 ++-----
>  include/linux/bit_spinlock.h         |  5 ++---
>  include/linux/cgroup.h               |  7 ++-----
>  include/linux/seqlock.h              | 10 ++++------
>  5 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 68e3bf5..e10aee2 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -402,6 +402,28 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
> 
>  #ifdef CONFIG_PPC64
>  #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
> +
> +#define spin_do						\
> +do {							\
> +	HMT_low();					\
> +	__asm__ __volatile__ (	"1010:");
> +
> +#define spin_while(cond)				\
> +	barrier();					\
> +	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
> +				"beq-	1010b	\n\t"	\
> +				: : "r" (cond));	\
> +	HMT_medium();					\
> +} while (0)
> +
> +#define spin_until(cond)				\
> +	barrier();					\
> +	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
> +				"bne-	1010b	\n\t"	\
> +				: : "r" (cond));	\
> +	HMT_medium();					\
> +} while (0)
> +
>  #else
>  #define cpu_relax()	barrier()
>  #endif
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index fe297b5..4c53b3a 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -235,12 +235,9 @@ do {									\
>  #define smp_cond_load_acquire(ptr, cond_expr) ({		\
>  	typeof(ptr) __PTR = (ptr);				\
>  	typeof(*ptr) VAL;					\
> -	for (;;) {						\
> +	spin_do {						\
>  		VAL = READ_ONCE(*__PTR);			\
> -		if (cond_expr)					\
> -			break;					\
> -		cpu_relax();					\
> -	}							\
> +	} spin_until (cond_expr);				\
>  	smp_acquire__after_ctrl_dep();				\
>  	VAL;							\
>  })
> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> index 3b5bafc..695743c 100644
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -25,9 +25,8 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>  	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
>  		preempt_enable();
> -		do {
> -			cpu_relax();
> -		} while (test_bit(bitnum, addr));
> +		spin_do {
> +		} spin_while (test_bit(bitnum, addr));
>  		preempt_disable();
>  	}
>  #endif
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 984f73b..e7d395f 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -450,12 +450,9 @@ task_get_css(struct task_struct *task, int subsys_id)
>  	struct cgroup_subsys_state *css;
> 
>  	rcu_read_lock();
> -	while (true) {
> +	spin_do {
>  		css = task_css(task, subsys_id);
> -		if (likely(css_tryget_online(css)))
> -			break;
> -		cpu_relax();
> -	}
> +	} spin_until (likely(css_tryget_online(css)));
>  	rcu_read_unlock();
>  	return css;
>  }
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index ead9765..93ed609 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -108,12 +108,10 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
>  {
>  	unsigned ret;
> 
> -repeat:
> -	ret = READ_ONCE(s->sequence);
> -	if (unlikely(ret & 1)) {
> -		cpu_relax();
> -		goto repeat;
> -	}
> +	spin_do {
> +		ret = READ_ONCE(s->sequence);
> +	} spin_while (unlikely(ret & 1));
> +
>  	return ret;
>  }
> 
