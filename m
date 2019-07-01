Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtp.duncanthrax.net ([89.31.1.170]:35385 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGARJD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 13:09:03 -0400
Date: Mon, 1 Jul 2019 19:08:53 +0200
From: Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH RFC] generic ELF support for kexec
Message-ID: <20190701170853.GD19243@t470p.stackframe.org>
References: <20190625185433.GA10934@t470p.stackframe.org>
 <87o92isbxg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o92isbxg.fsf@concordia.ellerman.id.au>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org, deller@gmx.de, linuxppc-dev@lists.ozlabs.org

Hi Michael,

On Fri, Jun 28, 2019 at 12:04:11PM +1000, Michael Ellerman wrote:
> Sven Schnelle <svens@stackframe.org> writes:
>   https://github.com/linuxppc/wiki/wiki/Booting-with-Qemu
> 
> But I'm not sure where you get a version of kexec that uses kexec_file().

kexec-tools HEAD supports it, so that's not a problem.

> > If that change is acceptable i would finish the patch and submit it. I think
> > best would be to push this change through Helge's parisc tree, so we don't
> > have any dependencies to sort out.
> 
> That will work for you but could cause us problems if we have any
> changes that touch that code.
> 
> It's easy enough to create a topic branch with just that patch that both
> of us merge.

What should be the base branch for that patch? Christophe suggested the
powerpc/merge branch?

> >  #include <linux/elf.h>
> >  #include <linux/kexec.h>
> >  #include <linux/libfdt.h>
> > @@ -31,540 +29,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  
> > -#define PURGATORY_STACK_SIZE	(16 * 1024)
> 
> This is unused AFAICS. We should probably remove it explicitly rather
> than as part of this patch.

I have one patch right now. If wanted i can split up all the changes
suggested during the review into smaller pieces, whatever you prefer.

> Or that.
> 
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +#define elf_addr_to_cpu	elf64_to_cpu
> 
> Why are we doing that rather than just using elf64_to_cpu directly?
> 
> > +#ifndef Elf_Rel
> > +#define Elf_Rel		Elf64_Rel
> > +#endif /* Elf_Rel */
> 
> And that?

Don't know - ask the PPC people :-)

Regards
Sven
