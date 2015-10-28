From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 28 Oct 2015 17:36:53 +0900
Message-ID: <1446021413.1856.28.camel@kernel.crashing.org>
References: <cover.1446014204.git.luto@kernel.org>
	<20151028091208-mutt-send-email-mst@redhat.com>
	<56307BD1.6010806@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56307BD1.6010806@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2015-10-28 at 16:40 +0900, Christian Borntraeger wrote:
> We have discussed that at kernel summit. I will try to implement a dummy dma_ops for
> s390 that does 1:1 mapping and Ben will look into doing some quirk to handle "old"
> code in addition to also make it possible to mark devices as iommu bypass (IIRC,
> via device tree, Ben?)

Something like that yes. I'll look into it when I'm back home.

Cheers,
Ben.
