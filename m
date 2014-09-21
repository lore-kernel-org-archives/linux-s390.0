From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Sat, 20 Sep 2014 22:48:58 -0700
Message-ID: <CALCETrUu6hSyw5quP8fCQzB2Rwo17Vd18Pkf-Bese0q0hcxkQw@mail.gmail.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrULv=zj_+rA2sRgf0Pxw3P6RDBzmM5C40=OHWwpYtEuJQ@mail.gmail.com>
	<1411162406.30672.64.camel@pasglop>
	<CALCETrUSRXv9wPoNF54GuXT+kKnLAdJmRPEsOjeFNfSE4QueoA@mail.gmail.com>
	<1411275788.30672.79.camel@pasglop> <1411275943.30672.81.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411275943.30672.81.camel@pasglop>
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

On Sat, Sep 20, 2014 at 10:05 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2014-09-21 at 15:03 +1000, Benjamin Herrenschmidt wrote:
>
>> The exception I mentioned is that I would really like the virtio device
>> to expose via whatever transport we chose to use (though capability
>> exchange sounds like a reasonable one) whether the "server"
>> implementation is bypassing IOMMUs or not instead on relying on client
>> side heuristics.
>>
>> IE. Basically, we are trying to "guess" with an ifdef CONFIG_PPC, what
>> is essentially an attribute of the server-side, ie, whether is bypasses
>> the iommu for the PCI bus it resides on.
>
>> I believe all the arguments about whether this should be a bus property
>> or whether the x86 case can be worked around via ACPI tables etc... are
>> all moot. Today, qemu implementation can put virtio devices on busses
>> with an iommu and bypass it, so at the very least for backward
>> compatibility, we should expose that appropriately from the "server"
>> side.
>

I'm all for doing this as some kind of bus property, if needed,
although David Woodhouse may be right that the best solution is to
*always* have the IOMMU there and to just ask it for an identity map
if desired.

> And of course, since we are talking about backward compatibility with
> existing qemus here, the capability should be the opposite, ie "honor
> iommu", with the assumption that without it, the implementation bypasses
> it, which reflects what the current qemu implementation does on any
> architecture, whether you configure the bus to have an iommu emulated on
> it or not.
>

If I'm understanding you correctly, this won't work for Xen on QEMU.
QEMU's virtio-pci device doesn't have a real IOMMU, but it is still
behind Xen's translation layer, and QEMU doesn't even know that Xen is
there.

--Andy

> Cheers,
> Ben.
>
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
