Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87h8s3cvel.fsf@concordia.ellerman.id.au>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de>
 <878tdgtwzp.fsf@concordia.ellerman.id.au> <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
 <87h8s3cvel.fsf@concordia.ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Jan 2018 08:49:35 +0100
Message-ID: <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com>
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180103074935.1_jyWqQKI2K_bfXAg2NjkmHB0YA8KiCTySPbuyEZ66w@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, adi-buildroot-devel@lists.sourceforge.net, linux-m68k <linux-m68k@lists.linux-m68k.org>, patches@groups.riscv.org, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, Parisc List <linux-parisc@vger.kernel.org>, Cris <linux-cris-kernel@axis.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Hi Michael,

On Wed, Jan 3, 2018 at 7:24 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Christoph Hellwig <hch@lst.de> writes:
>>>
>>>> We want to use the dma_direct_ namespace for a generic implementation,
>>>> so rename powerpc to the second best choice: dma_nommu_.
>>>
>>> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
>>> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
>>> than mapping dynamically.
>>>
>>> Though I don't have a good idea for a better name, maybe "1to1",
>>> "linear", "premapped" ?
>>
>> "identity"?
>
> I think that would be wrong, but thanks for trying to help :)
>
> The address on the device side is sometimes (often?) offset from the CPU
> address. So eg. the device can DMA to RAM address 0x0 using address
> 0x800000000000000.
>
> Identity would imply 0 == 0 etc.
>
> I think "bijective" is the correct term, but that's probably a bit
> esoteric.

OK, didn't know about the offset.
Then "linear" is what we tend to use, right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
