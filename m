Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbfLSIn7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Dec 2019 03:43:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ8gaA3053032
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x00sfaxr4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 19 Dec 2019 08:43:56 -0000
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/3] s390/dasd patches
Date: Thu, 19 Dec 2019 09:43:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20191219084352.75114-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Hi Jens,

please see the following three patches that

 - fix a dead code path for DASD
 - fix a memleak in DASD error case
 - fix typo in copyright statement

Regards,
Stefan

Jan Höppner (1):
  s390/dasd/cio: Interpret ccw_device_get_mdc return value correctly

Stefan Haberland (2):
  s390/dasd: fix memleak in path handling error case
  s390/dasd: fix typo in copyright statement

 drivers/s390/block/dasd_eckd.c | 28 +++++++---------------------
 drivers/s390/block/dasd_fba.h  |  2 +-
 drivers/s390/block/dasd_proc.c |  2 +-
 drivers/s390/cio/device_ops.c  |  2 +-
 4 files changed, 10 insertions(+), 24 deletions(-)

-- 
2.17.1
