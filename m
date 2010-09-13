From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next Sept 13] s390 build break
 [nclude/linux/interrupt.h:local_softirq_pending()]
Date: Mon, 13 Sep 2010 17:42:49 +0200
Message-ID: <20100913154249.GC2310@osiris.boeblingen.de.ibm.com>
References: <4C8E04C4.4060508@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C8E04C4.4060508@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, laijs@cn.fujitsu.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Sep 13, 2010 at 04:32:28PM +0530, Sachin Sant wrote:
> Today's next build failed on a s390 box with following
> 
> In file included from /tmp/build/linux/arch/s390/include/asm/hardirq.h:18,
>       from include/linux/hardirq.h:10,
>       from include/linux/pagemap.h:15,
>       from include/linux/blkdev.h:12,
>       from init/do_mounts.h:2,
>       from init/do_mounts_initrd.c:11:
> include/linux/interrupt.h: In function '__raise_softirq_irqoff':
> include/linux/interrupt.h:429: error: implicit declaration of function 'local_softirq_pending'
> include/linux/interrupt.h:429: error: lvalue required as left operand of assignment
> In file included from /tmp/build/linux/arch/s390/include/asm/hardirq.h:18,
>       from include/linux/hardirq.h:10,
>       from include/linux/ftrace_event.h:7,
>       from include/trace/syscall.h:6,
>       from include/linux/syscalls.h:76,
>       from init/initramfs.c:9:
> include/linux/interrupt.h: In function '__raise_softirq_irqoff':
> include/linux/interrupt.h:429: error: implicit declaration of function 'local_softirq_pending'
> include/linux/interrupt.h:429: error: lvalue required as left operand of assignment
> make[1]: *** [init/do_mounts_initrd.o] Error 1
> 
> and many more similar errors ..
> 
> The following commit added the code in question.
> 
> commit 2bf2160d8805de64308e2e7c3cd97813cb58ed2f
> irq: Add tracepoint to softirq_raise

Yes, header include dependencies suck here. But it's easy to fix since most
of the includes in s390's hardirq.h aren't necessary:

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index 498bc38..881d945 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -12,10 +12,6 @@
 #ifndef __ASM_HARDIRQ_H
 #define __ASM_HARDIRQ_H
 
-#include <linux/threads.h>
-#include <linux/sched.h>
-#include <linux/cache.h>
-#include <linux/interrupt.h>
 #include <asm/lowcore.h>
 
 #define local_softirq_pending() (S390_lowcore.softirq_pending)
