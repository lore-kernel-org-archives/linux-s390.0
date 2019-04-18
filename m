Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1> <20190417100244.42e29736@mschwideX1>
 <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
 <20190418100218.0a4afd51@mschwideX1>
In-Reply-To: <20190418100218.0a4afd51@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Apr 2019 08:49:32 -0700
Message-ID: <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
Content-Type: text/plain; charset="UTF-8"
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
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 18, 2019 at 1:02 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> The problematic lines in the generic gup code are these three:
>
> 1845:   pmdp = pmd_offset(&pud, addr);
> 1888:   pudp = pud_offset(&p4d, addr);
> 1916:   p4dp = p4d_offset(&pgd, addr);
>
> Passing the pointer of a *copy* of a page table entry to pxd_offset() does
> not work with the page table folding on s390.

Hmm. I wonder why. x86 too does the folding thing for the p4d and pud case.

The folding works with the local copy just the same way it works with
the orignal value.

But I see that s390 does some other kind of folding and does that
addition of the p*d_index() unconditionally.

I guess that does mean that s390 will just have to have its own walker.

For the issue of the page refcount overflow it really isn't a huge
deal. Adding the refcount checking is simple (see the example patch I
gave for powerpc - you'll just have a couple of extra cases since you
do it all, rather than just the special hugetlb cases).

Obviously in general it would have been nicer to share as much code as
possible, but let's not make things unnecessarily complex if s390 is
just fundamentally different..

                   Linus
