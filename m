Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728557AbgEHNPJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 09:15:09 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v3 0/3] s390/dasd: remove ioctl_by_bdev from DASD driver
Date: Fri,  8 May 2020 15:14:52 +0200
Message-Id: <20200508131455.55407-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: hch@lst.de
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

Hi Christoph,

as discussed yesterday I have picked your first patch, adopted the second
one and created a new third patch to remove the ioctl_by_bdev calls.
I export the symbol for the dasd_biodasdinfo function and obtain the
pointer with a kallsyms_lookup_name.
The checking if the gendisk is owned by a DASD is done by comparing the
fops pointer as you suggested. Looks like the most suitable method here.

Please note that this patch is not ready for inclusion and only basic
function tested. It is just for discussion.

Christoph Hellwig (2):
  dasd: refactor dasd_ioctl_information
  block: add a s390-only biodasdinfo method

Stefan Haberland (1):
  s390/dasd: remove ioctl_by_bdev calls

 block/partitions/ibm.c          | 15 +++++++--
 drivers/s390/block/dasd_int.h   |  1 +
 drivers/s390/block/dasd_ioctl.c | 59 ++++++++++++++++++++++++---------
 include/linux/blkdev.h          |  1 +
 4 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.17.1
