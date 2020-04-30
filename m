Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 0/1] remove ioclt_by_bdev from DASD
Date: Thu, 30 Apr 2020 13:17:53 +0200
Message-Id: <20200430111754.98508-1-sth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org

Hi Christoph and Jens,

here I have a different proposal how to remove the ioctl_by_bdev calls
from the DASD device driver. The patch is tested and from my perspective
OK to be integrated.
If you find it acceptable please feel free to integrate it into your tree.
Otherwise I am open for suggestions.

Regards,
Stefan

Stefan Haberland (1):
  s390/dasd: remove ioctl_by_bdev from DASD driver

 block/partitions/ibm.c           | 67 ++++++++++++++++++--------------
 drivers/s390/block/dasd_devmap.c | 17 +++++++-
 drivers/s390/block/dasd_diag.c   | 10 +++++
 drivers/s390/block/dasd_eckd.c   | 10 +++++
 drivers/s390/block/dasd_fba.c    |  8 ++++
 drivers/s390/block/dasd_genhd.c  |  1 +
 drivers/s390/block/dasd_int.h    | 10 +++++
 7 files changed, 91 insertions(+), 32 deletions(-)

-- 
2.17.1
