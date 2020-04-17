Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730256AbgDQS12 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 14:27:28 -0400
From: Jared Rossi <jrossi@linux.ibm.com>
Subject: [PATCH 0/1] vfio-ccw: Enable transparent CCW IPL from DASD
Date: Fri, 17 Apr 2020 14:29:38 -0400
Message-Id: <20200417182939.11460-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the explicit prefetch check when using vfio-ccw devices.
This check is not needed as all Linux channel programs are intended
to use prefetch and will be executed in the same way regardless.

Jared Rossi (1):
  vfio-ccw: Enable transparent CCW IPL from DASD

 drivers/s390/cio/vfio_ccw_cp.c  | 16 ++++------------
 drivers/s390/cio/vfio_ccw_cp.h  |  2 +-
 drivers/s390/cio/vfio_ccw_fsm.c |  6 +++---
 3 files changed, 8 insertions(+), 16 deletions(-)

-- 
2.17.0
