Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 10 May 2019 13:32:00 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190510043200.GC15652@jagdpanzerIV>
References: <20190509121923.8339-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509121923.8339-1-pmladek@suse.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190510043200.8FxCQhSO0N0LIZ4YtumRMpgw45VDU75TKeSE5eHU2dc@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On (05/09/19 14:19), Petr Mladek wrote:
> 1. Report on Power:
> 
> Kernel crashes very early during boot with with CONFIG_PPC_KUAP and
> CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
> 
> The problem is the combination of some new code called via printk(),
> check_pointer() which calls probe_kernel_read(). That then calls
> allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
> (before we've patched features). With the JUMP_LABEL debug enabled that
> causes us to call printk() & dump_stack() and we end up recursing and
> overflowing the stack.

Hmm... hmm... PPC does an .opd-based symbol dereference, which
eventually probe_kernel_read()-s. So early printk(%pS) will do

	printk(%pS)
	 dereference_function_descriptor()
	  probe_kernel_address()
	   dump_stack()
	    printk(%pS)
	     dereference_function_descriptor()
	      probe_kernel_address()
	       dump_stack()
	        printk(%pS)
	         ...

I'd say... that it's not vsprintf that we want to fix, it's
the idea that probe_kernel_address() can dump_stack() on any
platform. On some archs probe_kernel_address()->dump_stack()
is going nowhere:
 dump_stack() does probe_kernel_address(), which calls dump_stack(),
 which calls printk(%pS)->probe_kernel_address() again and again,
 and again.

	-ss
