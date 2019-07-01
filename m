Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728428AbfGAQY7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 12:24:59 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [RFC v1 3/4] vfio-ccw: Set pa_nr to 0 if memory allocation fails for pa_iova_pfn
Date: Mon,  1 Jul 2019 12:23:45 -0400
Message-Id: <19d813c58e0c45df3f23d8b1033e00b5ac5c7779.1561997809.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1561997809.git.alifm@linux.ibm.com>
References: <cover.1561997809.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1561997809.git.alifm@linux.ibm.com>
References: <cover.1561997809.git.alifm@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, alifm@linux.ibm.com

So we clean up correctly.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index cab1be9..c5655de 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -72,8 +72,10 @@ static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
 				  sizeof(*pa->pa_iova_pfn) +
 				  sizeof(*pa->pa_pfn),
 				  GFP_KERNEL);
-	if (unlikely(!pa->pa_iova_pfn))
+	if (unlikely(!pa->pa_iova_pfn)) {
+		pa->pa_nr = 0;
 		return -ENOMEM;
+	}
 	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
 
 	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
-- 
2.7.4
