Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729238AbgGNUDg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 16:03:36 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/2] DASD DIAG patches
Date: Tue, 14 Jul 2020 22:03:25 +0200
Message-Id: <20200714200327.40927-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Hi Jens,

please see the following two patches that fix and improve the DASD DIAG driver.

Regards,
Stefan

Gustavo A. R. Silva (1):
  s390/dasd: Use struct_size() helper

Stefan Haberland (1):
  s390/dasd: fix inability to use DASD with DIAG driver

 drivers/s390/block/dasd_diag.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

-- 
2.17.1
