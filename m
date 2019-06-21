Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfFUOeO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 10:34:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 06/14] vfio-ccw: Adjust the first IDAW outside of the nested loops
Date: Fri, 21 Jun 2019 16:33:47 +0200
Message-Id: <20190621143355.29175-7-cohuck@redhat.com>
In-Reply-To: <20190621143355.29175-1-cohuck@redhat.com>
References: <20190621143355.29175-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

From: Eric Farman <farman@linux.ibm.com>

Now that pfn_array_table[] is always an array of 1, it seems silly to
check for the very first entry in an array in the middle of two nested
loops, since we know it'll only ever happen once.

Let's move this outside the loops to simplify things, even though
the "k" variable is still necessary.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190606202831.44135-7-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
2.20.1
