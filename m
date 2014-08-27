From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 27 Aug 2014 14:50:53 -0700
Message-ID: <cover.1409176034.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Andy Lutomirski <luto@amacapital.net>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

This fixes virtio on Xen guests as well as on any other platform
that uses virtio_pci on which physical addresses don't match bus
addresses.

This can be tested with:

    virtme-run --xen xen --kimg arch/x86/boot/bzImage --console

using virtme from here:

    https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git

Without these patches, the guest hangs forever.  With these patches,
everything works.

This should be safe on all platforms that I'm aware of.  That
doesn't mean that there isn't anything that I missed.

Changes from v1:
 - Using the DMA API is optional now.  It would be nice to improve the
   DMA API to the point that it could be used unconditionally, but s390
   proves that we're not there yet.
 - Includes patch 4, which fixes DMA debugging warnings from virtio_net.

Andy Lutomirski (4):
  virtio_ring: Remove sg_next indirection
  virtio_ring: Support DMA APIs if requested
  virtio_pci: Use the DMA API for virtqueues
  virtio_net: Stop doing DMA from the stack

 drivers/lguest/lguest_device.c         |   3 +-
 drivers/misc/mic/card/mic_virtio.c     |   2 +-
 drivers/net/virtio_net.c               |  53 +++++---
 drivers/remoteproc/remoteproc_virtio.c |   4 +-
 drivers/s390/kvm/kvm_virtio.c          |   2 +-
 drivers/s390/kvm/virtio_ccw.c          |   4 +-
 drivers/virtio/virtio_mmio.c           |   5 +-
 drivers/virtio/virtio_pci.c            |  35 ++++--
 drivers/virtio/virtio_ring.c           | 219 ++++++++++++++++++++++++++-------
 include/linux/virtio_ring.h            |   1 +
 tools/virtio/linux/virtio.h            |   1 +
 tools/virtio/virtio_test.c             |   2 +-
 tools/virtio/vringh_test.c             |   3 +-
 13 files changed, 253 insertions(+), 81 deletions(-)

-- 
1.9.3
