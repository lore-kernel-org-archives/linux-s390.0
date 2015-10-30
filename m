From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Fri, 30 Oct 2015 10:57:37 +0100
Message-ID: <56333F11.5030300@de.ibm.com>
References: <cover.1446162273.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <cover.1446162273.git.luto@kernel.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Am 30.10.2015 um 02:09 schrieb Andy Lutomirski:
> This switches virtio to use the DMA API unconditionally.  I'm sure
> it breaks things, but it seems to work on x86 using virtio-pci, with
> and without Xen, and using both the modern 1.0 variant and the
> legacy variant.
> 
> This appears to work on native and Xen x86_64 using both modern and
> legacy virtio-pci.  It also appears to work on arm and arm64.
> 
> It definitely won't work as-is on s390x, and I haven't been able to
> test Christian's patches because I can't get virtio-ccw to work in
> QEMU at all.  I don't know what I'm doing wrong.


[...]
>   virtio-net: Stop doing DMA from the stack
> 
>  drivers/net/virtio_net.c           |  34 ++--
>  drivers/virtio/Kconfig             |   2 +-
>  drivers/virtio/virtio_mmio.c       |  67 ++-----
>  drivers/virtio/virtio_pci_common.h |   6 -
>  drivers/virtio/virtio_pci_legacy.c |  42 ++---
>  drivers/virtio/virtio_pci_modern.c |  61 ++-----
>  drivers/virtio/virtio_ring.c       | 348 ++++++++++++++++++++++++++++++-------

do you also have an untested patch for drivers/s390/virtio/* ?
