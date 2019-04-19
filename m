Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
Date: Fri, 19 Apr 2019 15:33:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190418204144.16adf2a0@mschwideX1>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1>
 <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1>
 <20190417100244.42e29736@mschwideX1>
 <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
 <20190418100218.0a4afd51@mschwideX1>
 <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
 <20190418204144.16adf2a0@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190419153307.4f2911b5@mschwideX1>
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

On Thu, 18 Apr 2019 20:41:44 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Thu, 18 Apr 2019 08:49:32 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Thu, Apr 18, 2019 at 1:02 AM Martin Schwidefsky
> > <schwidefsky@de.ibm.com> wrote:  
> > >
> > > The problematic lines in the generic gup code are these three:
> > >
> > > 1845:   pmdp = pmd_offset(&pud, addr);
> > > 1888:   pudp = pud_offset(&p4d, addr);
> > > 1916:   p4dp = p4d_offset(&pgd, addr);
> > >
> > > Passing the pointer of a *copy* of a page table entry to pxd_offset() does
> > > not work with the page table folding on s390.    
> > 
> > Hmm. I wonder why. x86 too does the folding thing for the p4d and pud case.
> > 
> > The folding works with the local copy just the same way it works with
> > the orignal value.  
> 
> The difference is that with the static page table folding pgd_offset()
> does the index calculation of the actual hardware top-level table. With
> dynamic page table folding as s390 is doing it, if the task does not use
> a 5-level page table pgd_offset() will see a pgd_index() of 0, the indexing
> of the actual top-level table is done later with p4d_offset(), pud_offset()
> or pmd_offset(). 
> 
> As an example, with a three level page table we have three indexes x/y/z.
> The common code "thinks" 5 indexing steps, with static folding the index
> sequence is x 0 0 y z. With dynamic folding the sequence is 0 0 x y z.
> By moving the first indexing operation to pgd_offset the static sequence
> does not add an index to a non-dereferenced pointer to a stack variable,
> the dynamic sequence does.

That problem got stuck in my head and I thought more about it. Why not
emulate the static folding sequence in the s390 page table code?

As the table type is encoded in every entry for the region and segment
tables, pgd_offset() can look at the first entry to find the table type
and then do the correct index calculation for the given top-level table.
Like this:

static inline pgd_t *pgd_offset_raw(pgd_t *pgd, unsigned long address)
{
        unsigned long rste;
        unsigned int shift;

        /* Get the first entry of the top level table */
        rste = pgd_val(*pgd);
        /* Pick up the shift from the table type of the first entry */
        shift = ((rste & _REGION_ENTRY_TYPE_MASK) >> 2) * 11 + 20;
        return pgd + ((address >> shift) & (PTRS_PER_PGD - 1));
}

#define pgd_offset(mm, address) pgd_offset_raw((mm)->pgd, address)
#define pgd_offset_k(address) pgd_offset(&init_mm, address)

static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
{
        if ((pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R1)
                return (p4d_t *) pgd;
        return (p4d_t *) pgd_deref(*pgd) + p4d_index(address);
}

static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
{
        if ((p4d_val(*p4d) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R2)
                return (pud_t *) p4d;
        return (pud_t *) p4d_deref(*p4d) + pud_index(address);
}

static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
{
        if ((pud_val(*pud) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R3)
                return (pmd_t *) pud;
        return (pmd_t *) pud_deref(*pud) + pmd_index(address);
}

This needs more thorough testing but in principle it does work. The kernel
boots and survives a kernel compile. The only things that is slightly off is
that pgd_offset() now has to look at the first table entry to do its job.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
