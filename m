Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
Date: Wed, 17 Apr 2019 10:02:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190417094637.51ad4c67@mschwideX1>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1>
 <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190417100244.42e29736@mschwideX1>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Apr 2019 09:46:37 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Tue, 16 Apr 2019 09:49:46 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Tue, Apr 16, 2019 at 9:16 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:  
> > >
> > > We actually already *have* this function.
> > >
> > > It's called "gup_fast_permitted()" and it's used by x86-64 to verify
> > > the proper address range. Exactly like s390 needs..
> > >
> > > Could you please use that instead?    
> > 
> > IOW, something like the attached.
> > 
> > Obviously untested. And maybe 'current' isn't declared in
> > <asm/pgtable.h>, in which case you'd need to modify it to instead make
> > the inline function be "s390_gup_fast_permitted()" that takes a
> > pointer to the mm, and do something like
> > 
> >   #define gup_fast_permitted(start, pages) \
> >          s390_gup_fast_permitted(current->mm, start, pages)
> > 
> > instead.
> > 
> > But I think you get the idea..  
> 
> Nice, I did not realize that gup_fast_permitted is a platform
> override-able function. So that part is doable in arch/s390. But I
> spoke to soon, I got my first crash and realized that the common gup code
> is not usable as it is. The reason is this e.g. this sequence:
> 
> 	pgdp = pgd_offset(current->mm, addr);
> 	pgd_t pgd = READ_ONCE(*pgdp);
> 	/* some checking on pgd */
> 	gup_p4d_range(pgd, addr, next, write, pages, nr);
> 
> 	p4dp = p4d_offset(&pgd, addr);
> 	p4d_t p4d = READ_ONCE(*p4dp);
> 	/* some checking on p4d */
> 	gup_pud_range(p4d, addr, next, write, pages, nr);
> 
> 	pudp = pud_offset(&p4d, addr);
> 	pud_t pud = READ_ONCE(*pudp);
> 	/* some checking on pud */
> 	gup_pmd_range(pud, addr, next, write, pages, nr;
> 
> Each step along the way will read the page table entry and pass the
> table entry to the next function. This clashes with the page table
> folding on s390. The s390 gup code looks more like this:
> 
> 	pgdp = pgd_offset(current->mm, addr);
> 	/* some checking on pgd */
> 	pgd_t pgd = READ_ONCE(*pgdp);
> 	gup_p4d_range(pgdp, pgd, addr, next, write, pages, &nr);
> 
> 	p4dp = p4d_offset(pgdp, addr);
> 	p4d_t p4d = READ_ONCE(*p4dp);
> 	/* some checking on p4d */
> 	gup_pud_range(p4dp, p4d, addr, next, write, pages, nr);
> 
> 	pudp = pud_offset(p4dp, addr);
> 	pud_t pud = READ_ONCE(*pudp);
> 	/* some checking on pud */
> 	gup_pmd_range(pudp, pud, addr, next, write, pages, nr;
> 
> There are magic dereferences in the s390 versions of p4d_offset,
> pud_offset and pmd_offset functions. To make this work the pointer
> passed to these functions may not be the local copy of the already
> dereferenced table entry. I'll cook up a patch for the common code.

Grumpf, that does *not* work. For gup the table entries may be read only
once. Now I remember why I open-coded p4d_offset, pud_offset and pmd_offset
in arch/s390/mm/gup.c, to avoid to read the table entries twice.
It will be hard to use the common gup code after all.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
