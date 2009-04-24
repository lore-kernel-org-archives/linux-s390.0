From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Next April 24: [S390] allmodconfig build failure (trace/events)
Date: Fri, 24 Apr 2009 09:25:33 +0200
Message-ID: <20090424072533.GE24912@elte.hu>
References: <20090424150456.ff35e4ea.sfr@canb.auug.org.au> <49F16654.8040208@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49F16654.8040208@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>
List-ID: <linux-s390.vger.kernel.org>


* Sachin Sant <sachinp@in.ibm.com> wrote:

> Today's next tree build(s390 allmodconfig) failed with
>
> kernel/built-in.o: In function `trace_softirq_entry'
> include/trace/events/irq.h:42: undefined reference to  
> `__tracepoint_softirq_entry'
> include/trace/events/irq.h:42: undefined reference to  
> `__tracepoint_softirq_entry'
> kernel/built-in.o: In function `trace_softirq_exit':
> include/trace/events/irq.h:48: undefined reference to  
> `__tracepoint_softirq_exit'
> include/trace/events/irq.h:48: undefined reference to  
> `__tracepoint_softirq_exit'

Hm, that's weird - s390 does not build kernel/softirq.o? Hm, it does 
- softirq.o is an obj-y object.

	Ingo
