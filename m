From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Tue, 30 Sep 2014 13:05:26 -0700
Message-ID: <CALCETrWhXg+DukKPXUrq0+yuBHatf3SmvZz-c8ND1oD=yczjig@mail.gmail.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
	<1412023777.4285.93.camel@pasglop>
	<CALCETrXPEepB2jcY+1GF_pM2L_xf9Et58YHud3N0Aff3uj39cg@mail.gmail.com>
	<20140930153821.GA4456@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140930153821.GA4456@redhat.com>
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

On Tue, Sep 30, 2014 at 8:38 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Sep 29, 2014 at 01:55:11PM -0700, Andy Lutomirski wrote:
>> On Mon, Sep 29, 2014 at 1:49 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Mon, 2014-09-29 at 11:55 -0700, Andy Lutomirski wrote:
>> >
>> >> Rusty and Michael, what's the status of this?
>> >
>> > The status is that I still think we need *a* way to actually inform the
>> > guest whether the virtio implementation will or will not bypass the
>> > IOMMU. I don't know Xen enough to figure out how to do that and we could
>> > maybe just make it something qemu puts in the device-tree on powerpc
>> > only.
>> >
>> > However I dislike making it global or per-bus, we could have a
>> > combination of qemu and HW virtio on the same guest, so I really think
>> > this needs to be a capability of the virtio device.
>>
>> Or a capability of the PCI slot, somehow.  I don't understand PCI
>> topology very well.
>>
>> >
>> > I don't completely understand what games Xen is playing here, but from
>> > what I can tell, it's pretty clear that today's qemu implementation
>> > always bypasses any iommu and so should always be exported as such on
>> > all platforms, at least all kvm and pure qemu ones.
>>
>> Except that I think that PPC is the only platform on which QEMU's code
>> actually bypasses any IOMMU.  Unless we've all missed something, there
>> is no QEMU release that will put a virtio device behind an IOMMU on
>> any platform other than PPC.
>
> I think that is true but it seems that this will be true for x86 for
> QEMU 2.2 unless we make some changes there.
> Which we might not have the time for since 2.2 is feature frozen
> from tomorrow.
> Maybe we should disable the IOMMU in 2.2, this is worth considering.
>
>
>> If the eventual solution is to say that virtio 1.0 PCI devices always
>> respect an IOMMU unless they set a magic flag saying "I'm not real
>> hardware and I bypass the IOMMU", then I don't really object to that,
>> except that it'll be a mess if the guest is running Xen.  But even Xen
>> would (I think) be okay if it actually worked by having a new DMA API
>> operation that says "this device is magically identity mapped" and
>> then just teaching Xen to implement that.
>>
>> But I'm not an OASIS member, so I can't really do this.  I agree that
>> this issue needs to be addressed somehow, but I don't think it needs
>> to block these patches.
>>
>> --Andy
>
> I thought hard about this, I think we are better off waiting till the
> next release: there's a chance QEMU will have IOMMU support for KVM x86
> then, and this will make it easier to judge which way does the wind
> blow.

If QEMU wants to fix this, it looks like it wouldn't be so bad.  The
virtio code could keep track of the address space in use.  It looks
like a lot of the changes would be simplifications, but vring_map
would have to go away.  That would cause some performance hit due to
the loss of the permanent ring mapping, bit it would be no worse than
the temporary mappings that already exist for indirect descriptors and
actual data.

--Andy
