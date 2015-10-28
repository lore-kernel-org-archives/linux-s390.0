From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Wed, 28 Oct 2015 09:45:13 +0900
Message-ID: <20151028004513.GE2805@suse.de>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Christian,

On Tue, Oct 27, 2015 at 11:48:47PM +0100, Christian Borntraeger wrote:
> Here is a very quick (still untested) shot at providing the s390 part:
> - patch1: dummy dma ops, inspired by the alpha code
> - patch2: replace some of the alpha functions with the dummy ones
> - patch3: allow per device dma ops for s390
> - patch4: wire up virtio dma ops

Thanks for the patches, I think they are a good start. I sent you
comments for two of the patches, the others look good to me.


	Joerg
