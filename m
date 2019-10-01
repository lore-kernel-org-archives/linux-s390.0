Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389599AbfJAPeq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Oct 2019 11:34:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91FSIcc074700
        for <linux-s390@vger.kernel.org>; Tue, 1 Oct 2019 11:34:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vc8e6u79s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 01 Oct 2019 11:34:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Tue, 1 Oct 2019 16:34:42 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/2] s390/dasd: fixes for thin provisioning support
Date: Tue,  1 Oct 2019 17:34:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20191001153439.62672-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Hi Jens,

please see the following two patches that

- fix a bug in the thin provisioning base support
- revert a commit because of possible data corruption

Regards,
Stefan


Jan Höppner (1):
  s390/dasd: Fix error handling during online processing

Stefan Haberland (1):
  Revert "s390/dasd: Add discard support for ESE volumes"

 drivers/s390/block/dasd_eckd.c | 81 +++++-----------------------------
 1 file changed, 11 insertions(+), 70 deletions(-)

-- 
2.17.1
