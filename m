From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 28 Oct 2015 16:40:01 +0900
Message-ID: <56307BD1.6010806@de.ibm.com>
References: <cover.1446014204.git.luto@kernel.org>
	<20151028091208-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151028091208-mutt-send-email-mst@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

Am 28.10.2015 um 16:17 schrieb Michael S. Tsirkin:
> On Tue, Oct 27, 2015 at 11:38:57PM -0700, Andy Lutomirski wrote:
>> This switches virtio to use the DMA API unconditionally.  I'm sure
>> it breaks things, but it seems to work on x86 using virtio-pci, with
>> and without Xen, and using both the modern 1.0 variant and the
>> legacy variant.
> 
> I'm very glad to see work on this making progress.
> 
> I suspect we'll have to find a way to make this optional though, and
> keep doing the non-DMA API thing with old devices.  And I've been
> debating with myself whether a pci specific thing or a feature bit is
> preferable.
> 

We have discussed that at kernel summit. I will try to implement a dummy dma_ops for
s390 that does 1:1 mapping and Ben will look into doing some quirk to handle "old"
code in addition to also make it possible to mark devices as iommu bypass (IIRC,
via device tree, Ben?)

Christian



> Thoughts?
> 
>> Changes from v2:
>>  - Fix really embarrassing bug.  This version actually works.
>>
>> Changes from v1:
>>  - Fix an endian conversion error causing a BUG to hit.
>>  - Fix a DMA ordering issue (swiotlb=force works now).
>>  - Minor cleanups.
>>
>> Andy Lutomirski (3):
>>   virtio_net: Stop doing DMA from the stack
>>   virtio_ring: Support DMA APIs
>>   virtio_pci: Use the DMA API
>>
>>  drivers/net/virtio_net.c           |  53 +++++++----
>>  drivers/virtio/Kconfig             |   2 +-
>>  drivers/virtio/virtio_pci_common.h |   3 +-
>>  drivers/virtio/virtio_pci_legacy.c |  19 +++-
>>  drivers/virtio/virtio_pci_modern.c |  34 +++++--
>>  drivers/virtio/virtio_ring.c       | 187 ++++++++++++++++++++++++++++++-------
>>  tools/virtio/linux/dma-mapping.h   |  17 ++++
>>  7 files changed, 246 insertions(+), 69 deletions(-)
>>  create mode 100644 tools/virtio/linux/dma-mapping.h
>>
>> -- 
>> 2.4.3
> 
