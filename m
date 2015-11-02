From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] s390/dma: Allow per device dma ops
Date: Mon, 2 Nov 2015 17:38:07 +0100 (CET)
Message-ID: <alpine.LFD.2.11.1511021733040.1747@denkbrett>
References: <1446211237-111298-1-git-send-email-borntraeger@de.ibm.com>
	<1446211237-111298-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1446211237-111298-4-git-send-email-borntraeger@de.ibm.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>, benh@kernel.crashing.org, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 30 Oct 2015, Christian Borntraeger wrote:

> As virtio-ccw now has dma ops, we can no longer default to the PCI ones.
> Make use of dev_archdata to keep the dma_ops per device. The pci devices
> now use that to override the default, and the default is changed to use
> the noop ops for everything that is not PCI. To compile without PCI
> support we also have to enable the DMA api with virtio.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
