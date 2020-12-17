Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbgLQP7y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 10:59:54 -0500
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/4] Fix DASD control unit updates
Date: Thu, 17 Dec 2020 16:59:03 +0100
Message-Id: <20201217155907.36436-1-sth@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hi Jens,

please apply the following patches that address problems during DASD
control unit updates.
Thanks.

Stefan Haberland (4):
  s390/dasd: fix hanging device offline processing
  s390/dasd: prevent inconsistent LCU device data
  s390/dasd: fix list corruption of pavgroup group list
  s390/dasd: fix list corruption of lcu list

 drivers/s390/block/dasd_alias.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.17.1
