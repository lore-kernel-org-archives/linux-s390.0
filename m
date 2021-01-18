Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29872 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406686AbhARQ4H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 11:56:07 -0500
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/1] s390/dasd: fix kobject removal
Date: Mon, 18 Jan 2021 17:55:17 +0100
Message-Id: <20210118165518.14578-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hi Jens,

please apply the following patch that fixes inconsistent kobject removal.

Jan Höppner (1):
  s390/dasd: Fix inconsistent kobject removal

 drivers/s390/block/dasd_devmap.c | 20 ++++++++++++++------
 drivers/s390/block/dasd_eckd.c   |  3 ++-
 drivers/s390/block/dasd_int.h    |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.17.1
