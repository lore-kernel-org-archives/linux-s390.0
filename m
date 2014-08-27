From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/3] virtio_ring: Use DMA APIs
Date: Wed, 27 Aug 2014 10:39:52 -0700
Message-ID: <CALCETrWDZ7fRQi2bD4y=H6OMh-ePUwrCMH+9MnNw-eoVftAyWw@mail.gmail.com>
References: <cover.1409087794.git.luto@amacapital.net>
	<24470d6ef6f915f9235a49b986ae181be7661681.1409087794.git.luto@amacapital.net>
	<53FD88E0.9020208@de.ibm.com>
	<20140827173552.GC5379@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140827173552.GC5379@laptop.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Aug 27, 2014 at 10:35 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Wed, Aug 27, 2014 at 09:29:36AM +0200, Christian Borntraeger wrote:
>> On 26/08/14 23:17, Andy Lutomirski wrote:
>> > virtio_ring currently sends the device (usually a hypervisor)
>> > physical addresses of its I/O buffers.  This is okay when DMA
>> > addresses and physical addresses are the same thing, but this isn't
>> > always the case.  For example, this never works on Xen guests, and
>> > it is likely to fail if a physical "virtio" device ever ends up
>> > behind an IOMMU or swiotlb.
>> >
>> > The immediate use case for me is to enable virtio on Xen guests.
>> > For that to work, we need this fix as well as a corresponding
>> > fix to virtio_pci or to another driver.
>> >
>> > With this patch, virtfs survives kmemleak and CONFIG_DMA_API_DEBUG.
>> > virtio-net warns (correctly) about DMA from the stack in
>> > virtnet_set_rx_mode.
>> >
>> > This breaks s390's defconfig.  The default configuration for s390
>> > does virtio through a KVM-specific interface, but that configuration
>> > does not support DMA.  I could modify this patch to stub out the DMA
>> > API calls if !CONFIG_HAS_DMA, but it seems to me that it would be
>> > much nicer to make s390 support DMA unconditionally.
>>
>> s390 has no DMA per se. Newest systems have a PCI-like  I/O attach in
>> addition to the classic channel I/O, and for that we enable the DMA code
>> just for that transport to be able to reuse some of the existing PCI
>> drivers. (only some because, we differ in some aspects from how PCI
>> looks like) But the architecture itself (and the virtio interface) does
>> not provide the DMA interface as you know it:
>
> Don't most of those DMA_API end up then being nops? As in, we do
> have in the dma-api file the #ifdef case when a platform does not do
> DMA which ends up with all functions stubbed out.
>

This doesn't work on s390.  It fails to link.

This was my initial thought, too -- it would be nice if s390 set up
no-op DMA ops its virtio device.  But this might be overkill, if
virtio is the *only* device on s390 that does anything that looks like
DMA.

Anyway, v2 (coming soon) adds a switch in virtio, so s390 should
continue to work.

--Andy
