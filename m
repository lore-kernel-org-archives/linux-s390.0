From: Sachin Sant <sachinp@in.ibm.com>
Subject: [-next Sept 13] s390 build break  [nclude/linux/interrupt.h:local_softirq_pending()]
Date: Mon, 13 Sep 2010 16:32:28 +0530
Message-ID: <4C8E04C4.4060508@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, laijs@cn.fujitsu.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Today's next build failed on a s390 box with following

In file included from /tmp/build/linux/arch/s390/include/asm/hardirq.h:18,
       from include/linux/hardirq.h:10,
       from include/linux/pagemap.h:15,
       from include/linux/blkdev.h:12,
       from init/do_mounts.h:2,
       from init/do_mounts_initrd.c:11:
include/linux/interrupt.h: In function '__raise_softirq_irqoff':
include/linux/interrupt.h:429: error: implicit declaration of function 'local_softirq_pending'
include/linux/interrupt.h:429: error: lvalue required as left operand of assignment
In file included from /tmp/build/linux/arch/s390/include/asm/hardirq.h:18,
       from include/linux/hardirq.h:10,
       from include/linux/ftrace_event.h:7,
       from include/trace/syscall.h:6,
       from include/linux/syscalls.h:76,
       from init/initramfs.c:9:
include/linux/interrupt.h: In function '__raise_softirq_irqoff':
include/linux/interrupt.h:429: error: implicit declaration of function 'local_softirq_pending'
include/linux/interrupt.h:429: error: lvalue required as left operand of assignment
make[1]: *** [init/do_mounts_initrd.o] Error 1

and many more similar errors ..

The following commit added the code in question.

commit 2bf2160d8805de64308e2e7c3cd97813cb58ed2f
irq: Add tracepoint to softirq_raise

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
