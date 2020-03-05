Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgCEJEK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Mar 2020 04:04:10 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0258wfJZ049346
        for <linux-s390@vger.kernel.org>; Thu, 5 Mar 2020 04:04:09 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yj4q25jh8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Mar 2020 04:04:08 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 5 Mar 2020 09:04:06 -0000
From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH] s390/diag: fix display of diagnose call statistics
Date: Thu,  5 Mar 2020 10:03:55 +0100
Message-Id: <20200305090355.88036-1-mimu@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, Michael Mueller <mimu@linux.ibm.com>

Show the full diag statistic table and not just parts of it.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kernel/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index e9dac9a24d3f..61f2b0412345 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -84,7 +84,7 @@ static int show_diag_stat(struct seq_file *m, void *v)
 
 static void *show_diag_stat_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos <= nr_cpu_ids ? (void *)((unsigned long) *pos + 1) : NULL;
+	return *pos <= NR_DIAG_STAT ? (void *)((unsigned long) *pos + 1) : NULL;
 }
 
 static void *show_diag_stat_next(struct seq_file *m, void *v, loff_t *pos)
-- 
2.17.1
