Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
Date: Tue, 23 Apr 2019 17:38:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
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
 <20190419153307.4f2911b5@mschwideX1>
 <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190423173859.42d5ba8b@mschwideX1>
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

On Fri, 19 Apr 2019 10:27:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Apr 19, 2019 at 6:33 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > That problem got stuck in my head and I thought more about it. Why not
> > emulate the static folding sequence in the s390 page table code?  
> 
> So this model seems much closer to what x86 does in its folding, where
> the pattern is basically
> 
> > static inline pX-1d_t *pXd_offset(pXd_t *pXd, unsigned long address)
> > {
> >         if (pXd_folded(pXd)
> >                 return (pX-1d_t *) pXd;
> >         return (pX-1d_t *) pXd_deref(*pXd) + pXd_index(address);
> > }  
> 
> which is really how the code is designed to work (ie the folded entry
> doesn't actually do anything to the page directory pointer, it just
> says "ok, we'll use this exact page directory pointer for the next
> lower level instead".
> 
> And that's very much what allows the generic gup code to load the
> entry once, and use a temporary, and as you walk down the chain, if it
> is folded it just then uses that (previous) temporary value for the
> next level instead. IOW, the lower level page table is hidden inside
> the upper level one, and folding just means "don't do any offsets,
> don't change any values, just use the entry as-is for the next lower
> level".
> 
> So I think that's the right thing to do.

Ok, I added two patches for my s390/linux:features branch

Martin Schwidefsky (2):
      s390/mm: make the pxd_offset functions more robust
      s390/mm: convert to the generic get_user_pages_fast code

All code changes are inside arch/s390, I plan to include these patches with
the next merge window. That gives us a little bit of time to run our tests.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
