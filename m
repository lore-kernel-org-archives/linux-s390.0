Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730577AbfJNSJF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 14:09:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9EHvlgn136764
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 14:09:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vmu30xw4q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 14:09:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Mon, 14 Oct 2019 19:09:02 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH 0/4] vfio-ccw: A couple trace changes
Date: Mon, 14 Oct 2019 20:08:51 +0200
Message-Id: <20191014180855.19400-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Hi Conny,

I mentioned these to you a while ago; just been caught up in other
things. These aren't really pre-reqs for anything in our pipe, but
they've been beneficial to me on their own, and simplify debugging
of future work (such as the FSM needs brought up by Halil).

While the first patch refactors the trace so new ones can be added
outside the FSM, none of the other patches in this series really do.
I imagine that would be beneficial in the future, so I think it
would be good to do that rework before we get too far along.

Eric Farman (4):
  vfio-ccw: Refactor how the traces are built
  vfio-ccw: Trace the FSM jumptable
  vfio-ccw: Add a trace for asynchronous requests
  vfio-ccw: Rename the io_fctl trace

 drivers/s390/cio/Makefile           |  4 +--
 drivers/s390/cio/vfio_ccw_cp.h      |  1 +
 drivers/s390/cio/vfio_ccw_fsm.c     | 11 +++---
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 drivers/s390/cio/vfio_ccw_trace.c   | 14 ++++++++
 drivers/s390/cio/vfio_ccw_trace.h   | 56 ++++++++++++++++++++++++++++-
 6 files changed, 79 insertions(+), 8 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.c

-- 
2.17.1
