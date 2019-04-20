Return-Path: <SRS0=agSP=SW=vger.kernel.org=kvm-owner@kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 0/8] s390: vfio-ap: dynamic configuration support
Date: Sat, 20 Apr 2019 17:49:32 -0400
Message-Id: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
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

Change log v1->v2:
-----------------
* Removed patches preventing root user from unbinding AP queues from 
  the vfio_ap device driver
* Introduced a shadow CRYCB in the vfio_ap driver to manage dynamic 
  changes to the AP guest configuration due to root user interventions
  or hardware anomalies.

Tony Krowiak (8):
  s390: vfio-ap: maintain a shadow of the CRYCB in use by a guest
  s390: vfio-ap: sysfs interface to display guest CRYCB
  s390: vfio-ap: allow assignment of unavailable AP resources to mdev
    device
  s390: vfio-ap: allow hot plug/unplug of AP resources using mdev device
  s390: vfio-ap: wait for queue empty on queue reset
  s390: kvm: test CRYCB masks before setting them
  s390: vfio-ap: handle bind and unbind of AP queue device
  s390: vfio-ap: update documentation

 Documentation/s390/vfio-ap.txt        | 188 +++++++++++---
 arch/s390/kvm/kvm-s390.c              |  31 +++
 drivers/s390/crypto/vfio_ap_drv.c     |  16 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 449 ++++++++++++++++++++--------------
 drivers/s390/crypto/vfio_ap_private.h |   4 +
 5 files changed, 467 insertions(+), 221 deletions(-)

-- 
2.7.4
