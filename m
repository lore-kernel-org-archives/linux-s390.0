Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727479AbfJPB6d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 21:58:33 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G1q1Aw128635
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 21:58:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vng3ts0ds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 21:58:31 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Wed, 16 Oct 2019 02:58:29 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 0/4] vfio-ccw: A couple trace changes
Date: Wed, 16 Oct 2019 03:58:18 +0200
Message-Id: <20191016015822.72425-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Steffen Maier <maier@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Here a couple updates to the vfio-ccw traces in the kernel,
based on things I've been using locally.  Perhaps they'll
be useful for future debugging.

Steffen's comments earlier today (thank you!) were simple enough
that here's a quick turnaround on a v2:

v1/RFC -> v2:
 - Convert state/event=%x to %d
 - Use individual fields for cssid/ssid/sch_no, to enable
   filtering by device
 - Add 0x prefix to remaining %x substitution in existing trace

Eric Farman (4):
  vfio-ccw: Refactor how the traces are built
  vfio-ccw: Trace the FSM jumptable
  vfio-ccw: Add a trace for asynchronous requests
  vfio-ccw: Rework the io_fctl trace

 drivers/s390/cio/Makefile           |  4 +-
 drivers/s390/cio/vfio_ccw_cp.h      |  1 +
 drivers/s390/cio/vfio_ccw_fsm.c     | 11 +++--
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 drivers/s390/cio/vfio_ccw_trace.c   | 14 ++++++
 drivers/s390/cio/vfio_ccw_trace.h   | 76 ++++++++++++++++++++++++++---
 6 files changed, 93 insertions(+), 14 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.c

-- 
2.17.1
