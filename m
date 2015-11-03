From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Tue, 3 Nov 2015 11:24:29 +0100
Message-ID: <56388B5D.6020508@redhat.com>
References: <56307BD1.6010806@de.ibm.com>
 <1446019787.3405.203.camel@infradead.org>
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
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151029104301-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@amacapital.net>
Cc: David Woodhouse <dwmw2@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>



On 29/10/2015 10:01, Michael S. Tsirkin wrote:
> > Everyone seems to agree that x86's emulated Q35 thing
> > is just buggy right now and should be taught to use the existing ACPI
> > mechanism for enumerating passthrough devices.
> 
> I'm not sure what ACPI has to do with it.
> It's about a way for guest users to specify whether
> they want to bypass an IOMMU for a given device.

It's not configured in the guest, it's configured _when starting_ the
guest (e.g. -device some-pci-device,iommu-bypass=on) and it is reflected
in the DMAR table or the device tree.

The default for virtio and VFIO is to bypass the IOMMU.  Changing the
default can be supported (virtio) or not (VFIO, vhost-user).  Hotplug
need to check whether the parent bridge is has the same setting that the
user desires for the new device.

> 1. virtio ignores the iommu
> 2. vhost user ignores the iommu
> 3. dataplane ignores the iommu
> 4. vhost-net ignores the iommu
> 5. VFIO ignores the iommu
> 
> I think so far I only saw patches for 1 above.

1 and 3 are easy.  For 2 and 5 you can simply forbid configurations with
vhost-user/VFIO behind an IOMMU.  For 4 QEMU can simply not activate
vhost-net and use the userspace fallback.

However, IOMMU support in QEMU is experimental.  We can do things a step
at a time.

Paolo
