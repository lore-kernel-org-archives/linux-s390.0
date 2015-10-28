From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/3] virtio_ring: Support DMA APIs
Date: Tue, 27 Oct 2015 22:12:23 -0700
Message-ID: <CALCETrWJojp4ORj2VTdUvt_4ALBPkNAG-2ddUi3DX-Dw6nej=Q@mail.gmail.com>
References: <cover.1445994839.git.luto@kernel.org> <6b42014d04258c706c7c43ae739efb30e32496b9.1445994839.git.luto@kernel.org>
 <20151028020650.GA18467@suse.de> <CALCETrVEXYZgPUEJt8FeJOsN9nccJH1g=iS2sZ19TBUSBPcvoA@mail.gmail.com>
 <20151028022148.GD18467@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151028022148.GD18467@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 27, 2015 at 7:21 PM, Joerg Roedel <jroedel@suse.de> wrote:
> On Tue, Oct 27, 2015 at 07:13:56PM -0700, Andy Lutomirski wrote:
>> On Tue, Oct 27, 2015 at 7:06 PM, Joerg Roedel <jroedel@suse.de> wrote:
>> > Hi Andy,
>> >
>> > On Tue, Oct 27, 2015 at 06:17:09PM -0700, Andy Lutomirski wrote:
>> >> From: Andy Lutomirski <luto@amacapital.net>
>> >>
>> >> virtio_ring currently sends the device (usually a hypervisor)
>> >> physical addresses of its I/O buffers.  This is okay when DMA
>> >> addresses and physical addresses are the same thing, but this isn't
>> >> always the case.  For example, this never works on Xen guests, and
>> >> it is likely to fail if a physical "virtio" device ever ends up
>> >> behind an IOMMU or swiotlb.
>> >
>> > The overall code looks good, but I havn't seen and dma_sync* calls.
>> > When swiotlb=force is in use this would break.
>> >
>> >> +             vq->vring.desc[head].addr = cpu_to_virtio64(_vq->vdev, vring_map_single(
>> >> +                     vq,
>> >> +                     desc, total_sg * sizeof(struct vring_desc),
>> >> +                     DMA_TO_DEVICE));
>> >
>>
>> Are you talking about a dma_sync call on the descriptor ring itself?
>> Isn't dma_alloc_coherent supposed to make that unnecessary?  I should
>> move the allocation into the virtqueue code.
>>
>> The docs suggest that I might need to "flush the processor's write
>> buffers before telling devices to read that memory".  I'm not sure how
>> to do that.
>
> The write buffers should be flushed by the dma-api functions if
> necessary.  For dma_alloc_coherent allocations you don't need to call
> dma_sync*, but for the map_single/map_page/map_sg ones, as these might
> be bounce-buffered.

I think that all the necessary barriers are already there.  I had a
nasty bug that swiotlb=force exposed, though, which I've fixed.

--Andy
