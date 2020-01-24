Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730037AbgAXOzG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Jan 2020 09:55:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00OEliIw001933
        for <linux-s390@vger.kernel.org>; Fri, 24 Jan 2020 09:55:05 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xqmjtjm64-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 24 Jan 2020 09:55:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 24 Jan 2020 14:55:02 -0000
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 0/1] vfio-ccw: Fix interrupt handling for HALT/CLEAR
Date: Fri, 24 Jan 2020 15:54:54 +0100
Message-Id: <20200124145455.51181-1-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Conny,

As I mentioned offline, I have been encountering some problems while
testing the channel path code.  By pure coincidence, I found some
really good clues that led me to this proposed fix.  I moved this
commit to the head of my channel path v2 code, but think maybe it
should be sent by itself so it doesn't get lost in that noise.

Figure 16-6 in SA22-7832-12 (POPS) goes into great detail of the
contents of the irb.cpa based on the other bits in the IRB.
Both the existing code and this new patch treates the irb.cpa as
valid all the time, even though that table has many many entries
where the cpa contents are "unpredictable."  Methinks that this
is partially how we got into this mess, so maybe I need to write
some smarter logic here anyway?  Thoughts?

(Disclaimer1:  I didn't go back and re-read the conversations
that were had for the commit I marked in the "Fixes:" tag,
but will just to make sure we didn't miss something.)

(Disclaimer2:  This makes my torturing-of-the-chpids test run
quite nicely, but I didn't go back to try some of the other
cruel-and-unusual tests at my disposable to ensure this patch
doesn't cause any other regressions.  That's on today's agenda.)

Eric Farman (1):
  vfio-ccw: Don't free channel programs for unrelated interrupts

 drivers/s390/cio/vfio_ccw_cp.c  | 11 +++++++++--
 drivers/s390/cio/vfio_ccw_cp.h  |  2 +-
 drivers/s390/cio/vfio_ccw_drv.c |  4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.17.1
