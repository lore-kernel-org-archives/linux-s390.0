Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbgESOXK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 10:23:10 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v4 0/2] s390/dasd: remove ioctl_by_bdev from DASD driver
Date: Tue, 19 May 2020 16:22:57 +0200
Message-Id: <20200519142259.102279-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: hch@lst.de
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

Hi Christoph,

here are the patches again. Reviewed and tested internally with DASD as
well as DASD labeled virtblk devices.
So if you agree with the two patches I have no objection against an
inclusion.

v3->v4:
  - merged patches
  - use symbol_get instead of kallsyms_lookup_name
  - add some comments and some cleanup

Christoph Hellwig (1):
  dasd: refactor dasd_ioctl_information

Stefan Haberland (1):
  s390/dasd: remove ioctl_by_bdev calls

 MAINTAINERS                     |  1 +
 block/partitions/ibm.c          | 24 ++++++++---
 drivers/s390/block/dasd_ioctl.c | 76 ++++++++++++++++++++++++---------
 include/linux/dasd_mod.h        |  9 ++++
 4 files changed, 85 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/dasd_mod.h

-- 
2.17.1
