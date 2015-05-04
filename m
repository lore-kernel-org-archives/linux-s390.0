Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 May 2015 14:23:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC kgr on klp 4/9] livepatch: add kgr infrastructure
Message-ID: <20150504142301.1405a5c0@mschwide>
In-Reply-To: <1430739625-4658-4-git-send-email-jslaby@suse.cz>
References: <1430739625-4658-1-git-send-email-jslaby@suse.cz>
	<1430739625-4658-4-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: live-patching@vger.kernel.org, jpoimboe@redhat.com, sjenning@redhat.com, jkosina@suse.cz, vojtech@suse.cz, mingo@redhat.com, linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  4 May 2015 13:40:20 +0200
Jiri Slaby <jslaby@suse.cz> wrote:

> This means:
> * add a per-thread flag to indicate whether a task is in the old or in
>   the new universe,
> * reset it in _slow_ paths of syscall's entry/exit,
> * add helpers around the flag to sched.h,
> * export the status in /proc/<pid>/kgr_in_progress,

> @@ -217,6 +226,7 @@ ENTRY(system_call)
>  	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
>  	stg	%r14,__PT_FLAGS(%r11)
>  .Lsysc_do_svc:
> +	HANDLE_KGRAFT %r12
>  	lg	%r10,__TI_sysc_table(%r12)	# address of system call table
>  	llgh	%r8,__PT_INT_CODE+2(%r11)
>  	slag	%r8,%r8,2			# shift and test for svc 0

This is not the slow path, .Lsysc_do_svc is on the main svc path. It is
"only" two instruction but nevertheless this should be avoided.
One way is to combine it with the _TIF_TRACE mechanics:

.Lsysc_nr_ok:
        xc      __SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
        stg     %r2,__PT_ORIG_GPR2(%r11)
        stg     %r7,STACK_FRAME_OVERHEAD(%r15)
        lgf     %r9,0(%r8,%r10)                 # get system call add.
 ->     tm      __TI_flags+6(%r12),_TIF_TRACE>>8
 ->     jnz     .Lsysc_tracesys
        basr    %r14,%r9                        # call sys_xxxx
        stg     %r2,__PT_R2(%r11)               # store return value

Add _TIF_KGR_IN_PROGRESS to _TIF_TRACE and branch to a new label,
e.g. to .Lsysc_trace. Distinguish between _TIF_KGR_IN_PROGRESS and
the other trace reasons and either call s390_handle_kgraft or
do_syscall_trace_enter / do_syscall_trace_exit.

The same for the exit work, add _TIF_KGR_IN_PROGRESS to _TIF_WORK
and sort out the reason in .Lsysc_work. That avoids another two
instructions on the main system call path.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
