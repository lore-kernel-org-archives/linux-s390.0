Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 0/7] s390: vfio-ap: dynamic configuration support
Date: Thu, 11 Apr 2019 17:03:17 -0400
Message-Id: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch series extends the crypto adapter pass-through support to 
provide safeguards against inadvertent sharing of AP resources between
guests and/or the host, and to implement more of the s390 AP
architecture related to provisioning and dynamic configuration of
AP resources.

Tony Krowiak (7):
  s390: zcrypt: driver callback to indicate resource in use
  s390: vfio-ap: implement in-use callback for vfio_ap driver
  s390: vfio-ap: allow assignment of unavailable AP resources to mdev
    device
  s390: vfio-ap: allow hot plug/unplug of AP resources using mdev device
  s390: vfio-ap: wait for queue empty on queue reset
  s390: vfio-ap: handle dynamic config/deconfig of AP adapter
  s390: vfio-ap: update documentation

 Documentation/s390/vfio-ap.txt        | 147 +++++++++++----
 arch/s390/include/asm/kvm_host.h      |   2 +
 arch/s390/kvm/kvm-s390.c              |  37 ++++
 drivers/s390/crypto/ap_bus.c          | 138 ++++++++++++++-
 drivers/s390/crypto/ap_bus.h          |   3 +
 drivers/s390/crypto/vfio_ap_drv.c     |  39 +++-
 drivers/s390/crypto/vfio_ap_ops.c     | 324 +++++++++++++++-------------------
 drivers/s390/crypto/vfio_ap_private.h |   2 +
 8 files changed, 471 insertions(+), 221 deletions(-)

-- 
2.7.4
