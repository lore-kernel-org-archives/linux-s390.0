Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgBRJXX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:23:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9JBXb132469
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:23:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1hdbq6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:23:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <vneethv@linux.ibm.com>;
        Tue, 18 Feb 2020 09:23:20 -0000
From: Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: [RFC v2 0/2] fces event support in cio
Date: Tue, 18 Feb 2020 10:23:15 +0100
Message-Id: <20200218092317.49846-1-vneethv@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org

Compared to the previous version of this RFC(RFC v1 0/2] support
FC-Endpoint Security events), there is a change in the information we
passed to the consumer-devices using path-event. 

Previously we used to share the exact event of fces, which is derived
from the sei_area->ccdf[0]. In this patch, instead of sending the right
event, simply inform the ccwdev about the occurance of 'fces event'
using path_event. The ccwdev then query more information about the
fces-event using the chsc_scud() call and notify based on the reply.

Sebastian Ott (1):
  s390/cio: handle changes related to endpoint security

Vineeth Vijayan (1):
  s390/cio: add support for fces status notification

 arch/s390/include/asm/ccwdev.h |  1 +
 drivers/s390/cio/chp.h         |  1 +
 drivers/s390/cio/chsc.c        | 73 ++++++++++++++++++++++++++++++++++
 drivers/s390/cio/device.c      | 19 ++++++++-
 4 files changed, 93 insertions(+), 1 deletion(-)

-- 
2.17.1
