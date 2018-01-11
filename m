From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/5] vfio/ccw: basic channel path event handling
Date: Thu, 11 Jan 2018 04:04:54 +0100
Message-ID: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Folks,

This is the QEMU couterpart for the "basic channel path event handling" series.
For more information, please refer to the kernel counterpart.

Dong Jia Shi (5):
  vfio: linux-headers update for vfio-ccw
  vfio/ccw: get schib region info
  vfio/ccw: get irq info and set up handler for chp irq
  vfio/ccw: update subchanel information block lazily
  vfio/ccw: build schib with real schib information

 hw/s390x/css.c                 |  97 ++++----------------
 hw/s390x/s390-ccw.c            |  32 +++++--
 hw/vfio/ccw.c                  | 199 ++++++++++++++++++++++++++++++++++-------
 include/hw/s390x/css.h         |   3 +-
 include/hw/s390x/s390-ccw.h    |   4 +-
 linux-headers/linux/vfio.h     |   2 +
 linux-headers/linux/vfio_ccw.h |   6 ++
 target/s390x/ioinst.c          |   3 +-
 8 files changed, 224 insertions(+), 122 deletions(-)

-- 
2.13.5
