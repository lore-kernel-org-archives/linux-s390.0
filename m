From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH/RFC 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
Date: Tue, 26 Jan 2016 21:38:52 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601262138260.3886@nanos>
References: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com> <1453799905-10941-4-git-send-email-borntraeger@de.ibm.com> <20160126181903.GB4671@osiris>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160126181903.GB4671@osiris>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Jan 2016, Heiko Carstens wrote:
> On Tue, Jan 26, 2016 at 10:18:25AM +0100, Christian Borntraeger wrote:
> > We can use debug_pagealloc_enabled() to check if we can map
> > the identity mapping with 1MB/2GB pages as well as to print
> > the current setting in dump_stack.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  arch/s390/kernel/dumpstack.c |  4 +++-
> >  arch/s390/mm/vmem.c          | 10 ++++------
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
> > index dc8e204..a1c0530 100644
> > --- a/arch/s390/kernel/dumpstack.c
> > +++ b/arch/s390/kernel/dumpstack.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/export.h>
> >  #include <linux/kdebug.h>
> >  #include <linux/ptrace.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/sched.h>
> >  #include <asm/processor.h>
> > @@ -186,7 +187,8 @@ void die(struct pt_regs *regs, const char *str)
> >  	printk("SMP ");
> >  #endif
> >  #ifdef CONFIG_DEBUG_PAGEALLOC
> > -	printk("DEBUG_PAGEALLOC");
> > +	printk("DEBUG_PAGEALLOC(%s)",
> > +		debug_pagealloc_enabled() ? "enabled" : "disabled");
> >  #endif
> 
> I'd prefer if you change this to
> 
> 	if (debug_pagealloc_enabled())
> 		printk("DEBUG_PAGEALLOC");
> 
> That way we can get rid of yet another ifdef. Having
> "DEBUG_PAGEALLOC(disabled)" doesn't seem to be very helpful.

Yes, same for x86 please.

Thanks,

	tglx

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
