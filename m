Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
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
 <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
 <20190418204144.16adf2a0@mschwideX1> <20190419153307.4f2911b5@mschwideX1>
In-Reply-To: <20190419153307.4f2911b5@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Apr 2019 10:27:17 -0700
Message-ID: <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
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

On Fri, Apr 19, 2019 at 6:33 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> That problem got stuck in my head and I thought more about it. Why not
> emulate the static folding sequence in the s390 page table code?

So this model seems much closer to what x86 does in its folding, where
the pattern is basically

> static inline pX-1d_t *pXd_offset(pXd_t *pXd, unsigned long address)
> {
>         if (pXd_folded(pXd)
>                 return (pX-1d_t *) pXd;
>         return (pX-1d_t *) pXd_deref(*pXd) + pXd_index(address);
> }

which is really how the code is designed to work (ie the folded entry
doesn't actually do anything to the page directory pointer, it just
says "ok, we'll use this exact page directory pointer for the next
lower level instead".

And that's very much what allows the generic gup code to load the
entry once, and use a temporary, and as you walk down the chain, if it
is folded it just then uses that (previous) temporary value for the
next level instead. IOW, the lower level page table is hidden inside
the upper level one, and folding just means "don't do any offsets,
don't change any values, just use the entry as-is for the next lower
level".

So I think that's the right thing to do.

Looking at the s390 code, it seems to fold things the other way,
conceptually hiding the upper level inside the lower one, and always
doing the offset thing (but just avoiding the dereference).

Maybe there's some reason why the s390 code does it that way, but I
think your new model is the right one, and hopefully means you can use
the generic page table walking more easily.

Of course, the s390 folding is very different from the x86 one (or the
generic fixed 3-level of 4-level cases). The x86 folding doesn't
depend on the contents of the page tables, it's just entirely static
(well, the 5th level is conditional, but it's conditional on a static
key, not on what is in the page tables). So maybe the old model of
s390 made more sense in that context, but I look at your new suggested
pXd_offset() functions and I go "yeah, that's the way it's supposed to
work".

                 Linus
