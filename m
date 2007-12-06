Return-Path: <linux-kernel-owner+w=401wt.eu-S1754812AbXLFHTi@vger.kernel.org>
Date: Wed, 5 Dec 2007 23:19:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc4-mm1 Kernel build fails on S390x
Message-Id: <20071205231904.3dc4d130.akpm@linux-foundation.org>
In-Reply-To: <47576959.4040706@linux.vnet.ibm.com>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47576959.4040706@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux390@de.ibm.com, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 06 Dec 2007 08:45:37 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> Hi Andrew,
> 
> The 2.6.24-rc4-mm1 kernel build fails on s390x,
> 
>   CC      arch/s390/kernel/traps.o
> In file included from include/asm/thread_info.h:39,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/seqlock.h:29,
>                  from include/linux/time.h:8,
>                  from include/linux/timex.h:57,
>                  from include/linux/sched.h:53,
>                  from arch/s390/kernel/traps.c:17:
> include/asm/processor.h:191: warning: "struct seq_file" declared inside parameter list
> include/asm/processor.h:191: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/s390/kernel/traps.c: In function `task_show_regs':
> arch/s390/kernel/traps.c:226: error: implicit declaration of function `seq_printf'
> make[1]: *** [arch/s390/kernel/traps.o] Error 1
> make: *** [arch/s390/kernel] Error 2

thanks.

--- a/arch/s390/kernel/traps.c~proc-seqfile-convert-proc_pid_status-to-properly-handle-pid-namespaces-fix-2
+++ a/arch/s390/kernel/traps.c
@@ -24,6 +24,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/seq_file.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/kdebug.h>
diff -puN include/asm-s390/processor.h~proc-seqfile-convert-proc_pid_status-to-properly-handle-pid-namespaces-fix-2 include/asm-s390/processor.h
--- a/include/asm-s390/processor.h~proc-seqfile-convert-proc_pid_status-to-properly-handle-pid-namespaces-fix-2
+++ a/include/asm-s390/processor.h
@@ -165,6 +165,7 @@ struct stack_frame {
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
+struct seq_file;
 
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
_


Unfortunately the current greg-versus-git-s390 snafu means that I'm not
cross-building s390.
