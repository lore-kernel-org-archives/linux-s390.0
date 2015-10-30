From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/4] s390/virtio: use noop dma ops
Date: Fri, 30 Oct 2015 13:32:26 +0100
Message-ID: <20151030133226.08115585.cornelia.huck@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
	<1445986131-239566-5-git-send-email-borntraeger@de.ibm.com>
	<20151030131746.49f6b129.cornelia.huck@de.ibm.com>
	<563361E1.2040605@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <563361E1.2040605@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 30 Oct 2015 13:26:09 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> I am currently reworking this to 
> 
>  static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>  {
> 	if (dev && dev->archdata.dma_ops)
> 		return dev->archdata.dma_ops;
> 	return &dma_noop_ops;
>  }
> 
> 
> Which uses the dma_noop_ops for everything unless the device overrides (PCI does)

Yes, opt-in seems less error-prone here.
