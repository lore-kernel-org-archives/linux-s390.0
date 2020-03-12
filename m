Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgCLNSH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 09:18:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CDGalg044329
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 09:18:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqjwny5w9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 09:18:02 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 12 Mar 2020 13:17:19 -0000
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/1] s390/dasd: fix data corruption
Date: Thu, 12 Mar 2020 14:17:14 +0100
Message-Id: <20200312131715.72621-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Hi Jens,

please find following patch that fixes a likely data corruption when using
devices with thin provisioning support.
As this is a severe issue I hope this will make it into RC6. If not, please
let me know.

Regards,
Stefan

Stefan Haberland (1):
  s390/dasd: fix data corruption for thin provisioned devices

 drivers/s390/block/dasd.c      |  27 +++++-
 drivers/s390/block/dasd_eckd.c | 163 +++++++++++++++++++++++++++++++--
 drivers/s390/block/dasd_int.h  |  15 ++-
 3 files changed, 193 insertions(+), 12 deletions(-)

-- 
2.17.1
