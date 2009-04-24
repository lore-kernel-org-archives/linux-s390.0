From: Sachin Sant <sachinp@in.ibm.com>
Subject: Next April 24: [S390] allmodconfig build failure (trace/events)
Date: Fri, 24 Apr 2009 12:42:20 +0530
Message-ID: <49F16654.8040208@in.ibm.com>
References: <20090424150456.ff35e4ea.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090424150456.ff35e4ea.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Today's next tree build(s390 allmodconfig) failed with

kernel/built-in.o: In function `trace_softirq_entry'
include/trace/events/irq.h:42: undefined reference to 
`__tracepoint_softirq_entry'
include/trace/events/irq.h:42: undefined reference to 
`__tracepoint_softirq_entry'
kernel/built-in.o: In function `trace_softirq_exit':
include/trace/events/irq.h:48: undefined reference to 
`__tracepoint_softirq_exit'
include/trace/events/irq.h:48: undefined reference to 
`__tracepoint_softirq_exit'

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
