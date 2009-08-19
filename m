From: Sachin Sant <sachinp@in.ibm.com>
Subject: Next Aug 19: s390 build failure (arch/s390/kernel/built-in)
Date: Wed, 19 Aug 2009 16:43:29 +0530
Message-ID: <4A8BDE59.2010400@in.ibm.com>
References: <20090819190233.86e78493.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090819190233.86e78493.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Today's next build failed on s390 with following errors.

  LD      .tmp_vmlinux1
arch/s390/kernel/built-in.o: In function `trace_syscall_exit':
include/trace/syscall.h:21: undefined reference to `__tracepoint_syscall_exit'
include/trace/syscall.h:21: undefined reference to `__tracepoint_syscall_exit'
arch/s390/kernel/built-in.o: In function `trace_syscall_enter':
include/trace/syscall.h:14: undefined reference to `__tracepoint_syscall_enter'
include/trace/syscall.h:14: undefined reference to `__tracepoint_syscall_enter'
make: *** [.tmp_vmlinux1] Error 1

thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
