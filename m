From: Stefan Haberland <sth@linux.ibm.com>
Date: Fri, 18 Jan 2019 10:26:25 +0000
Subject: [PATCH 0/1] Re: [bug report] [S390] dasd: security and PSF update patch for EMC CKD ioctl
Message-Id: <20190118102626.63773-1-sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dan,

thanks again for the report. This is the patch that is going into our tree:

Stefan Haberland (1):
  s390/dasd: fix using offset into zero size array error

 drivers/s390/block/dasd_eckd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.16.4
