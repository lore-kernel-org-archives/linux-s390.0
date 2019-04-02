From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 02 Apr 2019 16:44:32 +0000
Subject: [RFC v1 0/3] vfio-ccw fixes for kernel stacktraces
Message-Id: <cover.1554222348.git.alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

I have recently seen some interesting kernel stacktraces while
testing vfio-ccw mediated devices. These stack traces are seen
when things don't go right, for example when a guest crashes or
dies while still doing some I/O on the mediated device.

I have also come across an issue in the common vfio code as
well which I reported upstream (https://marc.info/?l=kvm&m=155369393523503&w=2)
and submitted a patch separately for it 
(https://marc.info/?l=kvm&m=155414703613868&w=2).

I would appreciate any review or feedback on these patches.

Thanks
Farhan


Farhan Ali (3):
  vfio-ccw: Do not call flush_workqueue while holding the spinlock
  vfio-ccw: Prevent quiesce function going into an infinite loop
  vfio-ccw: Release any channel program when releasing/removing vfio-ccw
    mdev

 drivers/s390/cio/vfio_ccw_drv.c | 28 ++++++++++++----------------
 drivers/s390/cio/vfio_ccw_ops.c |  9 +++++++++
 2 files changed, 21 insertions(+), 16 deletions(-)

-- 
2.7.4
