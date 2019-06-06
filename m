Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfFFU2k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 16:28:40 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56KQvov100588
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 16:28:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy93ej7rw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 16:28:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Jun 2019 21:28:37 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 6/9] vfio-ccw: Adjust the first IDAW outside of the nested loops
Date: Thu,  6 Jun 2019 22:28:28 +0200
In-Reply-To: <20190606202831.44135-1-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
Message-Id: <20190606202831.44135-7-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Now that pfn_array_table[] is always an array of 1, it seems silly to
check for the very first entry in an array in the middle of two nested
loops, since we know it'll only ever happen once.

Let's move this outside the loops to simplify things, even though
the "k" variable is still necessary.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 86a0e76ef2b5..ab9f8f0d1b44 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -201,11 +201,12 @@ static inline void pfn_array_table_idal_create_words(
 		pa = pat->pat_pa + i;
 		for (j = 0; j < pa->pa_nr; j++) {
 			idaws[k] = pa->pa_pfn[j] << PAGE_SHIFT;
-			if (k == 0)
-				idaws[k] += pa->pa_iova & (PAGE_SIZE - 1);
 			k++;
 		}
 	}
+
+	/* Adjust the first IDAW, since it may not start on a page boundary */
+	idaws[0] += pat->pat_pa->pa_iova & (PAGE_SIZE - 1);
 }
 
 
-- 
2.17.1
