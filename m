From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 3/3] s390/dma: Allow per device dma ops
Date: Tue, 3 Nov 2015 13:26:15 +0100
Message-ID: <20151103132615.53002e05.cornelia.huck@de.ibm.com>
References: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
	<1446551679-33492-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1446551679-33492-4-git-send-email-borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue,  3 Nov 2015 12:54:39 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> As virtio-ccw now has dma ops, we can no longer default to the PCI ones.
> Make use of dev_archdata to keep the dma_ops per device. The pci devices
> now use that to override the default, and the default is changed to use
> the noop ops for everything that is not PCI. To compile without PCI
> support we also have to enable the DMA api with virtio.

Not only with virtio, but generally, right?

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---
>  arch/s390/Kconfig                   | 3 ++-
>  arch/s390/include/asm/device.h      | 6 +++++-
>  arch/s390/include/asm/dma-mapping.h | 6 ++++--
>  arch/s390/pci/pci.c                 | 1 +
>  arch/s390/pci/pci_dma.c             | 4 ++--
>  5 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 1d57000..04f0e02 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -113,6 +113,7 @@ config S390
>  	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL
> +	select HAS_DMA
>  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_EARLY_PFN_TO_NID
> @@ -124,6 +125,7 @@ config S390
>  	select HAVE_CMPXCHG_DOUBLE
>  	select HAVE_CMPXCHG_LOCAL
>  	select HAVE_DEBUG_KMEMLEAK
> +	select HAVE_DMA_ATTRS
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_FTRACE_MCOUNT_RECORD
> @@ -580,7 +582,6 @@ config QDIO
> 
>  menuconfig PCI
>  	bool "PCI support"
> -	select HAVE_DMA_ATTRS
>  	select PCI_MSI
>  	help
>  	  Enable PCI support.

Hm. Further down in this file, there's

config HAS_DMA                                                                  
        def_bool PCI                                                            
        select HAVE_DMA_API_DEBUG

Should we maybe select HAVE_DMA_API_DEBUG above, drop the HAS_DMA
config option and rely on not defining NO_DMA instead?

Otherwise, the patch looks good to me.
