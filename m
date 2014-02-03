Return-Path: <owner-linux-mm@kvack.org>
Date: Mon, 3 Feb 2014 14:53:21 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 1/3] Revert "thp: make MADV_HUGEPAGE check for
 mm->def_flags"
Message-ID: <20140203145321.7de2bcf1@thinkpad>
In-Reply-To: <20140131145224.7f8efc67d882a2e1a89b0778@linux-foundation.org>
References: <1391192628-113858-1-git-send-email-athorlton@sgi.com>
	<1391192628-113858-3-git-send-email-athorlton@sgi.com>
	<20140131145224.7f8efc67d882a2e1a89b0778@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Thorlton <athorlton@sgi.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sasha Levin <sasha.levin@oracle.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 31 Jan 2014 14:52:24 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 31 Jan 2014 12:23:43 -0600 Alex Thorlton <athorlton@sgi.com> wrote:
> 
> > This reverts commit 8e72033f2a489b6c98c4e3c7cc281b1afd6cb85cm, and adds
> 
> 'm' is not a hex digit ;)
> 
> > in code to fix up any issues caused by the revert.
> > 
> > The revert is necessary because hugepage_madvise would return -EINVAL
> > when VM_NOHUGEPAGE is set, which will break subsequent chunks of this
> > patch set.
> 
> This is a bit skimpy.  Why doesn't the patch re-break kvm-on-s390?
> 
> it would be nice to have a lot more detail here, please.  What was the
> intent of 8e72033f2a48, how this patch retains 8e72033f2a48's behavior,
> etc.

The intent of 8e72033f2a48 was to guard against any future programming
errors that may result in an madvice(MADV_HUGEPAGE) on guest mappings,
which would crash the kernel.

Martin suggested adding the bit to arch/s390/mm/pgtable.c, if 8e72033f2a48
was to be reverted, because that check will also prevent a kernel crash
in the case described above, it will now send a SIGSEGV instead.

This would now also allow to do the madvise on other parts, if needed,
so it is a more flexible approach. One could also say that it would have
been better to do it this way right from the beginning...
 
> > --- a/arch/s390/mm/pgtable.c
> > +++ b/arch/s390/mm/pgtable.c
> > @@ -504,6 +504,9 @@ static int gmap_connect_pgtable(unsigned long address, unsigned long segment,
> >  	if (!pmd_present(*pmd) &&
> >  	    __pte_alloc(mm, vma, pmd, vmaddr))
> >  		return -ENOMEM;
> > +	/* large pmds cannot yet be handled */
> > +	if (pmd_large(*pmd))
> > +		return -EFAULT;
> 
> This bit wasn't in 8e72033f2a48.

Yes, in order to be on the safe side regarding potential distribution
backports, it would be good to have the revert and the "replacement"
in the same patch.

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
