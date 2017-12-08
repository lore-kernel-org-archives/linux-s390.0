From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 08 Dec 2017 06:15:42 +0000
Subject: Re: [pmladek:for-next 5/7] arch/s390/include/asm/mmu_context.h:111:0: warning:
Message-Id: <20171208061542.GE628@jagdpanzerIV>
In-Reply-To: <20171208070523.5c225699@mschwideX1>
References: <20171208070523.5c225699@mschwideX1>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On (12/08/17 07:05), Martin Schwidefsky wrote:
> > On (12/08/17 11:05), Sergey Senozhatsky wrote:
> > > 
> > > On (12/08/17 02:07), kbuild test robot wrote:  
> > > > All warnings (new ones prefixed by >>):
> > > > 
> > > >    In file included from arch/s390/include/asm/elf.h:141:0,
> > > >                     from include/linux/elf.h:5,
> > > >                     from include/linux/module.h:15,
> > > >                     from include/linux/kallsyms.h:13,
> > > >                     from kernel//sched/autogroup.c:6:  
> > > > >> arch/s390/include/asm/mmu_context.h:111:0: warning: "finish_arch_post_lock_switch" redefined  
> > > >     #define finish_arch_post_lock_switch finish_arch_post_lock_switch
> > > >     
> > > >    In file included from kernel//sched/autogroup.c:2:0:
> > > >    kernel//sched/sched.h:1328:0: note: this is the location of the previous definition
> > > >     # define finish_arch_post_lock_switch() do { } while (0)  
> > 
> > 
> > any chance you can help us out?
> 
> Move the include of "sched.h" in autogroup.c after all the other
> includes. For the #ifndef in sched.h to work the arch specific
> definition in mmu_context.h needs to be seen first.

yes, makes sense. care to submit a patch?

for now on I sent out a patch that removes the problematic kallsyms.h
include from autogroup.c, it doesn't need it anyway. but I agree that
that shed.h include [I didn't even notice it until you pointed that out]
better be the last one, indeed.

	-ss
