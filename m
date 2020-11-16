Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731021AbgKPPXy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 10:23:54 -0500
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/1] fix null pointer dereference for ERP requests
Date: Mon, 16 Nov 2020 16:23:46 +0100
Message-Id: <20201116152347.61093-1-sth@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hi Jens,

pleas apply the following patch that fixes a null pointer derefernce in the
DASD driver.

Stefan Haberland (1):
  s390/dasd: fix null pointer dereference for ERP requests

 drivers/s390/block/dasd.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.17.1
