From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Sun, 21 Sep 2014 15:03:08 +1000
Message-ID: <1411275788.30672.79.camel@pasglop>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrULv=zj_+rA2sRgf0Pxw3P6RDBzmM5C40=OHWwpYtEuJQ@mail.gmail.com>
	<1411162406.30672.64.camel@pasglop>
	<CALCETrUSRXv9wPoNF54GuXT+kKnLAdJmRPEsOjeFNfSE4QueoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUSRXv9wPoNF54GuXT+kKnLAdJmRPEsOjeFNfSE4QueoA@mail.gmail.com>
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
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2014-09-19 at 22:59 -0700, Andy Lutomirski wrote:
> Sure.
> 
> The question is: should the patches go in to 3.18 as is our should
> they wait?  It would be straightforward to remove the use_dma_api
> switch PPC, s390, and virtio_mmio are ready.

I don't mind the patches going in now in their current form with one
exception (see below), but I'm keen on moving all the way to an
unconditional use of the DMA API with a simple tweaking of the dma ops
of the device based on need/iommu/etc...

What I might do is first experiment with powerpc to try to set
use_dma_api to true and do the dma_ops manipulation.

The exception I mentioned is that I would really like the virtio device
to expose via whatever transport we chose to use (though capability
exchange sounds like a reasonable one) whether the "server"
implementation is bypassing IOMMUs or not instead on relying on client
side heuristics.

IE. Basically, we are trying to "guess" with an ifdef CONFIG_PPC, what
is essentially an attribute of the server-side, ie, whether is bypasses
the iommu for the PCI bus it resides on.

I believe all the arguments about whether this should be a bus property
or whether the x86 case can be worked around via ACPI tables etc... are
all moot. Today, qemu implementation can put virtio devices on busses
with an iommu and bypass it, so at the very least for backward
compatibility, we should expose that appropriately from the "server"
side.

Cheers,
Ben.
