From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Wed, 24 Sep 2014 14:59:35 -0700
Message-ID: <CALCETrWRfrLs5Se+mbiGhEbt=WM8fGd2bt6XWskPEYOq2tq-qg@mail.gmail.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrULv=zj_+rA2sRgf0Pxw3P6RDBzmM5C40=OHWwpYtEuJQ@mail.gmail.com>
	<1411162406.30672.64.camel@pasglop>
	<CALCETrUSRXv9wPoNF54GuXT+kKnLAdJmRPEsOjeFNfSE4QueoA@mail.gmail.com>
	<1411275788.30672.79.camel@pasglop> <1411275943.30672.81.camel@pasglop>
	<CALCETrUDMxsdPsZjRZj-T-Tc4OH697mGH1r4Vj6hPu8tjvmfew@mail.gmail.com>
	<1411595404.4184.48.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411595404.4184.48.camel@pasglop>
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

On Wed, Sep 24, 2014 at 2:50 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-09-24 at 14:41 -0700, Andy Lutomirski wrote:
>> On Sat, Sep 20, 2014 at 10:05 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Sun, 2014-09-21 at 15:03 +1000, Benjamin Herrenschmidt wrote:
>> >
>> >> The exception I mentioned is that I would really like the virtio device
>> >> to expose via whatever transport we chose to use (though capability
>> >> exchange sounds like a reasonable one) whether the "server"
>> >> implementation is bypassing IOMMUs or not instead on relying on client
>> >> side heuristics.
>> >>
>> >> IE. Basically, we are trying to "guess" with an ifdef CONFIG_PPC, what
>> >> is essentially an attribute of the server-side, ie, whether is bypasses
>> >> the iommu for the PCI bus it resides on.
>> >
>> >> I believe all the arguments about whether this should be a bus property
>> >> or whether the x86 case can be worked around via ACPI tables etc... are
>> >> all moot. Today, qemu implementation can put virtio devices on busses
>> >> with an iommu and bypass it, so at the very least for backward
>> >> compatibility, we should expose that appropriately from the "server"
>> >> side.
>> >
>> > And of course, since we are talking about backward compatibility with
>> > existing qemus here, the capability should be the opposite, ie "honor
>> > iommu", with the assumption that without it, the implementation bypasses
>> > it, which reflects what the current qemu implementation does on any
>> > architecture, whether you configure the bus to have an iommu emulated on
>> > it or not.
>>
>> Can PPC do this using a new devicetree property?
>
> The DT props for PCI devices are created by the FW inside the guest from
> standard PCI probing, so it would have to get the info from qemu via
> config or register space.
>

Scratch that idea, then.

The best that I can currently come up with is to say that pre-1.0
devices on PPC bypass the IOMMU and that 1.0 devices on PPC and all
devices on all other architectures do not bypass the IOMMU.

I agree that this is far from ideal.  Any ideas?  Is there any other
channel that QEMU can use to signal to a PPC guest that a specific PCI
virtio device isn't really behind an IOMMU?  From my POV, the main
consideration is that existing QEMU versions hosting Xen hypervisors
should work, which is not the case in current kernels, but which is
the case with my patches without any known regressions.

Is there some evil trick that a PPC guest could use to detect whether
the IOMMU is honored?  As an example that I don't like at all, the
guest could program the IOMMU so that the ring's physical address maps
to a second copy of the ring and then see which one works.

--Andy
