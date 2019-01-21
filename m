From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 21 Jan 2019 14:54:07 +0000
Subject: [RFC v1 0/2] Small vfio-ccw fixes
Message-Id: <cover.1548082107.git.alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

I have noticed some errors when running an intensive I/O workload
on a passthrough DASD device.

While debugging and looking through the code, I found 2 places
where things don't look write.

Thank you
Farhan

Farhan Ali (2):
  vfio-ccw: Don't assume there are more ccws after a TIC
  vfio-ccw: Don't exit early if state of the vfio-ccw subchannel is not
    idle

 drivers/s390/cio/vfio_ccw_cp.c  | 2 +-
 drivers/s390/cio/vfio_ccw_ops.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.7.4
