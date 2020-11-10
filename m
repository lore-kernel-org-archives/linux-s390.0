Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727098AbgKJJgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:36:32 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9YXdQ064883
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:31 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qanawk12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AA9ZSea067834
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 1/3] s390/vmem: remove redundant check
Date: Tue, 10 Nov 2020 10:36:21 +0100
Message-Id: <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
In-Reply-To: <cover.1605000280.git.agordeev@linux.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/vmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b09..56ab9bb770f3a 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -223,7 +223,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 		if (!add) {
 			if (pmd_none(*pmd))
 				continue;
-			if (pmd_large(*pmd) && !add) {
+			if (pmd_large(*pmd)) {
 				if (IS_ALIGNED(addr, PMD_SIZE) &&
 				    IS_ALIGNED(next, PMD_SIZE)) {
 					if (!direct)
-- 
2.26.0
