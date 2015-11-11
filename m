From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 11 Nov 2015 11:11:14 +0200
Message-ID: <20151111110744-mutt-send-email-mst@redhat.com>
References: <20151028132331-mutt-send-email-mst@redhat.com>
	<1446039327.3405.216.camel@infradead.org>
	<20151028155105-mutt-send-email-mst@redhat.com>
	<1446041609.3405.228.camel@infradead.org>
	<20151028161424-mutt-send-email-mst@redhat.com>
	<1446042754.3405.237.camel@infradead.org>
	<20151028175136-mutt-send-email-mst@redhat.com>
	<CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
	<20151029104301-mutt-send-email-mst@redhat.com>
	<20151030151612.GB2704@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151030151612.GB2704@suse.de>
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

On Sat, Oct 31, 2015 at 12:16:12AM +0900, Joerg Roedel wrote:
> On Thu, Oct 29, 2015 at 11:01:41AM +0200, Michael S. Tsirkin wrote:
> > Example: you have a mix of assigned devices and virtio devices. You
> > don't trust your assigned device vendor not to corrupt your memory so
> > you want to limit the damage your assigned device can do to your guest,
> > so you use an IOMMU for that.  Thus existing iommu=pt within guest is out.
> > 
> > But you trust your hypervisor (you have no choice anyway),
> > and you don't want the overhead of tweaking IOMMU
> > on data path for virtio. Thus iommu=on is out too.
> 
> IOMMUs on x86 usually come with an ACPI table that describes which
> IOMMUs are in the system and which devices they translate. So you can
> easily describe all devices there that are not behind an IOMMU.
> 
> The ACPI table is built by the BIOS, and the platform intialization code
> sets the device dma_ops accordingly. If the BIOS provides wrong
> information in the ACPI table this is a platform bug.

It doesn't look like I managed to put the point across.
My point is that IOMMU is required to do things like
userspace drivers, what we need is a way to express
"there is an IOMMU but it is part of device itself, use passthrough
 unless your driver is untrusted".

> > I'm not sure what ACPI has to do with it.  It's about a way for guest
> > users to specify whether they want to bypass an IOMMU for a given
> > device.
> 
> We have no way yet to request passthrough-mode per-device from the IOMMU
> drivers, but that can easily be added. But as I see it:
> 
> > By the way, a bunch of code is missing on the QEMU side
> > to make this useful:
> > 1. virtio ignores the iommu
> > 2. vhost user ignores the iommu
> > 3. dataplane ignores the iommu
> > 4. vhost-net ignores the iommu
> > 5. VFIO ignores the iommu
> 
> Qemu does not implement IOMMU translation for virtio devices anyway
> (which is fine), so it just should tell the guest so in the ACPI table
> built to describe the emulated IOMMU.
> 
> 
> 	Joerg

This is a short term limitation.
