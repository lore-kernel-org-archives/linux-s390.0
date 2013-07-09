From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2] Adapter interrupts for virtio-ccw.
Date: Tue,  9 Jul 2013 13:33:50 +0200
Message-ID: <1373369631-3148-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's again my proposal for adapter (thin) interrupt support for virtio-ccw
devices, originally posted at
http://marc.info/?l=linux-virtualization&m=137060143904927&w=2

The document is unchanged, only rebased against current master.

Cornelia Huck (1):
  virtio-ccw: Document adapter interrupts.

 virtio-spec.lyx |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 3 deletions(-)

-- 
1.7.9.5
