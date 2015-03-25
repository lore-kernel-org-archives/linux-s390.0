Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <1427317867.6468.87.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Mar 2015 08:11:07 +1100
In-Reply-To: <20150325183647.GA9331@gmail.com>
References: <20150325121118.GA2542@gmail.com>
	 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
	 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
	 <20150325183316.GA9090@gmail.com> <20150325183647.GA9331@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20150325211107.KAahTP9Dj9XAqy5pwdZdUZSxeL_krTa_mwpholLaMK0@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-mm@kvack.org, cov@codeaurora.org, criu@openvz.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2015-03-25 at 19:36 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > > +#define __HAVE_ARCH_REMAP
> > > +static inline void arch_remap(struct mm_struct *mm,
> > > +			      unsigned long old_start, unsigned long old_end,
> > > +			      unsigned long new_start, unsigned long new_end)
> > > +{
> > > +	/*
> > > +	 * mremap() doesn't allow moving multiple vmas so we can limit the
> > > +	 * check to old_start == vdso_base.
> > > +	 */
> > > +	if (old_start == mm->context.vdso_base)
> > > +		mm->context.vdso_base = new_start;
> > > +}
> > 
> > mremap() doesn't allow moving multiple vmas, but it allows the 
> > movement of multi-page vmas and it also allows partial mremap()s, 
> > where it will split up a vma.
> 
> I.e. mremap() supports the shrinking (and growing) of vmas. In that 
> case mremap() will unmap the end of the vma and will shrink the 
> remaining vDSO vma.
> 
> Doesn't that result in a non-working vDSO that should zero out 
> vdso_base?

Right. Now we can't completely prevent the user from shooting itself in
the foot I suppose, though there is a legit usage scenario which is to
move the vDSO around which it would be nice to support. I think it's
reasonable to put the onus on the user here to do the right thing.

Cheers,
Ben.

> Thanks,
> 
> 	Ingo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
