Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 13 May 2019 14:24:24 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190513122424.ynaox4v77uhgmvn6@pathway.suse.cz>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <20190510183258.1f6c4153@mschwideX1>
 <20190510124058.0d44b441@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510124058.0d44b441@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190513122424.Bzyc5wNhgHc3y9K3Vn-j74_9etFbZZ5gQ1QPdKl6DWc@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri 2019-05-10 12:40:58, Steven Rostedt wrote:
> On Fri, 10 May 2019 18:32:58 +0200
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > On Fri, 10 May 2019 12:24:01 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 10 May 2019 10:42:13 +0200
> > > Petr Mladek <pmladek@suse.com> wrote:
> > >   
> > > >  static const char *check_pointer_msg(const void *ptr)
> > > >  {
> > > > -	char byte;
> > > > -
> > > >  	if (!ptr)
> > > >  		return "(null)";
> > > >  
> > > > -	if (probe_kernel_address(ptr, byte))
> > > > +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > > >  		return "(efault)";
> > > >      
> > > 
> > > 
> > > 	< PAGE_SIZE ?
> > > 
> > > do you mean: < TASK_SIZE ?  
> > 
> > The check with < TASK_SIZE would break on s390. The 'ptr' is
> > in the kernel address space, *not* in the user address space.
> > Remember s390 has two separate address spaces for kernel/user
> > the check < TASK_SIZE only makes sense with a __user pointer.
> > 
> 
> So we allow this to read user addresses? Can't that cause a fault?

I did some quick check and did not found anywhere a user pointer
being dereferenced via vsprintf().

In each case, %s did the check (ptr < PAGE_SIZE) even before this
patchset. The other checks are in %p format modifiers that are
used to print various kernel structures.

Finally, it accesses the pointer directly. I am not completely sure
but I think that it would not work that easily with an address
from the user address space.

Best Regards,
Petr
