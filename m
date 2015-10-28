From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] virtio_net: Stop doing DMA from the stack
Date: Wed, 28 Oct 2015 11:07:50 +0900
Message-ID: <20151028020750.GB18467@suse.de>
References: <cover.1445994839.git.luto@kernel.org>
 <b049d57c66d2fa62e0bafa9cf982de62310f4423.1445994839.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b049d57c66d2fa62e0bafa9cf982de62310f4423.1445994839.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 27, 2015 at 06:17:08PM -0700, Andy Lutomirski wrote:
> From: Andy Lutomirski <luto@amacapital.net>
> 
> Once virtio starts using the DMA API, we won't be able to safely DMA
> from the stack.  virtio-net does a couple of config DMA requests
> from small stack buffers -- switch to using dynamically-allocated
> memory.
> 
> This should have no effect on any performance-critical code paths.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 17 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
