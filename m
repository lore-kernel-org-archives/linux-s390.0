Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727227AbfGAQYn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 12:24:43 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [RFC v1 0/4] Some vfio-ccw fixes
Date: Mon,  1 Jul 2019 12:23:42 -0400
Message-Id: <cover.1561997809.git.alifm@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, alifm@linux.ibm.com

Hi,

While trying to chase down the problem regarding the stacktraces,
I have also found some minor problems in the code.

Would appreciate any review or feedback regarding them.

Thanks
Farhan 

Farhan Ali (4):
  vfio-ccw: Set orb.cmd.c64 before calling ccwchain_handle_ccw
  vfio-ccw: No need to call cp_free on an error in cp_init
  vfio-ccw: Set pa_nr to 0 if memory allocation fails for pa_iova_pfn
  vfio-ccw: Don't call cp_free if we are processing a channel program

 drivers/s390/cio/vfio_ccw_cp.c  | 12 ++++++------
 drivers/s390/cio/vfio_ccw_drv.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4
