Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502287AbfJYQNA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 12:13:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PG8vu2070223
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv46t0fe1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:12:59 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Fri, 25 Oct 2019 17:12:57 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v2 10/11] zfcp: proper indentation to reduce confusion in zfcp_erp_required_act
Date: Fri, 25 Oct 2019 18:12:52 +0200
In-Reply-To: <cover.1571934247.git.bblock@linux.ibm.com>
References: <cover.1571934247.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <df4f897f6e83eaa528465d0858d5a22daac47a2f.1572018132.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Steffen Maier <maier@linux.ibm.com>

No functional change.

The unary not operator only applies to the sub expression before
the logical or. So we return early if (not running) or failed.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 96f0d34e9459..93655b85b73f 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -174,7 +174,7 @@ static enum zfcp_erp_act_type zfcp_erp_required_act(enum zfcp_erp_act_type want,
 			return 0;
 		p_status = atomic_read(&port->status);
 		if (!(p_status & ZFCP_STATUS_COMMON_RUNNING) ||
-		      p_status & ZFCP_STATUS_COMMON_ERP_FAILED)
+		    p_status & ZFCP_STATUS_COMMON_ERP_FAILED)
 			return 0;
 		if (!(p_status & ZFCP_STATUS_COMMON_UNBLOCKED))
 			need = ZFCP_ERP_ACTION_REOPEN_PORT;
@@ -190,7 +190,7 @@ static enum zfcp_erp_act_type zfcp_erp_required_act(enum zfcp_erp_act_type want,
 			return 0;
 		a_status = atomic_read(&adapter->status);
 		if (!(a_status & ZFCP_STATUS_COMMON_RUNNING) ||
-		      a_status & ZFCP_STATUS_COMMON_ERP_FAILED)
+		    a_status & ZFCP_STATUS_COMMON_ERP_FAILED)
 			return 0;
 		if (p_status & ZFCP_STATUS_COMMON_NOESC)
 			return need;
-- 
2.21.0
