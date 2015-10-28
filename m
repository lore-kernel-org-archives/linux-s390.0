From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 28 Oct 2015 16:05:10 +0200
Message-ID: <20151028155105-mutt-send-email-mst@redhat.com>
References: <cover.1446014204.git.luto@kernel.org>
	<20151028091208-mutt-send-email-mst@redhat.com>
	<56307BD1.6010806@de.ibm.com>
	<1446019787.3405.203.camel@infradead.org>
	<20151028132331-mutt-send-email-mst@redhat.com>
	<1446039327.3405.216.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1446039327.3405.216.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 28, 2015 at 10:35:27PM +0900, David Woodhouse wrote:
> On Wed, 2015-10-28 at 13:35 +0200, Michael S. Tsirkin wrote:
> > E.g. on intel x86, there's an option iommu=pt which does the 1:1
> > thing for devices when used by kernel, but enables
> > the iommu if used by userspace/VMs.
> 
> That's none of your business.
> 
> You call the DMA API when you do DMA. That's all there is to it.
> 
> If the IOMMU happens to be in passthrough mode, or your device happens
> to not to be routed through an IOMMU today, then I/O virtual address
> you get back from the DMA API will look a *lot* like the physical
> address you asked the DMA to map. You might think there's no IOMMU. We
> couldn't possibly comment.
> 
> Use the DMA API. Always. Let the platform worry about whether it
> actually needs to *do* anything or not.
> -- 
> dwmw2
> 
> 

Short answer - platforms need a way to discover, and express different
security requirements of different devices.  If they continue to lack
that, we'll need a custom API in virtio, and while this seems a bit less
elegant, I would not see that as the end of the world at all, there are
not that many virtio drivers.

And hey - that's just an internal API.  We can change it later at a whim.

Long answer - PV is weird. It's not always the same as real hardware.

For PV, it's generally hypervisor doing writes into memory.

If it's monolitic with device emulation in same memory space as the
hypervisor (e.g. in the case of the current QEMU, or using vhost in host
kernel), then you gain *no security* by "restricting" it by means of the
IOMMU - the IOMMU is part of the same hypervisor.

If it is modular with device emulation in a separate memory space (e.g.
in case of Xen, or vhost-user in modern QEMU) then you do gain security:
the part emulating the IOMMU limits the part doing DMA.

In both cases for assigned devices, it is always modular in a sense, so
you do gain security since that is restricted by the hardware IOMMU.

The way things are set up at the moment, it's mostly global,
with iommu=pt on intel being a kind of exception.
We need host/guest and API interfaces that are more nuanced than that.

-- 
MST
