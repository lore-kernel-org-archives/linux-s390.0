Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29244 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgIJTta (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 15:49:30 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 0/2] zfcp: small changes for 5.10
Date: Thu, 10 Sep 2020 21:49:14 +0200
Message-Id: <cover.1599765652.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

Hello Martin, James,

here are some small changes for zfcp I'd like to include in 5.10 if
possible. They apply cleanly on Martin's `scsi-queue`, and James' `misc`
branches.

Both patches make the driver a bit cleaner, and hopefully easier to
maintain.

Both have been in our CI for quite a while now, running every night. I
also gave them a separate regression run just now with I/O and
error-injects such as cable pulls and other external error sources. So I
am rather confident that they don't break anything for us - apart from
that they're straight forward code changes.

As always, feedback and further reviews are appreciated :-)

Julian Wiedmann (2):
  zfcp: use list_first_entry_or_null() in zfcp_erp_thread()
  zfcp: clarify access to erp_action in zfcp_fsf_req_complete()

 drivers/s390/scsi/zfcp_erp.c |  8 +++-----
 drivers/s390/scsi/zfcp_fsf.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.26.2
