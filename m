From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 0/2] vfio-ccw bugfixs
Date: Tue, 18 Jul 2017 03:49:24 +0200
Message-ID: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dear Conny,

Here we got two bugfix patches for vfio-ccw:
- fix commit 7da624e2 which missed to initialize a new introduced
  pointer for the vfio-ccw case
- fix a memory allocation that used a wrong size for an irq info
  variable

Dong Jia Shi (1):
  vfio/ccw: fix initialization of the Object DeviceState pointer in the
    common base-device

Jing Zhang (1):
  vfio/ccw: allocate irq info with the right size

 hw/vfio/ccw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.11.2
