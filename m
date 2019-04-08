Return-Path: <SRS0=nFot=SK=vger.kernel.org=kvm-owner@kernel.org>
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [RFC v2 0/3] fio-ccw fixes for kernel stacktraces
Date: Mon,  8 Apr 2019 17:05:30 -0400
Message-Id: <cover.1554756534.git.alifm@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, alifm@linux.ibm.com
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

ChangeLog
---------
v1 -> v2
   - Use the return code from cio_cancel_halt_clear to prevent
     waiting unnecessarily (patch 2).

   - No need to reset the device on the remove path (patch 3).

Farhan Ali (3):
  vfio-ccw: Do not call flush_workqueue while holding the spinlock
  vfio-ccw: Prevent quiesce function going into an infinite loop
  vfio-ccw: Release any channel program when releasing/removing vfio-ccw
    mdev

 drivers/s390/cio/vfio_ccw_drv.c | 27 ++++++++++++---------------
 drivers/s390/cio/vfio_ccw_ops.c | 11 ++++++++++-
 2 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.7.4
