From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Mon, 29 Sep 2014 13:55:11 -0700
Message-ID: <CALCETrXPEepB2jcY+1GF_pM2L_xf9Et58YHud3N0Aff3uj39cg@mail.gmail.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
	<1412023777.4285.93.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412023777.4285.93.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Sep 29, 2014 at 1:49 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2014-09-29 at 11:55 -0700, Andy Lutomirski wrote:
>
>> Rusty and Michael, what's the status of this?
>
> The status is that I still think we need *a* way to actually inform the
> guest whether the virtio implementation will or will not bypass the
> IOMMU. I don't know Xen enough to figure out how to do that and we could
> maybe just make it something qemu puts in the device-tree on powerpc
> only.
>
> However I dislike making it global or per-bus, we could have a
> combination of qemu and HW virtio on the same guest, so I really think
> this needs to be a capability of the virtio device.

Or a capability of the PCI slot, somehow.  I don't understand PCI
topology very well.

>
> I don't completely understand what games Xen is playing here, but from
> what I can tell, it's pretty clear that today's qemu implementation
> always bypasses any iommu and so should always be exported as such on
> all platforms, at least all kvm and pure qemu ones.

Except that I think that PPC is the only platform on which QEMU's code
actually bypasses any IOMMU.  Unless we've all missed something, there
is no QEMU release that will put a virtio device behind an IOMMU on
any platform other than PPC.

If the eventual solution is to say that virtio 1.0 PCI devices always
respect an IOMMU unless they set a magic flag saying "I'm not real
hardware and I bypass the IOMMU", then I don't really object to that,
except that it'll be a mess if the guest is running Xen.  But even Xen
would (I think) be okay if it actually worked by having a new DMA API
operation that says "this device is magically identity mapped" and
then just teaching Xen to implement that.

But I'm not an OASIS member, so I can't really do this.  I agree that
this issue needs to be addressed somehow, but I don't think it needs
to block these patches.

--Andy

>
>> I think that (aside from the trivial DMI/DMA typo) the only real issue
>> here is that the situation on PPC is ugly.  We're failing to enable
>> physical virtio hardware on PPC with these patches, but that never
>> worked anyway.  I don't think that there are any regressions other
>> than ugliness.
>>
>> My preference would be to apply the patches as is (or with "DMA"
>> spelled correctly), and then to:
>>
>>  - Make sure that all virtio-mmio systems have working DMA ops so that
>> virtio-mmio can the DMA API
>>
>>  - Fix the DMA API on s390 (probably easy) and on PPC (not necessarily so easy)
>>
>>  - Remove the non-DMA-API code, which would be a very small change on
>> top of these patches.
>>
>> --Andy
>
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
