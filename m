Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Jan 2016 03:21:36 +0000
From: Keith Busch <keith.busch@intel.com>
Subject: Re: [BUG] Regression introduced with "block: split bios to max
 possible length"
Message-ID: <20160122032135.GA9244@localhost.localdomain>
References: <56A0F1CA.4010303@linux.vnet.ibm.com>
 <56A14EE4.1020008@fb.com>
 <20160121225127.GA30993@localhost.localdomain>
 <CA+55aFxbYLEj=aQtEu3X92m44dbREssAQeSG8ZfoLT_WL5_fkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxbYLEj=aQtEu3X92m44dbREssAQeSG8ZfoLT_WL5_fkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@fb.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 21, 2016 at 05:12:13PM -0800, Linus Torvalds wrote:
> On Thu, Jan 21, 2016 at 2:51 PM, Keith Busch <keith.busch@intel.com> wrote:
> >
> > My apologies for the trouble. I trust it really is broken, but I don't
> > quite see how. The patch supposedly splits the transfer to the max size
> > the request queue says it allows. How does the max allowed size end up
> > an invalid multiple?
> 
> I assume that in this case it's simply that
> 
>  - max_sectors is some odd number in sectors (ie 65535)
> 
>  - the block size is larger than a sector (ie 4k)

Wouldn't that make max sectors non-sensical? Or am I mistaken to think max
sectors is supposed to be a valid transfer in multiples of the physical
sector size?

I do think this is what's happening though. A recent commit (ca369d51b)
limits the max_sectors to 255 max by default, which isn't right for
4k. A driver has to override the queue's limits.max_dev_sectors first
to get the desired limit for their storage.

I'm not sure if that was the intention. There are lots of drivers
requesting more than 255 and probably unaware they're not getting it,
DASD included. I don't think we'd have seen this problem if the requested
setting wasn't overridden.
 
> What I think it _should_ do is:
> 
>  (a) check against max sectors like it used to do:
> 
>                 if (sectors + (bv.bv_len >> 9) > queue_max_sectors(q))
>                         goto split;

This can create less optimal splits for h/w that advertise chunk size. I
know it's a quirky feature (wasn't my idea), but the h/w is very slow
to not split at the necessary alignments, and we used to handle this
split correctly.

Point taken, though. The implementation needs some cleaning up.
