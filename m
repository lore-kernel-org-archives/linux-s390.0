Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388374AbgJBTjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 15:39:47 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 00/10] DASD FC endpoint security
Date: Fri,  2 Oct 2020 21:39:30 +0200
Message-Id: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

Hi Jens,

please see following patches that add a new DASD feature to show
fibre channel endpoint security.
The patches apply on you for-next branch and are intended for 5.10.

The s390/cio patches should also go upstream through your tree this time
since they are required for the DASD patches to build.

Best regards,
Stefan

Jan Höppner (7):
  s390/dasd: Remove unused parameter from dasd_generic_probe()
  s390/dasd: Move duplicate code to separate function
  s390/dasd: Store path configuration data during path handling
  s390/dasd: Fix operational path inconsistency
  s390/dasd: Display FC Endpoint Security information via sysfs
  s390/dasd: Prepare for additional path event handling
  s390/dasd: Process FCES path event notification

Sebastian Ott (1):
  s390/cio: Export information about Endpoint-Security Capability

Vineeth Vijayan (2):
  s390/cio: Provide Endpoint-Security Mode per CU
  s390/cio: Add support for FCES status notification

 arch/s390/include/asm/ccwdev.h   |   2 +
 arch/s390/include/asm/cio.h      |   1 +
 drivers/s390/block/dasd.c        |  22 ++--
 drivers/s390/block/dasd_devmap.c | 105 +++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   | 170 ++++++++++++++++++++-----------
 drivers/s390/block/dasd_fba.c    |   2 +-
 drivers/s390/block/dasd_int.h    | 111 +++++++++++++++++++-
 drivers/s390/cio/chp.c           |  15 +++
 drivers/s390/cio/chp.h           |   1 +
 drivers/s390/cio/chsc.c          | 145 ++++++++++++++++++++++++--
 drivers/s390/cio/chsc.h          |   3 +-
 drivers/s390/cio/device.c        |  15 ++-
 12 files changed, 514 insertions(+), 78 deletions(-)

-- 
2.17.1
