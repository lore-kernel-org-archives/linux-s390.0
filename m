Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgINMg5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 08:36:57 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/1] DASD: fix discard for FBA devices
Date: Mon, 14 Sep 2020 13:56:46 +0200
Message-Id: <20200914115647.94062-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Hi Jens,

please see the following patch that fixes zero writes for DASD FBA devices under certain conditions.

Do you mind to take this for 5.9?

Jan Höppner (1):
  s390/dasd: Fix zero write for FBA devices

 drivers/s390/block/dasd_fba.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.17.1
