From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Wed, 24 Sep 2014 15:15:34 -0700
Message-ID: <CALCETrUGRCNT-bhfeYoVuFA1TAwjtadCEOLMbAQ_xN6A0GVPaQ@mail.gmail.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrULv=zj_+rA2sRgf0Pxw3P6RDBzmM5C40=OHWwpYtEuJQ@mail.gmail.com>
	<1411162406.30672.64.camel@pasglop>
	<CALCETrUSRXv9wPoNF54GuXT+kKnLAdJmRPEsOjeFNfSE4QueoA@mail.gmail.com>
	<1411275788.30672.79.camel@pasglop> <1411275943.30672.81.camel@pasglop>
	<CALCETrUDMxsdPsZjRZj-T-Tc4OH697mGH1r4Vj6hPu8tjvmfew@mail.gmail.com>
	<1411595404.4184.48.camel@pasglop>
	<CALCETrWRfrLs5Se+mbiGhEbt=WM8fGd2bt6XWskPEYOq2tq-qg@mail.gmail.com>
	<1411596297.4184.50.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411596297.4184.50.camel@pasglop>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 24, 2014 at 3:04 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-09-24 at 14:59 -0700, Andy Lutomirski wrote:
>
>> Scratch that idea, then.
>>
>> The best that I can currently come up with is to say that pre-1.0
>> devices on PPC bypass the IOMMU and that 1.0 devices on PPC and all
>> devices on all other architectures do not bypass the IOMMU.
>
> Well, the thing is, we *want* them to bypass the IOMMU for performance
> reasons in the long run. Today we have no ways to tell our guests that
> a PCI bus doesn't have an IOMMU, they always do !

Alternatively, the IOMMU could be extended to allow an efficient
identity map of the entire physical address space.

>
> Also qemu can mix and match devices on a given PCI bus so making this a
> bus property wouldn't work either.
>
>> I agree that this is far from ideal.  Any ideas?  Is there any other
>> channel that QEMU can use to signal to a PPC guest that a specific PCI
>> virtio device isn't really behind an IOMMU?
>
> Any reason why this can't be a virtio capability ?
>

For Xen.

On Xen, unless we do something quite kludgey, QEMU *cannot* bypass the
DMA API, and QEMU doesn't even know that Xen is there.  On Linux
kernels on Xen, the "physical" address (as returned by sg_phys, etc)
is not a real physical address.  The DMA API translates back and
forth.  Without using the DMA API, all of the DMA ends up in the wrong
place, and everything breaks.

We could teach the driver to bypass the IOMMU but to still use Xen's
mapping correctly, but that's complicated, and I think it serves
little purpose.  As I understand it, there is no reason to ever bypass
an IOMMU on x86, since x86 IOMMUs can be programmed to efficiently
identity map everything.  So, on x86, I think that the right long-term
solution is to just use the DMA API always.

There is a potential security issue, though.  If virtio-pci sets up an
identity map, then a malicious PCI device could pretend to speak
virtio and then take over the system using that identity map.  Using a
virtio capability here doesn't help, since a malicious device will
just set that capability to indicate that it should be identity
mapped.

I guess that we ideally want a secure way for the guest to distinguish
between three cases:

a) IOMMU should be used.
b) Device is trusted but the IOMMU still works.  The guest may want to
set up an identity map.
c) (PPC only) Device bypasses the IOMMU.  There's no security issue
here: a malicious device wouldn't be able to bypass the IOMMU, so it
would be unable to do DMA at all.

--Andy

>> From my POV, the main
>> consideration is that existing QEMU versions hosting Xen hypervisors
>> should work, which is not the case in current kernels, but which is
>> the case with my patches without any known regressions.
>>
>> Is there some evil trick that a PPC guest could use to detect whether
>> the IOMMU is honored?  As an example that I don't like at all, the
>> guest could program the IOMMU so that the ring's physical address maps
>> to a second copy of the ring and then see which one works.
>
> Cheers,
> Ben.
>
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
