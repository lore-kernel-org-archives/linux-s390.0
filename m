From: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: Next April 24: [S390] allmodconfig build failure (trace/events)
Date: Wed, 29 Apr 2009 15:21:39 +0530
Message-ID: <49F8232B.4090007@in.ibm.com>
References: <20090424150456.ff35e4ea.sfr@canb.auug.org.au> <49F16654.8040208@in.ibm.com> <20090424072533.GE24912@elte.hu> <20090424104108.0f2c0f05@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090424104108.0f2c0f05@osiris.boeblingen.de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, =?ISO-8859-1?Q?Fr=E9d=E9ric_W?= =?ISO-8859-1?Q?eisbecker?= <fweisbec@gmail.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Heiko Carstens wrote:
> On Fri, 24 Apr 2009 09:25:33 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
>
>   
>> * Sachin Sant <sachinp@in.ibm.com> wrote:
>>
>>     
>>> Today's next tree build(s390 allmodconfig) failed with
>>>
>>> kernel/built-in.o: In function `trace_softirq_entry'
>>> include/trace/events/irq.h:42: undefined reference to  
>>> `'
>>> include/trace/events/irq.h:42: undefined reference to  
>>> `__tracepoint_softirq_entry'
>>> kernel/built-in.o: In function `trace_softirq_exit':
>>> include/trace/events/irq.h:48: undefined reference to  
>>> `__tracepoint_softirq_exit'
>>> include/trace/events/irq.h:48: undefined reference to  
>>> `__tracepoint_softirq_exit'
>>>       
>> Hm, that's weird - s390 does not build kernel/softirq.o? Hm, it does 
>> - softirq.o is an obj-y object.
>>     
>
> s390 does build kernel/softirq.o. However it's anything but obvious to
> me how the tracepoint infrastructure works. Too many #ifdefs, #define's
> and #undefine's...
>
> I would expect that struct __tracepoint_softirq_entry somehow gets
> defined via one of the TRACE_FORMAT macros, no?
Today's next tree also has this failure. Any solution for this problem ?

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
