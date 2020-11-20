Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729284AbgKTSHu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 13:07:50 -0500
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 0/2] Connect request callback to mdev and vfio-ccw
Date: Fri, 20 Nov 2020 19:07:38 +0100
Message-Id: <20201120180740.87837-1-farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

There is a situation where removing all the paths from a device
connected via mdev and vfio-ccw can cause some difficulty.
Using the "chchp -c 0 xx" command to all paths will cause the
device to be removed from the configuration, and any guest
filesystem that is relying on that device will encounter errors.
Interestingly, the last chchp command will actually fail to
return to a shell prompt, and subsequent commands (another
chchp to bring the paths back online, chzdev, etc.) will also
hang because of the outstanding chchp.

The last chchp command drives to vfio_ccw_sch_remove() for every
affected mediated device, and ultimately enters an infinite loop
in vfio_del_group_dev(). This loop is broken when the guest goes
away, which in this case doesn't occur until the guest is shutdown.
This drives vfio_ccw_mdev_release() and thus vfio_device_release()
to wake up the vfio_del_group_dev() thread.

There is also a callback mechanism called "request" to ask a
driver (and perhaps user) to release the device, but this is not
implemented for mdev. So this adds one to that point, and then
wire it to vfio-ccw to pass it along to userspace. This will
gracefully drive the unplug code, and everything behaves nicely.

Despite the testing that was occurring, this doesn't appear related
to the vfio-ccw channel path handling code. I can reproduce this with
an older kernel/QEMU, which makes sense because the above behavior is
driven from the subchannel event codepaths and not the chpid events.
Because of that, I didn't flag anything with a Fixes tag, since it's
seemingly been this way forever.

RFC->V2:
 - Patch 1
   - Added a message when registering a device without a request callback
   - Changed the "if(!callback) return" to "if(callback) do" layout
   - Removed "unlikely" from "if(callback)" logic
   - Clarified some wording in the device ops struct commentary
 - Patch 2
   - Added Conny's r-b

Eric Farman (2):
  vfio-mdev: Wire in a request handler for mdev parent
  vfio-ccw: Wire in the request callback

 drivers/s390/cio/vfio_ccw_ops.c     | 26 ++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  4 ++++
 drivers/vfio/mdev/mdev_core.c       |  4 ++++
 drivers/vfio/mdev/vfio_mdev.c       | 10 ++++++++++
 include/linux/mdev.h                |  4 ++++
 include/uapi/linux/vfio.h           |  1 +
 6 files changed, 49 insertions(+)

-- 
2.17.1
