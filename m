From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/4] Provide simple noop dma ops
Date: Fri, 30 Oct 2015 23:45:58 +0900
Message-ID: <20151030144558.GA2704@suse.de>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <1445986131-239566-2-git-send-email-borntraeger@de.ibm.com>
 <20151028004132.GC2805@suse.de>
 <563368DC.3080606@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <563368DC.3080606@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 30, 2015 at 01:55:56PM +0100, Christian Borntraeger wrote:
> It not trivial without understanding the dma mask details. Do I read
> the x86 implementation right, that it limits the dma to 32 bit? Then
> we cannot collapse both implementations. Or maybe we can hide this in
> dma_capable. Dont know

No, DMA is not limited to 32bit on x86. Each device has its own
dma_mask, and the requested address+size is checked against it. The
DMA_BIT_MASK(32) check is only to there to print a warning when a 32bit
capable device trys to access memory above 4GB.



	Joerg
