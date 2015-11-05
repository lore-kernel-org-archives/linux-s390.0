From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] dma: Provide simple noop dma ops
Date: Thu, 5 Nov 2015 14:31:30 +0100
Message-ID: <20151105133130.GB2255@suse.de>
References: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
 <1446551679-33492-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446551679-33492-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, dwmw2@infradead.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 03, 2015 at 12:54:37PM +0100, Christian Borntraeger wrote:
> We are going to require dma_ops for several common drivers, even for
> systems that do have an identity mapping. Lets provide some minimal
> no-op dma_ops that can be used for that purpose.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  include/linux/dma-mapping.h |  2 ++
>  lib/Makefile                |  1 +
>  lib/dma-noop.c              | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 lib/dma-noop.c

Reviewed-by: Joerg Roedel <jroedel@suse.de>
