Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160121225127.GA30993@localhost.localdomain>
References: <56A0F1CA.4010303@linux.vnet.ibm.com>
	<56A14EE4.1020008@fb.com>
	<20160121225127.GA30993@localhost.localdomain>
Date: Thu, 21 Jan 2016 17:12:13 -0800
Message-ID: <CA+55aFxbYLEj=aQtEu3X92m44dbREssAQeSG8ZfoLT_WL5_fkQ@mail.gmail.com>
Subject: Re: [BUG] Regression introduced with "block: split bios to max
 possible length"
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 21, 2016 at 2:51 PM, Keith Busch <keith.busch@intel.com> wrote:
>
> My apologies for the trouble. I trust it really is broken, but I don't
> quite see how. The patch supposedly splits the transfer to the max size
> the request queue says it allows. How does the max allowed size end up
> an invalid multiple?

I assume that in this case it's simply that

 - max_sectors is some odd number in sectors (ie 65535)

 - the block size is larger than a sector (ie 4k)

 - the device probably doesn't even have any silly chunk size issue
(so chunk_sectors is zero).

and because the block size is 4k, no valid IO can ever generate
anything but 4k-aligned IO's, and everything is fine.

Except now the "split bios" patch will split blindly at the
max_sectors size, which is pure and utter garbage, since it doesn't
take the minimum block size into account.

Also, quite frankly, I think that whole "split bios" patch is garbage *anyway*.

The thing is, the whole "blk_max_size_offset()" use there is broken.
What I think it _should_ do is:

 (a) check against max sectors like it used to do:

                if (sectors + (bv.bv_len >> 9) > queue_max_sectors(q))
                        goto split;

 (b) completely separately, and _independently_ of that max sector
check, it should check against the "chunk_sectors" limit if it exists.

instead, it uses that nasty blk_max_size_offset() crap, which is
broken because it's confusing, but also because it doesn't honor
max_sectors AT ALL if there is a chunking size.

So I think chunking size should be independent of max_sectors. I could
see some device that has some absolute max sector size, but that
_also_ wants to split so that the bio never crosses a particular chunk
size (perhaps due to RAID, perhaps due to some internal device block
handling rules).

Trying to mix the two things with those "blk_max_size_offset()" games
is just wrong.

                   Linus
