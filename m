Return-Path: <linux-kernel-owner+w=401wt.eu-S1753320AbXLFDPx@vger.kernel.org>
Message-ID: <47576959.4040706@linux.vnet.ibm.com>
Date: Thu, 06 Dec 2007 08:45:37 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: 2.6.24-rc4-mm1 Kernel build fails on S390x
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
In-Reply-To: <20071204211701.994dfce6.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux390@de.ibm.com, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Andrew,

The 2.6.24-rc4-mm1 kernel build fails on s390x,

  CC      arch/s390/kernel/traps.o
In file included from include/asm/thread_info.h:39,
                 from include/linux/thread_info.h:21,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:57,
                 from include/linux/sched.h:53,
                 from arch/s390/kernel/traps.c:17:
include/asm/processor.h:191: warning: "struct seq_file" declared inside parameter list
include/asm/processor.h:191: warning: its scope is only this definition or declaration, which is probably not what you want
arch/s390/kernel/traps.c: In function `task_show_regs':
arch/s390/kernel/traps.c:226: error: implicit declaration of function `seq_printf'
make[1]: *** [arch/s390/kernel/traps.o] Error 1
make: *** [arch/s390/kernel] Error 2

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
