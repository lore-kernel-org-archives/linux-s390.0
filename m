From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Sat, 31 Oct 2015 00:16:12 +0900
Message-ID: <20151030151612.GB2704@suse.de>
References: <1446019787.3405.203.camel@infradead.org>
 <20151028132331-mutt-send-email-mst@redhat.com>
 <1446039327.3405.216.camel@infradead.org>
 <20151028155105-mutt-send-email-mst@redhat.com>
 <1446041609.3405.228.camel@infradead.org>
 <20151028161424-mutt-send-email-mst@redhat.com>
 <1446042754.3405.237.camel@infradead.org>
 <20151028175136-mutt-send-email-mst@redhat.com>
 <CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
 <20151029104301-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151029104301-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, David Woodhouse <dwmw2@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 29, 2015 at 11:01:41AM +0200, Michael S. Tsirkin wrote:
> Example: you have a mix of assigned devices and virtio devices. You
> don't trust your assigned device vendor not to corrupt your memory so
> you want to limit the damage your assigned device can do to your guest,
> so you use an IOMMU for that.  Thus existing iommu=pt within guest is out.
> 
> But you trust your hypervisor (you have no choice anyway),
> and you don't want the overhead of tweaking IOMMU
> on data path for virtio. Thus iommu=on is out too.

IOMMUs on x86 usually come with an ACPI table that describes which
IOMMUs are in the system and which devices they translate. So you can
easily describe all devices there that are not behind an IOMMU.

The ACPI table is built by the BIOS, and the platform intialization code
sets the device dma_ops accordingly. If the BIOS provides wrong
information in the ACPI table this is a platform bug.

> I'm not sure what ACPI has to do with it.  It's about a way for guest
> users to specify whether they want to bypass an IOMMU for a given
> device.

We have no way yet to request passthrough-mode per-device from the IOMMU
drivers, but that can easily be added. But as I see it:

> By the way, a bunch of code is missing on the QEMU side
> to make this useful:
> 1. virtio ignores the iommu
> 2. vhost user ignores the iommu
> 3. dataplane ignores the iommu
> 4. vhost-net ignores the iommu
> 5. VFIO ignores the iommu

Qemu does not implement IOMMU translation for virtio devices anyway
(which is fine), so it just should tell the guest so in the ACPI table
built to describe the emulated IOMMU.


	Joerg
