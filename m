Return-Path: <pmladek@suse.com>
Date: Tue, 3 May 2016 11:07:16 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v2 10/18] livepatch/powerpc: add TIF_PATCH_PENDING
 thread flag
Message-ID: <20160503090716.GN2749@pathway.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <948131afc5d1e0fab00e78287a665d7b383cf884.1461875890.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <948131afc5d1e0fab00e78287a665d7b383cf884.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-04-28 15:44:41, Josh Poimboeuf wrote:
> Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
> per-task consistency model for powerpc.  The bit getting set indicates
> the thread has a pending patch which needs to be applied when the thread
> exits the kernel.
> 
> The bit is included in the _TIF_USER_WORK_MASK macro so that
> do_notify_resume() and klp_patch_task() get called when the bit is set.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/powerpc/include/asm/thread_info.h | 4 +++-
>  arch/powerpc/kernel/signal.c           | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 8febc3f..df262ca 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -88,6 +88,7 @@ static inline struct thread_info *current_thread_info(void)
>  					   TIF_NEED_RESCHED */
>  #define TIF_32BIT		4	/* 32 bit binary */
>  #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
> +#define TIF_PATCH_PENDING	6	/* pending live patching update */
>  #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
>  #define TIF_SINGLESTEP		8	/* singlestepping active */
>  #define TIF_NOHZ		9	/* in adaptive nohz mode */
> @@ -111,6 +112,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
>  #define _TIF_32BIT		(1<<TIF_32BIT)
>  #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
> +#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
>  #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
>  #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
>  #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
> @@ -127,7 +129,7 @@ static inline struct thread_info *current_thread_info(void)
>  
>  #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>  				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
> -				 _TIF_RESTORE_TM)
> +				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING)
>  #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
>  
>  /* Bits in local_flags */
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index cb64d6f..844497b 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -14,6 +14,7 @@
>  #include <linux/uprobes.h>
>  #include <linux/key.h>
>  #include <linux/context_tracking.h>
> +#include <linux/livepatch.h>
>  #include <asm/hw_breakpoint.h>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
> @@ -159,6 +160,9 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
>  		tracehook_notify_resume(regs);
>  	}
>  
> +	if (thread_info_flags & _TIF_PATCH_PENDING)
> +		klp_patch_task(current);
> +

JFYI, if we later add the fake signal to speed up migration of
sleeping task, we would need to move this up before calling
do_signal(). It would help to avoid cycling here twice.
Mirek surely knows more details about it.

Best Regards,
Petr

>  	user_enter();
>  }
>  
> -- 
> 2.4.11
> 
