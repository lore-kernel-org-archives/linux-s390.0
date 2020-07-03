Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgGCNVG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:21:06 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 0/7] zfcp: cleanups and small changes for 5.9
Date: Fri,  3 Jul 2020 15:19:56 +0200
Message-Id: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, George Spelvin <lkml@sdf.org>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org

Hello Martin, James, Jonathan,

here are some cleanups and small changes for zfcp I'd like to include in
5.9 if possible.

One of the changes touches documentation in `Documentation/scsi/`, so I
put Jonathan on To, hope that was correct. I hope you can still pull
this all in one go to minimize work. IBM did retire some old URLs and
content from our public website, so we have to clean that up in the
documentation so there are not dead links. I changed these in the hopes
we can minimize documentation churn going forward, just to replace URLs.

The other changes are mostly small cleanups for our driver that make at
least parts more sane than they've been.

Most of these have been in our CI for quite a while now - shame on me
for delaying sending them upstream so long -, so I am rather confident
that they don't break anything for us.

As always, feedback and reviews are appreciated :-)

Benjamin Block (2):
  scsi: docs: update outdated link to IBM developerworks
  scsi: docs: remove invalid link and update text for zfcp kernel config

George Spelvin (1):
  zfcp: use prandom_u32_max() for backoff

Julian Wiedmann (4):
  zfcp: fix an outdated comment for zfcp_qdio_send()
  zfcp: clean up zfcp_erp_action_ready()
  zfcp: replace open-coded list move
  zfcp: avoid benign overflow of the Request Queue's free-level

 Documentation/scsi/scsi-parameters.rst |  2 +-
 drivers/s390/scsi/zfcp_ccw.c           |  7 +++----
 drivers/s390/scsi/zfcp_erp.c           |  2 +-
 drivers/s390/scsi/zfcp_fc.c            |  2 +-
 drivers/s390/scsi/zfcp_qdio.c          |  7 +++++--
 drivers/scsi/Kconfig                   | 15 ++++++++++-----
 6 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.26.2
