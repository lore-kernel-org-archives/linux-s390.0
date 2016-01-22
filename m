Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160122032135.GA9244@localhost.localdomain>
References: <56A0F1CA.4010303@linux.vnet.ibm.com>
	<56A14EE4.1020008@fb.com>
	<20160121225127.GA30993@localhost.localdomain>
	<CA+55aFxbYLEj=aQtEu3X92m44dbREssAQeSG8ZfoLT_WL5_fkQ@mail.gmail.com>
	<20160122032135.GA9244@localhost.localdomain>
Date: Thu, 21 Jan 2016 20:15:37 -0800
Message-ID: <CA+55aFwGRQb_2SUTj8A9MzTC4WCVC37p64t5obUfTvLNyctjKA@mail.gmail.com>
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

On Thu, Jan 21, 2016 at 7:21 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, Jan 21, 2016 at 05:12:13PM -0800, Linus Torvalds wrote:
>>
>> I assume that in this case it's simply that
>>
>>  - max_sectors is some odd number in sectors (ie 65535)
>>
>>  - the block size is larger than a sector (ie 4k)
>
> Wouldn't that make max sectors non-sensical? Or am I mistaken to think max
> sectors is supposed to be a valid transfer in multiples of the physical
> sector size?

If the controller interface is some 16-bit register, then the maximum
number of sectors you can specify is 65535.

But if the disk then doesn't like 512-byte accesses, but wants 4kB or
whatever, then clearly you can't actually *feed* it that maximum
number. Not because it's a maximal, but because it's not aligned.

But that doesn't mean that it's non-sensical. It just means that you
have to take both things into account.  There may be two totally
independent things that cause the two (very different) rules on what
the IO can look like.

Obviously there are probably games we could play, like always limiting
the maximum sector number to a multiple of the sector size. That would
presumably work for Stefan's case, by simply "artificially" making
max_sectors be 65528 instead.

But I do think it's better to consider them independent issues, and
just make sure that we always honor those things independently.

That "honor things independently" used to happen automatically before,
simply because we'd never split in the middle of a bio segment. And
since each bio segment was created with the limitations of the device
in mind, that all worked.

Now that it splits in the middle of a vector entry, that splitting
just needs to honor _all_ the rules. Not just the max sector one.

>> What I think it _should_ do is:
>>
>>  (a) check against max sectors like it used to do:
>>
>>                 if (sectors + (bv.bv_len >> 9) > queue_max_sectors(q))
>>                         goto split;
>
> This can create less optimal splits for h/w that advertise chunk size. I
> know it's a quirky feature (wasn't my idea), but the h/w is very slow
> to not split at the necessary alignments, and we used to handle this
> split correctly.

I suspect few high-performance controllers will really have big issues
with the max_sectors thing. If you have big enough IO that you could
hit the maximum sector number, you're already pretty well off, you
might as well split at that point.

So I think it's ok to split at the max sector case early.

For the case of nvme, for example, I think the max sector number is so
high that you'll never hit that anyway, and you'll only ever hit the
chunk limit. No?

So in practice it won't matter, I suspect.

                 Linus
