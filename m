From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Tue, 10 Nov 2015 17:02:19 +0200
Message-ID: <20151109224720-mutt-send-email-mst@redhat.com>
References: <20151028155105-mutt-send-email-mst@redhat.com>
	<1446041609.3405.228.camel@infradead.org>
	<20151028161424-mutt-send-email-mst@redhat.com>
	<1446042754.3405.237.camel@infradead.org>
	<20151028175136-mutt-send-email-mst@redhat.com>
	<CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
	<20151029104301-mutt-send-email-mst@redhat.com>
	<1446135536.3405.279.camel@infradead.org>
	<20151108120627-mutt-send-email-mst@redhat.com>
	<20151108114946.GG2255@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151108114946.GG2255@suse.de>
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
To: Joerg Roedel <jroedel@suse.de>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Nov 08, 2015 at 12:49:46PM +0100, Joerg Roedel wrote:
> On Sun, Nov 08, 2015 at 12:37:47PM +0200, Michael S. Tsirkin wrote:
> > I have no problem with that. For example, can we teach
> > the DMA API on intel x86 to use PT for virtio by default?
> > That would allow merging Andy's patches with
> > full compatibility with old guests and hosts.
> 
> Well, the only incompatibility comes from an experimental qemu feature,
> more explicitly from a bug in that features implementation. So why
> should we work around that in the kernel? I think it is not too hard to
> fix qemu to generate a correct DMAR table which excludes the virtio
> devices from iommu translation.
> 
> 
> 	Joerg

It's not that easy - you'd have to dedicate some buses
for iommu bypass, and teach management tools to only put
virtio there - but it's possible.

This will absolutely address guests that don't need to set up IOMMU for
virtio devices, and virtio that bypasses the IOMMU.

But the problem is that we do want to *allow* guests
to set up IOMMU for virtio devices.
In that case, these are two other usecases:

A- monolitic virtio within QEMU:
	iommu only needed for VFIO ->
	guest should always use iommu=pt
        iommu=on works but is just useless overhead.

B- modular out of process virtio outside QEMU:
	iommu needed for VFIO or kernel driver ->
	guest should use iommu=pt or iommu=on
	depending on security/performance requirements

Note that there could easily be a mix of these in the same system.

So for these cases we do need QEMU to specify to guest that IOMMU covers
the virtio devices.  Also, once one does this, the default on linux is
iommu=on and not pt, which works but ATM is very slow.

This poses three problems:

1. How do we address the different needs of A and B?
   One way would be for virtio to pass the information to guest
   using some virtio specific way, and have drivers
   specify what kind of DMA access they want.

2. (Kind of a subset of 1) once we do allow IOMMU, how do we make sure most guests
   use the more sensible iommu=pt.

3. Once we do allow IOMMU, how can we keep existing guests work in this configuration?
   Creating different hypervisor configurations depending on guest is very nasty.
   Again, one way would be some virtio specific interface.

I'd rather we figured the answers to this before merging Andy's patches
because I'm concerned that instead of 1 broken configuration
(virtio always bypasses IOMMU) we'll get two bad configurations
(in the second one, virtio uses the slow default with no
gain in security).

Suggestions wellcome.

-- 
MST
