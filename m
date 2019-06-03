Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 3 Jun 2019 17:27:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 4/8] s390/airq: use DMA memory for adapter interrupts
Message-ID: <20190603172740.1023e078.cohuck@redhat.com>
In-Reply-To: <20190529122657.166148-5-mimu@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-5-mimu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 29 May 2019 14:26:53 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> Protected virtualization guests have to use shared pages for airq
> notifier bit vectors, because hypervisor needs to write these bits.
> 
> Let us make sure we allocate DMA memory for the notifier bit vectors by
> replacing the kmem_cache with a dma_cache and kalloc() with
> cio_dma_zalloc().
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/include/asm/airq.h |  2 ++
>  drivers/s390/cio/airq.c      | 32 ++++++++++++++++++++------------
>  drivers/s390/cio/cio.h       |  2 ++
>  drivers/s390/cio/css.c       |  1 +
>  4 files changed, 25 insertions(+), 12 deletions(-)

Apologies if that already has been answered (and I missed it in my mail
pile...), but two things had come to my mind previously:

- CHSC... does anything need to be done there? Last time I asked:
  "Anyway, css_bus_init() uses some chscs
   early (before cio_dma_pool_init), so we could not use the pools
   there, even if we wanted to. Do chsc commands either work, or else
   fail benignly on a protected virt guest?"
- PCI indicators... does this interact with any dma configuration on
  the pci device? (I know pci is not supported yet, and I don't really
  expect any problems.)
