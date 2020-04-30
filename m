Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgD3V1f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 17:27:35 -0400
From: Jared Rossi <jrossi@linux.ibm.com>
Subject: [PATCH v2 0/1] vfio-ccw: Enable transparent CCW IPL from DASD
Date: Thu, 30 Apr 2020 17:29:58 -0400
Message-Id: <20200430212959.13070-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the explicit prefetch check when using vfio-ccw devices.
This check is not needed in practice as all Linux channel programs
are intended to use prefetch.

Version 2 improves logging by issuing a warning if a non-prefetch
ORB is encountered. A kernel warning is printed when an ORB without
the p-bit set is initialized.  The warning is limited to once per
five seconds because, if encountered, non-prefetch ORBs tend to
appear in bursts of hundreds per second.

The commit message is expanded to highlight the potential for
future risk if non-prefetch dependent channel programs become
prevalent.  Furthermore, a note of prefetch only support is
added to the limitations section of the vfio-ccw.rst.

Jared Rossi (1):
  vfio-ccw: Enable transparent CCW IPL from DASD

 Documentation/s390/vfio-ccw.rst |  4 ++++
 drivers/s390/cio/vfio_ccw_cp.c  | 16 +++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.17.0
