Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
Date: Thu, 18 Apr 2019 10:02:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190418100218.0a4afd51@mschwideX1>
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

On Wed, 17 Apr 2019 09:57:01 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Apr 17, 2019 at 1:02 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > Grumpf, that does *not* work. For gup the table entries may be read only
> > once. Now I remember why I open-coded p4d_offset, pud_offset and pmd_offset
> > in arch/s390/mm/gup.c, to avoid to read the table entries twice.
> > It will be hard to use the common gup code after all.  
> 
> Hmm. The common gup code generally should do the "read only once"
> thing too (since by definition the gup-fast case is done without
> locking), although it's probably the case that most architectures
> simply don't care.
> 
> What would it require for the generic code to work for s390?

The problematic lines in the generic gup code are these three:

1845:	pmdp = pmd_offset(&pud, addr);
1888:	pudp = pud_offset(&p4d, addr);
1916:	p4dp = p4d_offset(&pgd, addr);

Passing the pointer of a *copy* of a page table entry to pxd_offset() does
not work with the page table folding on s390. The pxd_offset() function
on s390 have to make a choice, either return the dereferenced value behind
the passed pointer (that works) or return the original page table pointer
if the table level is folded (that does not work).

To fix this we would need three new helpers pmd_offset_orig, pud_offset_orig
and p4d_offset_orig, their generic definition would look like this:

#define p4d_offset_orig(pgdp, pgd, address)    p4d_offset(&pgd, address)
#define pud_offset_orig(p4dp, p4d, address)    pud_offset(&p4d, address)
#define pmd_offset_orig(pudp, pud, address)    pmd_offset(&pud, address)

For the s390 definition see the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git generic-gup

A quick test with this branch shows everything working normally.
Keeping my fingers crossed that I did not miss anything.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
