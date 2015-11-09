From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Mon, 9 Nov 2015 13:27:57 +0100
Message-ID: <5640914D.6070401@redhat.com>
References: <cover.1446162273.git.luto@kernel.org>
 <20151109133624-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151109133624-mutt-send-email-mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>



On 09/11/2015 13:15, Michael S. Tsirkin wrote:
> Well that's not exactly true. I think we would like to make
> it possible to put virtio devices behind an IOMMU on x86,
> but if this means existing guests break, then many people won't be able
> to use this option: having to find out which kernel version your guest
> is running is a significant burden.
> 
> So on the host side, we need to detect guests that
> don't program the IOMMU and make QEMU ignore it.
> I think we need to figure out a way to do this
> before we commit to the guest change.

What is the usecase for putting virtio devices behind an IOMMU, apart from:

1) "because you can"

2) using VFIO within the guest

?  Case 1 can be ignored, and in case 2 the guest will do the right thing.

> Additionally, IOMMU overhead is very high when running within the VM.
> So for uses such as VFIO, we'd like a way to make something like
> iommu-pt the default.

That's not something that the kernel cares about.  It's just a
configuration issue.

Paolo
