From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/3] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 27 Aug 2014 09:54:11 +0200
Message-ID: <20140827095411.2d30a9cf.cornelia.huck@de.ibm.com>
References: <cover.1409087794.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1409087794.git.luto@amacapital.net>
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
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Aug 2014 14:16:59 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> This fixes virtio on Xen guests as well as on any other platform on
> which physical addresses don't match bus addresses.
> 
> This can be tested with:
> 
>     virtme-run --xen xen --kimg arch/x86/boot/bzImage --console
> 
> using virtme from here:
> 
>     https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git
> 
> Without these patches, the guest hangs forever.  With these patches,
> everything works.
> 
> There are two outstanding issues.  virtio_net warns if DMA debugging
> is on because it does DMA from the stack.  (The warning is correct.)
> This also is likely to do something unpleasant to s390.

s/is likely to do something unpleasant to/breaks/

Sorry, this just won't work for s390, as Christian already explained.

> (Maintainers are cc'd -- I don't know what to do about it.)
> 
> Andy Lutomirski (3):
>   virtio_ring: Remove sg_next indirection
>   virtio_ring: Use DMA APIs
>   virtio_pci: Use the DMA API for virtqueues
> 
>  drivers/virtio/Kconfig       |   1 +
>  drivers/virtio/virtio_pci.c  |  25 ++++++--
>  drivers/virtio/virtio_ring.c | 150 ++++++++++++++++++++++++++++++-------------
>  3 files changed, 125 insertions(+), 51 deletions(-)
> 

Aren't you also changing some basic assumptions with the conversion to
DMA apis? virtqueues currently aren't accessed via dma (or it wouldn't
work on s390); if you want (say) virtio-pci to use dma, shouldn't that
be something that is negotiated between guest and host?
