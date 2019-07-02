Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727033AbfGCAnn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jul 2019 20:43:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62L1YVs077774
        for <linux-s390@vger.kernel.org>; Tue, 2 Jul 2019 17:02:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgcq9mbtn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 02 Jul 2019 17:02:08 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Tue, 2 Jul 2019 22:02:07 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 0/3] zfcp: fixes for the zFCP device driver
Date: Tue,  2 Jul 2019 23:01:59 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <cover.1562098940.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

Hello James and Martin,

here are some fixes for the zFCP device driver. I am rather certain this
won't fit into this rc-cycle anymore.. I just found these last week and
with internal reviews and tests I was regrettably not able to post these
any sooner.

So please consider them for the next cycle. Or should I not have send
them in that case? Sorry, this step of the process was a bit unclear to
me.

The first patch is the "most urgent" of the three, although nothing
too terrible happens if we hit it.

Reviews are welcome from everyone, obviously.

Benjamin Block (3):
  zfcp: fix request object use-after-free in send path causing seqno
    errors
  zfcp: fix request object use-after-free in send path causing wrong
    traces
  zfcp: fix GCC compiler warning emitted with -Wmaybe-uninitialized

 drivers/s390/scsi/zfcp_erp.c |  7 +++++
 drivers/s390/scsi/zfcp_fsf.c | 55 +++++++++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.17.1
