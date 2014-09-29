From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Mon, 29 Sep 2014 11:55:45 -0700
Message-ID: <CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140917141639.GA13684@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 17, 2014 at 7:16 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Sep 17, 2014 at 08:02:31AM -0400, Benjamin Herrenschmidt wrote:
>> On Tue, 2014-09-16 at 22:22 -0700, Andy Lutomirski wrote:
>> > On non-PPC systems, virtio_pci should use the DMA API.  This fixes
>> > virtio_pci on Xen.  On PPC, using the DMA API would break things, so
>> > we need to preserve the old behavior.
>> >
>> > The big comment in this patch explains the considerations in more
>> > detail.
>>
>> I still disagree with using CONFIG_PPC as a trigger here.
>>
>> Fundamentally, the qemu implementation today bypasses IOMMUs on all
>> platforms as far as I can tell.
>>
>> If that changes, we'll have a backward compatibility problem.
>>
>> The virtio device should advertise whether it's using that bypass
>> mode of operation and virtio_pci should react accordingly.
>
> Well if there's a way to detect that - that's outside the
> device, then we probably shouldn't use device-specific
> interfaces for this capability.
>
>
>> There is a demand for being able to operate on top of an IOMMU on
>> powerpc as well for some embedded stuff using PCI as a transport so your
>> patch precludes that.
>>
>> Cheers,
>> Ben.
>
> As far as I can see, nothing changes on PPC so this patch
> does not preclude anything that was working?

Rusty and Michael, what's the status of this?

I think that (aside from the trivial DMI/DMA typo) the only real issue
here is that the situation on PPC is ugly.  We're failing to enable
physical virtio hardware on PPC with these patches, but that never
worked anyway.  I don't think that there are any regressions other
than ugliness.

My preference would be to apply the patches as is (or with "DMA"
spelled correctly), and then to:

 - Make sure that all virtio-mmio systems have working DMA ops so that
virtio-mmio can the DMA API

 - Fix the DMA API on s390 (probably easy) and on PPC (not necessarily so easy)

 - Remove the non-DMA-API code, which would be a very small change on
top of these patches.

--Andy
