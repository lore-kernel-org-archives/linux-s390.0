Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbfKOF0v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 00:26:51 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF5OKZ5058468
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 00:26:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nsd0bwa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 00:26:49 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 15 Nov 2019 02:56:24 -0000
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v1 00/10] s390/vfio-ccw: Channel Path Handling
Date: Fri, 15 Nov 2019 03:56:10 +0100
Message-Id: <20191115025620.19593-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>

Here is a first pass at the channel-path handling code for vfio-ccw.
This was initially developed by Farhan Ali this past summer, and
picked up by me.  For my own benefit/sanity, I made a small changelog
in the commit message for each patch, describing the changes I've
made to his original code beyond just rebasing to master.

I did split a couple of his patches, to (hopefully) make them a little
more understandable.  The entire series is based on top of the trace
rework patches from a few weeks ago, which are currently pending.
But really, the only cause for overlap is the trace patch here.
The bulk of it is really self-contained.

With this, and the corresponding QEMU series (to be posted momentarily),
applied I am able to configure off/on a CHPID (for example, by issuing
"chchp -c 0/1 xx" on the host), and the guest is able to see both the
events and reflect the updated path masks in its structures.

For reasons that are hopefully obvious, issuing chchp within the guest
only works for the logical vary.  Configuring it off/on does not work,
which I think is fine.

Eric Farman (4):
  vfio-ccw: Refactor the unregister of the async regions
  vfio-ccw: Refactor IRQ handlers
  vfio-ccw: Add trace for CRW event
  vfio-ccw: Remove inline get_schid() routine

Farhan Ali (6):
  vfio-ccw: Introduce new helper functions to free/destroy regions
  vfio-ccw: Register a chp_event callback for vfio-ccw
  vfio-ccw: Use subchannel lpm in the orb
  vfio-ccw: Introduce a new schib region
  vfio-ccw: Introduce a new CRW region
  vfio-ccw: Wire up the CRW irq and CRW region

 drivers/s390/cio/Makefile           |   2 +-
 drivers/s390/cio/vfio_ccw_chp.c     | 128 +++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.c      |   4 +-
 drivers/s390/cio/vfio_ccw_drv.c     | 140 ++++++++++++++++++++++++++--
 drivers/s390/cio/vfio_ccw_fsm.c     |   8 +-
 drivers/s390/cio/vfio_ccw_ops.c     |  65 +++++++++----
 drivers/s390/cio/vfio_ccw_private.h |  11 +++
 drivers/s390/cio/vfio_ccw_trace.c   |   1 +
 drivers/s390/cio/vfio_ccw_trace.h   |  30 ++++++
 include/uapi/linux/vfio.h           |   3 +
 include/uapi/linux/vfio_ccw.h       |  10 ++
 11 files changed, 366 insertions(+), 36 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_chp.c

-- 
2.17.1
