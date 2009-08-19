From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Next Aug 19: s390 build failure (arch/s390/kernel/built-in)
Date: Wed, 19 Aug 2009 13:46:46 +0200
Message-ID: <20090819114646.GB32317@elte.hu>
References: <20090819190233.86e78493.sfr@canb.auug.org.au> <4A8BDE59.2010400@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A8BDE59.2010400@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


* Sachin Sant <sachinp@in.ibm.com> wrote:

> Today's next build failed on s390 with following errors.
>
>  LD      .tmp_vmlinux1
> arch/s390/kernel/built-in.o: In function `trace_syscall_exit':
> include/trace/syscall.h:21: undefined reference to `__tracepoint_syscall_exit'
> include/trace/syscall.h:21: undefined reference to `__tracepoint_syscall_exit'
> arch/s390/kernel/built-in.o: In function `trace_syscall_enter':
> include/trace/syscall.h:14: undefined reference to `__tracepoint_syscall_enter'
> include/trace/syscall.h:14: undefined reference to `__tracepoint_syscall_enter'
> make: *** [.tmp_vmlinux1] Error 1

Could you please send the .config that triggers this?

Thanks,

	Ingo
