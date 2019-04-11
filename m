Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 11 Apr 2019 09:32:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 10/12] s390: avoid __builtin_return_address(n) on clang
In-Reply-To: <CAK8P3a2n+nEcaNrATQVO8NSGzfrMP5n+SrvjpTYcH4ikCN5LGg@mail.gmail.com>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-10-arnd@arndb.de>
        <20190410180357.3290d24f@mschwideX1>
        <20190410121421.1414e179@gandalf.local.home>
        <CAK8P3a2n+nEcaNrATQVO8NSGzfrMP5n+SrvjpTYcH4ikCN5LGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190411093234.5f212a2e@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 10 Apr 2019 21:07:56 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Apr 10, 2019 at 6:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 10 Apr 2019 18:03:57 +0200 Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >  
> > > > --- a/arch/s390/include/asm/ftrace.h
> > > > +++ b/arch/s390/include/asm/ftrace.h
> > > > @@ -13,7 +13,12 @@
> > > >
> > > >  #ifndef __ASSEMBLY__
> > > >
> > > > +#ifdef CONFIG_CC_IS_CLANG
> > > > +/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
> > > > +#define ftrace_return_address(n) __builtin_return_address(0)
> > > > +#else
> > > >  #define ftrace_return_address(n) __builtin_return_address(n)
> > > > +#endif
> > > >
> > > >  void _mcount(void);
> > > >  void ftrace_caller(void);  
> > >
> > > I can say I like this one. If the compiler can not do __builtin_return_address(n)
> > > it feels wrong to just use __builtin_return_address(0).  
> >
> > I agree. The proper return value is 0UL, see include/linux/ftrace.h
> >
> > /* Archs may use other ways for ADDR1 and beyond */
> > #ifndef ftrace_return_address
> > # ifdef CONFIG_FRAME_POINTER
> > #  define ftrace_return_address(n) __builtin_return_address(n)
> > # else
> > #  define ftrace_return_address(n) 0UL
> > # endif
> > #endif
> >
> > This is why we treat zero differently:
> >
> > #define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
> > #define CALLER_ADDR1 ((unsigned long)ftrace_return_address(1))
> > #define CALLER_ADDR2 ((unsigned long)ftrace_return_address(2))
> > #define CALLER_ADDR3 ((unsigned long)ftrace_return_address(3))
> > #define CALLER_ADDR4 ((unsigned long)ftrace_return_address(4))
> > #define CALLER_ADDR5 ((unsigned long)ftrace_return_address(5))
> > #define CALLER_ADDR6 ((unsigned long)ftrace_return_address(6))  
> 
> Right, got it.
> 
> Martin, do you want me to send a replacement patch, or can you
> commit the patch with
> 
> #ifdef CONFIG_CC_IS_CLANG
> /* https://bugs.llvm.org/show_bug.cgi?id=41424 */
> #define ftrace_return_address(n) 0UL
> #else
> #define ftrace_return_address(n) __builtin_return_address(n)
> #endif
> 
> instead?

Ok, done.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
