Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbgEFANQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 20:13:16 -0400
From: Jared Rossi <jrossi@linux.ibm.com>
Subject: [PATCH v3 0/1] vfio-ccw: Enable transparent CCW IPL from DASD
Date: Tue,  5 May 2020 20:15:43 -0400
Message-Id: <20200506001544.16213-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the explicit prefetch check when using vfio-ccw devices.
This check does not trigger in practice as all Linux channel programs
are intended to use prefetch.

Version 3 improves logging by including the UUID of the vfio device
that triggers the warning.  A custom rate limit is used because
the generic rate limit of 10 per 5 seconds will still result in
multiple warnings during IPL. The warning message has been clarfied
to reflect that a channel program will be executed using prefetch
even though prefetch was not specified.

The text of warning itself does not explicitly refer to non-prefetching
channel programs as unsupported because it will trigger during IPL,
which is a normal and expected sequence.  Likewise, because we expect
the message to appear during IPL, the warning also does not explicitly
alert to the potential of an error, rather it simply notes that a
channel program is being executed in a way other than specified.

Verson 3 also makes some word choice changes to the documentation.

Jared Rossi (1):
  vfio-ccw: Enable transparent CCW IPL from DASD

 Documentation/s390/vfio-ccw.rst |  6 ++++++
 drivers/s390/cio/vfio_ccw_cp.c  | 19 ++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.17.0
