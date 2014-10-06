From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Mon, 06 Oct 2014 21:48:26 +1100
Message-ID: <1412592506.30859.74.camel@pasglop>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
	<543267FC.4030900@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <543267FC.4030900@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2014-10-06 at 11:59 +0200, Christian Borntraeger wrote:
> Just as a comment: On s390 we always considered the memory access as
> access to real memory (not device memory) for virtio accesses. I
> prefer to not touch the DMA API on s390 as it is quite s390-PCI
> specific but it is somewhat strange for CCW devices.
> 
> We would basically have two kinds of DMA mappings on s390 then, one
> iommu like for the PCI devices and one that maps DMA memory 1:1 to
> real memory. We would also need some buy-in from the s390 arch
> maintainers then.

It's pretty standard to have the dma API go via dma-ops hanging off
struct device, you can then easily make them to the right thing for the
type of device... Provided we have a way to identify "bypass everyting"
virtio vs. virtio going through normal PCI translation.

Cheers,
Ben.
